#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ -f ${SCRIPT_DIR}/slack_notify_config.sh ]; then
  # load slack_notify_config.sh
  . ${SCRIPT_DIR}/slack_notify_config.sh
else
  # Edit your Slack hook URL and footer icon URL
  export SLACK_URL=https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX
  export FOOTER_ICON=http://env.baarnes.com/Nagios.png
fi

# Service Notification command example :

# define command {
#                command_name                          slack-service
#                command_line                          /usr/lib64/nagios/plugins/slack_service_notify "$NOTIFICATIONTYPE$"  "$HOSTNAME$" "$HOSTADDRESS$" "$SERVICEDESC$" "$SERVICESTATE$" "$SERVICEOUTPUT$" "$LONGDATETIME$" "$LASTHOSTSTATECHANGE$"
# }

case $5 in

"CRITICAL")
  MSG_COLOR="danger"
  ;;
"WARNING")
  MSG_COLOR="warning"
  ;;
"OK")
  MSG_COLOR="good"
  ;;
*)
  MSG_COLOR="#CCCCCC"
  ;;
esac

IFS='%'

SLACK_MSG="payload={\"attachments\":[{\"color\": \"$MSG_COLOR\",\"title\": \"Service $1 notification\",
\"text\": \"Host:        $2\\nIP:             $3\\nService:    $4\\nState:        $5\"},
{\"color\": \"$MSG_COLOR\",\"title\":\"Additional Info :\",\"text\":\"\\n$6\",
\"footer\": \"Nagios notification: $7\",\"footer_icon\": \"$FOOTER_ICON\"}]}"

#Send message to Slack
curl -4 -X POST --data "$SLACK_MSG" $SLACK_URL

unset IFS
