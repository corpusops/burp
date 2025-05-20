#
# Regular cron jobs for the burp package
#
# CLIENT
# Run the burp client every 20 minutes with the 'timed' option.
# Sleep a random number of seconds from 0 to 1200 (20 minutes) before
# contacting the server.
# The burp server will decide whether it is yet time to do a backup or not.
#0,20,40 * * * *	root	/usr/sbin/burp -a t -q 1200 >>/var/log/burp-client 2>&1

# SERVER
# Send a summary at 6 every morning.
# If your server is using a different config file to /etc/burp/burp-server.conf,
# change the first argument to its path.
#0 6 * * *	root    /etc/burp/send_summary /etc/burp/burp.conf youremail@example.com "Daily backup summary"

# The following will run file deduplication over all client storages every
# Saturday at 8 in the morning. Again, if your server is using a different
# config file to /etc/burp/burp-server.conf, change that argument.
#0 8 * * 6	root    /usr/sbin/bedup -l -c /etc/burp/burp-server.conf >>/var/log/burp-bedup 2>&1
