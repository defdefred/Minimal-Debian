# Terminal
So you want to a very light working environment to enjoy your very old computer, a minimalist SBC or an ssh remote session to a server.
## Font size
### testing
setfont + font name from /usr/share/kbd/consolefonts/

### setting
change /etc/default/setup-console

## Word Processor
### WordGrinder

### Joe

## Spreadcheet
### Sc-im spreadcheet

## Database
### Visidata

## Image
### fbi -a image.jpg

## Youtube
```
apt install ytfzf
```

## Music
### Mpg123
```
apt install mpg123
```

### Flac
```
apt install flac
```
### converting from flac to mp3
```
find ./ -name \*.flac | while read F ; do flac -dc "$F" | lame -q0 -V0 - "$(echo "$F" | sed 's/.flac$/.mp3/')" ; done
```

