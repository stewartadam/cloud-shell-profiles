# Launch SSH agent (not longer automatic since 10.12) - https://twitter.com/lorentey/status/753581927412686850
OSX_VERSION=$(sw_vers -productVersion | cut -d'.' -f2)
if [ $OSX_VERSION -ge 12 ] && [ -z $SSH_AGENT_PID ];then
  { eval `ssh-agent`; ssh-add -A -K; } &>/dev/null
fi

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
