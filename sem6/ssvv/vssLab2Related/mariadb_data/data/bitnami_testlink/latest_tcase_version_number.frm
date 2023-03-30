TYPE=VIEW
query=select `NH_TC`.`id` AS `testcase_id`,max(`TCV`.`version`) AS `version` from ((`bitnami_testlink`.`nodes_hierarchy` `NH_TC` join `bitnami_testlink`.`nodes_hierarchy` `NH_TCV` on(`NH_TCV`.`parent_id` = `NH_TC`.`id`)) join `bitnami_testlink`.`tcversions` `TCV` on(`NH_TCV`.`id` = `TCV`.`id`)) group by `NH_TC`.`id`
md5=3e0b8a3fb50906a7212f50f8a95a619c
updatable=0
algorithm=0
definer_user=bn_testlink
definer_host=%
suid=2
with_check_option=0
timestamp=0001677861256913386
create-version=2
source=SELECT NH_TC.id AS testcase_id,max(TCV.version) AS version \nFROM  nodes_hierarchy NH_TC \nJOIN  nodes_hierarchy NH_TCV \nON NH_TCV.parent_id = NH_TC.id\nJOIN  tcversions TCV \nON NH_TCV.id = TCV.id \nGROUP BY testcase_id
client_cs_name=latin1
connection_cl_name=latin1_swedish_ci
view_body_utf8=select `NH_TC`.`id` AS `testcase_id`,max(`TCV`.`version`) AS `version` from ((`bitnami_testlink`.`nodes_hierarchy` `NH_TC` join `bitnami_testlink`.`nodes_hierarchy` `NH_TCV` on(`NH_TCV`.`parent_id` = `NH_TC`.`id`)) join `bitnami_testlink`.`tcversions` `TCV` on(`NH_TCV`.`id` = `TCV`.`id`)) group by `NH_TC`.`id`
mariadb-version=100338
