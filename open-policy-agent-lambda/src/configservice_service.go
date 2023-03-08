package services

import (
	"context"
	"encoding/json"
	"fmt"
	"log"

	"whyayala.com/opa-lambda/src/structs"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/configservice"
	"github.com/aws/aws-sdk-go-v2/service/configservice/types"
	"github.com/open-policy-agent/opa/rego"
)

func convertPaginatorToStrings(paginator configservice.SelectAggregateResourceConfigPaginator) ([]string, error) {
	var aggregated_configs []string
	for paginator.HasMorePages() {
		output, output_error := paginator.NextPage(context.TODO())
		if output_error != nil {
			return nil, output_error
		}
		aggregated_configs = append(aggregated_configs, output.Results...)
	}
	return aggregated_configs, nil
}

func convertStringsToConfigurationItems(strings []string) ([]structs.ConfigurationItem, error) {
	var aggregated_configs []structs.ConfigurationItem
	for _, element := range strings {
		config_item, config_item_error := structs.DeserializeConfigurationItem(element)
		if config_item_error != nil {
			return nil, config_item_error
		}
		aggregated_configs = append(aggregated_configs, config_item)
	}
	return aggregated_configs, nil
}

func resultSetToComplianceType(results rego.ResultSet) types.ComplianceType {
	if results.Allowed() {
		return types.ComplianceTypeCompliant
	}
	return types.ComplianceTypeNonCompliant
}

func EvaluateConfigItems(configItems []structs.ConfigurationItem, preparedQuery rego.PreparedEvalQuery) ([]structs.ConfigurationComplianceResult, error) {
	var config_compliance_results []structs.ConfigurationComplianceResult
	for _, config_item := range configItems {
		results, results_error := preparedQuery.Eval(context.Background(), rego.EvalInput(config_item))
		if results_error != nil {
			return nil, results_error
		}
		compliance_result := structs.ConfigurationComplianceResult{
			ConfigurationItem: config_item,
			ComplianceType:    resultSetToComplianceType(results),
		}
		config_compliance_results = append(config_compliance_results, compliance_result)
	}
	return config_compliance_results, nil
}

func QueryResourceConfigs(accountId string) ([]structs.ConfigurationItem, error) {
	default_config, default_config_error := config.LoadDefaultConfig(context.TODO())
	if default_config_error != nil {
		return nil, default_config_error
	}
	svc := configservice.NewFromConfig(default_config)

	org_aggregator := "MainOrganizationAggregator"
	query := fmt.Sprintf("select resourceId, resourceType, configuration, configurationItemCaptureTime where resourceType = 'AWS::RDS::DBInstance' AND accountId = '%s'", accountId)
	paginator := configservice.NewSelectAggregateResourceConfigPaginator(svc, &configservice.SelectAggregateResourceConfigInput{
		ConfigurationAggregatorName: &org_aggregator,
		Expression:                  &query,
	})

	config_strings, config_strings_error := convertPaginatorToStrings(*paginator)
	if config_strings_error != nil {
		return nil, config_strings_error
	}
	return convertStringsToConfigurationItems(config_strings)
}

func SubmitEvaluationResults(results []structs.ConfigurationComplianceResult, configEvent events.ConfigEvent) (*configservice.PutEvaluationsOutput, error) {
	default_config, default_config_error := config.LoadDefaultConfig(context.TODO())
	if default_config_error != nil {
		return nil, default_config_error
	}
	var evaluations []types.Evaluation
	for _, result := range results {
		stringified_config_item, _ := json.Marshal(&result.ConfigurationItem)
		log.Printf("ConfigurationItem to be converted: %s", string(stringified_config_item))
		evaluation := types.Evaluation{
			ComplianceType:         result.ComplianceType,
			ComplianceResourceType: &result.ConfigurationItem.ResourceType,
			OrderingTimestamp:      &result.ConfigurationItem.ConfigurationItemCaptureTime,
			ComplianceResourceId:   &result.ConfigurationItem.ResourceId,
		}
		evaluations = append(evaluations, evaluation)
	}

	svc := configservice.NewFromConfig(default_config)
	return svc.PutEvaluations(
		context.TODO(),
		&configservice.PutEvaluationsInput{
			ResultToken: &configEvent.ResultToken,
			Evaluations: evaluations,
		},
	)
}
