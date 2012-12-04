#!/bin/bash
#PASSLESS LOGIN
mkdir -p ~/public_html
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -f id_rsa -P ""
cp id_rsa.pub ~/public_html/
chmod a+r ~/public_html/id_rsa.pub

