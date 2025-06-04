# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="vi"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  aws
  colored-man-pages
  kubectx
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kubectl Aliases
alias k=kubectl
complete -F __start_kubectl k
alias kcc="kubectl config current-context"
alias kx="kubectl exec -it"
alias ktop="kubectl top"

alias tf=terraform
alias pl=pulumi
alias zshrc="${=EDITOR} ~/.zshrc && source ~/.zshrc"

alias awswho="aws sts get-caller-identity"

alias vim="~/nvim-macos/bin/nvim"
alias vi="~/nvim-macos/bin/nvim"

alias dn="dotnet"
alias dnr="dotnet run"
alias dnb="dotnet build"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

function reload-profile() {
  source ~/.zshrc
}

function gg() {
  if [[ -n "$1" ]]; then
    cd ~/git/${1}
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "${branch}" == "master" || "${branch}" == "main" ]]; then
        git pull
    fi
  else
    cd ~/git
  fi
}

function latest_module_version() {
    if [ -z "${1}" ]; then
        repo="terraform-modules"
    else
        repo="${1}"
    fi
    pushd ~/git/${repo}
    git ls-remote --tags --sort=taggerdate | tail -1
    popd
}

function random_password() {
  if [[ $1 == "safe" ]]; then
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 13; echo
  else
    LC_ALL=C tr -dc '[:graph:]' </dev/urandom | head -c 13; echo
  fi
}

function get_node_balance() {
    (
        echo -e "NODE\tCAPACITY\tPODS"
        kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{" "}{.status.capacity.pods}{"\n"}{end}' | while read -r node capacity; do
            non_terminated_pods=$(kubectl get pods --all-namespaces --field-selector spec.nodeName=$node,status.phase!=Succeeded,status.phase!=Failed -o json | jq '.items | length')
            echo -e "$node\t$capacity\t$non_terminated_pods"
        done
    ) | column -t
}

function get_kube_secret() {
    namespace=$1
    secret_name=$2
    secret_path=$3
    res=$(k get secret "${secret_name}" -n "${namespace}" -o=json | jq -r --arg path "${secret_path}" '.data[$path]' | base64 -d)
    echo "${res}"
}

# Check if my ssh key has already been added, and request it if not

current_keys=$(ssh-add -l)
work_key=$(ssh-keygen -lf ~/.ssh/id_rsa)
if [[ $current_keys != *$work_key* ]]; then
  ssh-add
fi
