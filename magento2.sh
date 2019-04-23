_magento()
{
    local cur prev opts base
    COMPREPLY=()
    _get_comp_words_by_ref -n : cur prev words
    
    if [[ "${#cur}" == "0" ]] || [[ "${words[1]}" != "bin/magento" ]]; then return 1;fi;
    
    # Absolute path to this script, e.g. /home/user/bin/foo.sh
    SCRIPT=$(readlink -f "$0")
    # Absolute path this script is in, thus /home/user/bin
    SCRIPTPATH=$(dirname "$SCRIPT")
    GENERATED_PATH=$SCRIPTPATH"/generated/auto-complete.txt"

    if [[ -f $GENERATED_PATH ]]; then
        opts=$(cat $GENERATED_PATH)
    else
        opts=$(${words[0]} bin/magento list --raw | sed -e 's/ \+.*$//')
        echo "$opts" > $GENERATED_PATH
    fi

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    __ltrim_colon_completions $cur
    return 0
}
complete -o default -F _magento php
complete -o default -F _magento php5.6
complete -o default -F _magento php7.0
complete -o default -F _magento php7.1
complete -o default -F _magento php7.2
complete -o default -F _magento php7.3
