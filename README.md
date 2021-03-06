# OpenVPN container image

![Docker Build Status](https://img.shields.io/docker/cloud/build/0x022b/openvpn?style=flat-square)
![Docker Image Version](https://img.shields.io/docker/v/0x022b/openvpn?sort=semver&style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/0x022b/openvpn?sort=semver&style=flat-square)

Minimal and secure [Alpine Linux][alpine] based [Docker][docker] image with
OpenVPN client.

## Security

### init

[Tini][tini] is used by the container as an `init` process. It protects the system
from process table being filled up, which can prevent the system from spawning any
new processes, by reaping zombie processes.

In addtion to reaping zombies Tini also performs signal forwarding.

### Firewall

Container uses iptables to configure packet filtering rules in the Linux kernel
and therefore `CAP_NET_ADMIN` capability is required to run the container.

Outbound IPv4 network traffic is only allowed using the protocol, address(es) and
port(s) defined in the OpenVPN configuration file. All outbound traffic that is
routed through the VPN tunnel is allowed.

All IPv6 traffic is blocked.

## Configuration

### Host user mapping

Host user and group can be mapped to a container by defining `HOST_UID` and
`HOST_GID` environment variables. If the variables are left undefined the
container will execute its command with a random UID/GID combination.

## SELinux

To use this container on a host that has SELinux enabled use the provided
`docker-openvpn.te` policy module or create your own if it doesn't work. To
compile and install the policy module run the following commands.

```shell
$ checkmodule -M -m docker-openvpn.te -o /tmp/docker-openvpn.mod
$ semodule_package -m /tmp/docker-openvpn.mod -o /tmp/docker-openvpn.pp
# semodule -i /tmp/docker-openvpn.pp
```

## Logging

Container is compatible with `docker logs` command although logging is disabled
by default if the container is started with `docker-compose` command. To find
out more about logging see the command [reference][docker-logs].

### Debug log

To print out a trace of commands executed by `container-entrypoint` script,
set `DEBUG` environment variable to any non-null value.

## License

This project is licensed under the MIT License.

[alpine]: https://alpinelinux.org/
[docker]: https://www.docker.com/
[openvpn]: https://openvpn.net/
[docker-logs]: https://docs.docker.com/engine/reference/commandline/logs/
[tini]: https://github.com/krallin/tini
