#!/bash/bin
home=/home/pi
sys_path=/home/pi/printer_data/config/src/system_config
config=/home/pi/printer_data/config
sudo apt update
sudo apt upgrade -y
cd /home/pi/klipper_config/
git pull
cd $home
sleep 1
rm -rf $home/configBKP
mkdir $home/configBKP
chown pi:pi $home/configBKP
cp -a $home/printer_data/config/. $home/configBKP/
cd /home/pi
mv $home/printer_data/config/standalone.cfg $home/standaloneTMP.cfg
mv $home/printer_data/config/crowsnest.conf $home/crowsnestTMP.conf
mv $home/printer_data/config/timelapse.cfg $home/timelapseTMP.cfg
mv $home/printer_data/config/src/paths.py $home/pathsTMP.py
mv $home/printer_data/config/shell_command.cfg $home/shell_commandTMP.cfg
mv $home/printer_data/config/.master.cfg $home/.masterTMP.cfg
rm -rf $home/printer_data/config
cp -a $home/klipper_config/. $home/printer_data/config/
mv $home/standaloneTMP.cfg $home/printer_data/config/standalone.cfg
mv $home/crowsnestTMP.conf $home/printer_data/config/crowsnest.conf
mv $home/timelapseTMP.cfg $home/printer_data/config/timelapse.cfg
mv $home/pathsTMP.py $home/printer_data/config/src/paths.py
mv $home/shell_commandTMP.cfg $home/printer_data/config/shell_command.cfg
mv $home/.masterTMP.cfg $home/printer_data/config/.master.cfg
chown pi:pi $config/standalone.cfg
chown pi:pi $config/crowsnest.conf
chown pi:pi $config/timelapse.cfg
chown pi:pi $config/shell_command.cfg
chown pi:pi $config/.master.cfg
sleep 1
export DISPLAY=:0
export XAUTHORITY=/home/pi/.Xauthority
xdotool key F5