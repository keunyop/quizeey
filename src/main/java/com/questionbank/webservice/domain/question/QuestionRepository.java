package com.questionbank.webservice.domain.question;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {
    List<Question> getQuestionsByTestDscd(String testDscd);

    List<Question> getQuestionsByTestDscdAndQuizId(String testDscd, Long quizId);
}