-- Read-only observed MySQL 5.7.30 schema, 2026-10-16 UTC.
-- Documentation only. Do not execute this MySQL DDL against either production database.
-- AUTO_INCREMENT values reflect metadata observation, not a final migration watermark.

CREATE TABLE `test` (
  `test_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `test_nm` varchar(500) DEFAULT NULL,
  `test_nm_eng` varchar(500) DEFAULT NULL,
  `url` varchar(100) NOT NULL,
  `inqr_seq` int(3) NOT NULL DEFAULT '0',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8;

CREATE TABLE `version` (
  `ver_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `test_id` bigint(20) NOT NULL,
  `ver_nbr` int(11) NOT NULL,
  `ver_nm` varchar(500) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8;

CREATE TABLE `question` (
  `quest_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `test_id` bigint(20) NOT NULL,
  `ver_nbr` int(11) NOT NULL,
  `quest_nbr` int(11) NOT NULL,
  `quest_txt` varchar(2000) NOT NULL,
  `explanation` varchar(4000) DEFAULT NULL,
  `reference` varchar(1000) DEFAULT NULL,
  `multi_answer_yn` varchar(1) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`quest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30946 DEFAULT CHARSET=utf8;

CREATE TABLE `example` (
  `exmp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `test_id` bigint(20) NOT NULL,
  `ver_nbr` int(11) NOT NULL,
  `quest_nbr` int(11) NOT NULL,
  `exmp_nbr` int(11) NOT NULL,
  `exmp_txt` varchar(1000) NOT NULL,
  `answer_yn` varchar(1) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`exmp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124559 DEFAULT CHARSET=utf8;

CREATE TABLE `explanation` (
  `expl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quest_id` bigint(20) NOT NULL,
  `user_nm` varchar(100) DEFAULT NULL,
  `explanation` varchar(1000) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`expl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2210 DEFAULT CHARSET=utf8;

CREATE TABLE `question_stats` (
  `quest_id` bigint(20) NOT NULL,
  `correct` int(11) NOT NULL,
  `in_correct` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
