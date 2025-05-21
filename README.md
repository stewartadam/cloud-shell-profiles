# About
Cloud Shell Profiles centralizes your shell profiles and SSH configuration using
a cloud sync provider (Dropbox, OneDrive, Google Drive, Copy, etc) so that they
are shared and synchronized between your machines.

The scripts are intended to be used cross-platform and support Linux, macOS
and Windows (bash via WSL/MinGW/MSYS/Cygwin), although support for other OSs can
be added in easily.

# Use cases
I regularly use Windows, macOS and Linux machines and wanted a simple way to keep
my shell tooling in sync.

For security reasons, SSH password authentication is disabled on many of the
machines I use and I quickly became annoyed at having to maintain all of my keys
for personal and work use between several machines.

These scripts avoid all of that by keeping your configuration & keys in one
place, new machine setup very easy and any changes to keys or configurations are
transferred to all your other machines seamlessly.

# Installation
1. Clone this repo into your cloud provider's sync folder (e.g. in `~/Dropbox`)
2. On each of the machines you'd like to keep in sync:
    1. Install the desktop sync client of your chosen cloud provider
    2. Copy the contents of [local-sample.profile](local-sample.profile) to your  `~/.profile` file (create it if necessary)
    3. Adjust the `CLOUD_SHELL_PROFILES` variable as necessary to point to the `cloud-shell-profiles` folder you checked out in step 1
3. Open a new terminal session and type `echo $CLOUD_SHELL_PROFILES` - if all is working, you should see the path configured in step 2-iii!

# Configuration
Once you've laid the framework for cloud shell profiles, the rest is up to you.

## Shell profiles
Anything placed in [common.profile](profiles/common.profile) will be sourced on all
OSs, where as [osx.profile](profiles/osx.profile), [linux.profile](profiles/linux.profile) and
[windows.profile](profiles/windows.profile) are only sourced when starting a shell on
that OS.

I've left a few handy aliases in those files, but feel free to clean those up if
you don't want them.

## SSH
Check out [ssh/config.sample](ssh/config.sample) for some examples of cool
tricks you can do with a SSH config.

### Option 1: SSH directory as symlink (recommended)
If you have SSH keys, place them in the [ssh](ssh) folder of your cloud shell
profiles folder so that they are synchronized between machines (make sure
they are password-protected).

Changing your `.ssh` directory to a symbolic link is the easiest way to ensure
your SSH configuration **and keys** are used consistently between machines:

```sh
mv ~/.ssh ~/.ssh.bak
ln -s "$CLOUD_SHELL_PROFILES/ssh" ~/.ssh

# This prevent SSH from backing out due to bad permissions after a cloud sync
chmod 700 "$CLOUD_SHELL_PROFILES"/ssh ~/.ssh
chmod 600 "$CLOUD_SHELL_PROFILES"/ssh/*
chmod 644 "$CLOUD_SHELL_PROFILES"/ssh/id_*.pub
```

Now simply use relative paths (i.e. `IdentityFile id_rsa_foo`) in your SSH
config as usual.

### Option 2: SSH keys without symlink (not recommended)
If some of your machines fail when using the symlink approach above, you can
still alias `ssh` as `ssh -F path-to-cloud-shell-config` to force it to use
the cloud synchronized SSH config, but you will need to specify keys to SSH
using one of two approaches:
1. Provide the absolute path to the key each time IdentityFile is used (i.e.
   `IdentityFile ~/Dropbox/cloud-shell-profiles/ssh/id_rsa_foo`), requiring
   you install cloud-shell-profiles at the exact same location on all machines.
2. Provide a relative path (i.e. `IdentityFile id_rsa_foo`) and copy the keys
   from `$CLOUD_SHELL_PROFILES/ssh` to `~/.ssh` manually. You will be required
   to manually re-copy them every time you add/change a key, but this permits
   your cloud shell profiles folder to live in different places on different
   machines.

## Extending
[`autoloader.profile`](profiles/autoloader.profile) is responsible for loading OS-specific profiles. If your OS
is not recognized (e.g. if you use a BSD variant), [`unmatched.profile`](profiles/unmatched.profile) is loaded
by default with a small warning. Adjust `autoloader.profile` if you want to load
a new OS-specific profile.
