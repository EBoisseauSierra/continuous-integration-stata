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

# # Add the list of artefacts and their SHA512 sum as a 'git notes' to HEAD
# git notes remove --ignore-missing #  Clear note if already existing

# # Source: how to comment on multi-line commands https://stackoverflow.com/a/12797512/5433628
# find results/ -type f `# list all artefacts…` \
#     -exec sha512sum {} \; `# … and compute their SHA-512 sum: https://askubuntu.com/a/1091369`\
#     | sed 's/  /,/' `# replace the double-space separator between sha and filename with a comma`\
#     | cat <(echo "sha512,file_name") - `# prefix the git note on the fly, as appending creates new line https://stackoverflow.com/a/58287466/5433628 + https://stackoverflow.com/a/33139133/5433628`\
#     | git -c "user.name=Github Actions" -c "user.email=bot@github.actions" notes add --allow-empty -F -
