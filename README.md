# Nagios2Slack

Nagios notifications for Slack, with formatted messages :

![OK](http://env.baarnes.com/nagios2slack/ok.png?git)
![Critical](http://env.baarnes.com/nagios2slack/critical.png?git)

* Set up an incoming webhook integration in your Slack workspace.</br>
( [https://my.slack.com/services/new/incoming-webhook/](https://my.slack.com/services/new/incoming-webhook/) )

* Copy the two scripts to your nagios plugins directory. ( could be '/usr/lib64/nagios/plugins/' but location may vary )

* Edit the Slack URLs in both scripts to reflect the webhooks you created in Slack.

* Define the new notification commands in Nagios.
( see examples in slack_commands.cfg, modify any paths as required)

* Set up a new contact to use the new host and service notification commands.


## Setup example

```sh
cd /usr/lib64/nagios/plugins/
sudo git clone -b include https://github.com/snickerjp/Nagios2Slack.git
cd /usr/lib64/nagios/plugins/Nagios2Slack
sudo cp slack_commands.cfg /etc/nagios/conf.d/

# edit config
cp slack_notify_config.sh.template slack_notify_config.sh
vi slack_notify_config.sh # SLACK_URL and FOOTER_ICON
```
