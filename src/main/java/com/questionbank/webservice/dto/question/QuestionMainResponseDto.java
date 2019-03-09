package com.questionbank.webservice.dto.question;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.questionbank.webservice.domain.question.Example;
import com.questionbank.webservice.domain.question.Question;

import lombok.Getter;

@Getter
public class QuestionMainResponseDto {
    private Long                         questId;
    private Long                         testId;
    private int                          verNbr;
    private int                          questNbr;
    private String                       questTxt;
    private String                       explanation;
    private String                       reference;
    private boolean                      isMultiAnswer;
    private List<ExampleMainResponseDto> examples;

    public QuestionMainResponseDto(Question quest, Stream<Example> exmps) {
        this.questId = quest.getQuestId();
        this.testId = quest.getTestId();
        this.verNbr = quest.getVerNbr();
        this.questNbr = quest.getQuestNbr();
        this.questTxt = quest.getQuestTxt();
        this.explanation = quest.getExplanation();
        this.reference = quest.getReference();
        this.isMultiAnswer = quest.isMultiAnswer();
        this.examples = exmps.map(ExampleMainResponseDto::new).collect(Collectors.toList());
    }

    @Override
    public String toString() {
        return "QuestionMainResponseDto [questId=" + questId + ", testId=" + testId + ", verNbr=" + verNbr
                + ", questNbr=" + questNbr + ", questTxt=" + questTxt + ", explanation=" + explanation + ", reference="
                + reference + ", isMultiAnswer=" + isMultiAnswer + ", examples=" + examples + "]";
    }
}