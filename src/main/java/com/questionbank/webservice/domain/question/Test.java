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
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@Entity
@ToString
public class Test extends BaseTimeEntity {
    @Id
    @GeneratedValue
    private Long   testId;

    @Column
    private String testNm;

    @Column
    private String testNmEng;

    @Column(nullable = false)
    private String url;

    @Column(nullable = false)
    private int    inqrSeq;

    @Builder
    public Test(Long testId, String testNm, String testNmEng, String url, int inqrSeq) {
        this.testId = testId;
        this.testNm = testNm;
        this.testNmEng = testNmEng;
        this.url = url;
        this.inqrSeq = inqrSeq;
    }
}