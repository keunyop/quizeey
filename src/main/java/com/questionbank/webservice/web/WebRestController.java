package com.questionbank.webservice.web;

import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.questionbank.webservice.dto.question.ExampleSaveRequestDto;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.dto.question.QuestionSaveRequestDto;
import com.questionbank.webservice.dto.question.QuestionStatsSaveRequestDto;
import com.questionbank.webservice.dto.question.VersionRequestDto;
import com.questionbank.webservice.dto.question.VersionResponseDto;
import com.questionbank.webservice.service.ExampleService;
import com.questionbank.webservice.service.QuestionService;
import com.questionbank.webservice.service.QuestionStatsService;
import com.questionbank.webservice.service.VersionService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class WebRestController {
    private QuestionService      questionService;
    private VersionService       versionService;
    private ExampleService       exampleService;
    private QuestionStatsService questionStatsService;

    @PostMapping("/question")
    public QuestionMainResponseDto getQuestion(@RequestBody
    QuestionRequestDto dto) {
        return questionService.getQuestion(dto);
    }

    @PostMapping("/versions")
    public List<VersionResponseDto> getVersion(@RequestBody
    VersionRequestDto dto) {
        return versionService.getVersions(dto.getTestId());
    }

    @PostMapping("/addQuestion")
    public Long addQustion(@RequestBody
    QuestionSaveRequestDto dto) {
        return questionService.addQuestion(dto);
    }

    @PostMapping("/addExample")
    public Long addExample(@RequestBody
    ExampleSaveRequestDto dto) {
        return exampleService.addExample(dto);
    }

    @PostMapping("/updateQuestionStats")
    public void updateQuestionStats(@RequestBody
    QuestionStatsSaveRequestDto dto) {
        questionStatsService.updateQuestionStats(dto);
    }
}