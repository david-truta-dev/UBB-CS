TYPE=VIEW
query=select `ltcvn`.`testcase_id` AS `testcase_id`,`ltcvn`.`version` AS `version`,`TCV`.`id` AS `tcversion_id` from ((`bitnami_testlink`.`latest_tcase_version_number` `LTCVN` join `bitnami_testlink`.`nodes_hierarchy` `NHTCV` on(`NHTCV`.`parent_id` = `ltcvn`.`testcase_id`)) join `bitnami_testlink`.`tcversions` `TCV` on(`TCV`.`id` = `NHTCV`.`id` and `TCV`.`version` = `ltcvn`.`version`))
md5=53056938f2d5b9468f49f67a655c363a
updatable=0
algorithm=0
definer_user=bn_testlink
definer_host=%
suid=2
with_check_option=0
timestamp=0001677861256981648
create-version=2
source=SELECT\n   LTCVN.testcase_id AS testcase_id,\n   LTCVN.version AS version,\n   TCV.id AS tcversion_id\nFROM  latest_tcase_version_number LTCVN \njoin  nodes_hierarchy NHTCV \non NHTCV.parent_id = LTCVN.testcase_id \njoin  tcversions TCV \non TCV.id = NHTCV.id \nand TCV.version = LTCVN.version
client_cs_name=latin1
connection_cl_name=latin1_swedish_ci
view_body_utf8=select `ltcvn`.`testcase_id` AS `testcase_id`,`ltcvn`.`version` AS `version`,`TCV`.`id` AS `tcversion_id` from ((`bitnami_testlink`.`latest_tcase_version_number` `LTCVN` join `bitnami_testlink`.`nodes_hierarchy` `NHTCV` on(`NHTCV`.`parent_id` = `ltcvn`.`testcase_id`)) join `bitnami_testlink`.`tcversions` `TCV` on(`TCV`.`id` = `NHTCV`.`id` and `TCV`.`version` = `ltcvn`.`version`))
mariadb-version=100338
