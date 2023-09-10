log_file=/tmp/expense.log

download_and_extract() {
  echo Download $com Code
  curl -s -o /tmp/$com.zip https://expense-artifacts.s3.amazonaws.com/$com.zip >>$log_file
  stat_check

  echo Extracting $com Code
  unzip /tmp/$com.zip >>$log_file
  stat_check
}

stat_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
  fi
}