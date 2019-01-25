package com.questionbank.webservice.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class WebController {

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

        model.addAttribute("quizName", id);

        return "quiz";
    }

}