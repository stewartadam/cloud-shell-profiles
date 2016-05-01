## Uncomment me to use virtualenvwrapper (sudo pip install virtualenvwrapper)
#export WORKON_HOME="$HOME/.virtualenvs"
#source /usr/local/bin/virtualenvwrapper.sh

# Overrides
alias ls="ls -G"

# Cyphers
alias md5sum="openssl dgst -md5"
alias sha1sum="openssl dgst -sha1"
alias sha256sum="openssl dgst -sha256"

# Tell tar, pax, etc. on Mac OS X 10.4+ not to archive
# extended attributes (e.g. resource forks) to ._* archive members.
# Also allows archiving and extracting actual ._* files.
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true COPYFILE_DISABLE=true

# Convert UNIX timestamps back and forth
ts2date() { date -j -f %s $1; }
date2ts() { date -jf "%Y-%m-%d %H:%M:%S" "$1" +"%s"; }

alias lockscreen="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
