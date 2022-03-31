#!/bin/sh
#!/usr/bin/env bash
sleep 30

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 17.7.0
node -e "console.log('Running Node.js ' + process.version)"
nvm use node
node -v
npm install npm@latest -g
npm -v

# install codedeploy agent
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status
sudo service codedeploy-agent start
sudo service codedeploy-agent status

ls -al
cd /tmp/
echo "$(pwd)"
ls -al
cp webservice.zip /home/ec2-user/
cd /home/ec2-user/
unzip -q webservice.zip
ls -ltr
chown ec2-user:ec2-user /home/ec2-user/webservice
cd webservice
ls -ltr
sudo chmod +x app-server.sh

npm install pm2 -g
sleep 15
sudo env PATH=$PATH:/home/ec2-user/.nvm/versions/node/v17.7.0/bin /home/ec2-user/.nvm/versions/node/v17.7.0/lib/node_modules/pm2/bin/pm2 startup systemd -u ec2-user --hp /home/ec2-user