#   Conda init
#   ------------------------------------------------------------
    __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/ubuntu/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        \eval "$__conda_setup"
    else
        if [ -f "/home/ubuntu/anaconda3/etc/profile.d/conda.sh" ]; then
            CONDA_CHANGEPS1=false conda activate base
        else
            \export PATH="/home/ubuntu/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    export CONDA_DEFAULT_ENV=base
    export CONDA_PYTHON_EXE=/home/ubuntu/anaconda3/bin/python
    export CONDA_BIN=/home/ubuntu/anaconda3/bin
    export CONDA_PREFIX=/home/ubuntu/anaconda3



#   Change Prompt
#   ------------------------------------------------------------
    parse_git_branch() {
        if git branch &>/dev/null; then
            printf "\n| \e[94m(${CONDA_DEFAULT_ENV})\033[00m\033[32m"
            git branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
        fi
    }
    current_env() {
        echo "()" # deactivate default conda env prefix with: conda config --set changeps1 False
    }
    line() {
        echo $(printf "%$(tput cols)s" | sed 's/ /…/g')
    }
    current_dir() {
        home_directory="ubuntu"
        full_path=$(pwd)
        printed_path_elements=()


        # # split pwd by '/'
        array=(${full_path//\// })


        # check if home directory
        if [[ ${array[1]} = $home_directory ]]; then
            if [[ ${#array[@]} -le 6 ]]; then
                path_prefix="~"
            else
                path_prefix=".."
            fi
        fi


        # remove first 3 elements /Users/guillaume.bournique
        delete=("home" $home_directory)
        for target in "${delete[@]}"; do
          for i in "${!array[@]}"; do
            if [[ ${array[i]} = $target ]]; then
              unset 'array[i]'
            fi
          done
        done


        # construct output
        if [[ ${#array[@]} -ge 3 ]]; then
            printed_path_elements+=("${array[@]: -3:1}")
        fi
        if [[ ${#array[@]} -ge 2 ]]; then
            printed_path_elements+=("${array[@]: -2:1}")
        fi
        if [[ ${#array[@]} -ge 1 ]]; then
            printed_path_elements+=("${array[@]: -1:1}")
        fi


        delimiter_colour="\033[0;35m"
        dir_colour="\033[33;1m"
        printed_path=$path_prefix
        for elt in "${printed_path_elements[@]}"; do
            printed_path="${printed_path}${delimiter_colour}»${dir_colour}${elt}"
        done
        printf ${printed_path}
    }


    export PS1="\[\e[90m\]\$(line)\n★ [\t] \[\033[36m\]\u\[\033[m\]@\[\e[35m\]\h\[\033[m\]:\[\033[33;1m\]\$(current_dir)\[\e[90m\]\$(parse_git_branch) \n\[\033[m\]» "
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
    # 🚀


#   Add color to terminal
#   ------------------------------------------------------------
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    # export GREP_OPTIONS=--color=auto
    export TERM="xterm-color"


#   Set environemnt variables
#   ------------------------------------------------------------
    export DOCKER_USERNAME=gbournique
    export DOCKER_PASSWORD=Vlan1478


#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------
    # Do not show hidden files and folders when <cd tab>
    bind 'set match-hidden-files off'

    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
    alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
    alias lll='tree -C'                         # Preferred 'tree -C' implementation
    alias less='less -FSRXc'                    # Preferred 'less' implementation
    cd() { builtin cd "$@"; ls -l; }            # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels
    alias edit='subl'                           # edit:         Opens any file in sublime editor
    alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
    alias ~="cd ~ && conda deactivate"          # ~:            Go Home and deactivate conda environment
    alias c='clear'                             # c:            Clear terminal display
    alias which='type -all'                     # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
    mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
    trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
    ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
    alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
    alias bashp='open ~/.bash_profile'
    alias bashrc='open ~/.bashrc'
    alias gst='git st'
    alias refresh='source ~/.bashrc'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#   Project aliases
    alias docker_login="echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin"


#   Go to folder aliases
    alias go_home='cd ~'

#   Bash completion for kubectl
    source <(kubectl completion bash)
    alias k='kubectl'

    alias kev="kubectl get events  --sort-by='.metadata.creationTimestamp'"