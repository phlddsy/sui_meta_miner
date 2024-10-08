function deploy() {
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
		echo "--------------------挖矿项目--------------------"
        echo "101. ORE-V2矿池（CPU） 一键挖矿"
        echo "102. blockjoker小丑币（网页） 一键挖矿"
		echo "103. ALEO鱼池(nvidia GPU)一键挖矿"
		echo "104. *CAT20 一键部署(已失效，请勿使用，等待更新)"
		echo "105. ALEO(GPU)/ORE(CPU)一键双挖"
		echo "106. BETG(GPU)一键挖矿"
		echo "107. FOMO(GPU)一键挖矿"
        echo "0. 退出脚本exit"
        read -p "请输入选项: " OPTION

        case $OPTION in
        
        101) cd ~; rm -rf ore_pool.sh; wget http://download.bithunter.store:9999/ore/ore_pool.sh; chmod u+x ore_pool.sh; ./ore_pool.sh ;;
        102) cd ~; rm -rf bithunter_joker.sh; wget http://download.bithunter.store:9999/joker/bithunter_joker.sh; chmod u+x bithunter_joker.sh; ./bithunter_joker.sh ;;
		103) cd ~; rm -rf aleo-F2Pool.sh; wget http://bh.bithunter.store:8111/aleo/aleo-F2Pool.sh; chmod u+x aleo-F2Pool.sh; ./aleo-F2Pool.sh ;;
		104) cd ~; rm -rf bithunter-fbcat20.sh; wget http://download.bithunter.store:9999/cat/bithunter-fbcat201.sh; chmod u+x bithunter-fbcat20.sh; ./bithunter-fbcat20.sh ;;
	    105) cd ~; rm -rf aleo-ore.sh; wget http://df.bithunter.store:8111/aleo-ore.sh; chmod u+x aleo-ore.sh; ./aleo-ore.sh ;;
	    106) cd ~; rm -rf betg.sh; wget http://df.bithunter.store:8111/betg/betg.sh; chmod u+x betg.sh; ./betg.sh ;;
        107) cd ~;rm -rf fomo.sh;wget http://bh.bithunter.store:8111/sui/fomo.sh ; chmod u+x fomo.sh; ./fomo.sh ;;
		0) echo "退出。"; exit 0 ;;
	    *) echo "无效选项，请重新输入。"; sleep 1 ;;
	    esac
	    echo "按任意键返回主界面..."
        read -n 1
    done
}


# 显示主菜单
deploy