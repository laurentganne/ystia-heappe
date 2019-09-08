# Introduction to TOSCA

[TOSCA](https://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.2/os/TOSCA-Simple-Profile-YAML-v1.2-os.html) (Topology
and Orchestration Specification for Cloud Applications) is a standard allowing to provide a model for an application, its components, relationships between these components, dependencies, requirements, and capabilities.

It enables portability and automated management across cloud providers regardless of underlying platform or infrastructure.

The following figure explains how the core concepts work together:

![TOSCA figure](images/tosca.png)

The **Topology Template** defines the structure of the application. It consists in a set of node templates and and relationship templates.

A **Node Template** specifies the occurrence of a software component node as part of a Topology Template.

Each node template refers to a **Node Type** that defines the semantics of the node (properties, attributes, requirements, capabilities, interfaces).

A **Relationship Template** specifies the occurrence of a relationship between nodes in a Topology Template. Each Relationship Template refers to a Relationship Type that defines the semantics of the relationship (properties, attributes, interfaces).

In addition workflows (sometimes called plans) describe how the orchestrator will administrate the TOSCA application.

TOSCA specification defines normatives types, for which Ystia provides a built-in implementation, and from which the node types you will write will derive.

For example the TOSCA specification defines a [TOSCA Root Node Type](https://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.2/os/TOSCA-Simple-Profile-YAML-v1.2-os.html#_Toc528072956), which is the default type all other TOSCA Node Types derive from.
This specification defines that this root type has a set of [standard interfaces](https://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.2/os/TOSCA-Simple-Profile-YAML-v1.2-os.html#DEFN_TYPE_ITFC_NODE_LIFECYCLE_STANDARD) :
* create
* configure
* start
* stop
* delete

You can find the corresponding normative types implementation in the orchestrator code at [data/tosca/normative-types.yml](https://github.com/ystia/yorc/blob/develop/data/tosca/normative-types.yml).

For example, the Ystia orchestrator definition of the Root node type with its standard interfaces as described in the TOSCA specification :
```yaml
node_types:
  tosca.nodes.Root:
    description: >
      The TOSCA Root Node Type is the default type that all other TOSCA base Node Types derive from.
      This allows for all TOSCA nodes to have a consistent set of features for modeling and management
      (e.g., consistent definitions for requirements, capabilities and lifecycle interfaces).
    ...
    capabilities:
      feature:
        type: tosca.capabilities.Node
    requirements:
      - dependency:
          capability: tosca.capabilities.Node
          node: tosca.nodes.Root
          relationship: tosca.relationships.DependsOn
          occurrences: [ 0, UNBOUNDED ]
    interfaces:
      tosca.interfaces.node.lifecycle.Standard:
        create:
          description: Standard lifecycle create operation.
        configure:
          description: Standard lifecycle configure operation.
        start:
          description: Standard lifecycle start operation.
        stop:
          description: Standard lifecycle stop operation.
        delete:
          description: Standard lifecycle delete operation.
```


Next: [Description of the application](description.md)
