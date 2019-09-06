# Description of the application

The example application is made of three components (or *node templates* in TOSCA terminology).
Here is a graphical view of this application as seen in Alien4Cloud :

![App template](images/appTemplate.PNG)

* HEAppEJob is a job which will use the HEAppE Middleware API to create/submit/wait for the end/delete a HEAppe Job
* GetFilesJob is a job which will use the HEAppe Middleware API to get the file transfer method, get the list of files updated by the job, and scp the files (currently here this is a stub which is just printing messages)
* ReportComponent is a component, not a job, providing a custom interface print_usage, using HEAppe Middleware API to get a report of resources usage for a given Job.

Both ReportComponent and GetFilesJob are associated to a HEAppEJob through a relationship.

As described in the previous section, Alien4Cloud will generate standard workflows `install` and `uninstall` for the application,
by calling each component standard interface create/configure/start (and stop/delete for the `uninstall` standard workflow) in order according to the relationships between these components.

Similarly as an extension to TOSCA for jobs, Alien4Cloud will generate a workflow `run` for the application, that will call each Job component interfaces submit/run in order according to the relationships between jobs.
Which means here, the `run` workflow will submit a HEappeEJob, wait for the HEappeEJob to finish, then will submit a GetFilesJob and will wait for the GetFilesJob to finish.

As the component ReportComponent is not a job, it doesn't implement the Runnable interfaces submit/run and it is not involved in the generated workflow `run`.
To add the ReportComponent custom interface print_usage in a workflow, the user can define a custom workflow.
This is what will we do here creating workflow which will like the `run` workflow submit HEappeEJob and wait for it to finish,
but when the job will be finished, the worflow will in parrallel submit the GetFilesJob and call the print_usage interface of ReportComponent.
Which gives this graphical representation of the user-defined workflow :

![User workflow](images/workflow.PNG)

Next: [Implementation](implementation.md)
