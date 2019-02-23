package com.questionbank.webservice.service;

import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.QuestionRepository;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;

@RunWith(SpringRunner.class)
@SpringBootTest
public class QuestionServiceTest {
    @Autowired
    private QuestionService questionService;

    @Autowired
    QuestionRepository      questionRepository;

    @After
    public void cleanup() {
        questionRepository.deleteAll();
    }

    @Test
    public void getQuestionTest() {

        // given
        questionRepository.save(Question.builder().testId(1L).verId(1L).questNbr(1).questTxt("문제1번 내용").explanation("")
                .reference("").build());

        // given
        QuestionRequestDto dto = QuestionRequestDto.builder().testId(1L).build();

        // when
        QuestionMainResponseDto qs = questionService.getQuestion(dto);

        // then
        assertEquals(qs.getTestId(), dto.getTestId());
    }
}
