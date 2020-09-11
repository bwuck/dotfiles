if status --is-interactive
    set -x LC_ALL en_US.UTF-8
    set -x LANG en_US.UTF-8

    set -x EDITOR vim
    set -x GIT_EDITOR vim

    set -x OS (/usr/bin/uname)
    switch $OS
        case FreeBSD
            set -x LLVM_HOME /usr/local/llvm-devel
        case Linux
            set -x LLVM_HOME /usr/local/opt/llvm
        case Darwin
            # Java Home.
            #set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
            #set -x JAVA_HOME (/usr/libexec/java_home)
            set -x LLVM_HOME /usr/local/opt/llvm

            # to use stdc++
            # set -x LDFLAGS "-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
            set -x LDFLAGS "-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
            set -x CPPFLAGS "-I/usr/local/opt/llvm/include"
    end

    # Not suffixing with $PATH to be consistent accross OS.
    # Now set the correct PATH environment variable.
    set -x PATH \
        $HOME/.local/bin \
        $HOME/.cargo/bin \
        $HOME/go/bin \
        /snap/bin \
        /mingw64/bin \
        $LLVM_HOME/bin \
        /usr/local/bin \
        /usr/local/sbin \
        /usr/bin \
        /bin \
        /usr/sbin \
        /sbin


    function gtop
        set top_dir (git rev-parse --show-toplevel)
        printf "%s" $top_dir
    end
end

setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    if [ -n "$SSH_AGENT_PID" ]
        ps -ef | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null
        if [ $status -eq 0 ]
            test_identities
        end
    else
        if [ -f $SSH_ENV ]
            . $SSH_ENV >/dev/null
        end
        ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent >/dev/null
        if [ $status -eq 0 ]
            test_identities
        else
            echo "Initializing new SSH agent ..."
            ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV
            echo "succeeded"
            chmod 600 $SSH_ENV
            . $SSH_ENV >/dev/null
            ssh-add
        end
    end
end

function test_identities
    ssh-add -l | grep "The agent has no identities" >/dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

start_agent

function fish_title
    if [ $_ = 'fish' ]
        echo (prompt_pwd)
    else
        echo $_
    end
end

# Mac OS specific hack to set the path.
# if type -q launchctl
#     launchctl setenv PATH $PATH
# end

if type -q starship
    starship init fish | source
end
