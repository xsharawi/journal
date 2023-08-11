#!/bin/bash
set -e

sudo apt update -y && sudo apt upgrade -y
sudo apt install jq -y 

sudo mkdir -p /home/ubuntu/bin

export PATH="$PATH:/home/ubuntu/bin"
echo 'export PATH="$PATH:/home/ubuntu/bin"' >> /home/ubuntu/.bashrc

repo="dropbox/dbxcli"
download_url=$(curl "https://api.github.com/repos/$repo/releases/latest" | jq --raw-output '.assets[1].browser_download_url')
asset_name=$(curl "https://api.github.com/repos/$repo/releases/latest" | jq --raw-output '.assets[1].name')

curl -LO $download_url && mv $asset_name /home/ubuntu/bin/dbxcli && sudo chmod +x /home/ubuntu/bin/dbxcli


curl -O "https://raw.githubusercontent.com/xsharawi/journal/master/journal.service" && sudo mv journal.service /etc/systemd/system/

curl -O "https://raw.githubusercontent.com/xsharawi/journal/master/myscript.sh" && sudo mv myscript.sh /home/ubuntu &&  sudo chmod +x /home/ubuntu/myscript.sh

 
curl -O "https://raw.githubusercontent.com/xsharawi/journal/master/journal.timer" && sudo mv journal.timer /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable journal.timer


sudo reboot
