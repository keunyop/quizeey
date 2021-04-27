package com.questionbank.webservice.domain.question;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.questionbank.webservice.domain.BaseTimeEntity;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Entity
@ToString
public class Question extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long questId;

    @Column(nullable = false)
    private Long testId;

    @Column(nullable = false)
    private int verNbr;

    @Column(nullable = false)
    private int questNbr;

    @Column(length = 2000, nullable = false)
    private String questTxt;

    @Column(length = 2000)
    private String explanation;

    private String reference;

    private String multiAnswerYn;

    @Builder
    public Question(Long testId, int verNbr, int questNbr, String questTxt, String explanation, String reference,
	    String multiAnswerYn) {
	this.testId = testId;
	this.verNbr = verNbr;
	this.questNbr = questNbr;
	this.questTxt = questTxt;
	this.explanation = explanation;
	this.reference = reference;
	this.multiAnswerYn = multiAnswerYn;
    }
}