log_file=/tmp/expense.log
echo Installing Nginx
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
fi

echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &&>>$log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
fi

echo Removing Old Nginx content
rm -rf /usr/share/nginx/html/* &&>>$log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
fi

cd /usr/share/nginx/html

echo Download $component Code
  curl -s -o /tmp/$frontend.zip https://expense-artifacts.s3.amazonaws.com/$frontend.zip >>$log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
fi

echo Extracting $component Code
  unzip /tmp/$component.zip >>$log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
fi

echo Starting Nginx Service
systemctl enable nginx &&>>$log_file
systemctl restart nginx &&>>$log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
fi
