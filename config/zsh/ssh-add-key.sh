# SSHエージェントの起動と鍵の登録
# 利用方法：
# source ssh-add-key.sh [ssh_id_file]

ssh_id_file="$1"
ssh_id_file=${ssh_id_file:-$HOME/.ssh/id_ed25519}
ssh_dir=$(cd "$(dirname "$ssh_id_file")" && pwd)

ssh-add -l >/dev/null 2>&1
ret=$?
if [ $ret -eq 2 ]; then
    # ssh-agentが接続されていない
    if [ -f "$ssh_dir/ssh-agent.env" ]; then
        # ssh-agentが起動しているかもしれない
        source "$ssh_dir/ssh-agent.env" >/dev/null 2>&1
        ssh-add -l >/dev/null 2>&1
        ret=$?
        if [ $ret -eq 2 ]; then
            # ssh-agentが起動していない
            echo "ssh-agent start"
            ssh-agent >"$ssh_dir/ssh-agent.env"
            source "$ssh_dir/ssh-agent.env" >/dev/null 2>&1
            ssh-add "$ssh_id_file"
        elif [ $ret -eq 1 ]; then
            # ssh-agentが起動しているが、鍵が登録されていない
            echo "ssh-add key"
            ssh-add "$ssh_id_file"
        fi
    else
        # ssh-agentが起動していない
        echo "ssh-agent start"
        ssh-agent >"$ssh_dir/ssh-agent.env"
        source "$ssh_dir/ssh-agent.env" >/dev/null 2>&1
        ssh-add "$ssh_id_file"
    fi
elif [ $ret -eq 1 ]; then
    # ssh-agentが起動しているが、鍵が登録されていない
    echo "ssh-add key"
    ssh-add "$ssh_id_file"
fi
