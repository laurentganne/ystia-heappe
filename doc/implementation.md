# Implementation

To show an example of inheritance, the implementation is providing abstract types for the components, and concrete types inheriting from these abstract components.
An application template (*topology template* in TOSCA terminology) is also provided.

## Abstract types
Abstract types are defined here in [components/pub/types.yaml](../components/pub/types.yaml).

A first section `data_types` defines new types that will be used by our components, derived from types defined in [HEAppE Middleware](https://code.it4i.cz/ADAS/HEAppE/Middleware/wikis/home) API.

HEAppE Middleware defines a `Job` type having properties :
* `minCores`: minimum number of cores required
* `maxCores`: maximum number of cores required
* `tasks`: array of task
* ...

A `task` type has these properties :
* `minCores`: minimum number of cores required
* `maxCores`: maximum number of cores required
* `templateParameterValues` : array of commandTemplateParameterValue
* ...

A `commandTemplateParameterValue` is a structure having these properties:
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

## Concrete types

## Application template


Next: [Using this template to create and deploy applications in Ystia](using_ystia.md)
