#!/bin/bash

[ -z $GID ] && { GID=1000; }
[ -z $UID ] && { UID=1000; }

# group for app
[ $( getent group app | wc -l ) -gt 0 ] && { groupdel app; }
groupadd -g $GID app
# user
[ $( getent passwd app | wc -l ) -gt 0 ] && { userdel app; }
useradd -g app -u $UID -s /bin/bash -m app

if [ ! -z "$SYNC_LIST" ]
then
  echo -n > /config/sync_list
  # convert comma limited list to line-by-line and insert into the sync_list file
  echo "$SYNC_LIST" | tr -s ',' '\n' > /config/sync_list
fi

# start onedrive
#[ -d /config ] && { mkdir /config; }
#[ -d /onedrive ] && { mkdir /onedrive; }
mkdir -p /{config,onedrive}
chown -R app:app /config
chown -R app:app /onedrive
su app -c "onedrive --monitor --confdir /config --syncdir /onedrive"

