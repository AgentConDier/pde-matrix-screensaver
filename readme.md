# Matrix-Screensaver
A screensaver that looks somewhat like that famous scene. Done in processing. I know it isn't the first of of kind, but it also serves as an example on how to create windows screensavers using processing. It looks somewhat like this: [matrix.gif](https://s2.imagebanana.com/file/180602/21sp0XTE.gif)
## Features
* The screensaver can be installed and configured by right-clicking like you'd expect
* It allows aou to edit a lot of values changing how it looks
* multi-screen support
* You can add a border on the right and/or left, for example to only display it on one screen
* non-intrusive update checking
* Uses a katakana font. Not sure if that is canon, but it looks cool
## Installation
I'll post a release soon, but you can also put it together yourself:
### Processing
1. Download the source code and open `matrix.pde` in the processing ide
2. (Optional) Run it once to generate the `data/config.txt` if you want to include it
3. Compile it for Windows x64 using processing
### Making a screensaver
The screensaver executable is written in autoHotkey which you need to install in order to compile it.
Note: The autoHotkey script currently only works with the compiled jarfiles for x64 operating systems
1. Compile the `Screensaver/matrix.ahk` using autoHotkey.
2. Rename the generated `matrix.exe` to `matrix.scr`
3. Copy `application.windows64/data` and `application.windows64/lib` to `Screensaver/matrix`
You should now be able to launch the screensaver by simply clicking on `matrix.scr`. (You can delete `matrix.ahk` now, if you want)
