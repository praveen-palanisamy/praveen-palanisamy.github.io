#Epson Work Force pro 4640 printer and scanner driver installation on Linux

1.  Go to the Epson driver search page : <http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX>

2. Enter **WF-4640** in the product name field and make sure *linux* is selected as the operating system.
3. You will see the following list of files:
![Search results from Epson driver search](http://praveenofpersia.bitbucket.org/wiki/images/Screenshot-from-2015-05-21-11:02:03.png)
4. Click the download button for the last one in the list which says:
_WF-4640 Series | Scanner Driver  Linux | 2.30.1/1.36.0  | core package&data package |  All language |    03-23-2015_|_
5. In the next page, scroll down and click on _Accept_ to see the download links below it:
![Driver File list](http://praveenofpersia.bitbucket.org/wiki/images/Screenshot-from-2015-05-21-11:06:32.png)
6. Choose the **iscan-data_1.36.0-1_all.deb** file to download
7. Open with the _Ubuntu software Central_ and install it:
![](http://praveenofpersia.bitbucket.org/wiki/images/Screenshot-from-2015-05-21-11:08:33.png)
8. After that download **iscan_2.30.1-1~usb0.1.ltdl7_amd64.deb** and install it like the previous one
9. Now that the data package and the core packages are installed, we can go ahead and install the drivers for the printers and the scanners. Let's install the **network plugin package**. Click on the download button next to this module and go ahead and accept the license terms and choose **iscan-network-nt_1.1.1-1_amd64.deb** to download the deb file for debian based linux systems like Ubuntu. Install it using your preferred way. The simples way would be to use the software center to install it as before.
10. Next, install the **ESC/P-R Driver (generic driver)** and **Epson Printer Utility** depending on what you require. You may also want to install the fax drivers if you require.
11. Done! You should now be able to send scans to your computer over the network and also you should be able to print from your computer. The printer drivers will install a new printer device like below:
![New Epson printer device installed](http://praveenofpersia.bitbucket.org/wiki/images/Screenshot-from-2015-05-21-11:34:36.png)
You will also see the **simple scan** and **Image Scan for Linux** utility on your system.
12. **Testing!** Open the printer device on your linux machine (type printers in dash) and find the **EPSON-WF-4640-Series**, right click and choose **properties** then under the **Settings** you will find a button **Print Test Page** you know what to do! Good luck.

