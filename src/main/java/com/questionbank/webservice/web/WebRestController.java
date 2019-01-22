package com.questionbank.webservice.web;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.domain.question.Test;
import com.questionbank.webservice.dto.posts.PostsSaveRequestDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.service.PostsService;
import com.questionbank.webservice.service.QuestionService;
import com.questionbank.webservice.service.TestService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class WebRestController {

    private PostsService    postsService;
    private QuestionService questionService;
    private TestService     testService;

    @GetMapping("/hello")
    public String hello() {
        return "HelloWorld";
    }

    @PostMapping("/posts")
    public Long savePosts(@RequestBody
    PostsSaveRequestDto dto) {
        return postsService.save(dto);
    }

    @GetMapping("/questions")
    public List<Question> getQuestions(QuestionRequestDto dto) {
        return questionService.getQuestions(dto.getQuestionId());
    }

    @GetMapping("/tests")
    public List<Test> getTests() {
        return testService.getTests();
    }
}