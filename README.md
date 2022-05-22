# Test assignment: Deploy a container to ECS

In this assignment we deploy a simple static website made w/ hugo to ECS FARGATE using cloudformation as
the orchestration tool of choice. The reason I went w/ cloudformation over terraform despite the latter's clearly
superior tooling is because it's easier to set up automatic rollbacks in case of a deployment failure.

Technologies used:
- [nix](https://nixos.org/guides/how-nix-works.html), the package manager
- [just](https://github.com/casey/just)
- [AWS cloudformation](https://aws.amazon.com/cloudformation/)
- [hugo](https://gohugo.io/)
- [docker](https://www.docker.com/)


Some considerations:
- I assume a Route53 zone is already up and in place - setting one up is outside of the assignment's scope, imho
- only a test environment has been set up.

