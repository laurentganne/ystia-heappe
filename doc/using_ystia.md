# Using the topology template to create and deploy applications in Ystia

## Prerequisites

This example is using node templates that don't have a requirement to be hosted on a 
Compute Instance.

No compute instance will be created on demand here. To be able to execute the scripts associated 
to our components interfaces, a specific configuration of the orchestrator is required, as by default it will refuse to execute such operations.

This can be done modifying yorc configuration (in /etc/yorc/config.yorl.yaml if you used Yorc bootstrap to install your setup) as described in [Yorc configuration documentation](https://yorc.readthedocs.io/en/latest/configuration.html#option-ansible-sandbox-hosted-ops-cfg).

For example, this is a configuration that you can use in tests/development environments, where you allow the orchestrator Yorc to execute such non-hosted operations directly on the host where it is running:

```yaml
ansible:
  hosted_operations:
    unsandboxed_operations_allowed: true
```

And this is a configuration where Yorc is configured to execute such non-hosted operations within a docker container using an image of you choice:

```yaml
ansible:
  hosted_operations:
    unsandboxed_operations_allowed: false
    default_sandbox:
      image: python:2.7-stretch
```
Then a restart of yorc is needed.

Once done, this example (components and topology template) can be uploaded in Alien4Cloud catalog.

Next section describe how to do it from Alien4Cloud UI.

## through the UI

## through the REST API
