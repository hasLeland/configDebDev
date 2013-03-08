        __  __     __         _______ __         
       / / / /__  / /___     / ____(_) /__  _____
      / /_/ / _ \/ / __ \   / /_  / / / _ \/ ___/
     / __  /  __/ / /_/ /  / __/ / / /  __(__  ) 
    /_/ /_/\___/_/ .___/  /_/   /_/_/\___/____/  
                /_/                              

Author: Leland Batey

This help file is going to be primarilly written using markdown as an organizational tool. It won't be rendered markdown, but since markdown is a nice and human readable format, it makes this easier.


#### How to reconnect to an interupted screen session. Useful for when a terminal quits on you. ####
	- use "screen -D" to force a disconnect, then reconnect normally (using "screen -r")

#### Alternate way to add network interfaces for Ubuntu ####
There is some kind of bug in Ubuntu, you can't add interfaces very well. To add and interface, use this command:
	sudo ifconfig eth0:0 199.21.222.23 netmask 255.255.255.240 up

substitute different values as needed, but that is the basic way it should go.

#### Connecting to the RaspberyPi with RaspBMC installed ####
Connection details:
	username : pi
	password : raspberry

Use "nmap -sP '192.168.2.*'" to find it in the group of IP's.
Even better, use "nmap 192.168.2.1-254" to scan all ports on all ip addresses.

#### Installing Easy_Install with Python3 on Ubuntu ####
Run "sudo apt-get install python3-setuptools"
From there, you can install Pip with:
	"python3 -m easy_install pip"

#### Installing Xmobar with DWM on Ubuntu Server ####
Installing Xmobar normally seems to fail with the error: 

	checking for X11/extensions/Xinerama.h... yes
	checking X11/extensions/Xrandr.h usability... no
	checking X11/extensions/Xrandr.h presence... no
	checking for X11/extensions/Xrandr.h... no
	configure: error: X11/extensions/Xrandr.h (from libXrandr) is required
	cabal: Error: some packages failed to install:
	X11-1.6.0.2 failed during the configure step. The exception was:
	ExitFailure 1
	xmobar-0.15 depends on X11-1.6.0.2 which failed to install.

The problem is that there aren't certain Xrandr development files installed. To resolve this, run:
	"sudo apt-get install libxrandr-dev"

This will install the appropriate files for Xmobar to be installed.

#### Using Irssi Linux IRC Client ####
Irssi operates in a way similar to screen/xmonad in that it creates many virtual "windows" to manage things. Additionally, the switching of windows is done using a "modkey" (is generally ALT, although the ESC key will also always work).
	A great guide on using IRSSI can be found at http://carina.org.uk/screenirssi.shtml
The following is a list of commands and tips for using IRSSI:
	- To join a channel, use the command "/j #<channelname>" (the # is important!)
	- The modkey is either the ALT key or the ESC key. I use ESC because ALT is used for Xmonad.
	- To switch between windows, press the modkey and the number of the window you want to switch to.
	- To list all the users in a channel, type "/names" or the shorthand, "/n"

#### Using SSH with Authorization Keys ####
To make use of authorization keys, the basics are that you need to append your rsa/dsa public key to the "authorized_keys" file on the machine you want to connect to. When you connect, the server creates a problem using your public key, that only the private key will solve. You recieve this data, solve it with your private key, and you send it back to the server. Then, the server knows you are who you say you are, and lets you connect. (This is pretty much taken straight out of the Arch Wiki https://wiki.archlinux.org/index.php/SSH_Keys#Background)
The following is the basics on using ssh keys with a server.
	1. On the host machine (the desktop) create an rsa/dsa pair.
	2. Log into the remote machine (server) and append the rsa/dsa .PUB (!!!) to the end of the "authorized_keys" file on the server.
	3. At this point, you may have to run the command "exec ssh-agent /bin/bash" on the host (desktop) machine to get the ssh service working correctly.
	4. Now connect to the server with "ssh <hostname here>"
	5. If you need to connect with a user other than the one on the host machine, use "ssh -l <remote machine username> <remote hostname here>"

It is important to note that on the client machine, the name of the public/private key pair needs to be "rsa/dsa_id(.pub)" to work by default. Otherwise, you have to specify if something is using an alternateley named key pair.

#### Using "Sets" in Python ####
In Python, a "set" is nearly exactly like a list, however it is not ordered. That means that referencing anything via placement (i.e. myList[0]) will not work. However, checking the membership of an item in a set is much much faster than checking the membership of an item in a list. For this reason, it is worthwhile to convert large lists to sets before checking for membership in one of those lists/sets.
	(I should note that I ran across this tip while working on my TorrentTxt project. The web page that started this all is: http://stackoverflow.com/questions/10005367/python-set-difference )

#### Using Virtual Environments (virtualenv) in Python ####
So virtualenvs seem pretty awesome. However, something to note is that they cannot be moved. That means that if they move at all, they break. So if you rename a parent directory, then they're broken. Something to be aware of.

#### Stopping Access/Hotlinking Using .Htaccess by Checking the Referer ####
To restrict access according to a websites referer, this is how the .htaccess needs to look like this:

RewriteEngine On
RewriteCond %{HTTP_REFERER} !^http://(.+\.)?allowedSite\.com/ [NC]
RewriteCond %{HTTP_REFERER} !^$
RewriteRule .* - [F]

Mod_rewrite works by comparing the incoming referer against the specified (regular expression) rules for referers. If all of the (regular expression) rules return True, then it acts out the "RewriteRule". For example:

	RewriteCond %{HTTP_REFERER} !^http://(.+\.)?allowedSite\.com/ [NC]
		Returns TRUE if the referer does not come from "allowedSite.com"
	
	RewriteCond %{HTTP_REFERER} !^$
		Returns TRUE if the referer is not blank (null).

It then applies the rule, which in this case is to deny access.

#### Deleting Old Kernels from a Full /boot partition ####
I have found that on my Ubuntu servers I frequently run out of space on my /boot partition. Normally you'd empty that out by using the "sudo apt-get autoremove" command, but it will fail because that partition is full and that partition is used as a temporary extraction point by apt-get. Here are the steps involved:
    Use the command "dpkg -l | grep linux-image" to show a list of all installed linux kernels
    Use "uname -r" to show the current kernel
    Now you can remove and old kernels with the command "sudo apt-get purge linux-image-<kernel number here>"
        I recommend only getting rid of old kernels and only just enough to allow you to run "sudo apt-get autoremove"

#### Using Bootstrap Javascript and Jquery ####
I had gone into this trying to set up a simple dropdown for the frontpage of adrenl.in. However, I could not for the life of me figure out why the bootstrap javascript wasn't working. After tons of trial and error, this is what I eventually learned:

    1. Placement of javascript "<script>" notifications matters. These will not work if called in the "head", they must be called in the "body" of the page.
    2. The *order* of the javascript files matters. In my case, bootstrap requires jquery to already be loaded, so jquery must come BEFORE bootstrap.

Once I'd done both of those, everything worked great!

### Converting video's to animated GIF's ###
So, converting a video to an animated gif is semi-easy, but mostly not. Here's how it goes:

Make sure you have the following tools install:
    
    ffmpeg
    gifsicle

Both of which can be gotten via "sudo apt-get install <name>".

Now for the fun part! For whatever reason, the built in video -> .gif convertion function of ffmpeg is super garbage. So, instead we do things a little bit better:

    First, we split apart every single frame of the video into it's own gif frame, with an appropriate file name to put it in the correct order.
    Second, we use gifsicle to combine all these .gif frames into a single animated gif.

Here's the command to split up the video into the gif frames:
    
    ffmpeg -i file_to_be_input.mp4 out%04d.gif

Note the weird name specified for the output gif. For whatever reason, this seems to be important. It apparently makes sure each frame has the correct/appropriate number.

Alright, now you've got this big long list of individual frames, but no animated gif :( NEVER FEAR, all shall be well. To combine them into a single animated gif, this is the command:

    gifsicle --delay=4 --loop *.gif > anim.gif

This will combine every ".gif" file in the current working directory into a single animated gif, in the order of the file name (lowest is first frame, highest is last frame).

Also note the `--delay=4` option. What this option is doing is specifying the delay in miliseconds between frames. I found that for a ~25 fps video, which most video is, this will produce a reasonably "normal speed" gif.

For further gif awesomeness, you can shrink the size of your gif using the `imagemagick` software package (also installable via apt-get). The command to remember is:

    convert -layers Optimize input.gif output_optimized.gif

And that's all. I was able to shrink a gif from 8mb to 2.1mb by doing this.

### Converting Video to .gif (Continued) ###
So, after fidling with that a bunch more, I found out some interesting things:

The first is that you don't need gifsicle at all. Imagemagick is able to do all of the necessary operations (and seems to be able to do them better!). To combine the composite frames into a .gif, use the following:

    convert -delay 4 out*.gif anim.gif

However, this is actually not the only improvement. After messing around with this some more, I found a way to produce even higher quality (yet larger) .gifs. The only different step is instead of telling ffmpeg to export the frames as .gif's, have it export them as .png's. This lets Imagemagick handle the conversion to .gif, and it does a much better job of making the .gif look nice. The only thing is that it produces much larger .gif's. Here is a comparison:

[.gif converted via ffmpeg](http://i.imgur.com/DWc4OdD.gif)

[.gif converted via imagemagick](http://i.imgur.com/OdojPSo.gif)

Notice that while the imagemagick .gif looks better, the one created by ffmpeg is **half as big.** This may be relevant info if you're trying to upload a file to say, imgur, which has a 5mb limit on .gifs.

To actually do this, switch your ffmpeg line from this:

    ffmpeg -i $1 out%04d.gif

to this:

    ffmpeg -i $1 out%04d.png

Now FFMPEG will output high quality .png's as the individual frames. Then, you'll also have to change the imagemagick line to this:

    convert -delay 4 out*.png anim.gif

In the end, this is what the whole script looks like:

    #!/bin/bash
    
    # NOTE: the "$1" in the line below this means "command line argument #1 is inserted here". If you're running these manually, replace the $1 with the name of your video file.
    ffmpeg -i $1 out%04d.png # Extracts each frame of the video as a single gif
    convert -delay 4 out*.png anim.gif # Combines all the frames into one very nicely animated gif.
    convert -layers Optimize anim.gif optimized_output.gif # Optimizes the gif using imagemagick
     
    # vvvvv Cleans up the leftovers
    rm out*
    rm anim.gif

And that's how you convert a video to a .gif file!

### Further Details on Converting Video to .GIF ###

So, after *EVEN MOAR* messing around with .gifs and videos, I have found a nice and easy way to also do reverse .gifs! This script needs to be run between the `ffmpeg` step and the `convert` step:

    image=( out*.png )
    MAX=${#image[*]}
    echo $MAX
    for i in ${image[*]}
    do
        num=${i:5:3} # grab the digits
        compliment=$(printf '%04d' $(echo 2*$MAX-$num+1 | bc))
        echo $num $i $compliment
        ln $i out$compliment.png
    done

Btw, [this is where I found this script](http://stackoverflow.com/questions/7136222/bash-script-to-copy-numbered-files-in-reverse-order) though I've done a lot of adapting it to my needs.

#### Anyway, here's an explanation of what the above is doing:

Here's an abstract look at what it acomplishes.

    For a set of files named `out*.png` it counts how many there are, then copys them in reverse order, renaming them sequentially, continuing with the numbering of the existing photos.

    So, if we had 5 frames named like so:

        out0001.png
        out0002.png
        out0003.png
        out0004.png
        out0005.png

    Then it would create the following:

        out0001.png
        out0002.png
        out0003.png
        out0004.png
        out0005.png
        out0006.png <- Is actually a renamed out0005.png
        out0007.png <- renamed out0004.png
        out0008.png <- renamed out0003.png
        out0009.png <- etc
        out0010.png

What this does is make the .gif go forwards, then backwards (then it loops, continuing to go backwards then forwards). So you get a nice smooth effect. Sometimes it's nice!