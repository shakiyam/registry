Docker Registry Sample
======================

Simple setup scripts for private Docker registry with self-signed certificate, basic authentication, Web UI

Requirement
-----------

Docker and Docker Compose

How to run your private Docker registry
---------------------------------------

Edit sample.env and rename it to .env. Then, execute the following commands.

```console
make configure
make start
```

Using your private Docker registry from client
----------------------------------------------

Edit sample.env and rename it to .env. Then, connect to your Docker registry by the following commands.

```console
./configure_client.sh
```

Pull the example image from the Docker Hub registry and push it to your private Docker registry.

```console
. ./.env
docker pull hello-world:latest
docker tag hello-world:latest ${REGISTRY_HOST}/hello-world:latest
docker push ${REGISTRY_HOST}/hello-world:latest
```

Web UI
------

The registry UI is reachable http://localhost:8000/

![crane_operator.png](crane_operator.png)

Author
------

[Shinichi Akiyama](https://github.com/shakiyam)

License
-------

[MIT License](https://opensource.org/licenses/MIT)
