# ENVIRONMENT PREPARATION

Instruction on how to get the basics running on your machine before proceeding
with the development.

## Importing the GPG key for Secrets

Sensitive values are stored in the repository as secrets. To read them you will
need to have the private key on your GPG keychain, which will be used by
[Sops](https://github.com/mozilla/sops/) to decrypt the secrets.

The GPG key pair is [available here](https://github.com/freeletics/techops-challenge/tree/master/.secret).
You'll need to import them to your keychain by running

```bash
gpg --import .secret/private.gpg
```
