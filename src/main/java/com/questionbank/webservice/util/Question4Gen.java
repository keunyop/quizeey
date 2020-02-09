package com.questionbank.webservice.util;

import java.util.List;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Question4Gen {
    private String            questNbr;
    private String            questTxt;
    private String            explanation;
    private String            reference;
    private String            multiAnswerYn;
    private List<Example4Gen> example4Gens;

    @Builder
    public Question4Gen(String questNbr, String questTxt, String explanation, String reference, String multiAnswerYn,
                        List<Example4Gen> example4Gens) {
        this.questNbr = questNbr;
        this.questTxt = questTxt;
        this.explanation = explanation;
        this.reference = reference;
        this.multiAnswerYn = multiAnswerYn;
        this.example4Gens = example4Gens;
    }
}