# ENVIRONMENT PREPARATION

Instruction on how to get the basics running on your machine before proceeding
with the development.

## Importing the GPG key for Secrets

Sensitive values are stored in the repository as secrets. To read them you will
need to have the private key on your GPG keychain, which will be used by
[Sops](https://github.com/mozilla/sops/) to decrypt the secrets.

```bash
gpg --import .secret/private.gpg
```

When applying the code, Terraform will call gpg and a pinentry will ask for the
passphrase of the key. This should've been shared on the challenge e-mail.
