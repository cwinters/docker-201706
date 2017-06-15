# Sequence

## What are we going to do?

* This is not a Docker tutorial
* You don't need to to know anything about Docker
* My aim: convey Docker's powerful view of the world
* ...and why that's useful for you


* It would probably help if you know a little about docker :-)

## Telling you up front: here's why

* Docker lets you name and share things you build
* Docker runtime constraints move you to 12 Factor thinking

## Hard problems

There are two hard problems in computer science:

1. Naming things
2. Cache invalidation

- Phil Karlton ([via Fowler](https://martinfowler.com/bliki/TwoHardThings.html))

## Naming abstractions is even harder!

(meh)

* Settled long ago on certain names
* What does "Save" actually mean? Or "File"? Or "Copy" and "Paste"?


* We settled on certain abstractions and gave them names
* Some of those names and iconography don't really fit anymore!
* ...put this bag of bits away so I can get it later with a name (yeah, I guess)

## (no title)

Floppy save icon (large)

## Other naming affordances

* The developer hedge of "Tags"

## Temporal displacement

Rick Sebak photo

(king photo: https://www.pghcitypaper.com/Blogh/archives/2017/03/29/wqeds-rick-sebak-launches-crowdfunding-campaign/)
(smiley cookie: http://www.smileycookie.com/non-active-holidays/rick-sebak-smiley-cookies-3.html)
(sandwich photo: http://sandwichweek.pittsburghnorthside.com/CelebrityJudges.aspx)

* Devs lean on 'tags' whenever they're unsure about names
* Hedge against having to give some *thing* more than one name
* Rick Sebak is a Pittsburgh documentarian who talks about "Things that used to
  be there", giving homage to the time-honored Pittsburgh tradition of giving
  directions in relation to buildings that used to be there -- "Turn left by
  where the Willy's used to be"

## Our favorite: the version

* A version is a concept at a point in time
* We try really hard to make it mean something logical

* Versions are a way for us to give a name to a particular flavor of a bag of bits
* Semantic versioning is admirable

## Downfalls of versions

* But what can you *do* with a version?
* Use it for distribution!
* ...but

## DEPENDENCIES

(dependencies image: https://zeroturnaround.com/rebellabs/java-build-tools-how-dependency-management-works-with-maven-gradle-and-ant-ivy/)

## The dream of integrated software components

* You focus on your problem, plugin the rest
* We're closer to the dream than ever
* NPM, RubyGems, Maven, CPAN, PyPI
* ...but

* People have been writing about ISCs for *decades*
* Open source and enterprising hackers building distribution software on top of
  benevolent companies has given us all jobs
* ...how many of you would be here if SOP was releasing once a quarter?
* ...releasing often lets you experiment

## Double-edged sword of easy and frequent

* Easy to version and distribute
* Which lets everyone frequently version and distribute
* Nobody likes hard pinning


* All our dependencies do the same
* ...and their dependencies, and their dependencies
* ...libraries rarely hard pin versions because they don't want to have to
  monitor all of them for bug/security fixes

## It feels like...

cats_playing_ping_pong.gif

## Docker images

* Docker image is the immutable result of a build
* Every one has a unique hash ID (like Git)
* A change to an image makes a new hash ID (like Git)
* One or more unique tags can reference that hash ID (like Git)

## Images are for sharing

* Images are the granularity and means of distribution
* `docker pull` --> Bring an image to me
* `docker push` --> Send an image somewhere else

## An image is all the code you need

* Your code
* Your dependencies (and theirs)
* Your runtime and supporting libraries
* ...and it has a name!

## What was a version again?

* A version is a concept at a point in time
* ...Docker makes that runnable!

## Pull...

(look up this actual version!)

```
$ docker pull nktpro/swagger-cli:0.0.8
0.0.8: Pulling from nktpro/swagger-cli
12b41071e6ce: Already exists
a3ed95caeb02: Pull complete
92d79449cdd2: Pull complete
411450e8f560: Pull complete
Digest: sha256:204aee80c9111fde723a94b3606061a02fe8974344ac4c4222a7e793c9a91d58
Status: Downloaded newer image for nktpro/swagger-cli:0.0.8

```

## ...and run

```
$ ls
... swagger.yaml ....
$ docker run -v $(pwd):/app \
    nktpro/swagger-cli:0.0.8 \
    validate /app/swagger.yaml
/app/swagger.yaml is valid
```

## Tell docker to do something

```
$ <b>docker run</b> <i>-v $(pwd):/app \
    nktpro/swagger-cli:0.0.8 \
    validate /app/swagger.yaml</i>
```
## Share our directory with the container

```
$ <i>docker run</i> <b>-v $(pwd):/app</b> \
    <i>nktpro/swagger-cli:0.0.8 \
    validate /app/swagger.yaml</i>
```

## Our lovely name!

```
$ <i>docker run -v $(pwd):/app</i> \
     <b>nktpro/swagger-cli:0.0.8</b> \
     <i>validate /app/swagger.yaml</i>
```

## Command plus arguments

```
$ <i>docker run -v $(pwd):/app \
    nktpro/swagger-cli:0.0.8</i> \
    <b>validate /app/swagger.yaml</b>
```

## Things I don't care about anymore

* What language is this tool written in?
* What libraries does it use?
* Does it work with my version of ruby/python/java?
* Do I have to create a gemspec/virtualenv?
* How do I install this container?

## ...but I can find out if I want

* An image is the result of `docker build`
* Build uses a `Dockerfile`
* `Dockerfile` is just text

## Dockerfile for swagger-cli

```
SHOW THIS
```

## Dockerfile is instructions

* Install everything you need
* ...but you don't have to start from scratch

## FROM is sharing

* The first line of the `Dockerfile` is `FROM`
* There's another name!
* Someone else has done work for us!
* We can use it AS IS and build on it!

## Rewind a sec... already exists?!

```
$ docker pull nktpro/swagger-cli:0.0.8
0.0.8: Pulling from nktpro/swagger-cli
12b41071e6ce: Already exists
...
```

## Remember: every image has a hash

* That image is cached by hash
* That cached image can be shared among multiple images
* For example, multiple images have `FROM alpine:3.4`
* Docker only stores one of them and everyone uses it

## Sharing code and runtime

* What does all this mean?
* You have a way to share your code
* ...plus its runtime
* ...and allow run as-is or extension

## This Is Powerful!

infinite_coffee_table_book.gif

## Docker containers

* From earlier: Docker <b>image</b> is the result of a build
* Docker <b>container</b> is a running image
* "Can I run more than one container from the same image?"

## Language shift

* Docker <b>container</b> is a process you execute
* "Can I run more than one process from the same binary?"
* Of course!

## 

keanu_whoa.gif

## A container is a running process

* Think of it as a process plus all the stuff it needs to run
* Docker makes this explicit with STD(ERR|IN|OUT)
* But... "needs to run"?

## What do you need to run?

* Environment
* Network
* STDIN/STDOUT/STDERR
* Storage

## 12 Factor: ?

* Who knows what 12 Factor apps are?

## 12 Factory: Really?

* Who is using 12 Factor apps in production?

## Similar to Docker: A way of viewing the world

* Stateless apps
* Configure via environment
* Use stateful services over the network
* Log as stream, not to files
* Others, see [12factor.net](https://12factor.net/)

* From experience starting and running Heroku

## Luring

https://twitter.com/littleidea/status/875125224752111617

"Lure them in with promises of faster deployments, then hammer them with 12 Factor --Verizon"

## Stateless

* Try your darndest not to need mutable files
* Think about what you're really using that file for
* Can you use a file over the network? (S3)
* Can you use a cache? (Redis, Memcache)

## Environment for configuration

* Might feel very primitive -- simple keys and values????
* You can still have dynamic configuration files
* ...just put variances in the environment
* Database, S3, Redis, Email host, Log aggregator, etc

## Stateful services

* Get out of the habit of storing state in-memory
* Even sessions -- load balanced sticky sessions are a crutch
* Connecting to write- and read-databases? Two URLs!
* Change is really, really easy

* TTM experience working with Heroku and Redis

## Logging streams

* A container's STDOUT/STDERR will be that of its running process
* Docker allows you to send that stream somewhere else with log drivers
* You don't have to rely on Docker logging
* Log aggregation services

## How we log?

* Option 1: Every container sends its logs to aggregator
* Option 2: Containers send their logs to another container, which sends them
  to aggregator
* Hands for 1? 2?

## Log forwarding container

* We use Loggly, but it's a commodity
* `rsyslog` container gets logs from other containers on host
* Forwards over HTTPS to aggregator
* We can swap out logging containers, or even tee them, without the runtime
  containers knowing the difference

## Other neat things

* Having all backend services on Docker means we can run on one machine
* Deploy different branches of many projects via Slack (and everyone does it!)
* Run full back-end stack on your laptop
* ...working more on front-end

## Just operations?

* This feels like "operational stuff" <snooze>

wargames_norad_war_room.jpg

# "Just" operations!

* But it's operational stuff the way unit tests are "quality stuff"

tree_eating_machine.gif

# Shaping

It can shape how you think about problems

we_have_bigger_problems.gif

# Powerful

That's a powerful thing indeed.

string_cuts_knife.gif

# Thank you!

Chris Winters
[@cwinters](https://twitter.com/cwinters/)


# Garbage

## What is Docker?

Technical answer:

- Docker is a set of tools around Linux contaners that facilitate reuse and sharing.
- Yes, other things manage Linux containers, too.
- Containers let you bundle some application with required libraries.
- Containers provide some secure separation via cgroups and namespaces.
- Containers are not VMs. You should not think of them as VMs.

Non-technical answer:

- Docker and its ecosystem are the easiest way I have seen to get software from
  your computer through testing and into production and be confident that it
  will run.

## Things to come away with

* Containers bundle libraries and dependencies along with your code and allow
  you to distribute that bundle anywhere you want.
    * Better way: give your code + dependencies a name and run them

* Containers strongly encourage you to think about your application in a 12
  Factor way (swimming upstream if not)
    * Configuration
    * Logging
    * Declare your ports and give them standard health checks

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


# An image is the result of a build and it has a name

* It turns out naming this is really important.
* This is a (somewhat sneaky) side effect of REST: name your resources
* "It *looks* like a project + version, we already have that!"
* ...but it's a **runnable version** project + version + dependencies

## Gotchas

* Do not use `:latest` for anything except local development.
* Managing dependencies among containers is non-trivial
* ...especially for development. (What is `:latest`)
