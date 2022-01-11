#!/bin/bash
SSH_CONFIG="/etc/ssh/sshd_config" 

if [[ $EUID -ne 0 ]]; then
   echo -e " !!! BRAK UPRAWNIEN !!!"
   exit 1
fi

installsudo=$(dpkg -s sudo | grep Status)

if [[ "$installsudo" == "Status: install ok installed" ]]; then
  echo "Sudo zainstalowane"
else
          apt-get install sudo
fi

read -r -p "Chcesz dodać nowego użytkownika i dodac go do sudo ? " varuser
if [[ "$varuser" =~ [yY](es)* ]]

then

read -r -p "Podaj nazwe nowego użytkownika:" VAR_NEWUSER
adduser $VAR_NEWUSER
passwd $VAR_NEWUSER
adduser $VAR_NEWUSER sudo

fi


echo "Obecny port SSH to :"
cat /etc/ssh/sshd_config | grep -w Port

read -r -p "Chcesz zmienic domyslny port SSH ? y/n " varssh
if [[ "$varssh" =~ [yY](es)* ]]

then

read -r -p "Na jaki port chcesz zmienić domyślny port SSH ? " SSH_PORT

sed -i -e "s/^[#\t ]*Port[\t ]*.*\$/Port $SSH_PORT/"  ${SSH_CONFIG}

cat /etc/ssh/sshd_config | grep -w Port

fi

exit 1
