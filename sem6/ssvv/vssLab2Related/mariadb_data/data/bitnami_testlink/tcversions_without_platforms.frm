TYPE=VIEW
query=select `NHTCV`.`parent_id` AS `testcase_id`,`NHTCV`.`id` AS `id` from `bitnami_testlink`.`nodes_hierarchy` `NHTCV` where `NHTCV`.`node_type_id` = 4 and !exists(select 1 from `bitnami_testlink`.`testcase_platforms` `TCPL` where `TCPL`.`tcversion_id` = `NHTCV`.`id` limit 1)
md5=8a94d7c20105d9c8c0e64d916466bec6
updatable=1
algorithm=0
definer_user=bn_testlink
definer_host=%
suid=2
with_check_option=0
timestamp=0001677861257508092
create-version=2
source=SELECT\n   NHTCV.parent_id AS testcase_id,\n   NHTCV.id AS id\nFROM  nodes_hierarchy NHTCV \nWHERE NHTCV.node_type_id = 4 AND\nNOT(EXISTS(SELECT 1 FROM  testcase_platforms TCPL\n           WHERE TCPL.tcversion_id = NHTCV.id))
client_cs_name=latin1
connection_cl_name=latin1_swedish_ci
view_body_utf8=select `NHTCV`.`parent_id` AS `testcase_id`,`NHTCV`.`id` AS `id` from `bitnami_testlink`.`nodes_hierarchy` `NHTCV` where `NHTCV`.`node_type_id` = 4 and !exists(select 1 from `bitnami_testlink`.`testcase_platforms` `TCPL` where `TCPL`.`tcversion_id` = `NHTCV`.`id` limit 1)
mariadb-version=100338
