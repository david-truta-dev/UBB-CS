TYPE=VIEW
query=select `lrqvn`.`req_id` AS `req_id`,`lrqvn`.`version` AS `version`,`REQV`.`id` AS `req_version_id` from ((`bitnami_testlink`.`latest_req_version` `LRQVN` join `bitnami_testlink`.`nodes_hierarchy` `NHRQV` on(`NHRQV`.`parent_id` = `lrqvn`.`req_id`)) join `bitnami_testlink`.`req_versions` `REQV` on(`REQV`.`id` = `NHRQV`.`id` and `REQV`.`version` = `lrqvn`.`version`))
md5=e3d2ffbb37bd7eae86b33fa0c9554a49
updatable=0
algorithm=0
definer_user=bn_testlink
definer_host=%
suid=2
with_check_option=0
timestamp=0001677861257155753
create-version=2
source=SELECT\n   LRQVN.req_id AS req_id,\n   LRQVN.version AS version,\n   REQV.id AS req_version_id\nFROM  latest_req_version LRQVN \nJOIN  nodes_hierarchy NHRQV\nON NHRQV.parent_id = LRQVN.req_id \nJOIN  req_versions REQV \nON REQV.id = NHRQV.id AND REQV.version = LRQVN.version
client_cs_name=latin1
connection_cl_name=latin1_swedish_ci
view_body_utf8=select `lrqvn`.`req_id` AS `req_id`,`lrqvn`.`version` AS `version`,`REQV`.`id` AS `req_version_id` from ((`bitnami_testlink`.`latest_req_version` `LRQVN` join `bitnami_testlink`.`nodes_hierarchy` `NHRQV` on(`NHRQV`.`parent_id` = `lrqvn`.`req_id`)) join `bitnami_testlink`.`req_versions` `REQV` on(`REQV`.`id` = `NHRQV`.`id` and `REQV`.`version` = `lrqvn`.`version`))
mariadb-version=100338
