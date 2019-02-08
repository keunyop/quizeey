package com.questionbank.webservice.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.questionbank.webservice.service.enums.TestEnum;

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

    @GetMapping("/test")
    public String getTest(Model model, @RequestParam("testId")
    String testId) {
        model.addAttribute("testId", testId);
        model.addAttribute("testName", TestEnum.getByCode(testId).getName());

        return "test";
    }
}