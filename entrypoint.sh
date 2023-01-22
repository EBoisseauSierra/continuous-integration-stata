#!/bin/bash

# populate licence file
echo -n "$1" > /usr/local/stata/stata.lic

$2 -b do main

# print log result
cat main.log

# Fail CI if Stata ran with an error
EXIT_CODE=$(tail -1 main.log | tr -d '[:cntrl:]')

if [[ ${EXIT_CODE:0:1} == "r" ]]; then
    exit 1
fi
