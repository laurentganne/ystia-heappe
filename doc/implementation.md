# Implementation


## Data types

In addition to built-in types defined in the YAML specification (string, integer, float, boolean, timestamp) and supported by TOSCA, you can define your own types in a section `data_types` of a TOSCA file.

This is what was done in [components/pub/types.yaml](../components/pub/types.yaml) to have data types that will be used by our components. The data types defined here are directly derived from types defined in [HEAppE Middleware](https://code.it4i.cz/ADAS/HEAppE/Middleware/wikis/home) API.

HEAppE Middleware defines a `JobSpecification` type having properties :
* `minCores`: minimum number of cores required
* `maxCores`: maximum number of cores required
* `tasks`: array of `TaskSpecification`
* ...

A `TaskSpecification` type has these properties :
* `minCores`: minimum number of cores required
* `maxCores`: maximum number of cores required
* `templateParameterValues` : array of `CommandTemplateParameterValue`
* ...

A `CommandTemplateParameterValue` type is a structure having these properties:
* `commandParameterIdentifier`: a string identifying a parameter
* `parameterValue` : a parameter value

The corresponding data type definition for a `commandTemplateParameterValue` defined in [components/pub/types.yaml](../components/pub/types.yaml) is:

```yaml
data_types:
  org.ystia.heappe.types.CommandTemplateParameterValue:
    derived_from: tosca.datatypes.Root
    properties:
      commandParameterIdentifier:
        description: Command parameter identifier
        type: string
        required: true
      parameterValue:
        description: Command parameter value
        type: string
```

Note here that the property `commandParameterIdentifier`  has the attribute `required` set to `true`, while this is not the case of `parameterValue`. You can also use the attribute `default` to specify a default value.

The `TaskSpecification` type property `templateParameterValues` which is array of `CommandTemplateParameterValue` is described this way in TOSCA:

```yaml
  org.ystia.heappe.types.TaskSpecification:
    derived_from: tosca.datatypes.Root
    properties:
      templateParameterValues:
        description: Command template parameters
        type: list
        entry_schema:
          type: org.ystia.heappe.types.CommandTemplateParameterValue
      ...
```

This is a property of type `list` whose type of elements are provided by the `entry_schema` type.

Similarly, the `JobSpecification` type property `tasks` which is array of `TaskSpecification` is described this way in TOSCA:
```yaml
  org.ystia.heappe.types.JobSpecification:
    derived_from: tosca.datatypes.Root
    properties:
      tasks :
        description: Tasks (at leat one task needs to be defined)
        type: list
        entry_schema:
          type: org.ystia.heappe.types.TaskSpecification
        required: true
      ...
```


## Abstract types

To show an example of inheritance, this example is defining abstract type. Next section will describe concrete types inheriting from these abstract components.

Other example of abstract types: the orchestrator is providing abstract types for resources (Compute Instance, Block Storage, Network...) of infrastructures it supports, that you can reference in your application template to have a portabke application, and when you will have selected on which location to deploy the application, Alien4Cloud will take care of substituting these abstract infrastucture resource types refernced in your application with concrete types, these concrete types having implementation of standard create/configure/start/stop/delete that the orechestrator wiil execute when running install/uninstall workflows.

Abstract types are defined here in [components/pub/types.yaml](../components/pub/types.yaml), in a section `node_types`.

The abstract type `Job` derives from the parent type `org.alien4cloud.nodes.Job` which is a component with additional interfaces corresponding to a job submit, run, cancel, as seen previously.
And this type `Job` defines:
* properties, which are configured by the user and won't change at runtime
* attributes, which will be set at runtime, like here the job ID that will return by HEAppe middleware once the job will be created
* a capability, that will allow to build a relationship between components having a requiremnent to be associated wih a HEAppE job, and this component having this capability

```yaml
node_types:
  org.ystia.heappe.components.pub.Job:
    derived_from: org.alien4cloud.nodes.Job
    abstract: true
    description: >
      HEAppE Job
    properties:
      heappeURL:
        description: URL of the HEAppE Middleware service
        type: string
        required: true
      user:
        description: User used to connect to HEAppE Middleware
        type: string
        required: true
      password:
        description: Password used to connect to HEAppE Middleware
        type: string
        required: true
      jobSpecification:
        description: Specification of the job to create
        type: org.ystia.heappe.types.JobSpecification
        required: true
    attributes:
      jobID:
        type: string
        description: >
          ID of the HEAppE job created
      sessionID:
        type: string
        description: >
          ID of the HEAppE session created
    capabilities:
      heappejob:
        type: org.ystia.heappe.capabilities.pub.HeappeJob

```

This capability is defined later in this file. A capability can have as well properties and attributes, here for this example there is no such need :

```yaml
capability_types:
  org.ystia.heappe.capabilities.pub.HeappeJob:
    derived_from: tosca.capabilities.Root
    description: >
      A capability fulfilling requirements of a node requiring to be
      associated with a HEAppE Job.
```



## Concrete types

## Application template

An application template (*topology template* in TOSCA terminology) is also provided.

Next: [Using this template to create and deploy applications in Ystia](using_ystia.md)
