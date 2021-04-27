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
public class Explanation extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long explId;

    @Column(nullable = false)
    private Long questId;

    private String userNm;

    @Column(nullable = false)
    private String explanation;

    @Builder
    public Explanation(Long questId, String userNm, String explanation) {
	this.questId = questId;
	this.userNm = userNm;
	this.explanation = explanation;
    }
}