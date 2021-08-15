# Cherwell-Slackbot
Slack-bot that listens in on slack conversation for a user to type in a 6-digit Cherwell service management ticket number, and returns the corresponding hyperlink to said Cherwell ticket. 

## Installation
* Navigate to the root directory of this project, and create a virtual environment: 
```bash
User@User Cherwell-Slackbot $ python3 -m venv slackbot_env
```

* Activate the virtual environment packaged within this project.
* Indication that you've entered the virtual environment is the presence of parentheses and the name of the virtual environment preceding the username in the terminal: 
```bash
(Cherwell-Slackbot) User@User Cherwell-Slackbot $ source slackbot_env/bin/activate
```
* Download package dependecies: 
```bash
(Cherwell-Slackbot) User@User Cherwell-Slackbot $ pip3 install -r requirements.txt
```
* Check to confirm that dependecies have been downloaded:
```bash
(Cherwell-Slackbot) User@User Cherwell-Slackbot $ pip3 list

Package        Version
-------------- -------
click          7.1.2
Flask          1.1.4
itsdangerous   1.1.0
Jinja2         2.11.3
MarkupSafe     1.1.1
pip            20.2.2
pyee           7.0.4
python-dotenv  0.19.0
setuptools     49.1.3
slack-sdk      3.8.0
slackeventsapi 2.2.1
Werkzeug       1.0.1

```




## Requirements
* Create a Slack app. Click [here](https://api.slack.com/authentication/basics#creating) for instructions if needed.
* Install Cloudflared using the instructions [here](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation)
* Authenticate Cloudflare using the instructions [here](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/setup)
* Create a Cloudflared argo tunnel. This enables the Slack app to listen in on Slack channel conversations in real-time. Click [here](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/create-tunnel) for instructions if needed.


## Enable and Gather Credentials
* Click [here](https://api.slack.com/apps) to view the list of your Slack apps and select your Slack app. Click the Slack app you've created for this project. 
* Take note of the ***Signing Secret*** as seen below in the App info page:

<img src="./images/img1.png"/>

* Next, go to the **OAUTH & Permissions** tab, and add the following OAUTH scopes under the **Scopes** tab.  
  * ***channels:history***
  * ***chat:write***
  * ***groups:history***


<img src="./images/img2.png"/>

* After adding these scopes, **Reinstall** the app to the workspace, and take note of the Bot User Token: 

<img src="./images/img3.png"/>



## Setting environmental variables
* Refer back to the **Signing Secret** and the **Bot Token** you created earlier
* Navigate to the root of this project, and create a .env file and set these tokens as environment variables:
```bash
User@User Ticket-Bot $ touch .env

# Sample output
1 SIGN_SEC=YourSigningSecret
2 SLACK_BOT_TOKEN=YourBotToken
3 BASE_LINK=CherwellBaseLink
                                                                          
```
* Save the .env file

## Running the script
* Assuming your Cloudflared Argo tunnel is properly configured, make the `run` and `bot` python executable files have execution permissions to run flask on port 5000 and expose localhost port 5000 to the internet: 
```bash 
User@User Cherwell-Slackbot $ chmod u+x run
User@User Cherwell-Slackbot $ chmod u+x bot
User@User Cherwell-Slackbot $ ./run
```
* After running the executable, you should have 3 log files : 
```bash
User@User Cherwell-Slackbot $ ls 

bot  cloudflared.log  flask.log  images  LICENSE  Log.log  README.md  requirements.txt  run  slackbot_env
```
* Take note of the log file `cloudflared.log` and view the contents using `cat`. The output should look like something similiar below:
```bash
User@User Cherwell-Slackbot $ cat cloudflared.log

2021-08-12T18:52:38Z INF Route propagating, it may take up to 1 minute for your new route to become functional
2021-08-12T18:52:38Z INF Each HA connection's tunnel IDs: map[0:4six4cvv1c05469nv11d9pag 1:4six4cvv1c05469nva7vqf66bufsntg11d9pag 2:4six4cvv1c05469nva7vqf66b3:4six4cvv1c05469nva7vqf66bgxkxkqxnlplhayufsntg11d9pag]
2021-08-12T18:52:38Z INF +----------------------------------------------------------------------+
2021-08-12T18:52:38Z INF |  Your free tunnel has started! Visit it:                             |
2021-08-12T18:52:38Z INF |    https://meaningful-atmospheric-explaining-park.trycloudflare.com  |
2021-08-12T18:52:38Z INF +----------------------------------------------------------------------+
```
* Take note of the hyperlink `https://mean-apple-golash-parka.trycloudflare.com`. This is the link we use to enable slack events API to send data to. 



* Take note of the link above. 


## Enable Slack Event Subscriptions
* Navigate to the Slack Apps [homepage](https://api.slack.com/apps), and select your app you used for this project
* Navigate to the **Event Subscriptions** tab, and paste the Cloudflared Argo tunnel link (in our case, `https://mean-apple-golash-parka.trycloudflare.com`) you retrieved in the previous section into the **Request URL** field: 
* If everything is working properly, there should be a **Verified** notification near the URL field followed by a ✅ . 

<img src="./images/img4.png"/>

* Next, add the events **messages.channel** and **message.groups** for the Slackbot to subscribe to:


<img src="./images/img5.png"/>

* Reinstall the Slack app if needed. 


## Enable Interactive Components
* Enabling interactive components in our app allows for us to collect user input with the button included in our Cherwell Ticket hyperlink payload. 
* Navigate to the Slack app [homepage](https://api.slack.com/apps), select your app, and go to the **Interactivity and Shortcuts** tab
* Turn on **Interactivity & Shortcuts** and Enter the same URL from Cloudflare (in our case, `https://mean-apple-golash-parka.trycloudflare.com`) into the **Request URL** field:
<img src="./images/img6.png"/>

* If everything is functioning properly, there should be a **Verified** notification near the URL field followed by a ✅ .
* Click the **Save Changes** button, and reinstall the app if needed.

## Testing
* Open and sign-in to the Slack App either on Desktop or via browser.
* Next, type the command `/invite @YourBotName` into the channel you want to add the bot to and press Enter: 

<img src="./images/img7.png"/>

* Now that the bot is added to the channel, as a different user, type text into the channel including a 6-digit ticket number like ```Ticket Bot Test - Ticket # 234211```

If everything is working properly, you should recieve an output similiar to this: 

<img src="./images/img8.png"/>


## **Contributing**

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## **License**

[MIT](https://choosealicense.com/licenses/mit/)




