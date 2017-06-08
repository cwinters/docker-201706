# Overview

## What is Docker?

Technical answer:

- Docker is a set of tools around Linux contaners that facilitate reuse and sharing.
- Other things manage Linux containers, too.
- Containers let you bundle some application with required libraries.
- Containers provide some secure separation via cgroups and namespaces.
- Containers are not VMs. You should not think of them as VMs.

Non-technical answer:

- Docker and its ecosystem are the easiest way I have seen to get software from
  your computer through testing and into production and be confident that it
  will run.

## Things to come away with

* Containers bundle libraries and dependencies along with your code and allow
  you to distribute that bundle anywhere you want. (Think of a pithy way to say
  this.)

* Containers strongly encourage you to think about your application in a 12
  Factor way (swimming upstream)

* Being stateless makes using containers far, far easier. (Not a surprise!)

* Just because you're using containers for one thing doesn't mean you have to
  use it for all things (e.g., databases)

* The systems for managing containers in production are still really young,
  though some of them are certainly more popular than others.

## Our story, very briefly

* one motivation: ML stack a PITA to install and keep consistent

## Containers, very briefly

[cgroups](https://en.wikipedia.org/wiki/Cgroups) are a way to create limits for
a set of processes to constrain memory, limit CPU, and monitor.

The [Docker filesystem](https://medium.com/@nagarwal/docker-containers-filesystem-demystified-b6ed8112a04a)
lets you layer filesets on top of one another, kindasorta how git lets you
layer changesets on top of one another. Layers can be cached and shared.

## It's a client-server architecture

* This is technically interesting but it has some interesting implications to
  how you use it.
* How can you tell? Do a `docker version`, it's pretty explicit:

```
$ docker version
Client:
 Version:      1.12.2
 API version:  1.24
 Go version:   go1.7.1
 Git commit:   bb80604
 Built:        Sun Oct 16 07:57:31 UTC 2016
 OS/Arch:      darwin/amd64

Server:
 Version:      17.05.0-ce
 API version:  1.29
 Go version:   go1.7.5
 Git commit:   89658be
 Built:        Thu May  4 21:43:09 2017
 OS/Arch:      linux/amd64
```

* How does it know? `DOCKER_HOST` environment variable
* Just like a lot of unix tools, it'll default to a domain socket `/var/run/docker.sock`


## Tags

* A *tag* in Docker is a named identifier for a container
* Again, it's like git -- containers have hashes and you can associate one or more tags with that hash.
* The tag is the *full* identifier, not just the part after the ":"
* host/path/name:version => it's all the tag
* "host" is assumed to be the docker.com registry (hub.docker.com) -- they make
  the tools, they get to define defaults
* auth tokens are associated with "host"


```
$ cat ~/.docker/config.json
{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "somekey",
      "email": "chris@cwinters.com"
    },
    "quay.io": {
      "auth": "someotherkey",
      "email": "chris@cwinters.com"
    }
  }
}
```

so when I do `docker pull quay.io/lightside/svc-awesome:1.2.3` the docker
client will check my credentials to see if it finds a matching one; if so
it'll send along your auth token.


## Gotchas

* Do not use `:latest` for anything except local development.
* Managing dependencies among containers is non-trivial
* ...especially for development. (What is `:latest`
