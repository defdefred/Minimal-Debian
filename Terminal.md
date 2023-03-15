# Terminal
So you want to a very light working environment to enjoy your very old computer, a minimalist SBC or just for fun.

Linux terminal is not limited to text, you can display images and video using the framebuffer!

## Terminal emulation

### Basic Linux terminal

If you computosaure is really old, this is the way to go, instead skip to the next terminal emulator.

You can have unicode, colors, but no italic, no underline, no bold, etc.

You can use several virtual console with `ALT-F1`,`ALT-F2`, etc. Just `systemctl start getty@tty9` to have a new with ALT-F9 and `systemctl enable getty@tty9` to keep it.

You can have mouse support with copy/paste using `gpm` (`apt install gpm`).

Depending of your screen size or your eyes quality, you may want to have smaller or bigger character size.

All available font are in folder `/usr/share/kbd/consolefonts/`. To test a font use `setfont fontname`.

Once the right font selected, edit the `/etc/default/setup-console` file to make is persistent.

If you are using a wide screen, you may want to split the terminal in two part verticaly with `tmux`. Install it with `apt install tmux`, start it and create a splitted second session with `Ctrl-B c` and `Ctrl+b %`. Jump to session using `Ctrl+B <arrow keys>` (keystrokes can be custoized in `.tmux.conf`). 

### Terminology

You may try this terminal emulator compatible with the framebuffer: `apt install termonology` 


## text editor

### Vim

## Word Processor

### WordGrinder

### Joe

## Spreadcheet

### Sc-im
https://github.com/jonnieey/Sc-im-Tutorial
https://github.com/andmarti1424/sc-im

## Database

### Visidata

## Image

### Fim
`fim` is perfect to browse a folder full of images and select the one to keep, the one to delete.
`sudo apt install fim`
`cd folder` `fim *` `SPACE` for next, `BACK-SPACE` for previous, `DEL` to delete, `q` to quit.
### ImageMagik

## Video

### Mpv

### Ffmpeg

### mps-youtube/yewtube
```
root# apt install pipx
root# pipx install yewtube
```

## Music

### MOC
Web: [Music On Console](http://moc.daper.net/about)
Add: `sudo apt install moc`
Run: `mocp`

### Mpg123
Web: [Music On Console](http://moc.daper.net/about)
Add: `sudo apt install mpg123`
Run: `mpg123 `

`apt install mpg123`

### Flac
Web: [Music On Console](http://moc.daper.net/about)
Add: `sudo apt install moc`
Run: `mocp`

`apt install flac`

### Lame

### Converting from flac to mp3
```
find ./ -name \*.flac | while read F ; do flac -dc "$F" | lame -q0 -V0 - "$(echo "$F" | sed 's/.flac$/.mp3/')" ; done
```

