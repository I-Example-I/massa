# Options
. <(wget -qO- https://raw.githubusercontent.com/Kallen-c/utils/main/colors.sh) --
option_value(){ echo "$1" | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/Kallen-c/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: the script installs an Aleo client or miner node"
		echo
		echo -e "${C_LGn}Usage${RES}: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -h, --help       show the help page"
		echo -e "  -n, --node PORT  assign the specified port to use RPC (default is ${C_LGn}${node}${RES})"
		echo -e "  -r, --rpc PORT   assign the specified port to use RPC (default is ${C_LGn}${rpc}${RES})"
		echo -e "  -u, --update     update the node"
		echo
		echo
		return 0 2>/dev/null; exit 0
		;;
	-n*|--node*)
		if ! grep -q "=" <<< $1; then shift; fi
		node=`option_value $1`
		shift
		;;
	-r*|--rpc*)
		if ! grep -q "=" <<< $1; then shift; fi
		rpc=`option_value $1`
		shift
		;;
	-u|--update)
		function="update"
		shift
		;;
	*|--)
		break
		;;
	esac
done


cd /root

sudo tee /root/rollsup.sh > /dev/null <<EOF
#!/bin/bash
#Версия 0.05
cd /root/massa/massa-client
#Задаем переменные
candidat=\$(./massa-client wallet_info |grep 'Candidate rolls'|awk '{print \$3}')
massa_wallet_address=\$(./massa-client wallet_info |grep 'Address'|awk '{print \$2}')
tmp_final_balans=\$(./massa-client wallet_info |grep 'Final balance'|awk '{print \$3}')
final_balans=\${tmp_final_balans%%.*}
if [ -z "\$candidat" ];then
echo \`/bin/date |awk '{print \$2,\$3,\$5}'\` "Нода в данный момент не в сети" >> /root/rolls.log
elif [ \$candidat -gt "0" ];then
echo "Ok" > /dev/null
elif [ \$final_balans -gt "99" ]; then
echo \`/bin/date |awk '{print \$2,\$3,\$5}'\` "Ролл слетел, проверяем количество монеток и пробуем купить" >> /root/rolls.log
resp=\$(./massa-client buy_rolls \$massa_wallet_address 1 0)
echo \`/bin/date |awk '{print \$2,\$3,\$5}'\` Был куплен 1 rolss >> /root/rolls.log
else
echo \`/bin/date |awk '{print \$2,\$3,\$5}'\` Недостаточно монет для покупки ролла у вас \$final_balans, необходимо минимум 100 >> /root/rolls.log
fi
EOF

printf "SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/3 * * * * root /bin/bash /root/rollsup.sh > /dev/null 2>&1
" > /etc/cron.d/massarolls