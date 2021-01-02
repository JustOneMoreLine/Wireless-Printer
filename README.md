# Wireless Printer Setup
## A.Install linux-4.15.1-popcorn-0.2
run <code>sudo dpkg -i linux-*-4.15.1-popcorn-0.2*</code>

## B. Install and setup CUPS
1. run
<code>
  sudo apt-get install cups -y
  sudo systemctl start cups
  sudo systemctl enable cups
</code>
2. Configure cups by copying cupsd.conf to /etc/cups/cupsd.conf
<code>
  sudo cp cupsd.conf /etc/cups/cupsd.conf
  sudo systemctl restart cups
</code>
3. Add yourself to CUPS lpadmin group
<code>
  sudo usermod -a -G lpadmin 'yourself'
  sudo systemctl restart cups
</code>
## C. Install EPSON L1300 Series Printer
1. Install lsb
<code>sudo apt-get install lsb</code>
2. (conditional) sometimes there will be broken packages. If so run
<code>sudo apt --fix-missing</code>
and then retry step 1.
3. Install EPSON
<code>sudo dpkg -i epson-inkjet-printer-201311w_1.0.1-1lsb3.2_amd64</code>
4. Set printer as default
