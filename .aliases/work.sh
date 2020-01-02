#iexec sde
alias sde='docker run -it --rm -v $(pwd):/sde/files -v ~/.ssh/id_rsa:/sde/ssh/id_rsa:ro iexechub/iexec-sde:1.0.2'

# Gradle
alias grdbd='gradle clean build -Dtest.profile=skipDocker --refresh-dependencies buildImage -PforceDockerBuild' # gradle & docker build

# Shortcut directories
alias cddev="cd $HOME/iexecdev"
alias cdcor="cd $HOME/iexecdev/iexec-core"
alias cdwor="cd $HOME/iexecdev/iexec-worker"
alias cdcom="cd $HOME/iexecdev/iexec-common"
alias cdint="cd $HOME/iexecdev/iexec-core-integration-tests"
alias cdwal="cd $HOME/iexecdev/wallets"
alias cddep="cd $HOME/iexecdev/iexec-deploy"
alias cdsms="cd $HOME/iexecdev/iexec-sms"

# iExec-core dev
alias upstack="$HOME/iexecdev/iexec-deploy/core-dev/upstack"
alias rmstack="$HOME/iexecdev/iexec-deploy/core-dev/rmstack"
alias upcore="$HOME/iexecdev/iexec-deploy/core-dev/upcore"
alias rmcore="$HOME/iexecdev/iexec-deploy/core-dev/rmcore"
alias upworker="$HOME/iexecdev/iexec-deploy/core-dev/upworker"
alias rmworker="$HOME/iexecdev/iexec-deploy/core-dev/rmworker"
alias upworkers="$HOME/iexecdev/iexec-deploy/core-dev/upworkers"
alias rmworkers="$HOME/iexecdev/iexec-deploy/core-dev/rmworkers"
alias uppool="$HOME/iexecdev/iexec-deploy/core-dev/uppool"
alias rmpool="$HOME/iexecdev/iexec-deploy/core-dev/rmpool"

alias deploy="$HOME/iexecdev/wallets/deploy --workerpool=yes --app=docker.io/iexechub/vanityeth:1.1.1 --dataset=http://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/512/iExec-RLC-RLC-icon.png"
alias buy="$HOME/iexecdev/wallets/buy --workerpool=0xc0c288EC5242E7f53F6594DC7BADF417b69631Ba --app=0x63C8De22025a7A463acd6c89C50b27013eCa6472 --dataset=0x4b40D43da477bBcf69f5fd26467384355a1686d6"

# curl -X POST --header \"Content-Type: application/json\" --data '{"jsonrpc":"2.0", "method":"eth_getBlockByNumber", "params":["latest", false], "id":1}'
lastblock() {
    http --json --body POST $1 <<< '{"jsonrpc":"2.0", "method":"eth_getBlockByNumber", "params":["latest", false], "id":1}' | jq .result.number
}

# curl -X POST --header \"Content-Type: application/json\" --data '{"jsonrpc":"2.0", "method":"eth_syncing", "params":[], "id":1}'
issyncing() {
    http --json --body POST $1 <<< '{"jsonrpc":"2.0", "method":"eth_syncing", "params":[], "id":1}'
}
