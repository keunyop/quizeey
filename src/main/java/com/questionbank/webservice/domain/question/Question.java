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
    private Long   testId;

    @Column(nullable = false)
    private Long   verId;

    @Column(nullable = false)
    private int    questNbr;

    @Column(length = 500, nullable = false)
    private String questTxt;

    @Column(length = 1000)
    private String explanation;

    private String reference;

    @Builder
    public Question(Long testId, Long verId, int questNbr, String questTxt, String explanation, String reference) {
        this.testId = testId;
        this.verId = verId;
        this.questNbr = questNbr;
        this.questTxt = questTxt;
        this.explanation = explanation;
        this.reference = reference;
    }
}