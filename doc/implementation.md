# Implementation

To show an example of inheritance, the implementation is providing abstract types for the components, and concrete types inheriting from these abstract components.
An application template (*topology template* in TOSCA terminology) is also provided.

## Abstract types
Abstract types are defined here in [components/pub/types.yaml](../components/pub/types.yaml).

A first section `data_types` defines new types that will be used by our components, derived from types defined in [HEAppE Middleware](https://code.it4i.cz/ADAS/HEAppE/Middleware/wikis/home) API.

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

The `TaskSpecification` property `templateParameterValues` which is array of `CommandTemplateParameterValue` is described this way in TOSCA:

```yaml
  org.ystia.heappe.types.TaskSpecification:
    derived_from: tosca.datatypes.Root
    properties:
      templateParameterValues:
        description: Command template parameters
        type: list
        entry_schema:
          type: org.ystia.heappe.types.CommandTemplateParameterValue
```

This is a property of type `list` whose type of elements are provided by the `entry_schema` type.


## Concrete types

## Application template


Next: [Using this template to create and deploy applications in Ystia](using_ystia.md)
