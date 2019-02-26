package com.questionbank.webservice.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
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

        int qNum = 0;
        for (String line : qsGen._readFile().collect(Collectors.toList())) {
            qNum++;
            sb.append("\n-- Q" + qNum + "\n");
            sb.append(qsGen._genInsertQuestionSql(line));
            sb.append("\n");
            sb.append(qsGen._genInsertExampleSql(line));
            sb.append("\n");

            break;
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

        String questNbr = (strs.length > 0) ? strs[0].substring(3) : "";
        String questTxt = (strs.length > 1) ? strs[1] : "";
        String explanation = (strs.length > 4) ? strs[4] : "";
        String reference = (strs.length > 5) ? strs[5] : "";

        return String.format(
                "insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, questNbr, questTxt, explanation, reference);
    }

    private String _genInsertExampleSql(String line) {
        String[] strs = line.split("\\|\\|");

        String questNbr = (strs.length > 0) ? strs[0].substring(3) : "";
        String exmpTxt = (strs.length > 2) ? strs[2] : "";
        String answer = (strs.length > 3) ? strs[3] : "";

        StringBuilder sb = new StringBuilder();

        //        for (String example : examples) {
        //
        //        }

        return String.format(
                "insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, questNbr, "1", exmpTxt, answer);
    }

    private List<String> _getExamples(String exmpTxt) {
        List<String> examples = new ArrayList<>();

        if (exmpTxt.contains("B.")) {
            examples.add(exmpTxt.substring(0, exmpTxt.indexOf("B.")));
        }

        examples.add(exmpTxt.substring(exmpTxt.indexOf("B."), exmpTxt.indexOf("C.")));
        examples.add(exmpTxt.substring(exmpTxt.indexOf("C."), exmpTxt.indexOf("D.")));
        examples.add(exmpTxt.substring(exmpTxt.indexOf("D.")));

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