package com.questionbank.webservice.domain.question;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import com.questionbank.webservice.domain.BaseTimeEntity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Entity
public class Quiz extends BaseTimeEntity {
    @Id
    @GeneratedValue
    private Long   quizId;

    @Column(nullable = false)
    private String testDscd;

    @Column(nullable = false)
    private String quizName;

    @Builder
    public Quiz(String testDscd, String quizName) {
        this.testDscd = testDscd;
        this.quizName = quizName;
    }
}