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
    private int     verNbr;

    @Column(nullable = false)
    private int     questNbr;

    @Column(nullable = false)
    private int     exmpNbr;

    @Column(length = 500, nullable = false)
    private String  exmpTxt;

    @Column(nullable = false)
    private boolean answer;

    @Builder
    public Example(Long testId, int verNbr, int questNbr, int exmpNbr, String exmpTxt, boolean answer) {
        this.testId = testId;
        this.verNbr = verNbr;
        this.questNbr = questNbr;
        this.exmpNbr = exmpNbr;
        this.exmpTxt = exmpTxt;
        this.answer = answer;
    }
}