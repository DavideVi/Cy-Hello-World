# Hello World AWS Lambda

This is a simple AWS Lambda function that will return a "Hello World" message.

I normally use <a href="https://gitlab.com/davidevi/">GitLab</a> instead of GitHub with CircleCI but decided that it would be wiser to mirror your stack for this project.

## Set Up

I normally create a top-level CLI that automates the ops in the project.

For the sake of simplicity I wanted to stick to the traditional `Makefile`, but the `aws-cli` image does not come with `make` preinstalled so that's all the reason I needed to use the CLI approach. 

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

Deploy the Lambda:
```bash
./cli deploy
# or 
./cli d
```
