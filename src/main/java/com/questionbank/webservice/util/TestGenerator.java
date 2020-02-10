package com.questionbank.webservice.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import com.questionbank.webservice.domain.question.Example;
import com.questionbank.webservice.domain.question.ExampleRepository;
import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;
import com.questionbank.webservice.domain.question.Test;
import com.questionbank.webservice.domain.question.TestRepository;
import com.questionbank.webservice.domain.question.Version;
import com.questionbank.webservice.domain.question.VersionRepository;
import com.questionbank.webservice.service.enums.TestTypeEnum;

import lombok.AllArgsConstructor;

@AllArgsConstructor
//@NoArgsConstructor
@Service
public class TestGenerator {
    private TestRepository     testRepository;
    private VersionRepository  versionRepository;
    private QuestionRepository questionRepository;
    private ExampleRepository  exampleRepository;

    final static String        FILE_PATH = "D:\\99.KYLEE\\01.개인프로젝트\\36.QuestionBank\\dumps\\문제\\todo";

    public static void main(String[] args) {
        try (Stream<Path> paths = Files.walk(Paths.get(FILE_PATH))) {
            for (String fileName : paths.filter(Files::isRegularFile).map(file -> file.toString())
                    .collect(Collectors.toList())) {

                List<Question4Gen> qs = _toGTypeObject(fileName);

                for (Question4Gen q : qs) {
                    System.out.println(q);

                    for (Example4Gen e : q.getExample4Gens()) {
                        System.out.println(e);
                    }

                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void addTestBatch(TestTypeEnum testType) {
        try (Stream<Path> paths = Files.walk(Paths.get(FILE_PATH))) {
            for (String fileName : paths.filter(Files::isRegularFile).map(file -> file.toString())
                    .collect(Collectors.toList())) {

                Long testId = _getTestId(fileName);

                if (testId == null) {
                    testId = _addTest(fileName);
                    int verNbr = _addVersion(testId, fileName);

                    List<Question4Gen> qObj = testType.equals(TestTypeEnum.COMCBT) ? _toObject(fileName)
                            : _toGTypeObject(fileName);

                    _addQuestion(testId, verNbr, qObj);

                }
            }

            System.err.println("### 끝 ###");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void addVersionBatch() {
        try (Stream<Path> paths = Files.walk(Paths.get(FILE_PATH))) {
            for (String fileName : paths.filter(Files::isRegularFile).map(file -> file.toString())
                    .collect(Collectors.toList())) {

                Long testId = _getTestId(fileName);

                boolean isVersionNameExist = _isVersionNameExist(testId, fileName);

                System.out.println("### isVersionNameExist: " + isVersionNameExist);

                if (testId != null && !isVersionNameExist) {
                    int verNbr = _addVersion(testId, fileName);
                    _addQuestion(testId, verNbr, _toObject(fileName));
                }
            }

            System.err.println("### 끝 ###");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Long _getTestId(String fileName) {

        System.out.println("### In fileName: " + fileName);

        String actualFileName = fileName.substring(fileName.lastIndexOf('\\') + 1, fileName.indexOf('@'));

        System.out.println("### actualFileName: " + actualFileName);

        Test test = testRepository.findByTestNm(actualFileName);

        return test != null ? test.getTestId() : null;
    }

    private boolean _isVersionNameExist(Long testId, String fileName) {

        String verNm = fileName.substring(fileName.lastIndexOf('@') + 1, fileName.lastIndexOf('.')) + " 기출문제";

        System.out.println("### verNm: " + verNm);

        return versionRepository.existsByTestIdAndVerNm(testId, verNm);
    }

    private Long _addTest(String fileName) {
        String testNm = fileName.substring(fileName.lastIndexOf('\\') + 1, fileName.indexOf('@'));
        String url = fileName.substring(fileName.indexOf('@') + 1, fileName.lastIndexOf('@'));

        testRepository.save(Test.builder().testNm(testNm).url(url).build());

        return testRepository.findFirstByOrderByTestIdDesc().getTestId();
    }

    private int _addVersion(Long testId, String fileName) {
        Version version = versionRepository.findFirstByTestIdOrderByVerNbrDesc(testId);
        int verNbr = version == null ? 1 : version.getVerNbr() + 1;

        String verNm = fileName.substring(fileName.lastIndexOf('@') + 1, fileName.lastIndexOf('.')) + " 기출문제";

        versionRepository.save(Version.builder().testId(testId).verNbr(verNbr).verNm(verNm).build());

        return verNbr;
    }

    private void _addQuestion(Long testId, int verNbr, List<Question4Gen> qs) {
        for (Question4Gen q : qs) {
            int questNbr = Integer.parseInt(q.getQuestNbr());
            String multiAnswerYn = StringUtils.isEmpty(q.getMultiAnswerYn()) ? "N" : q.getMultiAnswerYn();

            questionRepository.save(Question.builder().testId(testId).verNbr(verNbr).questNbr(questNbr)
                    .questTxt(q.getQuestTxt()).explanation(q.getExplanation()).multiAnswerYn(multiAnswerYn).build());

            System.out.println("TEST: " + testId + ", Q-Nbr: " + questNbr);

            for (Example4Gen e : q.getExample4Gens()) {
                exampleRepository.save(Example.builder().testId(testId).verNbr(verNbr).questNbr(questNbr)
                        .exmpNbr(Integer.parseInt(e.getExmpNbr())).exmpTxt(e.getExampleStr()).answerYn(e.getAnswerYn())
                        .build());
            }
        }
    }

    private static List<Question4Gen> _toObject(String fileName) {

        List<Question4Gen> qs = new ArrayList<>();

        for (String line : _readFile(fileName).collect(Collectors.toList())) {
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
                //                System.out.println(line);
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

    private static List<Question4Gen> _toGTypeObject(String fileName) {

        List<Question4Gen> qs = new ArrayList<>();

        Pattern qNbrPattern = Pattern.compile("[0-9]+");

        boolean isExplanation = false;

        for (String line : _readFile(fileName).collect(Collectors.toList())) {

            if (line.equals("break;")) {
                break;
            }

            Question4Gen lastQ = null;
            List<Example4Gen> lastEs = null;

            if (!CollectionUtils.isEmpty(qs)) {
                lastQ = qs.get(qs.size() - 1);
                lastEs = lastQ.getExample4Gens() == null ? new ArrayList<>() : lastQ.getExample4Gens();
            }

            if (line.matches("^QUESTION [0-9].*")) {
                isExplanation = false;

                Matcher qNbrMatcher = qNbrPattern.matcher(line);

                String questNbr = qNbrMatcher.find() ? qNbrMatcher.group() : null;
                String questTxt = line.substring(line.indexOf("QUESTION " + questNbr) + 10 + questNbr.length());

                Question4Gen q = Question4Gen.builder().questNbr(questNbr).questTxt(questTxt).multiAnswerYn("N")
                        .build();

                qs.add(q);

            } else if (line.startsWith("A.")) {

                Example4Gen e1 = Example4Gen.builder().exmpNbr("1")
                        .exampleStr(line.substring(line.indexOf("A.") + 2, line.indexOf("B.")).trim()).answerYn("N")
                        .build();
                lastEs.add(e1);

                Example4Gen e2 = Example4Gen.builder().exmpNbr("2")
                        .exampleStr(line.substring(line.indexOf("B.") + 2, line.indexOf("C.")).trim()).answerYn("N")
                        .build();
                lastEs.add(e2);

                Example4Gen e3 = Example4Gen.builder().exmpNbr("3")
                        .exampleStr(line.substring(line.indexOf("C.") + 2, line.indexOf("D.")).trim()).answerYn("N")
                        .build();
                lastEs.add(e3);

                if (line.contains("E.")) {
                    Example4Gen e4 = Example4Gen.builder().exmpNbr("4")
                            .exampleStr(line.substring(line.indexOf("D.") + 2, line.indexOf("E.")).trim()).answerYn("N")
                            .build();
                    lastEs.add(e4);

                    if (line.contains("F.")) {
                        Example4Gen e5 = Example4Gen.builder().exmpNbr("5")
                                .exampleStr(line.substring(line.indexOf("E.") + 2, line.indexOf("F.")).trim())
                                .answerYn("N").build();
                        lastEs.add(e5);

                        if (line.contains("G.")) {
                            Example4Gen e6 = Example4Gen.builder().exmpNbr("6")
                                    .exampleStr(line.substring(line.indexOf("F.") + 2, line.indexOf("G.")).trim())
                                    .answerYn("N").build();
                            lastEs.add(e6);

                            if (line.contains("H.")) {
                                Example4Gen e7 = Example4Gen.builder().exmpNbr("7")
                                        .exampleStr(line.substring(line.indexOf("G.") + 2, line.indexOf("H.")).trim())
                                        .answerYn("N").build();
                                lastEs.add(e7);

                                Example4Gen e8 = Example4Gen.builder().exmpNbr("8")
                                        .exampleStr(line.substring(line.indexOf("H.") + 2).trim()).answerYn("N")
                                        .build();
                                lastEs.add(e8);
                            } else {
                                Example4Gen e7 = Example4Gen.builder().exmpNbr("7")
                                        .exampleStr(line.substring(line.indexOf("G.") + 2).trim()).answerYn("N")
                                        .build();
                                lastEs.add(e7);
                            }

                        } else {
                            Example4Gen e6 = Example4Gen.builder().exmpNbr("6")
                                    .exampleStr(line.substring(line.indexOf("F.") + 2).trim()).answerYn("N").build();
                            lastEs.add(e6);
                        }

                    } else {
                        Example4Gen e5 = Example4Gen.builder().exmpNbr("5")
                                .exampleStr(line.substring(line.indexOf("E.") + 2).trim()).answerYn("N").build();
                        lastEs.add(e5);
                    }

                } else {
                    Example4Gen e4 = Example4Gen.builder().exmpNbr("4")
                            .exampleStr(line.substring(line.indexOf("D.") + 2).trim()).answerYn("N").build();
                    lastEs.add(e4);
                }

            } else if (line.startsWith("Correct Answer:")) {

                Question4Gen qe = qs.get(qs.size() - 1);

                char[] answers = line.substring(line.indexOf("Correct Answer:") + 15).trim().toCharArray();

                for (char answer : answers) {
                    int answerInt = 0;
                    switch (answer) {
                        case 'A':
                            answerInt = 0;
                            break;
                        case 'B':
                            answerInt = 1;
                            break;
                        case 'C':
                            answerInt = 2;
                            break;
                        case 'D':
                            answerInt = 3;
                            break;
                        case 'E':
                            answerInt = 4;
                            break;
                        case 'F':
                            answerInt = 5;
                            break;
                        case 'G':
                            answerInt = 6;
                            break;
                        case 'H':
                            answerInt = 7;
                            break;
                        default:
                            break;
                    }

                    //                    System.out.println(qe.getExample4Gens());

                    qe.getExample4Gens().get(answerInt).setAnswerYn("Y");
                }

                if (answers.length > 1) {
                    qe.setMultiAnswerYn("Y");
                }

            } else if (line.startsWith("Explanation:")) {
                isExplanation = true;

                String explanation = line.substring(line.indexOf("Explanation:") + 13).trim();

                Question4Gen qe = qs.get(qs.size() - 1);
                qe.setExplanation(explanation);

            } else if (line.startsWith("Objective:") || line.startsWith("Sub-Objective:")) {
                continue;
            } else if (line.startsWith("References:")) {
                if (line.length() > 11) {
                    String reference = line.substring(line.indexOf("References:") + 12).trim();

                    Question4Gen qe = qs.get(qs.size() - 1);
                    qe.setReference(reference);
                }
            } else {
                Question4Gen qe = qs.get(qs.size() - 1);

                if (isExplanation) {
                    qe.setExplanation(qe.getExplanation() + "<br>" + line);
                } else {
                    qe.setQuestTxt(qe.getQuestTxt() + "<br>" + line);
                }

            }

            if (lastQ != null) {
                lastQ.setExample4Gens(lastEs);
            }

        }

        return qs;
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
}