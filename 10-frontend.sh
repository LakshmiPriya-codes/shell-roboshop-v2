#!/bin/bash

app_name=frontend
source ./common.sh
check_root

dnf module disable nginx -y &>>$LOGS_FILE
dnf module enable nginx:1.24 -y &>>$LOGS_FILE
dnf install nginx -y &>>$LOGS_FILE
validate $? "Installing nginx"

rm -rf /usr/share/nginx/html/*  &>>$LOGS_FILE
validate $? "Removed default code"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOGS_FILE
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOGS_FILE
validate $? "Downloaded and extracted frontend code"

rm -rf /etc/nginx/nginx.conf
validate $? "Removed nginx conf"

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
validate $? "Copied roboshop nginx conf"


systemctl restart nginx
systemctl enable nginx &>> $LOGS_FILE
validate $? "Enabled and restarted nginx"

print_total_time
