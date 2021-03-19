# CHALLENGE

Inside this repository you will find Terraform code and modules to provision our
challenge in a Minikube (local Kubernetes "cluster"). The challenge consists of
a Jenkins installation using [Jenkins Configuration as
Code](https://www.jenkins.io/projects/jcasc/) to configure Jenkins and create
the jobs using a mixture of [Jenkins Job DSL](https://plugins.jenkins.io/job-dsl/)
and [Terraform templates](https://www.terraform.io/docs/language/expressions/strings.html#string-template).

Prerequisites to work with this repo:

+ [sops](https://github.com/mozilla/sops)
+ [minikube](https://minikube.sigs.k8s.io/docs/start/)
+ [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Regarding **challenge 3a** and **challenge 3b** we do expect you only to address one of the challenges. If you like to do both? No problem.

## CHALLENGE 0

**Goal: Setup all prerequisites.**

Setup all prerequisites according the docs or your personal idea on your system.

If you like to use a different kubernetes flavor for you local machine like kind or microk8s
feel free to do so and adopt the code provided accordingly.

## CHALLENGE 1

**Goal: Access the Jenkins**

The code is capable of deploying a jenkins with some configurations via the [CASC Plugin .](https://github.com/jenkinsci/configuration-as-code-plugin)
But its not accessible from your local machine.

**What do we expect to see?**

A description how to access the jenkins and were to retrieve the credentials to login.
As a bonus we would like to see a way how to permanently make the jenkins accessible.

## CHALLENGE 2

**Goal: Cipher all credentials**

Inside the [environment.json](../terraform/environment.json) file there are some values encrypted and some are not.

```json
			{
				"string": {
					"id": "first_string_secret",
					"description": "Demo Secret",
					"scope": "GLOBAL",
					"secret": "t0ps3cr3t"
				}
			},
			{
				"usernamePassword": {
					"id": "ENC[AES256_GCM,data:pQtecC5A7wVZFjn6Nurmlf0W9tJP,iv:BMEkYyRJJDTTynrAF3r94g2SFIAR2aBFqIDkoi+Zge8=,tag:PM45tYLtRYmXneB0LXnjFQ==,type:str]",
					"description": "ENC[AES256_GCM,data:pG0Dx7Pr7NLZbpQ=,iv:Csm/O4hQu07CNb4ufP2BVYb2ZbpSlniMSN283lkGTXw=,tag:VH2phlp56KDHWECGib1IjQ==,type:str]",
					"password": "ENC[AES256_GCM,data:giyM,iv:aod+gvsXaZh1OiF4FDImeSaeBhHIY4IQPTY/IT4o10U=,tag:M8Zqs2V0qNdngP8/s6EatA==,type:str]",
					"scope": "ENC[AES256_GCM,data:vAeamqRe,iv:wbSHMdNKKdt6p/qbB0YLSzJvmadlOQt8fseNFGE+JSo=,tag:eUXJRi3AAICU2pSNttkIFw==,type:str]",
					"username": "ENC[AES256_GCM,data:phps,iv:xGj1qRn2c/Uct9gWzGQDUJKRZCCMg92ZOD4rIsSQ0tY=,tag:APcgSAQ9W7dhpog7SP17Tw==,type:str]"
				}
			}
```

**What do we expect to see?**

Please search for the issue why its only partially encrypted and fix the root cause.
As a bonus please explain why the second item was already encrypted.



## CHALLENGE 3a

**Goal: Make Kubedoom work on Minikube with a single `terraform apply`.**

Kubedoom as-is won't come up due to a limitation, it will display "Running" for
some time before crashing. To solve that you have to identify, fix and integrate
your solution back to code so that it is easily reproducible.

Nice-to-have: Apart from the bug with Kubedoom itself, the fact of the Pod
displaying "Running" and then crashing is a design flaw that could be addressed.

**What do we expect to see?**

An implementation that allows rolling-upgrades of Kubedoom and works
out-of-the-box. A nice-to-have would be a Helm Chart with the required
specs to deploy a working Kubedoom release.

## CHALLENGE 3b

**Goal: Implement a Jenkins Pipeline for Kubedoom to perform CI/CD on Minikube**

Inside the Terraform folder you will find a Jenkins setup including encrypted
secrets [(instructions available here)](docs/env-preparation.md), the Jenkins
controller (formerly master) password is available at the secrets.

**What do we expect to see?**

We expect you to integrate a [Jenkins Pipeline](https://www.jenkins.io/doc/book/pipeline/#overview)
using the provided Job DSL template for Multibranch pipelines. As this is a
multibranch pipeline, some strategy similar to [Git Flow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
for environment mapping would be nice.

The Terraform code is capable of creating a Jenkins with some folders and has
the capability of creating jobs (although they are not specified yet). Part of
the challenge is to find a way to introduce a job specification to the current
code base.
