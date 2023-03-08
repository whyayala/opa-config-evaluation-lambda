package structs

import (
	"encoding/json"
)

type RuleParameters struct {
	PolicyFile string
}

func DeserializeRuleParameters(ruleParameters string) (RuleParameters, error) {
	var mapped_rule_parameters RuleParameters

	err := json.Unmarshal([]byte(ruleParameters), &mapped_rule_parameters)
	return mapped_rule_parameters, err
}
