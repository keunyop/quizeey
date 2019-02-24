package com.questionbank.webservice.domain.question;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class QuestionRepositoryTest {
    @Autowired
    QuestionRepository questionRepository;

    @After
    public void cleanup() {
        questionRepository.deleteAll();
    }

    @Test
    public void getQuestionsByTestIdAndVerNbrTest() {
        // given
        questionRepository.save(Question.builder().testId(0L).verNbr(0).questNbr(0).questTxt("문제1번 내용").explanation("")
                .reference("").build());

        // when
        List<Question> questions = questionRepository.getQuestionsByTestIdAndVerNbr(0L, 0);

        // then
        Question question = questions.get(0);
        assertEquals(question.getTestId().toString(), "0");
        assertEquals(question.getQuestNbr(), 0);
        assertEquals(question.getQuestTxt(), "문제1번 내용");
    }

    @Test
    public void getQuestionsByTestIdTest() {
        // given
        questionRepository.save(Question.builder().testId(0L).verNbr(0).questNbr(0).questTxt("문제1번 내용").explanation("")
                .reference("").build());

        // when
        List<Question> questions = questionRepository.getQuestionsByTestId(0L);

        // then
        Question question = questions.get(0);
        assertEquals(question.getTestId().toString(), "0");
        assertEquals(question.getQuestNbr(), 0);
        assertEquals(question.getQuestTxt(), "문제1번 내용");
    }
}
