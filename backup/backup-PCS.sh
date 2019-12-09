#!/bin/bash

CONF='./rclone-PCS.sh'
SRCPATH='<source_path>'
DSTPATH='OVH:<container_name>'

if [ $# -ne 1 ]
then
    echo I need one variable !
    echo The account name to sync :
    echo  - Alexandra
    echo  - Remy
    echo  - Arlette
    echo  - Shared
    echo  - Jean-Pierre
    echo Or for every account : all
fi

case $1 in
Arlette) if [[ -e "$CONF" ]]
then
    echo Backuping Folder : /$1
    rclone --config $CONF sync $SRCPATH/$1 $DSTPATH/$1 --verbose
else
    echo Failed backuping Folder, \$CONF \'$CONF\' or \$SRCPATH \'$SRCPATH/$1\' empty
fi
;;
Alexandra) if [[ -e "$CONF" && -d "$SRCPATH/$1" ]]
then
    echo Backuping Folder : /$1
    rclone --config $CONF sync $SRCPATH/$1 $DSTPATH/$1 --verbose
else
    echo Failed backuping Folder, \$CONF \'$CONF\' or \$SRCPATH \'$SRCPATH/$1\' empty
fi
;;
Shared) if [[ -e "$CONF" && -e "$SRCPATH/$1" ]]
then
    echo Backuping Folder : /$1
    rclone --config $CONF sync $SRCPATH/$1 $DSTPATH/$1 --verbose
else
    echo Failed backuping Folder, \$CONF \'$CONF\' or \$SRCPATH \'$SRCPATH/$1\' empty
fi
;;
Remy) if [[ -e "$CONF" && -e "$SRCPATH/$1" ]]
then
    echo Backuping Folder : /$1
    rclone --config $CONF sync $SRCPATH/$1 $DSTPATH/$1 --verbose --exclude *.mcache
else
    echo Failed backuping Folder, \$CONF \'$CONF\' or \$SRCPATH \'$SRCPATH/$1\' empty
fi
;;
Jean-Pierre) if [[ -e "$CONF" && -e "$SRCPATH/$1" ]]
then
    echo Backuping Folder : /$1
    rclone --config $CONF sync $SRCPATH/$1 $DSTPATH/$1 --verbose
else
    echo Failed backuping Folder, \$CONF \'$CONF\' or \$SRCPATH \'$SRCPATH/$1\' empty
fi
;;
all) if [[ -e "$CONF" ]]
then
    echo Backuping ALL Folders
    rclone --config $CONF sync $SRCPATH/Arlette     $DSTPATH/Arlette     --verbose
    rclone --config $CONF sync $SRCPATH/Alexandra   $DSTPATH/Alexandra   --verbose
    rclone --config $CONF sync $SRCPATH/Shared      $DSTPATH/Shared      --verbose
    rclone --config $CONF sync $SRCPATH/Remy        $DSTPATH/Remy        --verbose --exclude *.mcache
    rclone --config $CONF sync $SRCPATH/Jean-Pierre $DSTPATH/Jean-Pierre --verbose
fi
;;
esac
