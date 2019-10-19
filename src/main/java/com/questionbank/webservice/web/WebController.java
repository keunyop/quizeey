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

    @GetMapping(value = { "/", "/kr", "/en" })
    public String main(HttpServletRequest request) {
        String html = "main";

        if ("/en".equals(request.getRequestURI())) {
            html = "en/main";
        }

        return html;
    }

    @GetMapping(value = { "/test", "/kr/test", "/en/test" })
    public String test(HttpServletRequest request, Model model, @RequestParam("testId")
    String testId) {

        String html = "";

        model.addAttribute("testId", testId);

        switch (request.getRequestURI()) {
            case "/test":
            case "/kr/test":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/test":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/aws-certified-developer-associate", "/kr/aws-certified-developer-associate",
            "/en/aws-certified-developer-associate" })
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
            case "/kr/aws-certified-developer-associate":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/aws-certified-developer-associate":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/sqlp-professional", "/kr/sqlp-professional", "/en/sqlp-professional" })
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
            case "/kr/sqlp-professional":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/sqlp-professional":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/cbp-basic-developer", "/kr/cbp-basic-developer", "/en/cbp-basic-developer" })
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
            case "/kr/cbp-basic-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/cbp-basic-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/computer-science", "/kr/computer-science", "/en/computer-science" })
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
            case "/kr/computer-science":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/computer-science":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/sqlp-developer", "/kr/sqlp-developer", "/en/sqlp-developer" })
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
            case "/kr/sqlp-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/sqlp-developer":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/engineer-information-processing", "/kr/engineer-information-processing",
            "/en/engineer-information-processing" })
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
            case "/kr/engineer-information-processing":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/engineer-information-processing":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/engineer-transportation", "/en/engineer-transportation" })
    public String engineerTransportation(HttpServletRequest request, Model model,
                                         @RequestParam(value = "questId", required = false)
                                         String questId) {

        String html = "";
        String testId = TestEnum.ENGR_TRANSPORTATION.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        switch (request.getRequestURI()) {
            case "/engineer-transportation":
                model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
                html = "test";
                break;

            case "/en/engineer-transportation":
                model.addAttribute("testName", TestEnum.getByCode(testId).getEngName());
                html = "en/test";
                break;

            default:
                break;
        }

        return html;
    }

    @GetMapping(value = { "/engineer-architecture" })
    public String engineerArchitecture(HttpServletRequest request, Model model,
                                       @RequestParam(value = "questId", required = false)
                                       String questId) {

        model.addAttribute("testId", "8");

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        model.addAttribute("testName", "건축기사");

        return "test";
    }

    @GetMapping(value = { "/engineer-broadcasting-communication" })
    public String engineerBroadcastingCommunication(HttpServletRequest request, Model model,
                                                    @RequestParam(value = "questId", required = false)
                                                    String questId) {

        model.addAttribute("testId", "9");

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        model.addAttribute("testName", "방송통신기사");

        return "test";
    }

    @GetMapping(value = { "/engineer-urban-planning" })
    public String engineerUrbanPlanning(HttpServletRequest request, Model model,
                                        @RequestParam(value = "questId", required = false)
                                        String questId) {

        model.addAttribute("testId", "10");

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        model.addAttribute("testName", "도시계획기사");

        return "test";
    }

    @GetMapping(value = { "/computer-specialist-in-spreadsheet-and-database-level-2" })
    public String computerSpecialistInSpreadsheetAndDatabaseLevel2(HttpServletRequest request, Model model,
                                                                   @RequestParam(value = "questId", required = false)
                                                                   String questId) {

        model.addAttribute("testId", "11");

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        model.addAttribute("testName", "컴퓨터활용능력 2급");

        return "test";
    }

    @GetMapping(value = { "/computer-specialist-in-spreadsheet-and-database-level-1" })
    public String computerSpecialistInSpreadsheetAndDatabaseLevel1(HttpServletRequest request, Model model,
                                                                   @RequestParam(value = "questId", required = false)
                                                                   String questId) {

        model.addAttribute("testId", "12");

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        model.addAttribute("testName", "컴퓨터활용능력 1급");

        return "test";
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