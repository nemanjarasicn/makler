#!/bin/sh

DBNAME=$1
ARCHIVED_DUMP=$2

/usr/bin/dropdb --username=$USER $DBNAME
/usr/bin/createdb --username=$USER --no-password --template=template0 $DBNAME
bunzip2 -c  $ARCHIVED_DUMP | pg_restore --no-owner --username=$USER -d $DBNAME
vacuumdb -U $USER -z $DBNAME
psql --username=$USER $DBNAME -c "ALTER USER $USER PASSWORD '$USER' ;" 

