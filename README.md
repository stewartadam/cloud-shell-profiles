# About
Cloud Shell Profiles centralizes your shell script and SSH configuration using a
cloud sync provider (Dropbox, OneDrive, Google Drive, Copy, etc) so that they
are shared and synchronized between your machines.

The scripts are intended to be used cross-platform and support Linux, OS X
and Windows (bash via MinGW, MSYS or Cygwin).

# Use cases
I regularly use Windows, OS X and Linux machines and wanted a simple way to keep
my shell tooling in sync.

For security reasons, SSH password authentication is disabled on many of the
machines I use and I quickly became annoyed at having to maintain all of my keys
for personal and work use between several machines.

These scripts avoid all of that by keeping your configuration & keys in one
place, making new machine setup very easy and transfering your configurations t
all your other machines seamlessly.

# Installation
1. Clone this repo into your cloud provider's sync folder (e.g. in `~/Dropbox`)
2. On each of the machines you'd like to keep in sync:
  1. Install the desktop sync client of your chosen cloud provider
  2. Copy the contents of [local-sample.profile](local-sample.profile) to your `~/.profile` file (create it if necessary)
  3. Adjust the `CLOUD_SHELL_PROFILES` variable as necessary to point to the `cloud-shell-profiles` folder you checked out in step 1
3. Open a new terminal session and type `echo $CLOUD_SHELL_PROFILES` - if all is working, you should see the path configured in step 2-iii!

# Configuration
Once you've laid the framework for cloud shell profiles, the rest is up to you.

## Shell profiles
Anything placed in [common.profile](common.profile) will be sourced on all
OSs, where as [osx.profile](osx.profile), [linux.profile](linux.profile) and
[windows.profile](windows.profile) are only sourced when starting a shell on
that OS.

I've left a few handy aliases in those files, but feel free to clean those up if
you don't want them.

## SSH
SSH tends to not like symlinks for security reasons, so instead of symlinking
`~/.ssh/config` which sometimes fails, I've opted to simply alias `ssh` as
`ssh -F` on all OSs to load the configuration stored at [ssh/config](ssh/config).

Check out [ssh/config.sample](ssh/config.sample) for some examples of cool
tricks you can do with a SSH config.

### SSH keys
If you have SSH keys, place them in the [ssh](ssh) folder so that they are
synchronized between machines.

Unfortunately, I have not found a straightforward way to have SSH load its key
files directly from `$CLOUD_SHELL_PROFILES/ssh`, so for now you will need
to copy SSH keys locally before using them: `cp $CLOUD_SHELL_PROFILES/ssh/id_rsa* ~/.ssh`
