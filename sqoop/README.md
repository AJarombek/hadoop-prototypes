### Overview

Scripts used to import data to HDFS on a Hadoop Cluster using Sqoop and MySQL.

### Commands

The following commands should be run after SSHing into the cluster.

```bash
# Bash Shell
MySQLAddress=$(sudo netstat -tulpn | grep -o '[0-9\.]\+:3306')
MySQLAddress=${MySQLAddress::-5}
echo ${MySQLAddress}

MySQLAddressDashed=$(sed 's/\./-/g' <<< ${MySQLAddress})
echo ${MySQLAddressDashed}

sed -i "s/{MySQLAddressDashed}/${MySQLAddressDashed}/g" create.sql

sudo mysql
```

```bash
# MySQL Shell
use test;
source create.sql

# Ctrl-D to Exit MySQL.
```

```bash
# Bash Shell
sudo -u hdfs hdfs dfs -chmod 777 /

sudo sqoop import --connect jdbc:mysql://${MySQLAddress}:3306/test --table core --m 1 --target-dir /test/core --direct
sudo sqoop import --connect jdbc:mysql://${MySQLAddress}:3306/test --table runs --m 1 --target-dir /test/runs --direct
```

### Files

| Filename            | Description                                                                             |
|---------------------|-----------------------------------------------------------------------------------------|
| `setup.sh`          | Setup the EMR Cluster to use Sqoop.                                                     |
| `sqlite-attempt.sh` | *[DEPRECATED]* Attempt to import data to HDFS using Sqoop and SQLite.                   |
| `test.sql`          | SQL code run on the EMR Cluster.                                                        |

### Resources

1) [Sqoop Basics](https://www.edureka.co/blog/apache-sqoop-tutorial/)
2) [Accumulo Error Fix](https://stackoverflow.com/a/42523568)
3) [Sqoop JDBC Support](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-sqoop-considerations.html#sqoop-supported-drivers-databases)
4) [MySQL Sqoop Tutorial](https://medium.com/@oguzkircicek/i%CC%87mporting-data-from-mysql-into-hdfs-using-sqoop-on-cloudera-30cac8678917)
5) [MapReduce Write Access Denied](https://community.cloudera.com/t5/Support-Questions/Permission-denied-user-mapred-access-WRITE-inode-quot-quot/td-p/16318)