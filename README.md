pypicloud docker image
======================

# Run new installation:
TODO

# Run existing installation:
`docker run -t -i -v /home/pypicloud:/etc/pypicloud -p 3031:3031 smalllark/pypicloud`

# Run as service:
`docker run -v /home/pypicloud:/etc/pypicloud -p 3031:3031 --name pypicloud --restart=always smalllark/pypicloud`

# Nginx config:

```
upstream docker-pypicloud {
  server localhost:3031;
}

server {
  listen 443;

  # ssl settings
  # ...  
  # ...

  server_name           your-domain.com;

  access_log            /var/log/nginx/your-domain/access.log;
  error_log             /var/log/nginx/your-domain/error.log;

  proxy_set_header Host       $http_host;   # required for docker client's sake
  proxy_set_header X-Real-IP  $remote_addr; # pass on real client's IP

  client_max_body_size 0; # disable any limits to avoid HTTP 413 for large image uploads

  # required to avoid HTTP 411: see Issue #1486 (https://github.com/dotcloud/docker/issues/1486)
  chunked_transfer_encoding on;

  location / {
    proxy_pass http://docker-pypicloud;
  }

}
```
