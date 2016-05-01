# Ensure SSH uses the shared configuration on all OSs
alias ssh="ssh -F \"$CLOUD_SHELL_PROFILES/ssh/config\""

# Put other custom directives below



# This should come last. Include OS-specific functions.
OS="$(uname -s)"
case "$OS" in
  Darwin)
    . "$CLOUD_SHELL_PROFILES/osx.profile"
    ;;

  CYGWIN*|MINGW*|MSYS*)
    . "$CLOUD_SHELL_PROFILES/windows.profile"
    ;;

  Linux)
    . "$CLOUD_SHELL_PROFILES/linux.profile"
    ;;

  *)
    . "$CLOUD_SHELL_PROFILES/linux.profile"
    ;;
esac
