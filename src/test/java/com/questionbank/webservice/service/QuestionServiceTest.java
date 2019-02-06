package com.questionbank.webservice.service;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.questionbank.webservice.dto.question.ExampleMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;

@RunWith(SpringRunner.class)
@SpringBootTest
public class QuestionServiceTest {
    @Autowired
    private QuestionService questionService;

    @Test
    public void getQuSestionTest() {
        //        Question qs = questionService.getRandomQuestion(null);
        //
        //        assertEquals("문제내용", qs.getQuestionText());

        // given
        QuestionRequestDto dto = QuestionRequestDto.builder().testDscd("01").quizId(1L).build();

        // when
        QuestionMainResponseDto qs = questionService.getQuestion(dto);

        System.out.println("### getQuSestionTest: " + qs.toString());
        for (ExampleMainResponseDto example : qs.getExamples()) {
            System.out.println(example.toString());
        }

        // then
        assertEquals(qs.getTestDscd(), dto.getTestDscd());
    }
}
