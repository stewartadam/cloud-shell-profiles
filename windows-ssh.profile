# From https://help.github.com/articles/working-with-ssh-key-passphrases
env=~/.ssh/agent.env

# Prevent errors on fresh installations
if [ ! -f "$env" ];then
  mkdir -p "$(dirname "$env")"
  touch "$env"
fi

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
  (umask 077; ssh-agent >| "$env")
  . "$env" >| /dev/null ;
}

agent_add_keys () {
  # see http://stackoverflow.com/a/7612420/1389817
  SSH_KEYS=()
  while read line;do
    SSH_KEYS+=("$line")
  done < <(find "$CLOUD/Setup/ssh" | grep id_rsa | grep -v -e 'pub$')
  ssh-add "${SSH_KEYS[@]}"
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
  agent_start
  agent_add_keys
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
  agent_add_keys
fi

unset env
