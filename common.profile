# Ensure SSH uses the shared configuration on all OSs
alias ssh="ssh -F \"$CLOUD/Setup/ssh/config\""

# Put other custom directives below



# This should come last. Include OS-specific functions.
OS="$(uname -s)"
case "$OS" in
  Darwin)
    . "$CLOUD/Setup/osx.profile"
    ;;

  CYGWIN*|MINGW*|MSYS*)
    . "$CLOUD/Setup/windows.profile"
    ;;

  Linux)
    . "$CLOUD/Setup/linux.profile"
    ;;

  *)
    . "$CLOUD/Setup/linux.profile"
    ;;
esac
