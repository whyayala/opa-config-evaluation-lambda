package structs

import (
	"encoding/json"
)

type InvokingEvent struct {
	ApplicationId   string
	ChangeSetId     string
	SemanticVersion string
	StackId         string
}

func DeserializeInvokingEvent(invokingEvent string) (InvokingEvent, error) {
	var mapped_invoking_event InvokingEvent

	err := json.Unmarshal([]byte(invokingEvent), &mapped_invoking_event)
	return mapped_invoking_event, err
}
