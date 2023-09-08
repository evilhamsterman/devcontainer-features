#!/bin/sh
set -e

env | sort > /root/env

# cache_dir () {
#   echo "Creating cache folder for $1"
#   dir_hash=$(echo $1 | sha1sum --zero | cut -f1 -d" ")
#   hashed_path=$CACHE_HOME/$dir_hash
#   if [ -e $1 ]; then
#     echo "Moving existing folder $1 to $1-old"
#     mv $1 $1-old
#   fi
#   mkdir $hashed_path
#   ln -s $hashed_path $1
#   chown -R $_REMOTE_USER:$_REMOTE_USER $1
#   echo "$1 $hashed_path" >> $_REMOTE_USER_HOME/.cache_maps
# }

# for path in $CACHE_VOLUMES; do
#   cache_dir $path
# done

# cat << EOF >> $_REMOTE_USER_HOME/.bashrc
# sudo chown -R $_REMOTE_USER:$_REMOTE_USER $CACHE_HOME
# EOF

# if [ -e "$_REMOTE_USER_HOME/.azure" ]; then
#   echo "Moving existing .azure folder to .azure-old"
#   mv "$_REMOTE_USER_HOME/.azure" "$_REMOTE_USER_HOME/.azure-old"
# fi

# ln -s /dc/azure/ "$_REMOTE_USER_HOME/.azure"
# chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$_REMOTE_USER_HOME/.azure"

# # chown mount (only attached on startup)
# cat << EOF >> "$_REMOTE_USER_HOME/.bashrc"
# sudo chown -R "${_REMOTE_USER}:${_REMOTE_USER}" /dc/azure
# EOF
# chown -R $_REMOTE_USER $_REMOTE_USER_HOME/.bashrc