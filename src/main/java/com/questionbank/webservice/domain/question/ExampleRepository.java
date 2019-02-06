package com.questionbank.webservice.domain.question;

import java.util.stream.Stream;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExampleRepository extends JpaRepository<Example, Long> {
    Stream<Example> findByQuestId(Long questId);
}