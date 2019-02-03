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
public class Question extends BaseTimeEntity {
    @Id
    @GeneratedValue
    private Long   questId;

    @Column(nullable = false)
    private String testDscd;

    @Column(nullable = false)
    private Long   quizId;

    @Column(nullable = false)
    private int    questNbr;

    @Column(length = 500, nullable = false)
    private String questText;

    @Column(length = 1000)
    private String explanation;

    private String reference;

    @Builder
    public Question(String testDscd, Long quizId, int questNbr, String questText, String explanation,
                    String reference) {
        this.testDscd = testDscd;
        this.quizId = quizId;
        this.questNbr = questNbr;
        this.questText = questText;
        this.explanation = explanation;
        this.reference = reference;
    }
}