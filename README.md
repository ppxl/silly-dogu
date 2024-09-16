# silly-dogu
A containerized go application for the Cloudogu EcoSystem to echo back request values

Build this within a local [Cloudogu EcoSystem](https://github.com/cloudogu/ecosystem) with
```bash
git clone git@github.com:ppxl/silly-dogu.git
cd silly-dogu
cesapp build .
cesapp start silly-dogu
```

Once started you can observe some HTTP echoing upon curl requests like so:
```
curl  -k https://192.168.56.2/silly-dogu/hey-you
Echo: /silly-dogu/hey-you
```

Also observe the alternative service route `/schmilly`:

```
curl -I -k https://192.168.56.2/schmilly/hello       
HTTP/2 301
server: nginx/1.26.1
date: Mon, 16 Sep 2024 15:17:37 GMT
content-type: text/html; charset=utf-8
location: /silly-dogu/hello
```

Furthermore, you can observe an additional nginx route in the nginx container:

```bash
docker exec -it nginx cat /var/nginx/conf.d/app.conf
...
   location /schmilly {
        proxy_pass http://172.18.0.16:8080//silly-dogu/;
    }
  
    location /silly-dogu {
        proxy_pass http://172.18.0.16:8080;
    }
...
```
