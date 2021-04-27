package com.questionbank.webservice.domain.question;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {
    List<Question> getQuestionsByTestId(Long testId);

    List<Question> getQuestionsByTestIdAndVerNbr(Long testId, int verNbr);

    Question findByQuestId(Long questId);
}