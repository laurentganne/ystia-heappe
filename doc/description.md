# Description of the application

The example application is made of three components (or *node templates* in TOSCA terminology).
Here is a graphical view of this application as seen in Alien4Cloud :

![App template](images/appTemplate.PNG)

* HEAppEJob is a job which will use the HEAppE Middleware API to create/submit/wait for the end/delete a HEAppe Job
* GetFilesJob is a job which will use the HEAppe Middleware API to get the file transfer method, get the list of files updated by the job, and scp the files (currently here this is a stub which is just printing messages)
* ReportComponent is a component, not a job, providing a custom interface  

Next: [Implementation](implementation.md)
