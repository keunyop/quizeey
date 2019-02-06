--insert into posts (title, author, content, created_date, modified_date) values ('테스트1', 'test1@gmail.com', '테스트1의 본문', now(), now());
--insert into posts (title, author, content, created_date, modified_date) values ('테스트2', 'test2@gmail.com', '테스트2의 본문', now(), now());

insert into quiz (test_dscd, quiz_name, created_date, modified_date) values ('01', 'AWS-Certified-Developer-Associate V13.95', now(), now());

insert into question (test_dscd, quiz_id, quest_nbr, quest_text, explanation, reference, created_date, modified_date) values ('01', '1', '1', '1-1번문제 내용', '1-1번문제 설명', '1-1번문제 참조', now(), now());
insert into question (test_dscd, quiz_id, quest_nbr, quest_text, explanation, reference, created_date, modified_date) values ('01', '2', '1', '2-1번문제 내용', '2-1번문제 설명', '2-1번문제 참조', now(), now());

insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('1', '1', '1-1번문제 1번보기', false, now(), now());
insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('1', '2', '1-1번문제 2번보기', false, now(), now());
insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('1', '3', '1-1번문제 3번보기', true, now(), now());
insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('1', '4', '1-1번문제 4번보기', false, now(), now());

insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('2', '1', '2-1번문제 1번보기', false, now(), now());
insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('2', '2', '2-1번문제 2번보기', false, now(), now());
insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('2', '3', '2-1번문제 3번보기', true, now(), now());
insert into example (quest_id, exmp_nbr, example_text, answer, created_date, modified_date) values ('2', '4', '2-1번문제 4번보기', false, now(), now());