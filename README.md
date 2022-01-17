# FlyingMonkeyExpress

This problem set is deceptively simple however the details does allow the developer skills to shine. 
I am fairly pleased with my progress, given I have not done any TF coding in a number of years and had no existing development environment.  The challenges presented are certainly not insurmountable and the progress was limited solely by the time restriction.
There were a number of challenges encountered on this project
<ol>
<li>No local TF environment for development - this was solved by</li>
    <ol>
   <li>creating / configuration free GitHub account</li>
   <li>creating / configuration Terraform Cloud account</li>
    </ol>
<li>No GCP Organization available in free tier account</li>
    <ol>
   <li>this results in the inablity to share vpcs between projects</li>
    </ol>
   <li>Initial versioning issues using published modules</li>
     <ol>
   <li>In order to preserve time for development modules were not included</li>
    </ol>
</ol>
<p>Coding practic used
    <ol>
   <li>all values paramatized in variables</li>
   <li>variable values are stored in TF Cloud and passed to TF at Plan/Verify</li>
    <li>This includes connection credentials</li>
        <ol>
            <li>Credentials stored as "sensitive" variable</li> 
            <li>"sensitive" variable values are hidden from view and not shown in any code base or logs</li>
             <li>"sensitive" variables cannot be modified or viewed - only deleted and re-created</li>
        </ol>
    <li>All code developed sections were coded then tested and modified as needed to perform correctly</li>
</p>
