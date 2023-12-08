---
title: JDBC
tags:
  - 不会用到的知识
abbrlink: 23591
toc: true
date: 2023-11-27 17:29:44
---
# 安装使用
`JDBC（Java Data Connectivity，在java.sql.*中）`是`SUN`公司制定的一套接口，使得可以在`java`语言中编写`sql`语句,对数据库中的内容进行`CRUD`操作。
由于每个数据库语言底层实现的原理不相同，为了不对每种语言单独编程，所以制定了`JDBC`接口，在`Java`中定义、使用接口，而在每种数据库语言中会对`java`语言定义`JDBC`的实现类。
所以我们知道要在Java中使用某种数据库语言如`mysql,mysql`必须安装了`jdbc`相关的驱动:`mysql-connector-java-5.1.23-bin.jar`
**注意事项：**JDBC中所有下标都从1开始

# JDBC编程六步
## JDBC编程六步
1、注册驱动（告诉Java程序，即将要连接的是哪个品牌的数据库）
2、获取连接（表示JVM的进程和数据库进程之间的通道打开了，这属于进程之间的通信，使用完之后一定要关闭通道。）
3、获取数据库操作对象（专门执行sql语句的对象）
4、执行SQL语句
5、处理查询结果集（只有当第四步执行的是select语句的时候，才有这第五步处理查询结果集。）
6、释放资源（使用完资源之后一定要关闭资源。Java和数据库属于进程间的通信，开启之后一定要关闭。）

## 具体实现
DriverManager 用于管理一组JDBC驱动程序的基本服务。
相关方法：
static void registerDriver​(Driver driver) 使用 DriverManager注册给定的驱动程序 
static Connection getConnection​(String url, String user, String password) 尝试建立与给定数据库URL的连接。  
Statement createStatement​() 创建一个 Statement对象，用于将SQL语句发送到数据库。 
int executeUpdate​(String sql) 执行给定的SQL语句，可能是INSERT ， UPDATE ，或DELETE语句，返回改变的记录条数
ResultSet executeQuery​(String sql) 执行给定的SQL语句，返回一个 ResultSet对象。 
ResultSet :   
boolean next​() 将光标从当前位置向前移动一行。
String getString​(int columnIndex)    getstring()这个方法是不管底层数据库表中是什么类型，统一都以string形式返回.
String getString​(String columnLabel)

注册驱动
方法1：
    java.sql.Driver driver=new com.mysql.jdbc.Driver();
    DriverManager.registerDriver (driver);
//在mysql中有接口java.sql.Driver，在mysql-connector-java-5.1.23-bin.jar 中由类com.mysql.jdbc.Driver实现

方法2(常用)：
com.mysql.jdbc.Driver中有静态代码块，其中的内容大概如方法1一样，可以注册驱动。
Class.forName (完整类名)作用：要求JVM查找并加载指定的类，加载类时，静态代码块会执行。

Class.forName("com.mysql.jdbc.Driver");

获取连接
Connection conn=DriverManager.getConnection (url,user,password);
获取数据库操作对象
Statement stmt=conn.createStatement ();
执行SQL语句
String sql="......";//JDBC中的sql语句不需要提供分号结尾。
stmt.executeUpdate (sql)
处理查询结果集
ResultSet rs=stmt.executeQuery (sql);
while(rs.next()){
  System.out.println(rs.getString ("deptno"));
}
释放资源
释放资源,先释放ResultSer,再Statement,再Connection
rs.close ();
stmt.close ();
conn.close ();

## 实例
```
a.properties
sqlType=com.mysql.jdbc.Driver
url=jdbc:mysql://localhost:3306/bjpowernode
user=root
password=123456



代码：
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;
try {
    //注册驱动
    ResourceBundle bundle=ResourceBundle.getBundle ("sql\\a");
    String sqlType=bundle.getString ("sqlType");
    Class.forName (sqlType);
    //获取连接
    String url=bundle.getString ("url");
    String user=bundle.getString ("user");
    String password=bundle.getString ("password");
    conn=DriverManager.getConnection (url,user,password);
    //获取数据库操作对象
    stmt=conn.createStatement ();
    //执行SQL语句
    String insertSql="insert into dept(deptno,dname,loc) value(50,'无名部','无名地')";
    String deleteSql="delete from dept where loc='无名地'";
    String selectSql="select * from dept";
    int count1=stmt.executeUpdate (insertSql);
    int count2=stmt.executeUpdate (deleteSql);
    System.out.println (String.format ("count1：%d， conut2：%d",count1,count2));
    rs=stmt.executeQuery (selectSql);
    //处理查询结果集
    while(rs.next ()){
        System.out.println(String.format ("%s,%s,%s",rs.getString("deptno"),rs.getString("dname"),rs.getString ("loc")));
    }
} catch (SQLException e) {
    e.printStackTrace ();
}finally {
    //释放资源,先释放ResultSer,再Statement,再Connection
    if(rs!=null){
        rs.close ();
    }
    if(stmt!=null){
        stmt.close ();
    }
    if(conn!=null){
        conn.close ();
    }
}
```

# SQL注入
一、定义
SQL 注入就是在用户输入的字符串中加入 SQL 语句，如果程序对用户输入数据的合法性没有判断和处理，那么攻击者可以在事先定义好的 SQL 语句中添加额外的 SQL 语句，在管理员不知情的情况下实现非法操作，在管理员不知情的情况下实现非法操作

二、举例：更改用户密码
..........
获取数据库操作对象
Statement stmt=conn.createStatement ();
执行SQL语句
String sql=String.format("update t_users set password='%s'  where user='%s' ",inputPassword,inputUser);
ResultSet rs=stmt.executeUpdate (sql);
...........

如果输入的pasword为123456，user为 HQ' or 'a'='a
那么sql语句将变成update t_users set password='123456' where user='HQ' or 'a'='a' 
这将更改所有用户的密码。

三、发生SQL注入的原因及改进方法
1、原因：可以发现之所以会发生sql注入，是由于先进行了字符串的拼接，在进行sql语句的编译
2、改进方法：采用先编译后传值的方法即可，改用preParedStatement接口，而非 Statement接口。
3、改进后的步骤：

1）注册驱动
Class.forName("com.mysql.jdbc.Driver");
2）获取连接
Connection conn=DriverManager.getConnection (url,user,password);
3）获取预编译的数据库操作对象
// ?，表示一个占位符，一个?将来接收一个“值”，注意：占位符不能使用单引号括起来。
            String sql = "select * from t_user where loginName = ? and loginPwd = ?";
            // 程序执行到此处，会发送sql语句框子给DBMS，然后DBMS进行sql语句的预先编译。
Statement stat = conn.prepareStatement(sql);
            // 给占位符?传值（第1个问号下标是1，第2个问号下标是2，JDBC中所有下标从1开始。）
            ps.setString(1, loginName);
            ps.setString(2, loginPwd);

4）执行sql
            rs = ps.executeQuery();
5）处理结果集
            if(rs.next()){
  ...
            }
6）释放资源
释放资源,先释放ResultSer,再Statement,再Connection
rs.close ();
stat.close ();
conn.close ();

4、对比一下Statement和PreparedStatement?
 - Statement存在sql注入问题，PreparedStatement解决了SQL注入问题。
 - Statement是编译一次执行一次。PreparedStatement是编译一次，可执行N次。PreparedStatement效率较高一些。
 - PreparedStatement会在编译阶段做类型的安全检查。

# PreparedStatement模糊查询
```
String sql = "select * from t_user where loginName like ？";
            // 程序执行到此处，会发送sql语句框子给DBMS，然后DBMS进行sql语句的预先编译。
            PreparedStatement ps = conn.prepareStatement(sql);
            // 给占位符?传值（第1个问号下标是1，第2个问号下标是2，JDBC中所有下标从1开始。）
            ps.setString(1,"%M% );
            
```
# JDBC事务
JDBC中的事务是自动提交的。

修改事务的自动提交机制：
conn.setAutoCommit(false); // 将自动提交机制修改为手动提交，开启事务
conn.commit(); // 提交事务
 conn.rollback();// 回滚事务

代码：
        try {
    // 注册驱动、获取连接
    ....
    // 将自动提交机制修改为手动提交
    conn.setAutoCommit(false); // 开启事务

    // 3、获取预编译的数据库操作对象、执行SQL语句，处理查询结果集
    .....
    // 程序能够走到这里说明以上程序没有异常，事务结束，手动提交数据
    conn.commit(); // 提交事务

        } catch (Exception e) {
    // 回滚事务
    if(conn != null){
        conn.rollback();
    }
    e.printStackTrace();
        } finally {
    // 6、释放资源
    .....
}

# 其他
URL：统一资源定位符，组成：协议+IP地址+端口号port+资源名
如http://192.169.100.2:8888/abc
如：jdbc:mysql://localhost:3306/bjpowernode  ,其中localhost指本机IP地址。