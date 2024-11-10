# bash-scripts

these scripts are being made on my journey to become a pentester. I will be updating them as frequentley as i can and if there are any issues let me know! 

some of these scripts (run_wpa_supplicant.sh) can be run on reboot using a cronjob. heres an example ... 

sudo crontab -e (to edit cronjobs)

@reboot sleep 10 /path/to/script

make sure you change permissions on the script , heres and example:

chmod +x <script.sh>
