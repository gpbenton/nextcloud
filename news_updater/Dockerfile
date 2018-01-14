FROM python:alpine

RUN pip install --upgrade nextcloud_news_updater --install-option="--install-scripts=/usr/bin"

CMD nextcloud-news-updater http://caddy/nextcloud/ --user ${NEXTCLOUD_ADMIN_USER} --password ${NEXTCLOUD_ADMIN_PASSWORD} --loglevel info
