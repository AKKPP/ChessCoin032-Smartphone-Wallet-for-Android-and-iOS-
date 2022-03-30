import socket
from curio.socket import getaddrinfo

from ... import _abc as abc


class Resolver(abc.AsyncResolver):
    async def resolve(self, host, port=0, family=socket.AF_UNSPEC):
        try:
            infos = await getaddrinfo(
                host=host,
                port=port,
                family=family,
                type=socket.SOCK_STREAM,
            )
        except socket.gaierror:  # pragma: no cover
            infos = None

        if not infos:  # pragma: no cover
            raise OSError('Can`t resolve address {}:{} [{}]'.format(host, port, family))

        infos = sorted(infos, key=lambda info: info[0])

        family, _, _, _, address = infos[0]
        return family, address[0]
