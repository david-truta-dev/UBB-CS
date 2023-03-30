TYPE=VIEW
query=select `TPRJ`.`prefix` AS `prefix`,`NHTPRJ`.`name` AS `testproject_name`,`NHTS_L1`.`name` AS `level1_name`,`NHTS_L2`.`name` AS `level2_name`,`NHTPRJ`.`id` AS `testproject_id`,`NHTS_L1`.`id` AS `level1_id`,`NHTS_L2`.`id` AS `level2_id` from (((`bitnami_testlink`.`testprojects` `TPRJ` join `bitnami_testlink`.`nodes_hierarchy` `NHTPRJ` on(`TPRJ`.`id` = `NHTPRJ`.`id`)) left join `bitnami_testlink`.`nodes_hierarchy` `NHTS_L1` on(`NHTS_L1`.`parent_id` = `NHTPRJ`.`id`)) left join `bitnami_testlink`.`nodes_hierarchy` `NHTS_L2` on(`NHTS_L2`.`parent_id` = `NHTS_L1`.`id`)) where `NHTPRJ`.`node_type_id` = 1 and `NHTS_L1`.`node_type_id` = 2 and `NHTS_L2`.`node_type_id` = 2
md5=0f1b3fe12300830be5982566b041c21f
updatable=0
algorithm=0
definer_user=bn_testlink
definer_host=%
suid=2
with_check_option=0
timestamp=0001677861257626298
create-version=2
source=SELECT TPRJ.prefix,\nNHTPRJ.name AS testproject_name,    \nNHTS_L1.name AS level1_name,\nNHTS_L2.name AS level2_name,\nNHTPRJ.id AS testproject_id, \nNHTS_L1.id AS level1_id, \nNHTS_L2.id AS level2_id \nFROM  testprojects TPRJ \nJOIN  nodes_hierarchy NHTPRJ \nON TPRJ.id = NHTPRJ.id\nLEFT OUTER JOIN  nodes_hierarchy NHTS_L1 \nON NHTS_L1.parent_id = NHTPRJ.id\nLEFT OUTER JOIN  nodes_hierarchy NHTS_L2\nON NHTS_L2.parent_id = NHTS_L1.id \nWHERE NHTPRJ.node_type_id = 1 \nAND NHTS_L1.node_type_id = 2\nAND NHTS_L2.node_type_id = 2
client_cs_name=latin1
connection_cl_name=latin1_swedish_ci
view_body_utf8=select `TPRJ`.`prefix` AS `prefix`,`NHTPRJ`.`name` AS `testproject_name`,`NHTS_L1`.`name` AS `level1_name`,`NHTS_L2`.`name` AS `level2_name`,`NHTPRJ`.`id` AS `testproject_id`,`NHTS_L1`.`id` AS `level1_id`,`NHTS_L2`.`id` AS `level2_id` from (((`bitnami_testlink`.`testprojects` `TPRJ` join `bitnami_testlink`.`nodes_hierarchy` `NHTPRJ` on(`TPRJ`.`id` = `NHTPRJ`.`id`)) left join `bitnami_testlink`.`nodes_hierarchy` `NHTS_L1` on(`NHTS_L1`.`parent_id` = `NHTPRJ`.`id`)) left join `bitnami_testlink`.`nodes_hierarchy` `NHTS_L2` on(`NHTS_L2`.`parent_id` = `NHTS_L1`.`id`)) where `NHTPRJ`.`node_type_id` = 1 and `NHTS_L1`.`node_type_id` = 2 and `NHTS_L2`.`node_type_id` = 2
mariadb-version=100338
