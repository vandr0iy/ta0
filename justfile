# https://github.com/casey/just

default:
  @just --list --unsorted

# serves the local hugo website on port 1313
serve-raw:
  hugo serve -D

# build a docker image with your hugo website
build tag="ta0-local":
  docker build . -t {{tag}}

# serves the docker image on port 1313
serve:
  docker run -p 1313:80 ta0-local

# pulls&updates the submodules
update-submodules:
  @git submodule foreach git pull origin master

# this deploys the given tag on the given env
deploy env tag:
  @aws cloudformation deploy \
    --template-file ta0.yml \
    --stack-name "{{env}}-ta0" \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides Env="{{env}}" Tag="{{tag}}"

#cloudformation template validation with AWS own API
validate-cfn-template filename="ta0":
  @aws cloudformation validate-template --template-body file://{{filename}}.yml

# launches a config scan with trivy
trivy-scan:
  @trivy config .

# inspect space usage of every docker layer
dive:
  @dive ta0-local
