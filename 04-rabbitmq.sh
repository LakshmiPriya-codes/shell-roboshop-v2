#!/bin/bash

source ./common.sh

check_root

cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
validate $? "Adding rabbitmq repo"  

dnf install rabbitmq-server -y &>> $LOGS_FILE
validate $? "Installing rabbitmq server"

systemctl enable rabbitmq-server &>> $LOGS_FILE
systemctl start rabbitmq-server  &>> $LOGS_FILE
validate $? "Enabling & Starting rabbitmq server"


rabbitmqctl add_user roboshop roboshop123   &>> $LOGS_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $LOGS_FILE
validate $? "setting up username and password"

print_total_time