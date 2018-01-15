# Nextcloud docker-compose setup

This is my nextcloud configuration, including database and news-feed updater, for use with the news application.

# Installation

- you need a reverse proxy as a front end.  I use caddy, but nginx will work to.
- git clone repository
- cd repository
- Create a .env with 
```
POSTGRES_PASSWORD=
POSTGRES_USER=
POSTGRES_DB=
NEXTCLOUD_ADMIN_USER=
NEXTCLOUD_ADMIN_PASSWORD=
```
- docker-compose up -d
- use your browser to connect via your reverse proxy.  You should be straight in as admin.

# Configuration

For the news updater to work, you may need to add caddy as a trusted domain (the container accesses nextcloud via the docker internal network).  This is easiest using occ.  

Try 

```
docker exec nextcloud_app_1 cat config/config.php
```

to see the current config, and

```
docker exec -u www-data nextcloud_app_1 ./occ config:system:set trusted_domains 2 --value=caddy
```

to set it, where `2` is the array index.

