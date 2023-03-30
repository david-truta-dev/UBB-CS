TYPE=VIEW
query=(select `NHTPL`.`name` AS `testplan_name`,date_format(`E`.`execution_ts`,\'%Y-%m-%d\') AS `yyyy_mm_dd`,date_format(`E`.`execution_ts`,\'%Y-%m\') AS `yyyy_mm`,date_format(`E`.`execution_ts`,\'%H\') AS `hh`,date_format(`E`.`execution_ts`,\'%k\') AS `hour`,`E`.`id` AS `id`,`E`.`build_id` AS `build_id`,`E`.`tester_id` AS `tester_id`,`E`.`execution_ts` AS `execution_ts`,`E`.`status` AS `status`,`E`.`testplan_id` AS `testplan_id`,`E`.`tcversion_id` AS `tcversion_id`,`E`.`tcversion_number` AS `tcversion_number`,`E`.`platform_id` AS `platform_id`,`E`.`execution_type` AS `execution_type`,`E`.`execution_duration` AS `execution_duration`,`E`.`notes` AS `notes` from ((`bitnami_testlink`.`executions` `E` join `bitnami_testlink`.`testplans` `TPL` on(`TPL`.`id` = `E`.`testplan_id`)) join `bitnami_testlink`.`nodes_hierarchy` `NHTPL` on(`NHTPL`.`id` = `TPL`.`id`)))
md5=5a3c8337836204c27a070729abd0b77c
updatable=1
algorithm=0
definer_user=bn_testlink
definer_host=%
suid=2
with_check_option=0
timestamp=0001677861257696192
create-version=2
source=(\nSELECT NHTPL.name AS testplan_name, \nDATE_FORMAT(E.execution_ts, \'%Y-%m-%d\') AS yyyy_mm_dd,\nDATE_FORMAT(E.execution_ts, \'%Y-%m\') AS yyyy_mm,\nDATE_FORMAT(E.execution_ts, \'%H\') AS hh,\nDATE_FORMAT(E.execution_ts, \'%k\') AS hour,\nE.* FROM  executions E\nJOIN  testplans TPL on TPL.id=E.testplan_id\nJOIN  nodes_hierarchy NHTPL on NHTPL.id = TPL.id)
client_cs_name=latin1
connection_cl_name=latin1_swedish_ci
view_body_utf8=(select `NHTPL`.`name` AS `testplan_name`,date_format(`E`.`execution_ts`,\'%Y-%m-%d\') AS `yyyy_mm_dd`,date_format(`E`.`execution_ts`,\'%Y-%m\') AS `yyyy_mm`,date_format(`E`.`execution_ts`,\'%H\') AS `hh`,date_format(`E`.`execution_ts`,\'%k\') AS `hour`,`E`.`id` AS `id`,`E`.`build_id` AS `build_id`,`E`.`tester_id` AS `tester_id`,`E`.`execution_ts` AS `execution_ts`,`E`.`status` AS `status`,`E`.`testplan_id` AS `testplan_id`,`E`.`tcversion_id` AS `tcversion_id`,`E`.`tcversion_number` AS `tcversion_number`,`E`.`platform_id` AS `platform_id`,`E`.`execution_type` AS `execution_type`,`E`.`execution_duration` AS `execution_duration`,`E`.`notes` AS `notes` from ((`bitnami_testlink`.`executions` `E` join `bitnami_testlink`.`testplans` `TPL` on(`TPL`.`id` = `E`.`testplan_id`)) join `bitnami_testlink`.`nodes_hierarchy` `NHTPL` on(`NHTPL`.`id` = `TPL`.`id`)))
mariadb-version=100338
