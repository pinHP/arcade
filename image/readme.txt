######   pinHP  Pi2Jamma & Pi2SCART image for Arcade cabinets   ######
######  Special thanks to Mr. Do for his original distribution  ######


***** INITIAL INSTRUCTIONS *****

Use a disk imaging program like "Win32DiskImager" to write the image file to a Micro-SD card (at least 16 GB size). A USB stick containing ROMs and configuration settings is recommended, but optional. Boot with an empty, formatted USB stick. The system will detect it and create the folder structure automatically.

***** PI2JAMMA / PI2SCART INSTRUCTIONS *****

All files required are stored in the "rpi2jamma" directory on either the USB stick or the "RPI_DATA" partition of the SC card. The most important subdirectory is "roms_advmame" - place your game ROMs there and you are good to go.

You can as well sort ROM files into subfolders, which will also show up in the game menu. Individual display names can be set with the “.title” file inside each directory. Write the name into the file and nothing else. Names preceded by a “.” (dot) will hide the directory completely, making it inaccessible from the menu. Names preceded by a “#” (hash sign) will show a blank line in the menu, but leave it accessible.

***** QUICK START *****

MENU CONTROLS

Select item: Player1-Button1 ("Left-CTRL")
Go back: Player1-Button2 (“Left-ALT”)

MAME CONTROLS

Insert coin: Player1-Start & Joystick up (“1” & “Up-Arrow”)
Pause game: Player1-Start & Joystick down (“1” & “Down-Arrow”)
Quit a game: Player1-Start & Player1-Button1 (“1” & “Left-CTRL”)

*******************************

CONFIGURATION / HIDDEN FEATURES

Select the "Options" menu. Advanced configuration settings are available.

If advanced settings are not visible, click into any of the empty lines between "Back" and "About" three times (slowly) within 10 seconds to activate the menu.
Hide the settings menu again to keep your system childproof.

Settings are stored in "config.ini" on the USB stick. 


SUBDIRECTORIES:

"roms_advmame"
– Game ROMs for games you want to see in the menu.
– NeoGeo BIOS (neogeo.zip) belongs here as well.
– Edit the game definition file “_games.template” to alter display names.
  
"roms_unused"
- Deleted (from pinHP menu) game roms.

"snaps"
- Preview snapshots (PNG) to be displayed in game selection menu.

"marquees"
- Marquees (PNG) to be displayed in game selection menu.

"videos"
- Preview videos (MP4) to be displayed in game selection menu.

"backup"
- Select "Backup Settings" from the "Options" menu to backup settings and hiscores here.

"backup.bak"
- Before actually making a backup, an existing backup folder is renamed to backup.bak, so this folder contains the second latest backup.

"autobackup"
- After each game and during system shutdown, hiscores and MAME settings are saved here automatically.

"samples_advmame"
- MAME audio files not included in the image.

"artwork_advmame"
- MAME artwork files not included in the image.

"snaps_advmame"
- Snapshots taken during gameplay.

"image_advmame"
- MAME chd/disk/cartridge/... image files.

"diff_advmame"
- MAME disk image differential files.

"memcard_advmame"
- MAME 'memcard' files.


EXTENDED GAME MENU ("Fav. Games", "More Games" and "All Games"):

There are options to display up to three filtered game menus: "Fav. Games", More Games" and "All Games".
Select the desired option from the advanced configuration menu. Display names of those menus can be edited in "config.ini" or from the menu.

To add games e.g. to the "Fav. Games" list, click on "Select Fav. Games". The screen turns green.
Go back to the games list as if you would want to start a game. Any game selected now will be added to the "Fav. Games" list.

"Deselect Fav. Games", "Select Autostart Game" and "Delete Game from USB" work in the same way.
 
Changes are applied when leaving edit mode.

Alternatively, pushing Player2-Start from the games menu adds the game to the Fav. Games list (needs to be configured from the System Settings Menu). By default, Player2-Start activates the screensaver.


AUTOSTART A GAME:

The system can boot right into a game.
Select it from the advanced configuration menu ("Select Autostart Game").


SCREENSAVER:

You can boot directly into a screensaver.
Select the option from the advanced configuration menu ("Autostart Screensaver").

The screensaver activates itself after an idle time of 10 minutes (default, can be edited in "config.ini") only when the menu is shown, NOT during a game.
Activate "Idle Exit" in the MAME section of the System Settings Menu to automatically exit a MAME game.


SCREEN ORIENTATION:

Screen orientation can be set to horizontal, vertical or automatic.
Automatic is useful for rotatable monitors.

Quick switch of screen orientation is possible by pressing Player2-Start if the option is set in the System Settings Menu.

GAME SELECTION:

Use Joystick to select your games. 

Scroll through games list pagewise: Joystick left/right
Scroll through pages alphabetically: Player1-Start + Joystick left/right

Select game or menu item: Press Player1-Button1.
Go back: Press Player1-Button2.


MAME CONTROLS (configurable, see instructions at the end of this document):

*** Insert coin: Player1-Start & Joystick up ***

*** Pause game: Player1-Start & Joystick down ***

*** Quit a game / Back to menu: Player1-Start & Player1-Button1 ***


MAME INFO:

Advance Mame 3.9
Romset version 0.106
Put ROMs inside "roms_advmame" folder on USB stick.
Put snapshots (preview images) inside "snaps" folder on USB stick.
Put preview videos inside "videos" folder on USB stick.


KEYBOARD:

A USB keyboard may be attached to configure Advance Mame general and/or individual game settings:
Start any game. No need to play, the title screen is sufficient.
Press the TAB key to access Advance Mame options. 


KEYBOARD MAPPING:

Coin1:                    "5"
Player1 Start:            "1"
Player2 Start:            "2"
Player1 Button1 (Fire):   Left-CTRL
Player1 Button2:          Left-ALT
Player1 Button3:          q


CHANGE BUTTONS OR KEYBOARD SETTINGS:

E.g. change the action to quit a game. This a MAME setting, so we need to access the MAME settings menu.
 1) Attach a USB keyboard.
 2) Start any game. No need to play, the title screen is sufficient.
 3) Press the TAB key.
 4) Navigate to "Input (general)" - press ENTER.
 5) Select "User Interface" - press ENTER.
 6) Navigate down to "UI cancel".
 7) Press ENTER - the definitions are cleared.
 8) Press whichever buttons are desired.
 9) Do NOT press ENTER again!
10) Wait until the key is registered.
    As soon as it is registered, if you do press ENTER before navigating away,
    you can select an optional additional control.
11) Navigate away and all the way down to go back to the game through the various settings screens.
12) Done!

When a game is internally using a “super resolution” (making it possible to run at exact refresh rates, yet Mame can still output pixel perfect resolutions), if you TAB into the settings, unreadable small lines will be shown on a vertical monitor. You need to temporarily change the game’s resolution before entering the menu. While in the game, press “.” (dot) or “,” (comma) to cycle through available resolutions, until the menu becomes readable. Then you can TAB in.

You can as well backup MAME settings from the "Options" menu, edit the advmame.rc config file and restore it via the menu.


HAVE FUN GAMING!


***** HOW TO CONNECT TO A WIFI NETWORK *****

 1) System Settings Menu > Online Tools > Wi-Fi Setup
 2) Select your network.
 3) Assign an internal name for the network, eg. “pinhp”.
 4) Enter the network key.
 5) Done! The system should be connected within a couple of seconds.
 The network profile is automatically saved, you don‘t need to enter credentials again next time. If you cannot connect
 because network settings have changed, go to „Remove Wi-Fi Profiles“ and start over again.
 6) Check your IP: System Settings Menu > Online Tools > Check IP
 7) To automatically connect after each reboot, select "Auto Connect"


***** HOW TO SSH INTO THE SYSTEM *****

Username: pinhp
Password: root

(If you have trouble transferring data with e. g. SCP software, connect as user: root / password: root)

Example Windows 10:
1) From the Windows menu, type “cmd” to open the command shell.
2) Type “ssh pinhp@192.168.1.243” (with the IP number found in step 6 above).
3) Password is “root”.
4) If you see the command prompt [pinhp@pinhp ~]$ you are connected!
5) Do whatever you want in the Linux system, e.g. run Midnight Commander: Type “mc”.

The DOS (FAT32) partition containing games and system settings, in use only if no USB stick is present, is mounted at /mnt/data.


***** ADVANCED INSTRUCTIONS IF THE SCREEN IS NOT CENTRED *****

How to Adjust modelines in advmame.rc.

For horizontal screen shifting on a SCART TV set, you can install ArcadeForge’s CRT RGB Picture Shifter device.

On Pi2SCART monitors, if there is no way to adjust the monitor itself, we can change the screen position (horizontal/vertical) on an individual base by altering modeline settings.

Let’s use Donkey Kong as example. Video mode according to Advance Mame’s game info:
256 x 224 (V) 60 Hz

In advmame.rc we look up the value for our game resolution.
We find the line

256x224x60/display_mode 320×224 (60.02 Hz)

which tells Mame, what to do with games running a 256×224 resolution at 60 Hz refresh rate. It tells Mame to use display_mode 320×224 (60.02 Hz).

We find the line

device_video_modeline “320×224 (60.02 Hz)” 6.4 320 321 352 407 224 229 236 262 -hsync -vsync # 15.72 kHz

which tells Mame how to set the video mode named “320×224 (60.02 Hz)”.

The group of the first four values 320 321 352 407 is for horizontal (long side) screen resolution, the second group 224 229 236 262 for vertical (short side) screen resolution.

Within each group, we change the second and third numbers by the same value. To shift the long side of the screen to the left (which is up on a vertical monitor), we increase the numbers. Let’s shift the whole screen image 20 pixels to the left on the long side of the monitor: We increase the numbers by 20:

device_video_modeline “320×224 (60.02 Hz)” 6.4 320 341 372 407 224 229 236 262 -hsync -vsync # 15.72 kHz

Now let’s additionally shift the image down on the short side of the monitor by subtracting 5 pixels:

device_video_modeline “320×224 (60.02 Hz)” 6.4 320 341 372 407 224 224 231 262 -hsync -vsync # 15.72 kHz

There are limitations: We cannot go below the first value or above the fourth value of each group. So, in our example, we cannot move the image down the short side anymore. 224 is the limit here.

Some games make use of “super resolution” settings, where Mame downscales the actual image. This is a workaround due to Raspberry Pi (up to 3B+) hardware limitations, making it possible to get almost exact resolutions and refresh rates. Usually we are more flexible in shifting the screen image as well.

We see modelines like
device_video_modeline “1920×240 (60.00 Hz)” 41.50 1920 2000 2288 2640 240 240 247 262 -hsync -vsync # 15.72 kHz

Since Mame scales the value of 1920 down by factor 6 to 320 pixels screen width, a horizontal shift by 1 pixel requires the value to be changed by 6.

Hint:
When a game is using a “super resolution”, if we TAB into the settings, unreadable small lines will be shown on a vertical monitor. We need to temporarily change the game’s resolution before entering the menu. While in the game, we press “.” (dot) or “,” (comma) to cycle through available resolutions, until the menu becomes readable. Then we can TAB in.

Adjusting the menu screen

To adjust screen positon of the pinHP menu, we need to edit the file config.txt on the SD card’s DOS boot partition.

We find the line
hdmi_timings=320 1 32 47 17 240 1 2 6 8 0 0 0 60 0 6400000 1 #240p #H-Rate 15.38kHz #V-Rate 60.10Hz

Here we need to change values #3 and #5 (32 and 17 in our example) for horizontal screen position, values #8 and #10 (2 and 8) for vertical position.
Be careful: If you ADD to one value, you have to SUBTRACT from the other and vice versa.
