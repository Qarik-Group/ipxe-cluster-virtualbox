#!/bin/bash

count=${1-1}

for i in $(seq 1 ${count}); do
    VBoxManage controlvm node-z${i} poweroff
    sleep 1
    VboxManage unregistervm node-z${i} --delete
done
