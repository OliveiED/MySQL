#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

echo "[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/rc-local.service

echo "#!/bin/sh -e
#
# rc.local
# Para instalar basta executar o mesmo com o usuáio root.

exit 0
" > /etc/rc.local

chmod 755 /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
systemctl status rc-local.service