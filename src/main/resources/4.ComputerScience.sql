-- TEST
insert into test (test_nm, created_date, modified_date) values ('Computer Science', now(), now());

-- VERSION
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('4', '1', 'C Programming', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('4', '2', 'C++ Programming', now(), now());
insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('4', '13', 'Computer Organization and Architecture', now(), now());

-- V1.C Quiz – 102.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('4', '1', '1', 'In the context of C data types, which of the followings is correct?', 'In C, "float" is single precision floating type. "double" is double precision floating type. "long double"is often more precise than double precision floating type.  So the maximum floating type is "long double". There''s nothing called "long long double". If someone wants to use bigger range than "long double", we need to define our own data type i.e. user defined data type. Besides, Type Specifiers "signed" and "unsigned" aren''t applicable for floating types (float, double, long double). Basically, floating types are always signed only.<br>But integer types i.e. "int", "long int" and "long long int" are valid combinations. As per C standard, "long long int" would be at least 64 bits i.e. 8 bytes. By default integer types would be signed. If we need to make these integer types as unsigned, one can use Type Specifier "unsigned". That''s why 1 is correct answer.', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '1', '“unsigned long long int” is a valid data type.', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '2', '“long long double” is a valid data type.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '3', '“unsigned long double” is a valid data type.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '4', 'A, B and C all are valid data types.', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '1', '1', '5', 'A, B and C all are invalid data types.', 'false', now(), now());

-- V2.Class and Object.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('4', '2', '1', 'What is the difference between struct and class in C++?', '', 'https://www.geeksforgeeks.org/g-fact-76/', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '2', '1', '1', 'All members of a structure are public and structures don''t have constructors and destructors', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '2', '1', '2', 'Members of a class are private by default and members of struct are public by default. When deriving a struct from a class/struct, default access-specifier for a base class/struct is public and when deriving a class, default access specifier is private.', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '2', '1', '3', 'All members of a structure are public and structures don''t have virtual functions', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '2', '1', '4', 'All of the above', 'false', now(), now());




-- V13.Computer Organization and Architecture.Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, is_multi_answer, created_date, modified_date) values ('4', '13', '1', 'In a k-way set associative cache, the cache is divided into v sets, each of which consists of k lines. The lines of a set are placed in sequence one after another. The lines in set s are sequenced before the lines in set (s+1). The main memory blocks are numbered 0 onwards. The main memory block numbered j must be mapped to any one of the cache lines from.', 'Number of sets in cache = v. So, main memory block j will be mapped to set (j mod v), which will be any one of the cache lines from (j mod v) * k to (j mod v) * k + (k-1). (Associativity plays no role in mapping- k-way associativity means there are k spaces for a block and hence reduces the chances of replacement.)', '', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '13', '1', '1', '(j mod v) * k to (j mod v) * k + (k-1)', 'true', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '13', '1', '2', '(j mod v) to (j mod v) + (k-1)', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '13', '1', '3', '(j mod k) to (j mod k) + (v-1)', 'false', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('4', '13', '1', '4', '(j mod k) * v to (j mod k) * v + (v-1)', 'false', now(), now());
    




