package com.questionbank.webservice.dto.question;

import java.util.List;
import java.util.stream.Collectors;

import com.questionbank.webservice.domain.question.Example;
import com.questionbank.webservice.domain.question.Question;

import lombok.Getter;

@Getter
public class QuestionMainResponseDto {
    private Long                         questId;
    private Long                         testId;
    private int                          verNbr;
    private String                       verName;
    private int                          questNbr;
    private String                       questTxt;
    private String                       explanation;
    private String                       reference;
    private boolean                      isMultiAnswer;
    private List<ExampleMainResponseDto> examples;

    public QuestionMainResponseDto(Question quest, List<Example> exmps, String verName) {
        this.questId = quest.getQuestId();
        this.testId = quest.getTestId();
        this.verNbr = quest.getVerNbr();
        this.verName = verName;
        this.questNbr = quest.getQuestNbr();
        this.questTxt = quest.getQuestTxt();
        this.explanation = quest.getExplanation();
        this.reference = quest.getReference();
        this.isMultiAnswer = "Y".equalsIgnoreCase(quest.getMultiAnswerYn());
        this.examples = exmps.stream().map(ExampleMainResponseDto::new).collect(Collectors.toList());
    }
}