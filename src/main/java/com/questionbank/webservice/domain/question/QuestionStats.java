package com.questionbank.webservice.domain.question;

import javax.persistence.Column;
import javax.persistence.Entity;
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
public class QuestionStats extends BaseTimeEntity {
    @Id
    private Long questId;

    @Column(nullable = false)
    private int  correct;

    @Column(nullable = false)
    private int  inCorrect;

    @Builder
    public QuestionStats(Long questId, int correct, int inCorrect) {
        this.questId = questId;
        this.correct = correct;
        this.inCorrect = inCorrect;
    }
}