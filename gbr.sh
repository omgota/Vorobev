#!/bin/bash

cd /opt/RedDatabase/bin/
./gfix -user sysdba -password *password* /home/fssp/db/*name db* -v -full > /home/fssp/db/vful.log  #Проверка на ошибки

cd /opt/RedDatabase/bin/
./gfix -user sysdba -password *password* /home/fssp/db/*name db* -mend > /home/fssp/db/mend.log  #Исправление ошибок

cd /opt/RedDatabase/bin/
./gbak -user sysdba -password *password* -b -v -g  /home/fssp/db/*name db* /home/fssp/data/*name db.fbk* > /home/fssp/db/backup.log  #Бэкап

cd /home/fssp/db/
mv *name db.fdb* /home/*name db.fdb*  #Перемещение  дб в другой каталог если не хватает свободного места

cd /opt/RedDatabase/bin/
./gbak -user sysdba -password *password* -c -v /home/fssp/data/*name db.fbk* /home/fssp/db/*name db* > /home/fssp/db/restore.log #Рестор

cd /home/fssp/db/
chmod 777 *name db*.fdb
chown firebird:firebird *name db*.fdb

