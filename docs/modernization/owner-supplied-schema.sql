-- Owner supplied on 2026-10-16. Historical/current status is unverified.
-- Documentation evidence only. Do not execute against either production database.
-- No engine, charset, collation, timezone, foreign keys or secondary indexes were supplied.
CREATE TABLE example (
  exmp_id BIGINT(20) NOT NULL AUTO_INCREMENT,
  test_id BIGINT(20) NOT NULL,
  ver_nbr INT(11) NOT NULL,
  quest_nbr INT(11) NOT NULL,
  exmp_nbr INT(11) NOT NULL,
  exmp_txt VARCHAR(1000) NOT NULL,
  answer VARCHAR(1) NOT NULL,
  created_date TIMESTAMP NOT NULL,
  modified_date TIMESTAMP NOT NULL,
  PRIMARY KEY (exmp_id));
CREATE TABLE question (
  quest_id BIGINT(20) NOT NULL AUTO_INCREMENT,
  test_id BIGINT(20) NOT NULL,
  ver_nbr INT(11) NOT NULL,
  quest_nbr INT(11) NOT NULL,
  quest_txt VARCHAR(2000) NOT NULL,
  explanation VARCHAR(2000) NULL,
  reference VARCHAR(500) NULL,
  is_multi_answer VARCHAR(1) NOT NULL,
  created_date TIMESTAMP NOT NULL,
  modified_date TIMESTAMP NOT NULL,
  PRIMARY KEY (quest_id));
CREATE TABLE question_stats (
  quest_id BIGINT(20) NOT NULL,
  correct INT(11) NOT NULL,
  in_correct INT(11) NOT NULL,
  created_date TIMESTAMP NOT NULL,
  modified_date TIMESTAMP NOT NULL,
  PRIMARY KEY (quest_id));
CREATE TABLE test (
  test_id BIGINT(20) NOT NULL AUTO_INCREMENT,
  test_nm VARCHAR(500) NOT NULL,
  created_date TIMESTAMP NOT NULL,
  modified_date TIMESTAMP NOT NULL,
  PRIMARY KEY (test_id));
CREATE TABLE version (
  ver_id BIGINT(20) NOT NULL AUTO_INCREMENT,
  test_id BIGINT(20) NOT NULL,
  ver_nbr INT(11) NOT NULL,
  ver_nm VARCHAR(500) NOT NULL,
  created_date TIMESTAMP NOT NULL,
  modified_date TIMESTAMP NOT NULL,
  PRIMARY KEY (ver_id));
