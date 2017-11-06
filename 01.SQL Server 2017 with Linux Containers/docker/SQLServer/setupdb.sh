# while [ `cat /var/opt/mssql/log/errorlog | grep "SQL Server is now ready for client connections" | wc -l` -eq 0 ]
# while [ `cat /var/opt/mssql/log/errorlog* | grep "Server is listening on" | wc -l` -ne 2]
while [ `cat /var/opt/mssql/log/errorlog | grep "The default collation was successfully changed" | wc -l` -eq 0 ]
do
    echo "Wait"
    sleep 5s
done

while :
do
    /opt/mssql-tools/bin/sqlcmd -S . -U sa -P $SA_PASSWORD -Q "SELECT @@SERVERNAME" -t 5 > /dev/null

    if [ $? -eq 0 ]; then
        echo "Connected"
        break
    fi
done

/opt/mssql-tools/bin/sqlcmd -S . -U sa -P $SA_PASSWORD -i /tmp/setupdb.sql

rm /tmp/setupdb.sql
rm /tmp/setupdb.sh


