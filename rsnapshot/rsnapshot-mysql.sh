#/bin/bash

#GRANT SUPER, PROCESS ON *.* TO 'readuser'@'localhost' IDENTIFIED BY "<password>";
#GRANT SELECT ON *.* TO 'readuser'@'localhost' IDENTIFIED BY "<password>";
#GRANT LOCK TABLES ON *.* TO 'readuser'@'localhost' IDENTIFIED BY "<password>";

if [ $# -ne 1 ]
then
    echo 'I need one variable !'
    echo '    preexec  [dump the DB]'
    echo '    postexec [rm the DB dump]'
fi

PDB='/root/.readuser'
DEST='/var/lib/mysql/dump'
HOST='localhost'
PORT='3306'
USER='readuser'

if [ ! -d $DEST ]
then
    if [[  ! -d '/var/lib/mysql' ]]
    then
        echo "WARN: No MySQL dir found. Is it installed ?"
    else
        echo "$DEST does not exist ! Trying to create ..."
        mkdir $DEST
    fi
fi

case $1 in
preexec) if [[ -e "$PDB" ]]
then
    PASS=`cat $PDB`
    echo [preexec] Backuping ...

    DBLIST=`mysql -u readuser -p$PASS -e 'SHOW DATABASES\G' | grep Database | grep -v '_schema' | awk '{print $NF}'`
    for DB in $DBLIST;do
        mysqldump --opt --lock-tables --user=$USER --password=$PASS --host=$HOST $DB > $DEST/dump-$DB.SQL
        if [[ -e "$DEST/dump-$DB.SQL" ]]
        then
            chmod 600 $DEST/dump-$DB.SQL
        else
            echo "WARN: Dump $DEST/dump-$DB.SQL not created. Shit happened !"
        fi
    done
    echo [preexec] ... done
else
    echo "WARN: The password file $PDB does not exist"
fi
;;
postexec) if [[ -e "$PDB" ]]
then
    echo [postexec] Cleaning ...
    rm -rf $DEST/dump-*.SQL
    echo [postexec] ... done
else
    echo "WARN: The password file $PDB does not exist"
fi
;;
esac
