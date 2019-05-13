package com.questionbank.webservice.domain.question;

import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionStatsRepository extends JpaRepository<QuestionStats, Long> {
}