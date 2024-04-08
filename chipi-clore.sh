#!/bin/bash

stroka="/bin/bash"
givers=$1
gpucount=$2
seed=$3

wget -4 -O ChipiCoinGpuMiner-main.zip https://github.com/ChipiCoin/ChipiCoinGpuMiner/archive/refs/heads/main.zip
unzip ChipiCoinGpuMiner-main.zip

echo "SEED=$seed" > config.txt
echo -e '#!'"$stroka\nnpm install\nwhile true; do\nnode send_multigpu.js --api tonapi --bin ./pow-miner-cuda --givers $givers --gpu-count $gpucount\nsleep 1;\ndone;\n" > start_multi_8.sh

cat >> /etc/supervisor/supervisord.conf <<\eof

[program:chipi]
command=/ChipiCoinGpuMiner-main/start_multi_8.sh
directory=/ChipiCoinGpuMiner-main
autostart=true
autorestart=true
stdout_logfile=/dev/fd/1
stdout_logfile_maxbytes=0
eof

supervisorctl reload
