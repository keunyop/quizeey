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
    // 1.AWS-Certified-Developer-Associate V13.95
    @Id
    @GeneratedValue
    private Long   quizId;

    // 01.AWS Certified Developer – Associate
    // 02.AWS Certified Solutions Architect – Associate
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