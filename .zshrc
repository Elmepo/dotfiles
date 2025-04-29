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

export PATH="$PATH:/opt/homebrew/bin:/Users/scottgardner/.cargo/bin"

# Kubectl Aliases
alias k=kubectl
complete -F __start_kubectl k
alias kcc="kubectl config current-context"
alias kx="kubectl exec -it"
alias ktop="kubectl top"

alias tf=terraform
alias pl=pulumi
alias zshrc="${=EDITOR} ~/.zshrc && source ~/.zshrc"
# alias gogit='cd ~/git'

alias refresh_aws="aws-azure-login --all-profiles --no-prompt"
alias awswho="aws sts get-caller-identity"
# alias awsqoneco="export AWS_PROFILE=qoneco-np"
# alias awshl="export AWS_PROFILE=hl-np"
# alias awshlprod="export AWS_PROFILE=hl-prod"
# alias awsqonecoprod="export AWS_PROFILE=qoneco-prod"

# alias hlprod="export AWS_PROFILE=hl-prod && aws-azure-login hl-prod"
# alias hlnonprod="export AWS_PROFILE=hl-nonprod && aws-azure-login hl-nonprod"
# alias qonecoprod="export AWS_PROFILE=qoneco-prod && aws-azure-login qoneco-prod"
# alias qonecononprod="export AWS_PROFILE=qoneco-nonprod && aws-azure-login qoneco-nonprod"

alias hlprod="export AWS_PROFILE=hl-prod"
alias hlnonprod="export AWS_PROFILE=hl-nonprod"
alias qonecoprod="export AWS_PROFILE=qoneco-prod"
alias qonecononprod="export AWS_PROFILE=qoneco-nonprod"

alias vim="~/nvim-macos/bin/nvim"
alias vi="~/nvim-macos/bin/nvim"

alias dn="dotnet"
alias dnr="dotnet run"
alias dnb="dotnet build"

alias daysleft="python3 ~/fun/days_left.py"
alias leetcode="cd ~/fun/prepare"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

function reload-profile() {
  source ~/.zshrc
}

function ssm() {
  if [ $# -eq 0 ]; then
    echo "ssm requires the instance-id at a minimum. Format is 'ssm <instance> [region (defaults to us-west-2)] [documentName]'"
    return 1
  fi
  local target=$1
  if [ $# -eq 2 ]; then
    local region=$2
  else
    case $AWS_PROFILE in
      hl-prod)
        local region="ap-northeast-1"
        ;;
      hl-nonprod)
        local region="us-west-2"
        ;;
      qoneco-prod)
        local region="us-west-2"
        ;;
      qoneco-nonprod)
        local region="us-west-2"
        ;;
      *)
        echo "Log in to AWS first and set the AWS_PROFILE env variable"
        return 1
        ;;
    esac
  fi

  if [ $# -eq 3 ]; then
    aws ssm start-session --target $target --region $region --document-name $3
  else
    aws ssm start-session --target $target --region $region
  fi

  # Nonprod
  # aws ssm start-session --target $target --region $region --document-name superAdminSession
  # prod
  # aws ssm start-session --target $target --region $region
}

function jenkinslogin() {
  case "$AWS_PROFILE" in
    hl-prod)
      acct_region="ap-northeast-1"
      ;;
    hl-nonprod)
      acct_region="us-west-2"
      ;;
    qoneco-prod)
      acct_region="us-west-2"
      ;;
    qoneco-nonprod)
      acct_region="us-west-2"
      ;;
    *)
      echo "Log in to AWS first and set the AWS_PROFILE env variable"
      exit 1
      ;;
  esac

  echo "Attempting to find the jenkins instance"

  instance_id=$(aws ec2 describe-instances --region "${acct_region}" --filters "Name=tag:serverType,Values=jenkins" --query 'Reservations[0].Instances[0].InstanceId' --output text)

  echo "Logging in to ${instance_id} in ${acct_region}"

  ssm "${instance_id}" "${acct_region}"
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

function check_commits() {
  repo_name=$1
  graph_type=${2:-"deployment_frequency"}
  pushd ~/git/$repo_name
  # TODO: Condense these into a single command
  if [[ ${graph_type} == "deployment_frequency" ]]; then
    git log --since="6 months ago" --format="%ad" --date=iso --merges > ~/commit_data.txt
  elif [[ ${graph_type} == "author" ]]; then
    git log --since="6 months ago" --format="%ai %an" --date=short > ~/commit_data.txt
  fi
  popd
  python3 ~/check_commits.py ${repo_name} ${graph_type}
}

function random_password() {
  if [[ $1 == "safe" ]]; then
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 13; echo
  else
    LC_ALL=C tr -dc '[:graph:]' </dev/urandom | head -c 13; echo
  fi
}

function login_docker() {
  case "$AWS_PROFILE" in
    hl-prod)
      docker_region="ap-northeast-1"
      ;;
    hl-nonprod)
      docker_region="us-west-2"
      ;;
    qoneco-prod)
      docker_region="us-west-2"
      ;;
    qoneco-nonprod)
      docker_region="us-west-2"
      ;;
    *)
      docker_region="us-west-2"
      ;;
  esac

  aws_account_number=$(aws sts get-caller-identity --output json | jq -r ".Account")
  aws ecr get-login-password --region "${docker_region}" | docker login --username AWS --password-stdin "${aws_account_number}.dkr.ecr.${docker_region}.amazonaws.com"

  exec_status=$?
  if [[ exec_status == 0 ]]; then
    echo "Failed to login"
  else
    echo "Logged in to ${aws_account_number}.dkr.ecr.${docker_region}.amazonaws.com"
  fi
}

# Insecure. Need to find a better way of doing this.
alias qonecosqlstage="mkdir -p ~/.mysql/ && touch ~/.mysql/qonecostage.cnf && password=\$(op item get \"Qoneco NP RDS Master Password - MySQL - Stage\" --fields password) && user=\$(op item get \"Qoneco NP RDS Master Password - MySQL - Stage\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=qonecostage-db.qoneco.dev\nport=3306\" > ~/.mysql/qonecostage.cnf && mysql --defaults-file=~/.mysql/qonecostage.cnf && rm ~/.mysql/qonecostage.cnf"
alias midassqlstage="echo 'I haven't written this yet'"
alias qonecosqlprod="mkdir -p ~/.mysql/ && touch ~/.mysql/qonecoprod.cnf && password=\$(op item get \"Qoneco Prod Master DB\" --fields password) && user=\$(op item get \"Qoneco Prod Master DB\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=qoneco-db.qoneco.com\nport=3306\" > ~/.mysql/qonecoprod.cnf && mysql --defaults-file=~/.mysql/qonecoprod.cnf && rm ~/.mysql/qonecoprod.cnf"
alias midassqlprod="mkdir -p ~/.mysql/ && touch ~/.mysql/midasprod.cnf && password=\$(op item get \"RDS Xoro Prod Master Account\" --fields password) && user=\$(op item get \"RDS Xoro Prod Master Account\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=xoro-db.xorogold.com\nport=3306\" > ~/.mysql/qonecoprod.cnf && mysql --defaults-file=~/.mysql/qonecoprod.cnf && rm ~/.mysql/midasprod.cnf"
alias highlowsqlstage="mkdir -p ~/.mysql/ && touch ~/.mysql/highlowstage.cnf && password=\$(op item get \"HL NP RDS Master Password - MySQL - Stage\" --fields password) && user=\$(op item get \"HL NP RDS Master Password - MySQL - Stage\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=stage-db.highlowmi.dev\nport=3306\" > ~/.mysql/highlowstage.cnf && mysql --defaults-file=~/.mysql/highlowstage.cnf && rm ~/.mysql/highlowstage.cnf"
alias highlowsqlprod="mkdir -p ~/.mysql/ && touch ~/.mysql/highlowprod.cnf && password=\$(op item get \"Highlowlive Master Database User\" --fields password) && user=\$(op item get \"Highlowlive Master Database User\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=highlow-db.highlow.com\nport=3306\" > ~/.mysql/highlowprod.cnf && mysql --defaults-file=~/.mysql/highlowprod.cnf && rm ~/.mysql/highlowprod.cnf"
alias cfdsqlstage="mkdir -p ~/.mysql/ && touch ~/.mysql/cfdstage.cnf && password=\$(op item get \"CFD Stage RDS Master Password\" --fields password) && user=\$(op item get \"CFD Stage RDS Master Password\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=cfdstage-db.highlowmi.dev\nport=3306\" > ~/.mysql/cfdstage.cnf && mysql --defaults-file=~/.mysql/cfdstage.cnf && rm ~/.mysql/cfdstage.cnf"
alias cfdsqlprod="mkdir -p ~/.mysql/ && touch ~/.mysql/cfdprod.cnf && password=\$(op item get \"CFD Live RDS Master Password\" --fields password) && user=\$(op item get \"CFD Live RDS Master Password\" --fields username) && echo \"[client]\npassword=\${password}\nuser=\${user}\nhost=cfd-db.highlow.com\nport=3306\" > ~/.mysql/cfdprod.cnf && mysql --defaults-file=~/.mysql/cfdprod.cnf && rm ~/.mysql/cfdprod.cnf"

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

# Created by `pipx` on 2024-05-29 05:44:14
export PATH="$PATH:/Users/scottgardner/.local/bin:/Users/scottgardner/Downloads/sonar-scanner-5.0.1.3006-macosx/bin"
export PATH="$PATH:/Users/scottgardner/Library/Python/3.9/bin"
unalias gg

# Check if my ssh key has already been added, and request it if not

current_keys=$(ssh-add -l)
work_key=$(ssh-keygen -lf ~/.ssh/id_rsa)
if [[ $current_keys != *$work_key* ]]; then
  ssh-add
fi
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
