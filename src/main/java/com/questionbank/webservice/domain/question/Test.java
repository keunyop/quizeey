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
public class Test extends BaseTimeEntity {
    @Id
    @GeneratedValue
    private Long   testId;

    @Column(nullable = false)
    private String testNm;

    @Builder
    public Test(String testNm) {
        this.testNm = testNm;
    }
}