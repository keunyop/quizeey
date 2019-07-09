package com.questionbank.webservice.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.questionbank.webservice.service.enums.TestEnum;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class WebController {

    @GetMapping(value = { "/", "/kr" })
    public String main(HttpServletRequest request) {
        String html = "main";

        if ("/kr".equals(request.getRequestURI())) {
            html = "kr/main";
        }

        return html;
    }

    @GetMapping(value = { "/test", "/kr/test" })
    public String test(HttpServletRequest request, Model model, @RequestParam("testId")
    String testId) {

        String html = "";

        model.addAttribute("testId", testId);

        switch (request.getRequestURI()) {
            case "/test":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/test":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/aws-certified-developer-associate", "/kr/aws-certified-developer-associate" })
    public String awsCertiDevAsct(HttpServletRequest request, Model model,
                                  @RequestParam(value = "questId", required = false)
                                  String questId) {

        String html = "";
        String testId = TestEnum.AWS_DEV_ASSOCT.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/aws-certified-developer-associate":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/aws-certified-developer-associate":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/sqlp-professional", "/kr/sqlp-professional" })
    public String sqlpProfessional(HttpServletRequest request, Model model,
                                   @RequestParam(value = "questId", required = false)
                                   String questId) {

        String html = "";
        String testId = TestEnum.SQLP.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/sqlp-professional":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/sqlp-professional":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/cbp-basic-developer", "/kr/cbp-basic-developer" })
    public String cbpBasicDeveloper(HttpServletRequest request, Model model,
                                    @RequestParam(value = "questId", required = false)
                                    String questId) {

        String html = "";
        String testId = TestEnum.CBP_BASIC.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/cbp-basic-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/cbp-basic-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/computer-science", "/kr/computer-science" })
    public String computerScience(HttpServletRequest request, Model model,
                                  @RequestParam(value = "questId", required = false)
                                  String questId) {

        String html = "";
        String testId = TestEnum.CS.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/computer-science":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/computer-science":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/sqlp-developer", "/kr/sqlp-developer" })
    public String sqlpDeveloper(HttpServletRequest request, Model model,
                                @RequestParam(value = "questId", required = false)
                                String questId) {

        String html = "";
        String testId = TestEnum.SQLD.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/sqlp-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/sqlp-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/engineer-information-processing", "/kr/engineer-information-processing" })
    public String engineerInfoProcessing(HttpServletRequest request, Model model,
                                         @RequestParam(value = "questId", required = false)
                                         String questId) {

        String html = "";
        String testId = TestEnum.ENGR_INFO_PROC.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/engineer-information-processing":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "test";
                break;

            case "/kr/engineer-information-processing":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "kr/test";
                break;

            default:
                break;
        }

        return html;
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