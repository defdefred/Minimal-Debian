# Terminal
So you want to a very light working environment to enjoy your very old computer, a minimalist SBC or for fun.

Linux terminal is not limited to text, you can display images and video.

You can also use several virtual console with `ALT-F1`,`ALT-F2`, etc. 

## Font size
Depending of your screen size or your eyes quality, you may want to have smaller or bigger character size.

### testing
All available font are in folder `/usr/share/kbd/consolefonts/`. To test a font use `setfont fontname`.

### setting
Once the right font selected, edit the `/etc/default/setup-console` file to make is persistent.

### wide screen
If you are using a wide screen, you may want to split the terminal in two part verticaly with `tmux`. Install it with `apt install tmux`, start it and create a splitted second session with `Ctrl-B c` and `Ctrl+b %`. Jump to session using `Ctrl+B <arrow keys>` (keystrokes can be custoized in `.tmux.conf`). 

## text editor

### Vim

## Word Processor

### WordGrinder

### Joe

## Spreadcheet

### Sc-im

## Database

### Visidata

## Image

### Fim
`fim` is perfect to browse a folder full of images and mark the one to delete.
`sudo apt install fim`
`cd folder` `fim * > to-delete.txt` `SPACE` for next, `BACK-SPACE` for previous, `ENTER` to mark, `q` to quit and then you have the list of file to delete.
https://www.nongnu.org/fbi-improved/#docs

### Fbi

### ImageMagik

## Video

### Mpv

### Ffmpeg

### Youtube

`apt install ytfzf`

## Music

### Mpg123

`apt install mpg123`

### Flac

`apt install flac`

### Converting from flac to mp3
```
find ./ -name \*.flac | while read F ; do flac -dc "$F" | lame -q0 -V0 - "$(echo "$F" | sed 's/.flac$/.mp3/')" ; done
```

