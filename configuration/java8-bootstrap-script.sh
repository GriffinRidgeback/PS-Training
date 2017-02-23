#!/bin/bash
 
yum install -y krb5-workstation wget unzip
 
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm" -O jdk-8-linux-x64.rpm
rpm -i jdk-8-linux-x64.rpm
/bin/rm -f jdk-8-linux-x64.rpm
  
# Download the JCE and install it
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" -O UnlimitedJCEPolicyJDK8.zip
unzip UnlimitedJCEPolicyJDK8.zip
/bin/cp -f UnlimitedJCEPolicyJDK8/*.jar /usr/java/jdk1.8.0_60/jre/lib/security/
/bin/rm -rf UnlimitedJCEPolicyJDK8*
