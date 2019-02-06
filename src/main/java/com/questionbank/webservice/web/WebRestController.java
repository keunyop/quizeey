package com.questionbank.webservice.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.questionbank.webservice.dto.posts.PostsSaveRequestDto;
import com.questionbank.webservice.dto.question.QuestionMainResponseDto;
import com.questionbank.webservice.dto.question.QuestionRequestDto;
import com.questionbank.webservice.dto.question.QuestionSaveRequestDto;
import com.questionbank.webservice.service.PostsService;
import com.questionbank.webservice.service.QuestionService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class WebRestController {

    private PostsService    postsService;
    private QuestionService questionService;

    @GetMapping("/hello")
    public String hello() {
        return "HelloWorld";
    }

    @PostMapping("/posts")
    public Long savePosts(@RequestBody
    PostsSaveRequestDto dto) {
        return postsService.save(dto);
    }

    @PostMapping("/question")
    public QuestionMainResponseDto getQuestion(@RequestBody
    QuestionRequestDto dto) {
        return questionService.getQuestion(dto);
    }

    @PostMapping("/addQuestion")
    public Long addQustion(@RequestBody
    QuestionSaveRequestDto dto) {
        return questionService.addQuestion(dto);
    }

}