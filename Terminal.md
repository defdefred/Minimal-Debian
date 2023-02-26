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
`fim` is perfect to browse a folder full of images and select the one to keep, the one to delete.
`apt install fim`

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

