# 数据库整理和比对工具 （只适合于SQL Server）
在以往的项目开发中，一直缺少数据库的整理。

1. 开发时间短，只是往数据库建表，但没有系统性的整理数据表及结构，导致后期忘了字段的含义...

2. 系统上线后有需求变更，导致之前的一些列不再被使用，又没有即时删除，垃圾字段越来越多，越到后期，越不敢整理数据库

3. 没有找的好的方法和工具来整理数据库，表和字段含义整理起来麻烦，以前尝试过用以下方法将数据库表和字段导出，在Excel里整理，但后来每次更改数据库都需要更新文档，觉得麻烦就没有继续。

   ```
   SELECT
         a.colorder 字段序号,
         a.name 字段名,
         (case when COLUMNPROPERTY( a.id,a.name,'IsIdentity')=1 then '√'else '' end) 标识,
         (case when (SELECT count(*)
         FROM sysobjects
         WHERE (name in
                   (SELECT name
                  FROM sysindexes
                  WHERE (id = a.id) AND (indid in
                            (SELECT indid
                           FROM sysindexkeys
                           WHERE (id = a.id) AND (colid in
                                     (SELECT colid
                                    FROM syscolumns
                                    WHERE (id = a.id) AND (name = a.name))))))) AND
                (xtype = 'PK'))>0 then '√' else '' end) 主键,
         b.name 类型,
         a.length 占用字节数,
         COLUMNPROPERTY(a.id,a.name,'PRECISION') as 长度,
         isnull(COLUMNPROPERTY(a.id,a.name,'Scale'),0) as 小数位数,
         (case when a.isnullable=1 then '√'else '' end) 允许空,
         isnull(e.text,'') 默认值,
         isnull(g.value,'') AS 字段说明
   FROM  syscolumns  a left join systypes b
   on  a.xtype=b.xusertype
   inner join sysobjects d
   on a.id=d.id  and  d.xtype='U' and  d.name<>'dtproperties'
   left join syscomments e
   on a.cdefault=e.id
   left join sys.extended_properties g
   on a.id=g.major_id AND a.colid = g.Minor_id where d.name='ICMO'
   order by d.name,a.id,a.colorder
   ```

所以抽空自己做了一个数据库整理工具，以后计划还会增加数据库比对功能。（因为开发不是Code First，所以常常在本地改了数据库，但忘了去修改正式环境中的数据库）

目前这个系统有以下功能：

1. 通过数据库连接，自动读取该数据库的所有表及其字段的信息
2. 可以增加修改表的描述，以及表所属的系统模块
3. 可以批量增加和修改字段的描述

后续计划增加以下功能

1. 开发环境中和正式环境中的数据库比对功能

## 系统截图

**首页**

![image-20200324211513094](https://github.com/Nathan2020-0126/Db-Differ/blob/master/image-20200324211513094.png)

**增加和读取数据库信息**

![image-20200324211623144](https://github.com/Nathan2020-0126/Db-Differ/blob/master/image-20200324211623144.png)

**批量维护数据库字段的描述信息**

![image-20200324211710342](https://github.com/Nathan2020-0126/Db-Differ/blob/master/image-20200324211710342.png)

## 使用方法
1. 下载压缩文件并解压缩
2. 下载DB Differ.sql文件，执行创建数据库
3. 修改项目中的数据库连接语句
4. 运行项目
