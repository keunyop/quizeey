package com.questionbank.webservice.util;

import org.springframework.beans.factory.annotation.Autowired;

import com.questionbank.webservice.domain.question.TestRepository;

//@RunWith(SpringRunner.class)
//@SpringBootTest
public class Zen {

    final static String    FILE_NAME  = "D:\\99.KYLEE\\01.개인프로젝트\\36.QuestionBank\\dumps\\교통기사\\20190427.txt";
    final String           WRITE_PATH = "src/main/java/com/questionbank/webservice/util/sql.sql";
    final String           TEST_ID    = "8";
    final String           TEST_NAME  = "교통기사";
    final String           VER_NBR    = "1";
    final String           VER_NAME   = "2019-04-27 기출문제";

    @Autowired
    private TestRepository testRepository;

    //    @Test
    public void main() {
        Zen qsGen = new Zen();
        qsGen._genInsertTestSql();
    }

    private void _genInsertTestSql() {

        testRepository.save(com.questionbank.webservice.domain.question.Test.builder().testNm(TEST_NAME).build());

    }
}