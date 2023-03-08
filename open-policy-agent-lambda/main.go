package main

import (
	"context"
	"embed"
	"encoding/json"
	"log"

	services "whyayala.com/opa-lambda/src"
	"whyayala.com/opa-lambda/src/structs"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/open-policy-agent/opa/rego"
)

// TODO: can we exclude test_

//go:embed src/policies/*
var embedFS embed.FS

func getPolicyFileString(policy_file string) (string, error) {
	array_data, err := embedFS.ReadFile(policy_file)
	return string(array_data), err
}

func handleRequest(lambdaCtx context.Context, configEvent events.ConfigEvent) (string, error) {
	config_event_json, _ := json.Marshal(configEvent)
	log.Printf("Received the following ConfigEvent: %s", string(config_event_json))

	rule_parameters, rule_parameters_error := structs.DeserializeRuleParameters(configEvent.RuleParameters)
	if rule_parameters_error != nil {
		log.Printf("rule_parameters_error: %v\n", rule_parameters_error)
		return "Error returned from call to DeserializeRuleParameters", rule_parameters_error
	}
	policy_file_string, policy_file_error := getPolicyFileString(rule_parameters.PolicyFile)
	if policy_file_error != nil {
		log.Printf("policy_file_error: %v\n", policy_file_error)
		return "Error returned from call to getPolicyFileString", policy_file_error
	}
	configuration_items, configuration_items_error := services.QueryResourceConfigs(configEvent.AccountID)
	if configuration_items_error != nil {
		log.Printf("configuration_items_error: %v\n", configuration_items_error)
		return "Error returned from call to QueryResourceConfigs", configuration_items_error
	}

	if len(configuration_items) > 0 {

		r, rego_error := rego.New(
			rego.Module(rule_parameters.PolicyFile, policy_file_string),
			rego.Query(`data.config.allow`),
		).PrepareForEval(context.TODO())

		if rego_error != nil {
			log.Printf("rego_error: %v\n", rego_error)
			return "Error returned from call to rego.New", rego_error
		}

		compliance_results, compliance_results_error := services.EvaluateConfigItems(configuration_items, r)

		if compliance_results_error != nil {
			log.Printf("compliance_results_error: %v\n", compliance_results_error)
			return "Error returned from call to EvaluateConfigItems", compliance_results_error
		}

		submit_evaluations_results, submit_evaluations_error := services.SubmitEvaluationResults(compliance_results, configEvent)
		if submit_evaluations_error != nil {
			log.Printf("submit_evaluations_error: %v\n", submit_evaluations_error)
			return "Error returned from call to SubmitEvaluationResults", submit_evaluations_error
		}
		stringified_put_evaluations_output, _ := json.Marshal(submit_evaluations_results)

		log.Printf("PutEvaluationsOutput: %s", string(stringified_put_evaluations_output))
	}
	log.Printf("Handler finished processing %d resource configuration(s) for AccountId: %s.", len(configuration_items), configEvent.AccountID)
	return "Finished without error.", nil
}

func main() {
	lambda.Start(handleRequest)
}
