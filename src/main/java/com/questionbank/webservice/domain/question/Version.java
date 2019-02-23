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
public class Version extends BaseTimeEntity {
    @Id
    @GeneratedValue
    private Long   verId;

    @Column(nullable = false)
    private Long   testId;

    @Column(nullable = false)
    private String verNm;

    @Builder
    public Version(Long testId, String verNm) {
        this.testId = testId;
        this.verNm = verNm;
    }
}