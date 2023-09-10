source common.sh
com=frontend
echo Installing Nginx
dnf install nginx -y &>>$log_file
stat_check

echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &&>>$log_file
stat_check

echo Removing Old Nginx content
rm -rf /usr/share/nginx/html/* &&>>$log_file
stat_check



echo Download frontend Code
  curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file
stat_check

cd /usr/share/nginx/html

echo Extracting frontend Code
  unzip /tmp/frontend.zip >>$log_file
stat_check

echo Starting Nginx Service
systemctl enable nginx &&>>$log_file
systemctl restart nginx &&>>$log_file
stat_check
