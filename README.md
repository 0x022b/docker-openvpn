# docker-openvpn

A minimal and secure [Alpine Linux][alpine] based [Docker][docker] image with
[OpenVPN][openvpn].

## Configuration

### Host user mapping

Host user and group can be mapped to a container by defining `HOST_UID` and
`HOST_GID` environment variables. If the variables are left undefined the
container will execute its command with a random UID/GID combination.

## SELinux

To use this container on a host that has SELinux enabled use the provided
`docker-openvpn.te` policy module or create your own if it doesn't work. To
compile and install the policy module run the following commands.

```
$ checkmodule -M -m docker-openvpn.te -o /tmp/docker-openvpn.mod
$ semodule_package -m /tmp/docker-openvpn.mod -o /tmp/docker-openvpn.pp
# semodule -i /tmp/docker-openvpn.pp
```

## Logging

Container is compatible with `docker logs` command although logging is disabled
by default if the container is started with `docker-compose` command. To find
out more about logging see the command [reference][docker-logs].

### Debug log

To print out a trace of commands executed by `docker-entrypoint` script,
set `DEBUG` environment variable to any non-null value.

## License

This project is licensed under the MIT License.

[alpine]: https://alpinelinux.org/
[docker]: https://www.docker.com/
[openvpn]: https://openvpn.net/
[docker-logs]: https://docs.docker.com/engine/reference/commandline/logs/
