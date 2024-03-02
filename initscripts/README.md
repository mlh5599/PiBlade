Init scripts - to make the programs start automatically at boot.  

If you are running a current Raspbian (Jessie or later) with systemd:  
Copy the systemd/*.service files to the /etc/systemd/system/ directory, and then run  

``` sh
sudo systemctl daemon-reload  
sudo systemctl enable hddledPi.service  
sudo systemctl enable netledPi.service  
sudo systemctl enable tailscaleledPi.service
```

If you are running an older Raspbian (Wheezy) with SysV init:  
Copy the sysVinit/* files to the /etc/init.d/ directory, and then run  

``` sh
sudo update-rc.d enable hddledPi  
sudo update-rc.d enable netledPi  
```

Creating init scripts for actledPi is left as an exercise for the reader ;-)
