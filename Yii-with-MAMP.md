# INSTALLING YII FRAMEWORK ON MAMP

## Using a MacBook Pro

### DATABASE CONFIG - main-local.php (database config)
Mac needs a socket for MySQL... 
<br>
you can add that, and the MAMP port to 
<br>
{app directory}/common/config/main-local.php
<pre>
'db' => [
            'class' => 'yii\db\Connection',
            // changed from localhost to 127.0.0.1
            'dsn' => 'mysql:host=localhost;port=8889;dbname=yiip2;unix_socket=/Applications/MAMP/tmp/mysql/mysql.sock',
            'username' => 'admin',
            'password' => 'adminadmin',
            'charset' => 'utf8',
        ],
</pre>

### MIGRATE ERROR 1 - MySQL Connection Refused

<pre>
yiip2 % ./yii migrate
Yii Migration Tool (based on Yii v2.0.43)

Exception 'yii\db\Exception' with message 'SQLSTATE[HY000] [2002] Connection refused'

in /Users/development/Sites/yiip2/vendor/yiisoft/yii2/db/Connection.php:649

Error Info:
Array
(
    [0] => HY000
    [1] => 2002
    [2] => Connection refused
)
</pre>

### MIGRATE ERROR 2 - MySQL no such file or directory

<pre>
yiip2 % ./yii migrate
Yii Migration Tool (based on Yii v2.0.43)

Exception 'yii\db\Exception' with message 'SQLSTATE[HY000] [2002] No such file or directory'

in /Users/development/Sites/yiip2/vendor/yiisoft/yii2/db/Connection.php:649

Error Info:
Array
(
    [0] => HY000
    [1] => 2002
    [2] => No such file or directory
)
</pre>


### MIGRATE ERROR 3 - MySQL access denied with password
<pre>
yiip2 % ./yii migrate
Yii Migration Tool (based on Yii v2.0.43)

Exception 'yii\db\Exception' with message 'SQLSTATE[HY000] [1045] Access denied for user 'admin'@'localhost' (using password: YES)'

in /Users/development/Sites/yiip2/vendor/yiisoft/yii2/db/Connection.php:649

Error Info:
Array
(
    [0] => HY000
    [1] => 1045
    [2] => Access denied for user 'admin'@'localhost' (using password: YES)
)
</pre
