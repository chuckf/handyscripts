#!/bin/bash

# Created by Chuck Frain <linux@chuckfrain.net>
# Licensed under the GPL v2 https://www.gnu.org/licenses/gpl2.txt
# This file creates user certs for OpenVPN and zips the files needed to the username.zip
# This is excuted by a user with rights to run the scripts and access to the files in /etc/openvpn/easy-rsa/*
# This has only been tested and used on a CentOS 7 machine as of O2/06/2016

# USAGE: ./zipcerts.sh username

# This sources the variable file for easy-rsa parameters
source vars
# This creates user certs with a password
./build-key-pass $1
# This copies a default ovpn file to be used with the new user that was just created
cp keys/sample.ovpn keys/$1.ovpn
# This changes the key and crt file names to match the new user name
sed -i 's/CHANGEME/'$1'/g' keys/$1.ovpn
# This zips the needed files for the new user's client configuration
zip keys/$1.zip keys/ca.crt keys/$1.key keys/$1.crt keys/$1.ovpn
