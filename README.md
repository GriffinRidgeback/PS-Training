# PS-East-and-Federal-Training
Repository for work done for this training session

# How to scp the certificate file to the EC2 instance

```
scp -i ~/Documents/certificates/ubuntu_14.04.pem ~/Documents/certificates/ubuntu_14.04.pem ec2-user@ec2-54-221-4-185.compute-1.amazonaws.com:~/.ssh
```

# To install Java 8 on RHEL 7
```
sudo su -
```
gets you in as root so you don't have to __sudo__ all the commands

[This link](https://lintut.com/how-to-install-java-8-on-rhel-centos-7-x-and-fedora-linux/) was a good one for getting Java installed.  __Note:__ it was necessary to do a _yum install wget_ prior to downloading the SDK.
[This link](http://tecadmin.net/install-java-8-on-centos-rhel-and-fedora/) is a little more involved; not sure it's necessary.

# Command I used to configure the SOCKS proxy
```
nohup ssh -i ~/Documents/certificates/ubuntu_14.04.pem -CND 8157 ec2-user@ec2-184-73-151-179.compute-1.amazonaws.com
```

# Command I used to launch Chrome
```
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --user-data-dir="$HOME/chrome-with-proxy" --proxy-server="socks5://localhost:8157"
```

# URL I used to access the admin screen for Cloudera Director
```
http://ip-172-31-52-56.ec2.internal:7189/
```

# Access keys needed for creating environment
Information is described [here](https://aws.amazon.com/developers/access-keys/) but I created a new pair from [here](https://console.aws.amazon.com/iam/home?#/home)

1. Click on _Delete your root access keys_, then click the _Manage Security Credentials_ button.
2. Click the _Continue to Security Credentials_ button
3. Expand the _Access Keys_ menu item
4. Click _Create New Access Key_

# Environment setup 
## (Access Key information is not correct for security reasons)

![Environment](/images/Environment.png "Environment Settings")

# Template creation

![Template](/images/Template.png "Template Settings")

# Cluster creation
## Configuration
![Configuration](/images/Configuration.png "Configuration Settings")

## Director Version
![Director Version](/images/Director Version.png "Director Version")

## CDH Version
![CDH Version](/images/CDH version.png "CDH Version")

## Cluster startup
![Cluster 1](/images/Cluster 1.png "Cluster setup")
![Cluster 2](/images/Cluster 2.png "Cluster setup")

# Cleanup

1. Follow the cleanup instructions in the [public docs](https://www.cloudera.com/documentation/director/latest/topics/director_get_started_aws_cleanup.html)
2. Run __sudo service cloudera-director-manager stop__ on the node running Director
3. Stop the instance from the AWS console; the cluster nodes should have a status of __terminated__

# Location of the configuration files
On the instance I created they were in __/usr/lib64/cloudera-director/client__

I copied them using
```
cp /usr/lib64/cloudera-director/client/aws.*.* ~
```
# Configuration property links
[Cloudera Manager](https://www.cloudera.com/documentation/enterprise/properties/5-10-x/topics/cm_props_cmserver.html)

[Cloudera Management Services](https://www.cloudera.com/documentation/enterprise/properties/5-10-x/topics/cm_props_mgmtservice.html)

It is easiest to look under the resource management section for each service; heap_size is a resource, after all!

For the services, look [here](https://www.cloudera.com/documentation/enterprise/properties/5-10-x/topics/cm_props_cdh5100.html)

To figure out where the configuration settings belong, do the following:

1. Search for the service, e.g., YARN

2. Each service will be deployed on a particular node in the cluster (master, worker)

3. For that node, see what daemon will be running (NODEMANAGER, etc.)

4. So, to configure YARN RESOURCEMANAGER parameters, you have to do that in the master node because this is the role assigned to YARN on that node:

__YARN: [RESOURCEMANAGER, JOBHISTORY, GATEWAY]__

# Environment variables
Set the following before running cloudera-director

```
export AWS_ACCESS_KEY_ID=<your access key ID>
export AWS_SECRET_ACCESS_KEY=<your secret access key>
```

# Results
<pre>
cloudera-director bootstrap exercise.conf 
Process logs can be found at /home/ec2-user/.cloudera-director/logs/application.log
Plugins will be loaded from /var/lib/cloudera-director-plugins
Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=256M; support was removed in 8.0
Cloudera Director 2.3.0 initializing ...
Installing Cloudera Manager ...
* Starting ..... done
* Requesting an instance for Cloudera Manager ........................... done
* Installing screen package (1/1) ....... done
* Inspecting capabilities of 172.31.56.142 .......... done
* Normalizing 478d9c67-5d04-4288-86c8-da581b7f5d73 ...... done
* Installing ntp package (1/4) ..... done
* Installing curl package (2/4) .... done
* Installing nscd package (3/4) ..... done
* Installing gdisk package (4/4) ............................ done
* Resizing instance root partition ......... done
* Mounting all instance disk drives .............. done
* Waiting for new external database servers to start running ......... done
* Installing repositories for Cloudera Manager ........ done
* Installing oracle-j2sdk1.7 package (1/3) ..... done
* Installing cloudera-manager-daemons package (2/3) ..... done
* Installing cloudera-manager-server package (3/3) ...... done
* Setting up embedded PostgreSQL database for Cloudera Manager ..... done
* Installing cloudera-manager-server-db-2 package (1/1) ..... done
* Starting embedded PostgreSQL database ....... done
* Starting Cloudera Manager server ... done
* Waiting for Cloudera Manager server to start ..... done
* Changing admin Credentials for Cloudera Manager ... done
* Setting Cloudera Manager License ... done
* Configuring Cloudera Manager ...... done
* Deploying Cloudera Manager agent ..... done
* Waiting for Cloudera Manager to deploy agent on 172.31.56.142 ... done
* Setting up Cloudera Management Services ............ done
* Backing up Cloudera Manager Server configuration ......... done
* Inspecting capabilities of 172.31.56.142 ...... done
* Running Deployment post create scripts ... done
* Done ...
Cloudera Manager ready.
Creating cluster Exercise1 ...
* Starting ..... done
* Requesting 4 instance(s) in 2 group(s) ....................................... done
* Preparing instances in parallel (20 at a time) ............................................................................... done
* Waiting for Cloudera Manager installation to complete ... done
* Installing Cloudera Manager agents on all instances in parallel (20 at a time) ....... done
* Creating CDH5 cluster using the new instances ....... done
* Creating cluster: Exercise1 .... done
* Downloading parcels: CDH-5.9.1-1.cdh5.9.1.p0.4 .... done
* Raising rate limits for parcel distribution to 256000KB/s with 5 concurrent uploads ... done
* Distributing parcels: CDH-5.9.1-1.cdh5.9.1.p0.4 .... done
* Activating parcels: CDH-5.9.1-1.cdh5.9.1.p0.4 ....... done
* Creating cluster services ... done
* Applying custom configurations of services ... done
* Renaming role config group from NodeManager Default Group to NODEMANAGER worker Group ... done
* Renaming role config group from Hive Metastore Server Default Group to HIVEMETASTORE master Group ... done
* Renaming role config group from Oozie Server Default Group to OOZIE_SERVER master Group ... done
* Creating Hive Metastore Database ... done
* Waiting for firstRun on cluster Exercise1 ... done
* Starting ... done
* Collecting diagnostic data ... done
* Done ...
Cluster ready.
</pre>

# Accessing Cloudera Manager
Since the instance used for loading Cloudera Manager is specified as type __m4x.large__, simply look at the _Instance Type_ column (enable it via the settings cogwheel if it is not displayed) and find the one with this type.
```
http://ec2-54-159-0-63.compute-1.amazonaws.com:7180
```

# Java 8 installation
Can be found [here](https://www.cloudera.com/documentation/director/latest/topics/director_create_java_8_clusters.html)

# Kerberos installation
First, run the provided script __AS SUDO__ in the configuration directory *setup_kdc.sh*.  It is run on the instance where Director is installed.  The output should look like this:
<pre>
[ec2-user@ip-172-31-52-56 ~]$ sudo ./setup_kdc.sh
Enter a REALM name: exercise2
Enter a KDC password: 
Re-Enter the KDC password: 
Enter a password for the cloudera-scm/admin principal: 
Re-Enter the password for the cloudera-scm/admin principal: 
Installing packages...done
Setting up rng-tools...done
Configuring /var/kerberos/krb5kdc/kadm5.acl...done
Configuring /var/kerberos/krb5kdc/kdc.conf...done
Configuring /etc/krb5.conf...done
Creating realm EXERCISE2...done
Starting KDC...done
Starting kadmin...done
Creating cloudera-scm/admin principal...done

Completed!
</pre>

__Note:__ The setup_kdc.log has a lot of information.

# Running the second script

Problems encountered early were fixed (mismatched curlies in the roles section).  But now the following problem exists and have been unable to resolve it:
<pre>
ec2-user@ip-172-31-52-56 ~]$ cloudera-director bootstrap PS-East-and-Federal-Training/configuration/exercise2.conf 
Process logs can be found at /home/ec2-user/.cloudera-director/logs/application.log
Plugins will be loaded from /var/lib/cloudera-director-plugins
Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=256M; support was removed in 8.0
Cloudera Director 2.3.0 initializing ...
Installing Cloudera Manager ...
* Starting .... done
* Requesting an instance for Cloudera Manager ............................ done
* Installing screen package (1/1) ...... done
* Running custom bootstrap script on [172.31.58.217, ip-172-31-58-217.ec2.internal, 54.157.196.120, ec2-54-157-196-120.compute-1.amazonaws.com] ........... done
* Waiting for SSH access to [172.31.58.217, ip-172-31-58-217.ec2.internal, 54.157.196.120, ec2-54-157-196-120.compute-1.amazonaws.com], default port 22 ...... done
* Inspecting capabilities of 172.31.58.217 ............ done
* Normalizing b8cfb1cf-e59b-4627-a276-12d6fafbe139 ..... done
* Installing ntp package (1/4) ..... done
* Installing curl package (2/4) ..... done
* Installing nscd package (3/4) ..... done
* Installing gdisk package (4/4) ........................... done
* Resizing instance root partition ......... done
* Mounting all instance disk drives .............. done
* Waiting for new external database servers to start running ........ done
* Installing repositories for Cloudera Manager ........ done
* Installing cloudera-manager-daemons package (1/2) ..... done
* Installing cloudera-manager-server package (2/2) ........ done
* Installing krb5-workstation package (1/1) .... done
* Setting up embedded PostgreSQL database for Cloudera Manager ...... done
* Installing cloudera-manager-server-db-2 package (1/1) ..... done
* Starting embedded PostgreSQL database ....... done
* Starting Cloudera Manager server ... done
* Waiting for Cloudera Manager server to start ..... done
* Changing admin Credentials for Cloudera Manager .... done
* Verifying Cloudera Manager Credentials from DeploymentTemplate ... done
* Enabling Enterprise Trial ... done
* Configuring Cloudera Manager .... done
* Importing Kerberos admin principal credentials into Cloudera Manager .... done
* Deploying Cloudera Manager agent ...... done
* Waiting for Cloudera Manager to deploy agent on 172.31.58.217 ... done
* Setting up Cloudera Management Services ............ done
* Backing up Cloudera Manager Server configuration ......... done
* Inspecting capabilities of 172.31.58.217 ...... done
* Running Deployment post create scripts ... done
* Done ...
Cloudera Manager ready.
Creating cluster Exercise2 ...
* Starting ...... done
* Requesting 7 instance(s) in 5 group(s) ................................Unexpected internal error (see logs): Pipeline handle='e69001f1-795f-4317-9eb0-300763fb082d/child-00000-104fb7c2-7a35-40e3-b602-ae2dc4fbc523/child-00000-0cf5b9f0-c9b3-4ad5-af20-2d2320c01234'
</pre>