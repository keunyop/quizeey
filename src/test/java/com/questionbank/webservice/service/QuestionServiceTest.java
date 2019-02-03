package com.questionbank.webservice.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class QuestionServiceTest {
    @Autowired
    private QuestionService questionService;

    @Test
    public void getRandomQuestionTest() {
        //        Question qs = questionService.getRandomQuestion(null);
        //
        //        assertEquals("문제내용", qs.getQuestionText());
    }
}
