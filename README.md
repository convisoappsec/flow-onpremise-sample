# Flow on premise sample

This is a demo project to be used as guide for new flow users or developers.

### Installation

Flow requires:
  - docker
  - docker-compose
  - access token to [convisoappsec docker registry]
  - flow license issued by [convisoappsec]


Let's start cloning the demo project.
```sh
$ git clone git@github.com:convisoappsec/flow-onpremise-sample.git flow-onpremise
```
Go to the demo project root folder.
```sh
$ cd flow-onpremise
```
With the access_token file provided by [convisoappsec] you're be able to pull the flow
dependency docker images.
```sh
$ chmod +x scripts/pull_flow_images.sh
$ sudo scripts/pull_flow_images.sh access_token
```
### Configuring
Copy the configuration sample files to be edited.
```sh
$ cp .env.sample .env
```
#### The .env file
Open the file, note that the variable APP_SECRET_KEY_BASE is already set, but we encourage you override it.
Execute the following command to generate a secret.
```sh
$ KEY="$(sudo docker run convisoappsec/flow bundle exec rake secret)"
```
```sh
$ echo "APP_SECRET_KEY_BASE=${KEY}" >> .env
```
Now the __LICENSE_ON_PREMISE_GENERATE_KEY__ variable must be set. The value from this variable is provided by [convisoappsec].


```sh
$ echo "LICENSE_ON_PREMISE_GENERATE_KEY=the-gen-key-provided-by-conviso" >> .env
```
## Running the aplication

After follow all previous steps the flow program can be started using the
docker-compose. Execute the following command.
```sh
$ sudo docker-compose up -d
```
Access the flow application at https://localhost.
See [docker-compose] for more commands.

## Useful commands
To see when the magister and flow services are healthy
```sh
$ sudo watch docker ps
```

To display magister admin credentials to configure integration with flow
```sh
$ sudo docker-compose exec magister-api rake magister:admin:credentials
```

## Development
For developers some few steps are needed.
Yet inside this project root dir, clone the flow source code.
```sh
$ git clone git@github.com:convisoappsec/csc.git
```
Switch to the onpremise branch.
```sh
$ cd csc && git checkout feature/onpremise && cd ..
```
Create docker-compose.override.yml from dev sample. This file will mount the flow source code folders at the docker containers from flow.
```sh
$ cp docker-compose.override.yml.dev docker-compose.override.yml
```
Build the flow images from the code.
```sh
$ sudo docker-compose build
```
From now you're ready to run the application.
```sh
$ sudo docker-compose up -d
```

[docker-compose]: <https://docs.docker.com/compose/>
[docker]: <https://www.docker.com/>
[convisoappsec]: <https://convisoappsec.com/>
[convisoappsec docker registry]:<https://136214147921.dkr.ecr.us-west-2.amazonaws.com>
