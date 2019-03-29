-- TEST
insert into test (test_nm, created_date, modified_date) values ('Computer Science', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('4', '1', 'C Programming', now(), now());

-- V1.C Quiz – 102.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('4', '1', '1', 'In the context of C data types, which of the followings is correct?', 'In C, "float" is single precision floating type. "double" is double precision floating type. "long double"is often more precise than double precision floating type.  So the maximum floating type is "long double". There''s nothing called "long long double". If someone wants to use bigger range than "long double", we need to define our own data type i.e. user defined data type. Besides, Type Specifiers "signed" and "unsigned" aren''t applicable for floating types (float, double, long double). Basically, floating types are always signed only.<br>But integer types i.e. "int", "long int" and "long long int" are valid combinations. As per C standard, "long long int" would be at least 64 bits i.e. 8 bytes. By default integer types would be signed. If we need to make these integer types as unsigned, one can use Type Specifier "unsigned". That''s why 1 is correct answer.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '1', '“unsigned long long int” is a valid data type.', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '2', '“long long double” is a valid data type.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '3', '“unsigned long double” is a valid data type.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '4', 'A, B and C all are valid data types.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '5', 'A, B and C all are invalid data types.', 'false', now(), now());





    