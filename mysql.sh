source common.sh

echo Disable MySQL 8 Version
dnf module disable mysql -y &>>$log_file
stat_check


echo Copy MySQL Repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo Install MySQL Server
dnf install mysql-community-server -y &>>$log_file
stat_check

echo Start MySQL Service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo Setup root Password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
stat_check

