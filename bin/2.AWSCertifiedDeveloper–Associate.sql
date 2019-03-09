-- TEST
insert into test (test_nm, created_date, modified_date) values ('AWS Certified Developer – Associate', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('1', '1', 'AWS-Developer V12.75', now(), now());


-- Q40
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('1', '2', '40', 'Which of the following statements about SWF are true? Choose 3 answers ', '', '', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('1', '2', '40', '1', 'SWF tasks are assigned once and never duplicated', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('1', '2', '40', '2', 'SWF requires an S3 bucket for workflow storage', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('1', '2', '40', '3', 'SWF workflow executions can last up to a year', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('1', '2', '40', '4', 'SWF triggers SNS notifications on task assignment', 'FALSE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('1', '2', '40', '5', 'SWF uses deciders and workers to complete tasks', 'TRUE', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('1', '2', '40', '6', 'SWF requires at least 1 EC2 instance per domain', 'FALSE', now(), now());
