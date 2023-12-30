#!/bin/bash

# check cert renewal everyday
#(crontab -l ; echo "0 0 * * * /bin/bash $(pwd)/90renew.sh") | crontab -

# cron job: cert renewal everyday
echo "===== schedual certificate renewal everyday ====="
cron_renewal="0 0 * * * /bin/bash $(pwd)/90renew.sh"
if ! crontab -l | grep -q "${cron_renewal//\*/\\*}"; then
    (crontab -l ; echo "$cron_renewal") | crontab -
    echo "New cron job added."
else
    echo "Cron job already exists."
fi

