#!/bin/bash


source ./common.sh

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo
validate $? "Adding mongo repo" 

dnf install mongodb-org -y &>> $LOGS_FILE
validate $? "Installing Mongodb" 

systemctl --now enable mongod
systemctl start mongod 
validate $? "Starting and Enabling MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g'  /etc/mongod.conf
validate $? "Allowing remote connections to MongoDB"

systemctl restart mongod
validate $? "Restarting MongoDB"

print_total_time