# docker-git2consul

Docker image for [git2consul](https://github.com/Cimpress-MCP/git2consul)

## Up and running

```bash
$ mkdir -p /tmp/git2consul.d
$ cat <<EOF > /tmp/git2consul.d/config.json
{
  "version": "1.0",
  "repos" : [{
    "name" : "sample_configuration",
    "url" : "https://github.com/ryanbreen/git2consul_data.git",
    "branches" : ["dev"],
    "hooks": [{
      "type" : "polling",
      "interval" : "1"
    }]
  }]
}
EOF

$ docker run -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h node1 --name consul progrium/consul -server -bootstrap
$ CONSUL_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' consul)
$ docker run -d --name git2consul -v /tmp/git2consul.d:/etc/git2consul.d cimpress/git2consul --endpoint $CONSUL_IP --port 8500 --config-file /etc/git2consul.d/config.json

# Run with private repository
$ docker run -d --name git2consul \
    -v /tmp/git2consul.d:/etc/git2consul.d \
    -v /tmp/private_key:/private_key \
    -e PRIVATE_KEY=/private_key \
    cimpress/git2consul --endpoint $CONSUL_IP --port 8500 --config-file /etc/git2consul.d/config.json
```
*Note: PRIVATE_KEY defaults to /setup/id_rsa*

*Note: If using docker-machine, you will need to place `config.json` in the host VM.*

## Additional information

If using webhooks, you will have to expose the ports that are going to be used.
