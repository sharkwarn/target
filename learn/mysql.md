
# mysql 常用命令


### 更新表字段

```mysql
ALTER TABLE `user_test_task` modify column `target` VARCHAR(100) DEFAULT '' COMMENT '目的'
```

### 增加字段

```mysql
ALTER TABLE user_test_task add COLUMN reward VARCHAR(1000) DEFAULT '' COMMENT '奖励'
```

### 增加多个字段

```mysql
ALTER TABLE user_test_task add (
	punishment VARCHAR(1000) DEFAULT '' COMMENT '惩罚',
    reward VARCHAR(1000) DEFAULT '' COMMENT '奖励'
) 
```