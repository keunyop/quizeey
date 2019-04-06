package com.questionbank.webservice.domain.question;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ExampleRepository extends JpaRepository<Example, Long> {
    List<Example> findByTestIdAndVerNbrAndQuestNbr(Long testId, int verNbr, int questNbr);
}