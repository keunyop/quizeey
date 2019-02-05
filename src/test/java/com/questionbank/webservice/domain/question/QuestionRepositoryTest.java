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
    public void 문제저장_불러오기() {
        // given
        questionRepository.save(Question.builder().testDscd("AWS").quizId(1L).questNbr(1).questText("문제1번 내용")
                .explanation("").reference("").build());

        // when
        List<Question> questions = questionRepository.findAll();

        // then
        Question question = questions.get(0);
        assertEquals(question.getTestDscd(), "AWS");
        assertEquals(question.getQuestNbr(), 1);
        assertEquals(question.getQuestText(), "문제1번 내용");
    }
}
