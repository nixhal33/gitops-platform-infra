# Terraform commands

Run these from a root folder (`terraform/` or `envs/staging/`), never from `modules/`.

## Daily workflow

| Command | What it does |
|---|---|
| `terraform init` | Downloads providers and connects the backend. Run once per folder, and again after adding a module or changing the backend. |
| `terraform fmt -recursive` | Formats all `.tf` files. No output means already formatted. |
| `terraform validate` | Checks syntax and references. |
| `terraform plan` | Previews changes. Read the last line: `X to add, Y to change, Z to destroy`. |
| `terraform apply` | Applies the plan after you type `yes`. |
| `terraform destroy` | Deletes everything in this folder's state. |

Skip the prompt with `-auto-approve` (always `plan` first):

```
terraform apply -auto-approve
terraform destroy -auto-approve
```

## Useful extras

```
terraform -chdir=envs/staging plan      # run from the repo root without cd
terraform plan -out=tfplan              # save a plan
terraform apply tfplan                  # apply exactly that plan
terraform destroy -target=module.compute  # destroy one module only
terraform output                        # show output values
terraform state list                    # list managed resources
terraform providers lock -platform=linux_amd64 -platform=darwin_arm64
terraform force-unlock <LOCK_ID>        # only if a crashed run left a stale lock
```

## Plan symbols

| Symbol | Meaning |
|---|---|
| `+` | create |
| `~` | change in place |
| `-` | destroy |
| `-/+` | destroy and recreate (read carefully) |

## Order of operations

1. `terraform/` (bootstrap): creates the S3 state bucket, uses local state.
2. `envs/staging/`: uses the bucket as its backend, builds networking, security and compute.
3. Destroy in reverse: `envs/staging/` first, bootstrap last.

## Rules

- Never commit `*.tfstate`, `*.tfvars` or `.terraform/`. Do commit `.terraform.lock.hcl`.
- Backend blocks can't use variables, so write the values out.
- Set `AWS_PROFILE` before running Terraform if you use more than one AWS account.
- Run `terraform destroy` when you stop working, to protect your credits.
