package structs

import (
	"encoding/json"
	"time"
)

type ConfigurationItem struct {
	ResourceType                 string
	ResourceId                   string
	ConfigurationItemCaptureTime time.Time
	Configuration                map[string]interface{}
}

func DeserializeConfigurationItem(configurationItem string) (ConfigurationItem, error) {
	var mapped_configuration_item ConfigurationItem

	err := json.Unmarshal([]byte(configurationItem), &mapped_configuration_item)
	return mapped_configuration_item, err
}
