package com.questionbank.webservice.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class QuestionSqlGenerator {

    public static void main(String[] args) {
        String fileName = "src/main/resources/static/test/aws/AWS-Certified-Developer-Associate V13.25.dat";

        QuestionSqlGenerator qsGen = new QuestionSqlGenerator();

        StringBuilder sb = new StringBuilder();
        sb.append(qsGen._genInsertQuizSql());
        sb.append(qsGen._genInsertQuestionSql());
        sb.append(qsGen._genInsertExampleSql());

    }

    private StringBuilder _genInsertQuizSql() {
        return null;
    }

    private StringBuilder _genInsertQuestionSql() {
        return null;
    }

    private StringBuilder _genInsertExampleSql() {
        return null;
    }

    private Stream<String> _readFile(String fileName) {
        Stream<String> stream = null;

        try {
            stream = Files.lines(Paths.get(fileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return stream;
    }
}