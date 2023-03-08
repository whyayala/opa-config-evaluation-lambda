# Config

## Open Policy Agent Lambda

### Requirements

To develop and run this project on your local machine, you will need to follow the steps below to install the necessary tooling.

1. Install Rancher Desktop
    - [Install Rancher Desktop](https://docs.rancherdesktop.io/getting-started/installation)
    - [Change Rancher Desktop's container engine to dockerd](https://docs.rancherdesktop.io/next/ui/preferences/container-engine/)
1. Install sam-cli
    - [Sam cli installation steps](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)
1. Install the Go runtime environment.
    - On MacOS
        - `brew install go`
1. Install the project dependencies.
    - `cd config/open-policy-agent-lambda`
    - `go get`
1. Install Open Policy Agent (OPA)
    - [Download OPA](https://www.openpolicyagent.org/docs/latest/#1-download-opa)


### What It Is

This folder contains golang code for a lambda resource that evaluates config resources in all accounts under the organization. It uses rego files to define compliance standards for resources.

The lambda is invoked by an Organization Config Rule (OCR). The OCR is triggered by a daily scheduled event. It invokes the lambda with the event, info about the OCR, and input parameters for the lambda's execution.

When the lambda finishes evalutating an account's config resource against the rego rules, it publishes the evaluation result to the account's config dashboard.

### How It Works

In the `central-config.yml` file we define resources deployed to the main account. This consists of our OPA Lambda, an OCR to invoke it, and other resources.

In the `template.yml` file we define resources that will be deployed to all accounts belonging to the Organization.
