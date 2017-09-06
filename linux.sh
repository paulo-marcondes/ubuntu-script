#!/bin/bash

function timer()
{
    if [[ $# -eq 0 ]]; then
        echo $(date '+%s')
    else
        local  stime=$1
        etime=$(date '+%s')

        if [[ -z "$stime" ]]; then stime=$etime; fi

        dt=$((etime - stime))
        ds=$((dt % 60))
        dm=$(((dt / 60) % 60))
        dh=$((dt / 3600))
        printf '%d:%02d:%02d' $dh $dm $ds
    fi
}

startTime=$(timer)
echo "$(date) Starting now...:"

t=$(timer)
echo
echo
echo "*************************************"
echo "Adding the needed keys and repositories"
echo "*************************************"
sudo add-apt-repository ppa:numix/ppa -y
sudo add-apt-repository ppa:libreoffice/ppa -y
sudo add-apt-repository ppa:jonathonf/firefox-esr -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list' 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)

t=$(timer)
echo
echo
echo "**********************************"
echo "**** Updating repositories... ****"
echo "**********************************"
sudo apt update -qq
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)

t=$(timer)
echo
echo
echo "*******************************************"
echo "**** Updating your system ****"
echo "*******************************************"
sudo apt upgrade -y
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)

t=$(timer)
echo
echo
echo "*******************************************"
echo "**** Installing ALL packages ****"
echo "*******************************************"
sudo apt install git vlc unrar p7zip numix-icon-theme-circle browser-plugin-freshplayer-pepperflash firefox-esr chrome-stable opera spotify-client audacious playonlinux chromium-browser xfce4-screenshooter soundconverter -y
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)

t=$(timer)
echo
echo
echo "*******************************************"
echo "**** Installing *.deb packages ****"
echo "*******************************************"
cd /media/paulo/F814-8F32/install/Linux/
sudo dpkg -i *.deb
sudo apt install -f
sudo dpkg -i *.deb
cd
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)

t=$(timer)
echo
echo
echo "*******************************************"
echo "**** Installing Apps on /home/Apps/"
echo "*******************************************"
mkdir Apps
cd Apps
wget https://telegram.org/dl/desktop/linux
tar -xvf linux
wget http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office_10.1.0.5707~a21_amd64.deb
sudo dpkg -i *.deb
wget https://www.dropbox.com/s/7qh902qv2sxyp6p/SoulseekQt-2016-1-17-64bit.tgz
tar -zxvf SoulseekQt-2016-1-17-64bit.tgz
wget https://www.torproject.org/dist/torbrowser/7.0.3/tor-browser-linux64-7.0.3_en-US.tar.xz
tar -xvJf tor-browser-linux64-7.0.3_en-US.tar.xz
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)


t=$(timer)
echo
echo
echo "*******************************************"
echo "**** Removing all unecessary packages ****"
echo "*******************************************"
sudo apt autoremove -y
printf 'DONE    ...    Elapsed time: %s \n\n' $(timer $t)

echo "\n\n\n"
echo "********************************"
echo "**** Finished! ****"
echo "********************************"

printf 'Total Elapsed time: %s\n' $(timer $startTime)

echo "$(date) End."





