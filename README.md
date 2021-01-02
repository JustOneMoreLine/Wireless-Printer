# Wireless Printer
## Setup
Follow the instructions below or just import WirelessPrinter.ova to your Virtual Machine Box 
### A.Install linux-4.15.1-popcorn-0.2
run <code>sudo dpkg -i linux-*-4.15.1-popcorn-0.2*</code>

### B. Install and setup CUPS
1. run

<code>
	sudo apt-get install cups -y;
  	sudo systemctl start cups;
  	sudo systemctl enable cups;
</code>

2. Configure cups by copying cupsd.conf to /etc/cups/cupsd.conf

<code>
	sudo cp cupsd.conf /etc/cups/cupsd.conf;
	sudo systemctl restart cups;
</code>

3. Add yourself to CUPS lpadmin group
<code>
  sudo usermod -a -G lpadmin 'yourself';
  sudo systemctl restart cups;
</code>


### C. Install EPSON L1300 Series Printer
1. Install lsb
<code>sudo apt-get install lsb;</code>
2. (conditional) sometimes there will be broken packages. If so run
<code>sudo apt --fix-missing;</code>
and then retry step 1.
3. Install EPSON
<code>sudo dpkg -i epson-inkjet-printer-201311w_1.0.1-1lsb3.2_amd64;</code>
4. Set printer as default
<code>sudo lpoptions -d EPSON_L1300_Series;</code>
5. Open CUPS web interface on localhost:631 or systems ip address on port 631 (ex:192.168.1.253:631)
6. Click "Adding Printers and Classes"
7. Log in with your normal system log
8. Click "Add printer"
9. Pick EPSON_L1300_Series and continue
10. Tick "Share this printer" and continue
11. Click "continue"
12. Click "Add Printer"
13. Set your default settings, and click "Set Default"


### D. Configure initramfs.conf
1. Edit /etc/initramfs-tools/initramfs.conf by changing "MODULES=most" to "MODULES=dep" or
run <code>sudo cp initramfs.conf /etc/initramfs-tools/initramfs.conf</code>
2. run <code>sudo update-iniramfs -u</code>

### E. Set wirepri to run automatically
1. Copy wirepriWANservice.sh to /root by <code>sudo cp wirepriWANservice.sh /root/wirepriWANservice.sh</code>
2. Copy wirepriWAN.service to /lib/systemd/system by <code>sudo cp wirepriWAN.service /lib/systemd/system/wirepriWAN.service</code>
3. run <code>sudo systemctl start wirepriWAN.service; sudo systemctl enable wirepriWAN.service</code>
done

### F. Set a static IP
1. Edit your netplan setting by running <code>sudo vi /etc/netplan/*.yaml</code>
2. Follow the 50-cloud-init.yaml as an example
3. Save

## How to use
1. Open the system
2. Print by uploading file to http://wirepri.herokuapp.com/ or print from a printing software from a device on the same network as your system.
