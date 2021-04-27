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

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Entity
public class Version extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long verId;

    @Column(nullable = false)
    private Long testId;

    @Column(nullable = false)
    private int verNbr;

    @Column(nullable = false)
    private String verNm;

    @Builder
    public Version(Long testId, int verNbr, String verNm) {
	this.testId = testId;
	this.verNbr = verNbr;
	this.verNm = verNm;
    }
}