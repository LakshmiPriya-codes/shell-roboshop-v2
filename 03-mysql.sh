#!/bin/bash

source ./common.sh

check_root

dnf install mysql-server -y &>> $LOGS_FILE
validate $? "Insatallimg MySQL Srver"

systemctl enable mysqld &>> $LOGS_FILE
systemctl start mysqld  &>> $LOGS_FILE
validate $? "Enable and Starte MySQL Srver"


mysql_secure_installation --set-root-pass RoboShop@1 
validate $? "Setting up root password"


print_total_time