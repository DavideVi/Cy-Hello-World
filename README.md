# Hello World AWS Lambda

This is a simple AWS Lambda function that will return a "Hello World" message.

I normally use <a href="https://gitlab.com/davidevi/">GitLab</a> instead of GitHub with CircleCI but decided that it would be wiser to mirror your stack for this project (I found it on StackShare.io).

## Set Up

Versions utilised:
- Python 3.10 (latest Lambda supported runtime)
- Terraform 1.4.6 (latest version at the time of writing)

I've recently started creating top-level CLIs that automate the ops in projects; Similar to a Makefile but with fewer limitations.

I did want to stick to a Makefile here for the sake of simplicity, but the `terraform` image did not actually ship with it, so I've decided to just stick with the CLI approach. (Naturally, I could have used a custom image but then that adds maintenance overhead).

I hope it does not come accross as opinionated. 

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

# Notes

## Lambda Function

I used PyEnv to peg the version to 3.10 (latest Lambda supported runtime).

I normally use Poetry for managing the local package but thought it would be 
overkill in this case, I was planning on manually writing the `requirements.txt` file but
it turned out that no additional packages were actually required. 

For some reason my mind initially conflated HTTP with HTML so I initially made it only support HTML; 
Currently it can return both HTML and JSON depending on the specified content type. 

## Terraform

I used TfEnv to peg the version to 1.4.6 (latest version at the time of writing).

I've added the support for CloudWatch in addition to the API gateway because I had to try to figure out why I was getting HTTP 429s (too many requests); For some reason the rate limits were set to `0` and I interpreted that as unlimited. Took me an entire hour to figure out. Once I figured it out, I thought might as well keep the extras there. 

# Shameless Plug

I have written extensively about many of my projects over here: <a href="https://davidevitelaru.com/cv/index.html">https://davidevitelaru.com/</a> (There's even pictures!)

