####Create the image

```
docker build -t fuseki github.com/ppiersonbt/fuseki-docker.git

or

docker build -t fuseki .
```

###Run the fuseki container
```
docker run -it -P --name some-name fuseki
```

###Locate the exposed port
```
docker port some-name
3030/tcp -> 0.0.0.0:32787
```

Go to docker-machine-ip:exposed-port
