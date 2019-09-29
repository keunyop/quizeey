package com.questionbank.webservice.domain.question;

import java.util.stream.Stream;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExplanationRepository extends JpaRepository<Explanation, Long> {

    Stream<Explanation> getExplanationsByQuestId(Long questId);
}