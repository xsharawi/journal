#!/bin/bash 

format=$(date +%Y-%m-%d-T%H-%M)
journalctl --since "1 hour ago" > /var/log/"kernel-logs-$format".txt
sudo tar -cvjSf /var/log/"kernel-logs-$format".tar.bz2 /var/log/"kernel-logs-$format".txt && sudo -u ubuntu /home/ubuntu/bin/dbxcli put /var/log/"kernel-logs-$format".tar.bz2

