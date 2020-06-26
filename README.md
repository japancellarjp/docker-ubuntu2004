# docker-ubuntu2004
docker ubuntu20.04 with gcloud, supervisord, duply, slackclient

## Usage

```
docker pull japancellarjp/docker-ubuntu2004

# gcloud
docker run --rm \
  --name ubuntu2004 \
  -v ${HOME}/.config/gcloud:/var/www/app/.config/gcloud \
  -u app \
  japancellarjp/docker-ubuntu2004 \
  gcloud config list

# git
GITERPO="${HOME}/gitrepo"
docker run --rm \
  --name ubuntu2004 \
  -v ${GITERPO}:/gitrepo \
  -u app \
  -w /gitrepo \
  japancellarjp/docker-ubuntu2004 \
  git config -l

# lvdisplay (for MySQL LVM snapshot backup)
# (docker host OS == docker container OS)
docker run --rm \
  --name ubuntu2004 \
  -v /etc/lvm:/etc/lvm \
  -v /dev:/dev \
  -v /lib/modules:/lib/modules \
  --tty \
  --privileged \
  --cap-add=ALL \
  japancellarjp/docker-ubuntu2004 \
  /usr/sbin/lvdisplay
```

```
git clone https://github.com/japancellarjp/docker-ubuntu2004.git
cd docker-ubuntu2004

# supervisord
docker run --rm \
  -d \
  --name ubuntu2004 \
  -v $(pwd)/test/supervisord.conf.minimal:/supervisord.conf.minimal \
  japancellarjp/docker-ubuntu2004 \
  /usr/local/bin/supervisord -c /supervisord.conf.minimal
docker exec ubuntu2004 supervisorctl -c /supervisord.conf.minimal version
docker stop ubuntu2004

# duply
mkdir -p /tmp/backup
docker run --rm \
  --name ubuntu2004 \
  -v $(pwd)/test/duplytest:/var/www/app/.duply/duplytest \
  -v /tmp/backup:/backup \
  -u app \
  japancellarjp/docker-ubuntu2004 \
  duply duplytest backup
ls -al /tmp/backup

# slack
docker run --rm \
  --name ubuntu2004 \
  -e SLACK_API_TOKEN="..." \
  -v $(pwd)/test/test_slack.py:/test_slack.py \
  -u app \
  japancellarjp/docker-ubuntu2004 \
  /test_slack.py '#general' 'test message'
```

## Library's Version

|production|version|url|note|
|---|---|---|---|
|ubutu|focal-20200423|https://hub.docker.com/_/ubuntu/ |docker image|
|python3|3.8.2-1ubuntu1.1|https://www.python.org/ ||
|gcloud|Google Cloud SDK 296.0.1|https://cloud.google.com/sdk/gcloud/reference |https://cloud.google.com/sdk/docs/downloads-apt-get |
|google-cloud-pubsub|1.6.0|https://googleapis.dev/python/pubsub/latest/index.html |pip|
|supervisord|4.2.0|https://github.com/Supervisor/supervisor |pip|
|duply|2.2-2|https://duply.net/ |apt|
|duplicity|0.8.11.1612-1|http://duplicity.nongnu.org/index.html |apt|
|python3-ijson|2.3-2.1|https://github.com/ICRAR/ijson |apt|
|mysql-connector-python|8.0.20|https://dev.mysql.com/doc/connector-python/en/ |pip|
|timeout-decorator|0.4.1|https://github.com/pnpnpn/timeout-decorator |pip|
|slackclient|2.7.1|https://github.com/slackapi/python-slackclient |pip|
|docker-py|4.2.1|https://github.com/docker/docker-py |pip|
|boto|2.49.0|https://github.com/boto/boto |pip|
|michaloo/go-cron|v0.0.2|https://github.com/michaloo/go-cron ||
|japancellarjp/go-redis-setlock|v0.0.1.1|https://github.com/japancellarjp/go-redis-setlock |forked from fujiwara/go-redis-setlock|

## Licence

Apache License 2.0

* Library's License

|production|license|license url|note|
|---|---|---|---|
|docker|Apache-2.0|https://github.com/moby/moby/blob/master/LICENSE ||
|ubutu|Free software + some proprietary device drivers |https://ubuntu.com/licensing ||
|python3|PSF|https://docs.python.org/3/license.html ||
|gcloud|Google Inc|https://cloud.google.com/sdk/ ||
|google-cloud-pubsub|Apache-2.0|https://googleapis.dev/python/pubsub/latest/index.html ||
|supervisord|BSD-derived|https://github.com/Supervisor/supervisor/blob/master/COPYRIGHT.txt ||
|duply|GPLv2|https://duply.net/index.php?title=Duply-license ||
|duplicity|GPLv2|http://duplicity.nongnu.org/vers8/CHANGELOG ||
|python3-ijson|MIT|https://github.com/raimon49/pip-licenses/blob/master/LICENSE ||
|mysql-connector-python|GPL,etc|https://downloads.mysql.com/docs/licenses/connector-python-8.0-gpl-en.pdf ||
|timeout-decorator|MIT|https://github.com/pnpnpn/timeout-decorator/blob/master/LICENSE.txt ||
|slackclient|MIT|https://github.com/slackapi/python-slackclient/blob/master/LICENSE ||
|docker-py|Apache-2.0|https://github.com/docker/docker-py/blob/master/LICENSE ||
|boto|AS IS|https://github.com/boto/boto/blob/develop/LICENSE ||
|michaloo/go-cron|MIT|https://github.com/michaloo/go-cron/blob/master/LICENSE ||
|japancellarjp/go-redis-setlock|MIT|https://github.com/japancellarjp/go-redis-setlock/blob/master/LICENSE ||


## Author

[ihironao](https://github.com/ihironao)
