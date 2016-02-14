from docker import Client
from docker.tls import TLSConfig

tls_config = TLSConfig(client_cert=('/root/.sdc/docker/dissipate/cert.pem', '/root/.sdc/docker/dissipate/key.pem'), verify='/root/.sdc/docker/dissipate/ca.pem')
cli = Client(base_url='https://us-sw-1.docker.joyent.com:2376', tls=tls_config)
print str(cli.containers())
