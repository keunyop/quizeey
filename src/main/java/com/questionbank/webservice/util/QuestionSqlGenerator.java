package com.questionbank.webservice.util;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.commons.lang3.StringUtils;
import org.springframework.util.CollectionUtils;

public class QuestionSqlGenerator {

    final static String FILE_NAME  = "D:\\99.KYLEE\\01.개인프로젝트\\36.QuestionBank\\dumps\\문제\\워드프로세서_20190831.txt";
    final static String WRITE_PATH = "src/main/java/com/questionbank/webservice/util/sql.sql";
    final static Long   TEST_ID    = (long) 15;
    final static String TEST_NAME  = "도시계획기사";
    final static int    VER_NBR    = 1;
    final static String VER_NAME   = "2019-08-31 기출문제";

    public static void main(String[] args) {
        StringBuilder sb = new StringBuilder();
        sb.append("-- TEST\n");
        sb.append(_genInsertTestSql());
        sb.append("\n-- VERSION\n");
        sb.append(_genInsertVersionSql());
        sb.append("\n-- QUESTION\n");

        int qNum = 0;
        for (String line : _readFile(FILE_NAME).collect(Collectors.toList())) {
            qNum++;
            sb.append("\n-- Q" + qNum + "\n");
            sb.append(_genInsertQuestionSql(line));
            sb.append("\n");
            sb.append(_genInsertExampleSql(line));
        }

        //        List<Question4Gen> qs = _toObject();
        //
        //        for (Question4Gen q : qs) {
        //            sb.append(_genInsertQuestionExampleSql(q));
        //            sb.append("\n\n");
        //        }

        _writeFile(sb);

        System.out.println("끝");

    }

    private static List<Question4Gen> _toObject() {

        List<Question4Gen> qs = new ArrayList<>();

        for (String line : _readFile(FILE_NAME).collect(Collectors.toList())) {
            if (line.equals("    ")) {
                continue;
            }

            Question4Gen lastQ = null;
            List<Example4Gen> lastEs = null;

            if (!CollectionUtils.isEmpty(qs)) {
                lastQ = qs.get(qs.size() - 1);
                lastEs = lastQ.getExample4Gens() == null ? new ArrayList<>() : lastQ.getExample4Gens();
            }

            if (line.matches("^[0-9.].*")) {
                String questNbr = line.substring(0, line.indexOf("."));
                String questTxt = line.substring(line.indexOf(".") + 1);

                Question4Gen q = Question4Gen.builder().questNbr(questNbr).questTxt(questTxt).build();

                qs.add(q);

            } else if (line.contains("①")) {
                if (line.contains("②")) {
                    Example4Gen e1 = Example4Gen.builder().exmpNbr("1")
                            .exampleStr(line.substring(line.indexOf("①") + 1, line.indexOf("②"))).answerYn("N").build();

                    Example4Gen e2 = Example4Gen.builder().exmpNbr("2")
                            .exampleStr(line.substring(line.indexOf("②") + 1)).answerYn("N").build();

                    lastEs.add(e1);
                    lastEs.add(e2);
                } else if (line.contains("❷")) {
                    Example4Gen e1 = Example4Gen.builder().exmpNbr("1")
                            .exampleStr(line.substring(line.indexOf("①") + 1, line.indexOf("❷"))).answerYn("N").build();

                    Example4Gen e2 = Example4Gen.builder().exmpNbr("2")
                            .exampleStr(line.substring(line.indexOf("❷") + 1)).answerYn("Y").build();

                    lastEs.add(e1);
                    lastEs.add(e2);
                } else {
                    Example4Gen e1 = Example4Gen.builder().exmpNbr("1")
                            .exampleStr(line.substring(line.indexOf("①") + 1)).answerYn("N").build();

                    lastEs.add(e1);
                }

            } else if (line.contains("❶")) {
                if (line.contains("②")) {
                    Example4Gen e1 = Example4Gen.builder().exmpNbr("1")
                            .exampleStr(line.substring(line.indexOf("❶") + 1, line.indexOf("②"))).answerYn("Y").build();

                    Example4Gen e2 = Example4Gen.builder().exmpNbr("2")
                            .exampleStr(line.substring(line.indexOf("②") + 1)).answerYn("N").build();

                    lastEs.add(e1);
                    lastEs.add(e2);
                } else {
                    Example4Gen e1 = Example4Gen.builder().exmpNbr("1")
                            .exampleStr(line.substring(line.indexOf("❶") + 1)).answerYn("Y").build();

                    lastEs.add(e1);
                }

            } else if (line.contains("②")) {
                Example4Gen e2 = Example4Gen.builder().exmpNbr("2").exampleStr(line.substring(line.indexOf("②") + 1))
                        .answerYn("N").build();

                lastEs.add(e2);

            } else if (line.contains("❷")) {
                Example4Gen e2 = Example4Gen.builder().exmpNbr("2").exampleStr(line.substring(line.indexOf("❷") + 1))
                        .answerYn("Y").build();

                lastEs.add(e2);

            } else if (line.contains("③")) {

                if (line.contains("④")) {
                    Example4Gen e3 = Example4Gen.builder().exmpNbr("3")
                            .exampleStr(line.substring(line.indexOf("③") + 1, line.indexOf("④"))).answerYn("N").build();

                    Example4Gen e4 = Example4Gen.builder().exmpNbr("4")
                            .exampleStr(line.substring(line.indexOf("④") + 1)).answerYn("N").build();

                    lastEs.add(e3);
                    lastEs.add(e4);

                } else if (line.contains("❹")) {
                    Example4Gen e3 = Example4Gen.builder().exmpNbr("3")
                            .exampleStr(line.substring(line.indexOf("③") + 1, line.indexOf("❹"))).answerYn("N").build();

                    Example4Gen e4 = Example4Gen.builder().exmpNbr("4")
                            .exampleStr(line.substring(line.indexOf("❹") + 1)).answerYn("Y").build();

                    lastEs.add(e3);
                    lastEs.add(e4);

                } else {
                    Example4Gen e3 = Example4Gen.builder().exmpNbr("3")
                            .exampleStr(line.substring(line.indexOf("③") + 1)).answerYn("N").build();

                    lastEs.add(e3);
                }

            } else if (line.contains("❸")) {
                if (line.contains("④")) {
                    Example4Gen e3 = Example4Gen.builder().exmpNbr("3")
                            .exampleStr(line.substring(line.indexOf("❸") + 1, line.indexOf("④"))).answerYn("Y").build();

                    Example4Gen e4 = Example4Gen.builder().exmpNbr("4")
                            .exampleStr(line.substring(line.indexOf("④") + 1)).answerYn("N").build();

                    lastEs.add(e3);
                    lastEs.add(e4);
                } else {
                    Example4Gen e3 = Example4Gen.builder().exmpNbr("3")
                            .exampleStr(line.substring(line.indexOf("❸") + 1)).answerYn("Y").build();

                    lastEs.add(e3);
                }

            } else if (line.contains("④")) {
                Example4Gen e4 = Example4Gen.builder().exmpNbr("4").exampleStr(line.substring(line.indexOf("④") + 1))
                        .answerYn("N").build();

                lastEs.add(e4);

            } else if (line.contains("❹")) {
                Example4Gen e4 = Example4Gen.builder().exmpNbr("4").exampleStr(line.substring(line.indexOf("❹") + 1))
                        .answerYn("Y").build();

                lastEs.add(e4);

            } else {
                Question4Gen qe = qs.get(qs.size() - 1);
                qe.setQuestTxt(qe.getQuestTxt() + "<br><br>" + line);
            }

            if (lastQ != null) {
                lastQ.setExample4Gens(lastEs);
            }

        }

        return qs;
    }

    private static String _genInsertTestSql() {
        return String.format(
                "insert into test (test_id, test_nm, test_nm_eng, url, inqr_seq, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);",
                TEST_ID, TEST_NAME);
    }

    private static String _genInsertVersionSql() {
        return String.format(
                "insert into version (test_id, ver_nbr, ver_nm, created_date, modified_date) values ('%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, VER_NAME);
    }

    private static String _genInsertQuestionExampleSql(Question4Gen q) {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(
                "insert into question (test_id, ver_nbr, quest_nbr, quest_txt, multi_answer_yn, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', now(), now());",
                TEST_ID, VER_NBR, q.getQuestNbr(), q.getQuestTxt(), "N"));

        for (Example4Gen e : q.getExample4Gens()) {
            sb.append("\n");
            sb.append(String.format(
                    "insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('%s', '%s', '%s', '%s', '%s', '%s', now(), now());",
                    TEST_ID, VER_NBR, q.getQuestNbr(), e.getExmpNbr(), e.getExampleStr(), e.getAnswerYn()));
        }

        return sb.toString();
    }

    private static String _genInsertQuestionSql(String line) {
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

    private static StringBuilder _genInsertExampleSql(String line) {
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

    private static Stream<String> _readFile(String fileName) {
        Stream<String> stream = null;

        try {
            stream = Files.lines(Paths.get(fileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return stream;
    }

    private static void _writeFile(StringBuilder sb) {
        Path path = Paths.get(WRITE_PATH);

        try (BufferedWriter writer = Files.newBufferedWriter(path)) {
            writer.write(sb.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}