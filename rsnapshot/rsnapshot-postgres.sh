#/bin/bash

if [ $# -ne 1 ]
then
    echo 'I need one variable !'
    echo '    preexec  [dump the DB]'
    echo '    postexec [rm the DB dump]'
fi

DB='postgres'
PDB='/root/.pdb'
DEST='/var/lib/postgresql/11/dump'
HOST='localhost'
PORT='5432'
USER='postgres'

if [ ! -d $DEST ]
then
    if [[ ! -e '/var/lib/postgresql' ]]
    then
        echo "WARN: No PG dir found. Is it installed ?"
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
    pg_dump --dbname=postgresql://$USER:$PASS@$HOST:$PORT/$DB > $DEST/dump-$DB.SQL
    if [[ -e "$DEST/dump-$DB.SQL" ]]
    then
        chmod 600 $DEST/dump-$DB.SQL
    else
        echo "WARN: Dump $DEST/dump-$DB.SQL not created. Shit happened !"
    fi
    echo [preexec] ... done
else
    echo "WARN: The password file $PDB does not exist"
fi
;;
postexec) if [[ -e "$PDB" ]]
then
    echo [postexec] Cleaning ...
    if [[ -e "$DEST/dump-$DB.SQL" ]]
    then
        rm -rf $DEST/dump-$DB.SQL
    else
        echo "WARN: The SQL dump file $DEST/dump-$DB.SQL does not exist"
    fi
    echo [postexec] ... done
else
    echo "WARN: The password file $PDB does not exist"
fi
;;
esac
