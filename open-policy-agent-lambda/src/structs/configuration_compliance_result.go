package structs

import (
	"github.com/aws/aws-sdk-go-v2/service/configservice/types"
)

type ConfigurationComplianceResult struct {
	ConfigurationItem ConfigurationItem
	ComplianceType    types.ComplianceType
}
