#!/bin/sh
set -e

echo "Remote User ${_REMOTE_USER}"
echo "Remote Home ${_REMOTE_USER_HOME}"

cache_maps=$_REMOTE_USER_HOME/.cache_maps

cache_dir () {
  home_path=$_REMOTE_USER_HOME/$1
  echo "Creating cache folder for $home_path"
  if [ -d $home_path ]; then
    mv $home_path $home_path-old
  fi
  dir_hash=$(echo $home_path | sha1sum --zero | cut -f1 -d" ")
  hashed_path=$CACHE_HOME/$dir_hash
  ln -sf $hashed_path $home_path
  chown -R $_REMOTE_USER:$_REMOTE_USER $home_path
  echo "$home_path:$hashed_path" >> $cache_maps
}

for path in $CACHE_VOLUMES; do
  cache_dir $path
done

cat << EOF >> $_REMOTE_USER_HOME/.persistence
#!/bin/sh
set -e
echo "Finalizing persistence"
echo "Create persistence folders"

while IFS=: read -r cached_path hashed_path; do
  if [ \$(id -u) != 0 ]; then
    if ! test -d \$hashed_path; then
      echo "Creating \$hashed_path"
      sudo mkdir \$hashed_path
    fi
    echo "chowning \$hashed_path"
    sudo chown -R "$_REMOTE_USER:$_REMOTE_USER" \$hashed_path
  else
    if ! test -d \$hashed_path; then
      mkdir \$hashed_path
    fi
    chown -R "$_REMOTE_USER:$_REMOTE_USER" \$hashed_path
  fi
done < $cache_maps

EOF
chmod +x $_REMOTE_USER_HOME/.persistence
