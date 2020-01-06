package com.questionbank.webservice.web;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.questionbank.webservice.dto.question.ExampleSaveRequestDto;
import com.questionbank.webservice.dto.question.ExplanationRequestDto;
import com.questionbank.webservice.dto.question.ExplanationResponseDto;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.dto.question.QuestionSaveRequestDto;
import com.questionbank.webservice.dto.question.QuestionStatsRequestDto;
import com.questionbank.webservice.dto.question.QuestionStatsResponseDto;
import com.questionbank.webservice.dto.question.QuestionStatsSaveRequestDto;
import com.questionbank.webservice.dto.question.TestRequestDto;
import com.questionbank.webservice.dto.question.TestResponseDto;
import com.questionbank.webservice.dto.question.VersionRequestDto;
import com.questionbank.webservice.dto.question.VersionResponseDto;
import com.questionbank.webservice.service.ExampleService;
import com.questionbank.webservice.service.ExplanationService;
import com.questionbank.webservice.service.QuestionService;
import com.questionbank.webservice.service.QuestionStatsService;
import com.questionbank.webservice.service.TestService;
import com.questionbank.webservice.service.VersionService;
import com.questionbank.webservice.util.TestGenerator;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class WebRestController {
    private QuestionService      questionService;
    private VersionService       versionService;
    private ExampleService       exampleService;
    private QuestionStatsService questionStatsService;
    private ExplanationService   explanationService;
    private TestService          testService;
    private TestGenerator        testGenerator;

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

    @PostMapping("/questionStats")
    public QuestionStatsResponseDto getQuestionStats(@RequestBody
    QuestionStatsRequestDto dto) {
        return questionStatsService.getQuestionStats(dto.getQuestId());
    }

    @PostMapping("/addExplanation")
    public void addExplanation(@RequestBody
    ExplanationRequestDto dto) {
        explanationService.addExplanation(dto);
    }

    @PostMapping("/explanations")
    public List<ExplanationResponseDto> getExplanations(@RequestBody
    ExplanationRequestDto dto) {
        return explanationService.getExplanations(dto.getQuestId());
    }

    @PostMapping("/tests")
    public List<TestResponseDto> getTests(@RequestBody
    TestRequestDto dto) {
        return testService.getTests(dto.getLanguageCd());
    }

    @GetMapping("/addTestBatch")
    public void addTest() {
        testGenerator.addTestBatch();
    }

    @GetMapping("/addVersionBatch")
    public void addVersion() {
        testGenerator.addVersionBatch();
    }

    @GetMapping("/clearCache")
    public void clearCache() {
        questionService.clearCache();
    }
}