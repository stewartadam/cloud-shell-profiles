. "$CLOUD_SHELL_PROFILES/profiles/common.profile"

# Include os-specific profiles last, to permit overriding common.profile
OS="$(uname -s)"
case "$OS" in
  Darwin)
    . "$CLOUD_SHELL_PROFILES/profiles/osx.profile"
    ;;

  CYGWIN*|MINGW*|MSYS*|Windows*)
    . "$CLOUD_SHELL_PROFILES/profiles/windows.profile"
    ;;

  Linux)
    . "$CLOUD_SHELL_PROFILES/profiles/linux.profile"
    ;;

  *)
    . "$CLOUD_SHELL_PROFILES/profiles/unmatched.profile"
    ;;
esac
