package com.questionbank.webservice.util;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.commons.lang3.StringUtils;

public class QuestionSqlGenerator {

    final static String FILE_NAME  = "D:\\99.KYLEE\\01.개인프로젝트\\36.QuestionBank\\dumps\\교통기사\\20190427.txt";
    final String        WRITE_PATH = "src/main/java/com/questionbank/webservice/util/sql.sql";
    final String        TEST_ID    = "7";
    final String        TEST_NAME  = "교통기사";
    final String        VER_NBR    = "1";
    final String        VER_NAME   = "2019-04-27 기출문제";

    public static void main(String[] args) {
        QuestionSqlGenerator qsGen = new QuestionSqlGenerator();

        StringBuilder sb = new StringBuilder();
        sb.append("-- TEST\n");
        sb.append(qsGen._genInsertTestSql());
        sb.append("\n-- VERSION\n");
        sb.append(qsGen._genInsertVersionSql());

        int qNum = 0;
        for (String line : qsGen._readFile(FILE_NAME).collect(Collectors.toList())) {

            //            if (!line.contains("NO.53")) {
            //                continue;
            //            }

            qNum++;
            sb.append("\n-- Q" + qNum + "\n");
            sb.append(qsGen._genInsertQuestionSql(line));
            sb.append("\n");
            //            sb.append(qsGen._genInsertExampleSql(line));
        }

        //        System.out.println(sb.toString());
        qsGen._writeFile(sb);
        System.out.println("끝");
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

        //        String questNbr = (strs.length > 0) ? strs[0].substring(3) : "";
        //        String questTxt = (strs.length > 1) ? strs[1].replace("'", "''") : "";
        //        String explanation = (strs.length > 4) ? strs[4].replace("Explanation:", "").replace("'", "''").trim() : "";
        //        String reference = (strs.length > 5) ? strs[5].replace("Reference:", "").trim() : "";
        //        boolean isMultiAnswer = (strs.length > 3) ? strs[3].contains(",") ? true : false : false;

        String questNbr = (strs.length > 0) ? strs[0] : "";
        String questTxt = (strs.length > 1) ? strs[1].replace("'", "''") : "";
        String explanation = "";
        String reference = "";

        return String.format(
                "insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, questNbr, questTxt, explanation, reference, "N");
    }

    private StringBuilder _genInsertExampleSql(String line) {
        String[] strs = line.split("\\|\\|");

        //        String questNbr = (strs.length > 0) ? strs[0].substring(3) : "";
        //        String exmpTxt = (strs.length > 2) ? strs[2] : "";
        //        String answer = (strs.length > 3) ? strs[3] : "";

        String questNbr = (strs.length > 0) ? strs[0] : "";
        String[] exmpTxts = { strs[2], strs[3], strs[4], strs[5] };

        StringBuilder sb = new StringBuilder();

        int exmpNbr = 1;
        for (String example : exmpTxts) {

            String exampleStr = example.trim();
            String answeYn = "N";

            if (example.startsWith("ANSWER")) {
                exampleStr = exampleStr.substring(6);
                answeYn = "Y";
            }

            sb.append(String.format(
                    "insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', '%s', now(), now());",
                    TEST_ID, VER_NBR, questNbr, exmpNbr, exampleStr, answeYn));
            sb.append("\n");
            exmpNbr++;
        }

        return sb;
    }

    private StringBuilder _genUpdateExampleSql(String line) {
        String[] strs = line.split("\\|\\|");

        StringBuilder sb = new StringBuilder();

        int questNbr = 18;
        for (String exmpNbr : strs) {
            sb.append(String.format(
                    "update example set answer_yn='Y' where test_id='%s' and ver_nbr='%s' and quest_nbr='%s' and exmp_nbr='%s';",
                    TEST_ID, VER_NBR, questNbr, exmpNbr));
            sb.append("\n");
            questNbr++;
        }

        return sb;
    }

    private List<String> _getExamples(String exmpTxt) {
        return Pattern.compile("[A-F][.]").splitAsStream(exmpTxt).filter(example -> !StringUtils.isEmpty(example))
                .map(example -> example.trim()).map(example -> example.replace("'", "''")).collect(Collectors.toList());
    }

    private String _isAnswer(String answerTxt, int exmpNbr) {
        String alphabet = String.valueOf((char) (exmpNbr + 64));

        List<String> answers = Pattern.compile("[,]").splitAsStream(answerTxt.replace("Answer:", ""))
                .map(answer -> answer.trim()).collect(Collectors.toList());

        if (answers.contains(alphabet)) {
            return "TRUE";
        }

        return "FALSE";
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

    private void _writeFile(StringBuilder sb) {
        Path path = Paths.get(WRITE_PATH);

        try (BufferedWriter writer = Files.newBufferedWriter(path)) {
            writer.write(sb.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}