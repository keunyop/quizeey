package com.questionbank.webservice.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class QuestionSqlGenerator {

    final String FILE_NAME = "src/main/resources/static/test/aws/AWS-Certified-Developer-Associate V13.25.dat";
    final String TEST_ID   = "1";
    final String TEST_NAME = "AWS Certified Developer – Associate";
    final String VER_NBR   = "2";
    final String VER_NAME  = "AWS-Certified-Developer-Associate V13.25";

    public static void main(String[] args) {
        QuestionSqlGenerator qsGen = new QuestionSqlGenerator();

        StringBuilder sb = new StringBuilder();
        sb.append("-- TEST\n");
        sb.append(qsGen._genInsertTestSql());
        sb.append("\n-- VERSION\n");
        sb.append(qsGen._genInsertVersionSql());
        sb.append("\n-- QUESTION\n");

        for (String line : qsGen._readFile().collect(Collectors.toList())) {
            sb.append(qsGen._genInsertQuestionSql(line));
            sb.append("\n");
            //            sb.append(qsGen._genInsertExampleSql(line));
        }

        System.out.println(sb.toString());

    }

    private String _genInsertTestSql() {
        return String.format("insert into test (test_nm, created_date, modified_date) values ('%s', now(), now());",
                TEST_NAME);
    }

    private String _genInsertVersionSql() {
        return String.format(
                "insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, VER_NAME);
    }

    private String _genInsertQuestionSql(String line) {
        String[] strs = line.split("\\|\\|");

        //        String questNbr = strs[0].substring(3);
        //        String questTxt = strs[1];
        //        String explanation = strs[4];
        //        String reference = strs[5];

        return String.format(
                "insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, strs[0].substring(3), strs[1], strs[4], strs[5]);
    }

    private String _genInsertExampleSql(String line) {
        return null;
    }

    private Stream<String> _readFile() {
        Stream<String> stream = null;

        try {
            stream = Files.lines(Paths.get(FILE_NAME));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return stream;
    }
}