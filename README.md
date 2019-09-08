# TOSCA application using HEappE Middleware REST API

This repository provides an example of [TOSCA](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.2/TOSCA-Simple-Profile-YAML-v1.2.html) application template using [HEappE Middleware](https://code.it4i.cz/ADAS/HEAppE/Middleware/wikis/home) REST API.

This example can be uploaded/instantiated in [Alien4Cloud](http://alien4cloud.github.io/index.html), then deployed by the [Ystia Orchestrator](https://github.com/ystia/yorc/blob/develop/README.md) on HPC clusters managed by the HEappE Middleware.

The orchestrator has a built-in support for the deployment of applications on Google Cloud, AWS, OpenStack, SLURM, Kubernetes, Host Pools...
Its capabilities can also be extended through a plugin mechanism, where you can add the support for a new type of infrastructure with associated resources that the Orchestrator can create on demand. For example, a plugin could provide a HEAppe Job resource, bringing to the orchestator the ability to create such job.

But here with this the example, this a very lightweight implementation without plugin extension. So here, the TOSCA components provide their implementation on how to create and submit a job, using directly HEAppE Middleware REST APIs.
Ystia front-end and orchestrator will just have here to execute the application workflows.

The following sections provide first an introduction to TOSCA, then a detailed description of the application, its implementation, and how to use it in Ystia:

* [Introduction to TOSCA](doc/tosca_intro.md)
  * [Specification](doc/tosca_intro.md#specification)
  * [Extensions brought by Ystia](doc/tosca_intro.md#tosca-extensions-brought-by-ystia)
    * [Jobs](doc/tosca_intro.md#jobs)
    * [Standard workflows automatic generation](doc/tosca_intro.md#standard-workflows-automatic-generation)
    * [Additional keyword](doc/tosca_intro.md#additional-keyword)
  * [Documentation](doc/tosca_intro.md#documentation)
* [Description of the application](doc/description.md)
* [Implementation](doc/implementation.md)
  * [data types](doc/implementation.md#data-types)
  * [abstract types](doc/implementation.md#abstract-types)
  * [concrete types](doc/implementation.md#concrete-types)
  * [Application template](doc/implementation.md#application-template)
* [Using this template to create and deploy applications in Ystia](doc/using_ystia.md)
  * through the UI
  * through the REST API
