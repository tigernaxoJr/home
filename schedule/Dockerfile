FROM alpine:3.18

# add curl, bash
RUN apk update && apk add --no-cache curl bash tzdata
RUN apk add --no-cache jq # required by ddns
ENV TZ Asia/Taipei

# copy crontabs for root user
COPY script /schedule
COPY cronjobs /etc/crontabs/root

# sudo crond -f -d 8 >> /path/to/cron.log 2>> /path/to/error.log
# start crond with log level 8 in foreground, output to stderr
CMD ["crond", "-f", "-d", "8", ">>", "/schedule/cron.log", "2>>", "/schedule/cron.err"]

