#!/bin/sh

DUMPDIR=/home/makler/dumps

FILENAME=makler-`/bin/date +%Y%m%d-%H%M`.tar.bz2

/usr/bin/pg_dump -b -F t makler | /bin/bzip2 -9 -c > $DUMPDIR/$FILENAME


/usr/bin/find $DUMPDIR -type f -ctime +90 -name "makler-????????-????.tar.bz2" -exec rm {} \;
