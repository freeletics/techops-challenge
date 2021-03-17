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

## CHALLENGE 0

Goal: Make Kubedoom work on Minikube with a single `terraform apply`.

Kubedoom as-is won't come up due to a limitation, it will display "Running" for
some time before crashing. To solve that you have to identify, fix and integrate
your solution back to code so that it is easily reproducible.

Nice-to-have: Apart from the bug with Kubedoom itself, the fact of the Pod
displaying "Running" and then crashing is a design flaw that could be addressed.

**What do we expect to see?**

An implementation that allows rolling-upgrades of Kubedoom and works
out-of-the-box. A nice-to-have would be a Helm Chart with the required
specs to deploy a working Kubedoom release.

## CHALLENGE 1

Goal: Implement a Jenkins Pipeline for Kubedoom to perform CI/CD on Minikube

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
