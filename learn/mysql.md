
# mysql 常用命令


### 更新表字段

```sql
ALTER TABLE `user_test_task` modify column `target` VARCHAR(100) DEFAULT '' COMMENT '目的'
```

### 增加字段

```sql
ALTER TABLE user_test_task add COLUMN reward VARCHAR(1000) DEFAULT '' COMMENT '奖励'
```

### 增加多个字段

```sql
ALTER TABLE user_test_task add (
	punishment VARCHAR(1000) DEFAULT '' COMMENT '惩罚',
    reward VARCHAR(1000) DEFAULT '' COMMENT '奖励'
) 
```

```sql
ALTER TABLE user_test_task add (
    haveSignDays int  default 0 COMMENT '已打卡天数',
    preAllDays int default 0 COMMENT '上一轮结束时总打卡天数'
)
```
### 设置某个字段的值
### 增加一个外建且关联其他表

```sql
ALTER TABLE `user_test_tag`
 ADD CONSTRAINT `user_test_tag_userid` FOREIGN KEY (`userid`) REFERENCES `tasks_user_info`.`user_test` (`id`);
```
### A表中的一个值复制B表中的值

```sql
update `user_test_tag` A,  `user_test` B set A.userid = b.`id` WHERE A.`phone`  = B.`phone` 
```


###   删除某个数据

```sql
DELETE FROM `user_test` WHERE `id`=5;
```

### 删除表中的多个字段

```sql
ALTER TABLE `user_test` DROP COLUMN `email`,  DROP COLUMN `emailcode`,  DROP COLUMN `phoneNum`
```

### 删除表中的外建

```sql

ALTER TABLE `user_test_tag`
 DROP FOREIGN KEY `user_test_tag_ibfk_1`;

```

### mysql 查找数据切，查关联条信息。


```sql
select a.`lastUpdate` , 
	b.name as 'tagName',
	b.color as 'tagColor',
    a.title, 
    a.`reward` , 
    a.`punishment` 
from (
	select `lastUpdate` , 
	 		title, 
	 		`reward` , 
	 		`punishment`,  
             `tag` 
	from user_test_task
	where phone = '7890123'
	and `lastUpdate` like '%2020-11-07%'
	and (reward != '' or `punishment` !='')
    and `status` in ('ongoing', 'fail', 'success')
) a
inner join (
	select `tagId`, `name`, `color`
	from `user_test_tag`
) b
on a.tag = b.tagId;
```






### 今天执行的命令

```sql
ALTER TABLE `user_test_task` modify column `fine` FLOAT(9, 2) DEFAULT 0 COMMENT '惩罚'


ALTER TABLE `user_test_log` add (
	userid int(30) PRIMARY KEY not null COMMENT '用户id'
)

update `user_test_log` A, `user_test_task` B set A.userid = B.`userid` WHERE A.`taskId`  = B.`taskId`

```