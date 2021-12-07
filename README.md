# Overview

[LocalStack 💻](https://localstack.cloud) is a cloud service emulator that runs in a single container on your local environment.
With LocalStack, you can run your AWS applications or Lambdas entirely on your local machine without connecting to a remote cloud provider!
Whether you are testing complex CDK applications or Terraform configurations, or just beginning to learn about AWS services,
LocalStack helps speed up and simplify your testing and development workflow.

LocalStack supports a growing number of AWS services, like AWS Lambda, S3, Dynamodb, Kinesis, SQS, SNS, and **many** more!
The [**Pro version** of LocalStack](https://localstack.cloud/pricing) supports additional APIs and advanced features.
You can find a comprehensive list of supported APIs on our [☑️ Feature Coverage](https://github.com/localstack/localstack/blob/master/doc/feature_coverage.md) page.

# Localstack blueprint overview 

Localstack blueprint will :

* Create a new VM
* Connect it to an existing network
* Create required secirity groups
* Install all the prerequisites 
* Run Localstack AWS cloud emulator using docker on newly created CentOS 7.6 and Ubuntu 18.04 VMs on OpenStack.

## Prerequisites

* Latest Cloudify Manager ( was certified with 6.1.0 )

* These plugins should exist on your manager. (E.g. You can just run `cfy plugins bundle-upload`, which will satisfy all plugin requirements.):

  * [cloudify-openstack-plugin](https://github.com/cloudify-cosmo/cloudify-openstack-plugin/releases), version 3.0.0 or higher.
 

* These secrets should exist on your manager:
  * `openstack_username`: Your Openstack username.
  * `openstack_password`: Your Openstack password.
  * `openstack_tenant_name`: Your Openstack tenant name.
  * `openstack_auth_url`: The v2.0 or v3 authorization endpoint URL for your Openstack API service.
  * `agent_key_private`: The content of an RSA private key. (E.g. You can upload this key from a file: `cfy secrets create agent_key_private -f ~/.ssh/id_rsa`).
 

## Usage
 
### Install 

The `cfy install <blueprint-path>` command will upload the blueprint to your Cloudify Manager, create a deployment out of it, and install the created deployment. 

```bash
cfy install https://github.com/cloudify-community/blueprint-examples/releases/download/latest/localstack-blueprint.zip
```

This will run a `Localstack AWS emulator` on your local machine in port 4566. 

To start interacting with Localstack, please follow the steps below: 

 * Run `install_awscli.sh` on your Linux host ( CentOS 7.6 and Ubuntu 18.04).  
 * `install_awscli.sh` script will install AWS CLI and AWS CLI local
 * AWS CLI local package provides the `awslocal` command, which is a thin wrapper around the `aws`
command line interface for use with [LocalStack](https://github.com/localstack/localstack).

### Localstack installation verification and basic usage

 * Once `install_awscli.sh` script executed and `awslocal` installed on your box you can check that `Localstack` is up and running. Default port is `4566`
  
  ```bash
curl <IP address>:<localstack port>
curl localhost:4566 - if installed on the same host where `Localstack` is running
curl <public IP address>:4566 - if installed on a separate host.

Expected command output when localstack is running 
{"status": "running"}
```
 * Basic usage
 
  Create s3 bucket, list s3 bucket, copy files to s3 bucket, copy files to s3 bucket.
 
 ```bash
 awslocal --endpoint-url=http://10.239.2.11:4566 s3 mb s3://mytestbucket
 awslocal --endpoint-url=http://10.239.2.11:4566 s3 ls
 awslocal --endpoint-url=http://10.239.2.11:4566 s3 cp test.txt s3://mytestbucket
 awslocal --endpoint-url=http://10.239.2.11:4566 s3 ls s3://mytestbucket
 ```
 


### Uninstall
To uninstall the localstack, simply run:

```bash
cfy uninstall <blueprint>
```





