# Hello World AWS Lambda

This is a simple AWS Lambda function that will return a "Hello World" message.

I normally use <a href="https://gitlab.com/davidevi/">GitLab</a> instead of GitHub with CircleCI but decided that it would be wiser to mirror your stack for this project.

## Set Up

Versions utilised:
- Python 3.10 (latest Lambda supported runtime)
- Terraform 

I normally create a top-level CLI that automates the ops in the project.

For the sake of simplicity I wanted to stick to the traditional `Makefile`, but the `aws-cli` image does not come with `make` preinstalled so that's all the reason I needed to use the CLI approach. (Naturally, I could have used a custom image but then that adds maintenance overhead).

Make the CLI executable first:
```bash
chmod +x cli
```

## Usage

Run the tests:
```bash
./cli tests
# or
./cli t
```

Provide the credentials and configuration:
```bash
cp .env.example .env
vim .env # Or whatever editor you prefer
```

Deploy the Lambda:
```bash
./cli deploy
# or 
./cli d
```

# Insights

## Lambda

I used PyEnv to peg the version to 3.10 (latest Lambda supported runtime).

I normally use Poetry for managing the local package but thought it would be 
overkill in this case, I've just manually written the `requirements.txt` file.

## Terraform

I used TfEnv to peg the version to 1.4.6 (latest version at the time of writing).

