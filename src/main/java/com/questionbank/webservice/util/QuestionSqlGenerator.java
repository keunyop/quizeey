package com.questionbank.webservice.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class QuestionSqlGenerator {

    final String FILE_NAME = "src/main/resources/static/test/aws/AWS-Certified-Developer-Associate V13.25.dat";
    final String TEST_DESC = "01";
    final String QUIZ_NAME = "AWS-Certified-Developer-Associate V13.25";

    public static void main(String[] args) {
        QuestionSqlGenerator qsGen = new QuestionSqlGenerator();

        StringBuilder sb = new StringBuilder();
        sb.append(qsGen._genInsertQuizSql());

        for (String line : qsGen._readFile().collect(Collectors.toList())) {
            sb.append(qsGen._genInsertQuestionSql(line));
            sb.append(qsGen._genInsertExampleSql(line));
        }

        System.out.println(sb.toString());
    }

    private String _genInsertQuizSql() {
        String sql = "insert into quiz (test_dscd, quiz_name, created_date, modified_date) values ('{0}', '{1}', now(), now());";
        sql = sql.replace("{0}", TEST_DESC);
        sql = sql.replace("{1}", QUIZ_NAME);

        return sql;
    }

    private StringBuilder _genInsertQuestionSql(String line) {
        return null;
    }

    private StringBuilder _genInsertExampleSql(String line) {
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