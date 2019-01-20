package com.questionbank.webservice.service;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.questionbank.webservice.domain.question.Question;

@RunWith(SpringRunner.class)
@SpringBootTest
public class QuestionServiceTest {
    @Autowired
    private QuestionService questionService;

    @Test
    public void getRandomQuestionTest() {
        Question q = questionService.getRandomQuestion();

        assertEquals("문제내용", q.getQuestionText());
    }
}
