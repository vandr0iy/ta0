# https://github.com/casey/just

default:
  @just --list --unsorted

# serves the local hugo website on port 1313
serve-raw:
  hugo serve -D

# build a docker image with your hugo website
build:
  docker build . -t ta0

# serves the docker image on port 1313
serve:
  docker run -p 1313:80 ta0

# pulls&updates the submodules
update-submodules:
  @git submodule foreach git pull origin master
