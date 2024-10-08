#!/bin/bash
trap ctrl_c INT

function ctrl_c() {
    clear
    echo -e "\n操作被取消，请按回车键，返回主菜单..."
    read -r  # 等待用户按下回车
    main_menu  # 返回主菜单
}


# Function to run aleominer
run_miner() {

    final_command="	screen -dmS fomo bash -c 'script -f -c \"node mine.js --fomo --chain=mainnet --phrase="$key"\" ./miner.log'"

    eval $final_command
    echo "miner started in screen session"
}


# Function to stop aleominer
stop_miner() {
    pkill -9 node
    pkill -f "tail -n 100 -f miner.log"
    echo "miner stopped and screen session terminated"
	echo -e "\n操作被取消，请按回车键，返回主菜单..."
	read -r  # 等待用户按下回车
	main_menu  # 返回主菜单
}

clear
# Function to install and run miner
install_run_miner() {
    read -p "请输入你的私钥(本脚代码来源网上，不能保证你的私钥安全，如果你害怕钱包被盗，请不要输入私钥): " key
	read -p "设置线程数(默认满线程): " threads
    cd ~
	rm -rf sui_fomo
	mkdir sui_fomo
	cd sui_fomo
	git clone https://github.com/phlddsy/sui_meta_miner.git
	cd sui_meta_miner
	if [ -z "$key" ]; then
		echo "key is not set. Please provide the key of ore as an argument."
    return
    fi
	if [ -z "$threads" ]; then
       threads=$(nproc)
    fi
	js_file="./includes/NonceFinder.js"
	# Use sed to replace the current _workersCount value with the user input
	sed -i "s/\(this\._workersCount\s*=\s*\)[0-9]\+;/\1$threads;/" "$js_file"
	echo "成功设置挖矿线程为: $threads"
    apt update -y
	apt install curl -y
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
	echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bash_profile
	echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME/.bash_profile
	echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.bash_profile
	source $HOME/.bash_profile
	nvm install --lts
    npm install
	run_miner
	echo "等待获取挖矿日志......"
	# 延迟2秒
	sleep 2
    if [ -f ~/sui_fomo/sui_meta_miner/miner.log ]; then
        tail -F ~/sui_fomo/sui_meta_miner/miner.log
    else
        echo "miner.log does not exist."
    fi

}

# Function to view aleominer log
view_miner_log() {
    if [ -f ~/sui_fomo/sui_meta_miner/miner.log ]; then
        tail -F ~/sui_fomo/sui_meta_miner/miner.log
    else
        echo "miner.log does not exist."
    fi
}





function main_menu() {


# Display menu
while true; do
	clear
	echo "======================比特猎人/BitHunter一键部署脚本==================="
	echo "比特猎人社区出品，仅供会员学习使用，请勿用于商业用途"
	echo "比特猎人官方电报群：https://t.me/BitHunterCN"
	echo "比特猎人官方推特：https://x.com/BitHunterCN"
	echo "比特猎人个人电报号：@bithunter1688"
	echo "4折vps优惠购买链接：https://bearhost.us/#/?recommendCode=bithunter"
	echo "========================================================================"
	echo "请选择一个选项，必须用root用户操作："
	echo "脚本需要输入私钥，存在一定的私钥泄露可能，所以如果你不想自己的私钥被盗，从而造成资产损失，请第一时间停止使用本脚本。"
    echo "选择一个选项:"
    echo "1. Fomo一键挖矿"
    echo "2. 查看运行日志"
    echo "3. 停止挖矿"
    echo "4. 退出"
    read -p "请输入你的选择 (1-4): " choice

    case $choice in
        1)
            install_run_miner
            ;;
        2)
            view_miner_log
            ;;
        3)
            stop_miner
            ;;
        4)
            echo "退出"
            exit 0
            ;;
        *)
            echo "无效的选项，请重试"
            ;;
    esac
done
}

main_menu