#!/bin/bash

# Make bot file executable
if ! grep -q 'cherbot_env' bot; then 
	envpath='#!'"$(pwd)/cherbot_env/bin/python3"
	sudo echo -e "$envpath\n$(cat bot)" > bot
fi
sudo chmod 777 bot 


# Copy cherwellbot service file to systemd
sudo cp cherwellbot.service /lib/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable cherwellbot
sudo systemctl restart cherwellbot
echo cherwellbot service loaded
