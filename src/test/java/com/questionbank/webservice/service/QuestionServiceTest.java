package com.questionbank.webservice.service;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;

@RunWith(SpringRunner.class)
@SpringBootTest
public class QuestionServiceTest {
    @Autowired
    private QuestionService questionService;

    @Test
    public void getQuestionTest() {
        // given
        QuestionRequestDto dto = QuestionRequestDto.builder().testDscd("01").build();

        // when
        QuestionMainResponseDto qs = questionService.getQuestion(dto);

        // then
        assertEquals(qs.getTestDscd(), dto.getTestDscd());
    }
}
