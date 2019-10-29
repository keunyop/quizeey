package com.questionbank.webservice.util;

import org.springframework.stereotype.Service;

import com.questionbank.webservice.domain.question.Example;
import com.questionbank.webservice.domain.question.ExampleRepository;
import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;
import com.questionbank.webservice.domain.question.Test;
import com.questionbank.webservice.domain.question.TestRepository;
import com.questionbank.webservice.domain.question.Version;
import com.questionbank.webservice.domain.question.VersionRepository;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class TestGenerator {
    private TestRepository     testRepository;
    private VersionRepository  versionRepository;
    private QuestionRepository questionRepository;
    private ExampleRepository  exampleRepository;

    final static String        FILE_NAME = "D:\\99.KYLEE\\01.개인프로젝트\\36.QuestionBank\\dumps\\문제\\워드프로세서_20190831.txt";
    final static Long          TEST_ID   = (long) 15;
    final static int           VER_NBR   = 1;
    final static String        VER_NAME  = "2019-08-31 기출문제";

    public void addTestBatch() {
        _addTest();
        _addVersion();
        _addQuestion();
        _addExample();
    }

    private void _addTest() {
        String testNm = "";
        String testNmEng = "";
        String url = "";
        int inqrSeq = 0;

        testRepository.save(Test.builder().testId(testRepository.findFirstByOrderByTestIdDesc().getTestId() + 1)
                .testNm(testNm).testNmEng(testNmEng).url(url).inqrSeq(inqrSeq).build());
    }

    private void _addVersion() {
        Long testId = 0L;
        int verNbr = 0;
        String verNm = "";

        versionRepository.save(Version.builder().testId(testId).verNbr(verNbr).verNm(verNm).build());
    }

    private void _addQuestion() {
        Long testId = 0L;
        int verNbr = 0;
        int questNbr = 0;
        String questTxt = "";
        String explanation = "";
        String reference = "";
        String multiAnswerYn = "";

        questionRepository.save(Question.builder().testId(testId).verNbr(verNbr).questNbr(questNbr).questTxt(questTxt)
                .explanation(explanation).reference(reference).multiAnswerYn(multiAnswerYn).build());
    }

    private void _addExample() {
        Long testId = 0L;
        int verNbr = 0;
        int questNbr = 0;
        int exmpNbr = 0;
        String exmpTxt = "";
        String answerYn = "";

        exampleRepository.save(Example.builder().testId(testId).verNbr(verNbr).questNbr(questNbr).exmpNbr(exmpNbr)
                .exmpTxt(exmpTxt).answerYn(answerYn).build());
    }
}
