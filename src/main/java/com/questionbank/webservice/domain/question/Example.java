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
public class Example extends BaseTimeEntity {
    @Id
    @GeneratedValue
    private Long    exmpId;

    @Column(nullable = false)
    private Long    testId;

    @Column(nullable = false)
    private Long    verId;

    @Column(nullable = false)
    private int     questNbr;

    @Column(nullable = false)
    private int     exmpNbr;

    @Column(nullable = false)
    private String  exmpTxt;

    @Column(nullable = false)
    private boolean answer;

    @Builder
    public Example(Long testId, Long verId, int questNbr, int exmpNbr, String exmpTxt, boolean answer) {
        this.testId = testId;
        this.verId = verId;
        this.questNbr = questNbr;
        this.exmpNbr = exmpNbr;
        this.exmpTxt = exmpTxt;
        this.answer = answer;
    }
}