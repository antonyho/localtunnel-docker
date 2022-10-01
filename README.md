# localtunnel-dockerfile
Dockerfile for [localtunnel](https://localtunnel.me/) client

### Build
```
git clone https://github.com/antonyho/localtunnel-dockerfile.git
cd localtunnel-dockerfile
docker build -t localtunnel .
```

### Usages
You can find out the usage options by yourself.
```
docker run --rm localtunnel -h
```

### General Usage
Assume that you have a service accessible on your localhost port 8080, below command will let the container to access your host exposed service.
```
docker run --name localtunnel --rm --network=host localtunnel --local-host host.docker.internal --port 8080 --subdomain localtunnel-example
```
Then your service will be accessible at `localtunnel-example.loca.lt`.

To stop it, you need to use docker command.
```
docker stop localtunnel
```

### docker-compose
Create your own docker-compose file and deploy the localtunnel along with your service. Remember to use a network to expose the connection between them.
Example [docker-compose-example.yml](./docker-compose-example.yml)
```
version: "3.9"

services:
  server:
    image: nginx
    networks: 
      - tunnel
  localtunnel:
    build: .
    restart: on-failure
    command:
      --local-host tunnel --port 80 --subdomain localtunnel-example
    networks: 
      - tunnel
    depends_on:
      - server

networks:
  tunnel:

```
