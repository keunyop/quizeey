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

    @GetMapping("/")
    public String main() {
        return "main";
    }

    public static void main(String[] args) {

        String cd = "";
        String a = "A00012";

        if (cd != null && !cd.equals(a.substring(0, 1))) {
            System.out.println("continue");
        } else {
            System.out.println("add");
        }
    }

    @GetMapping("/kr")
    public String mainKr() {
        return "kr/main";
    }

    @GetMapping("/test")
    public String test(Model model, @RequestParam("testId")
    String testId) {
        model.addAttribute("testId", testId);
        model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
        return "test";
    }

    @GetMapping("/kr/test")
    public String testKr(Model model, @RequestParam("testId")
    String testId) {
        model.addAttribute("testId", testId);
        model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());

        return "kr/test";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/request")
    public String request() {
        return "request";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }

    @GetMapping("/privacy")
    public String privacy() {
        return "privacy";
    }
}