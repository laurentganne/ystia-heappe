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

To show an example of inheritance, the implementation is providing abstract types for the components, and concrete types inheriting from these abstract components.

Abstract types are defined here in [components/pub/types.yaml](../components/pub/types.yaml).



## Concrete types

## Application template

An application template (*topology template* in TOSCA terminology) is also provided.

Next: [Using this template to create and deploy applications in Ystia](using_ystia.md)
