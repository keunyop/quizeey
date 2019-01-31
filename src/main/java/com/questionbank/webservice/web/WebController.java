package com.questionbank.webservice.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.questionbank.webservice.domain.question.Question;
import com.questionbank.webservice.service.QuestionService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class WebController {

    private QuestionService questionService;

    //    private PostsService postsService;
    //
    //    @GetMapping("/")
    //    public String main(Model model) {
    //        model.addAttribute("posts", postsService.findAllDesc());
    //        return "main";
    //    }

    @GetMapping("/")
    public String main() {
        return "main";
    }

    @GetMapping("/quiz")
    public String getQuiz(Model model, @RequestParam("id")
    String id) {

        Question question = questionService.getRandomQuestion(id);

        model.addAttribute("quizName", id);
        model.addAttribute("question", question.getQuestionText());
        model.addAttribute("examples", question.getExamples());

        return "quiz";
    }

}