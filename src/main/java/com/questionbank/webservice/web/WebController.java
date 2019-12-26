package com.questionbank.webservice.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.questionbank.webservice.service.enums.TestEnum;

@Controller
public class WebController {
    private static Map<String, String[]> TESTMAP;

    // Constructor
    public WebController() {
        if (TESTMAP == null) {
            TESTMAP = new HashMap<>();
            TESTMAP.put("/aws-certified-developer-associate", new String[] { "1" });
            TESTMAP.put("/sqlp-professional", new String[] { "2" });
            TESTMAP.put("/cbp-basic-developer", new String[] { "3" });
            TESTMAP.put("/sqlp-developer", new String[] { "5" });
            TESTMAP.put("/engineer-information-processing", new String[] { "6" });
            TESTMAP.put("/engineer-transportation", new String[] { "7" });
            TESTMAP.put("/engineer-architecture", new String[] { "8" });
            TESTMAP.put("/engineer-broadcasting-communication", new String[] { "9" });
            TESTMAP.put("/engineer-urban-planning", new String[] { "10" });
            TESTMAP.put("/computer-specialist-in-spreadsheet-and-database-level-2", new String[] { "11" });
            TESTMAP.put("/computer-specialist-in-spreadsheet-and-database-level-1", new String[] { "12" });
            TESTMAP.put("/craftsman-fork-lift-truck-operator", new String[] { "13" });
            TESTMAP.put("/craftsman-cook-korean-food", new String[] { "14", "한식조리기능사" });
            TESTMAP.put("/word-processor", new String[] { "15", "워드프로세서" });
            TESTMAP.put("/hairdresser", new String[] { "25", "미용사(일반)" });
            TESTMAP.put("/craftsman-electricity", new String[] { "26", "전기기능사" });
            TESTMAP.put("/engineer-electricity", new String[] { "27" });
            TESTMAP.put("/engineer-industrial-safety", new String[] { "28", "산업안전기사" });
            TESTMAP.put("/industrial-engineer-electricity", new String[] { "29", "전기산업기사" });
            TESTMAP.put("/engineer-fire-protection-system-electrical", new String[] { "31", "소방설비기사(전기분야)" });
            TESTMAP.put("/engineer-fire-protection-system-mechanical", new String[] { "33", "소방설비기사(기계분야)" });
            TESTMAP.put("/craftsman-information-processing", new String[] { "35", "정보처리기능사" });
            TESTMAP.put("/industrial-engineer-hazardous-material", new String[] { "37", "위험물산업기사" });
            TESTMAP.put("/engineer-general-machinery", new String[] { "40", "일반기계기사" });
            TESTMAP.put("/industrial-engineer-information-processing", new String[] { "41", "정보처리산업기사" });
            TESTMAP.put("/industrial-engineer-office-automation", new String[] { "42", "사무자동화산업기사" });
            TESTMAP.put("/craftsman-hazardous-material", new String[] { "44", "위험물기능사" });
            TESTMAP.put("/craftsman-computer-graphics-operation", new String[] { "45" });
            TESTMAP.put("/nail-technician", new String[] { "51" });
            TESTMAP.put("/industrial-engineer-industrial-safety", new String[] { "52" });
            TESTMAP.put("/craftsman-web-design", new String[] { "53" });
            TESTMAP.put("/engineer-information-security", new String[] { "54" });
            TESTMAP.put("/esthetician", new String[] { "55" });
        }
    }

    @GetMapping(value = { "/craftsman-cook-korean-food", "/word-processor", "/hairdresser", "/craftsman-electricity",
            "/engineer-industrial-safety", "/industrial-engineer-electricity",
            "/engineer-fire-protection-system-electrical", "/engineer-fire-protection-system-mechanical",
            "/craftsman-information-processing", "/industrial-engineer-hazardous-material",
            "/engineer-general-machinery", "/industrial-engineer-information-processing",
            "/industrial-engineer-office-automation", "/craftsman-hazardous-material" })
    public String craftsmanForkLiftTruckOperator(HttpServletRequest request, Model model,
                                                 @RequestParam(value = "questId", required = false)
                                                 String questId) {

        String uri = request.getServletPath();

        if (uri.startsWith("/kr/")) {
            uri = uri.substring(3);
        }

        String[] testInfos = TESTMAP.get(uri);

        model.addAttribute("testId", testInfos[0]);
        model.addAttribute("testName", testInfos[1]);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        return "test";
    }

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

    @GetMapping(value = { "/engineer-information-processing", "/kr/engineer-information-processing",
            "/craftsman-computer-graphics-operation", "/engineer-electricity", "/nail-technician",
            "/industrial-engineer-industrial-safety", "/sqlp-professional", "/kr/sqlp-professional",
            "craftsman-web-design", "/computer-specialist-in-spreadsheet-and-database-level-2",
            "/en/aws-certified-developer-associate", "/cbp-basic-developer", "/kr/cbp-basic-developer",
            "/sqlp-developer", "/kr/sqlp-developer", "/engineer-transportation", "/engineer-architecture",
            "/engineer-broadcasting-communication", "/engineer-urban-planning", "/engineer-information-security",
            "/esthetician", "/computer-specialist-in-spreadsheet-and-database-level-1",
            "/craftsman-fork-lift-truck-operator" })
    public String sample(HttpServletRequest request, Model model, @RequestParam(value = "questId", required = false)
    String questId) {

        String uri = request.getServletPath();
        String prefix = "test";

        if (uri.startsWith("/kr/")) {
            uri = uri.substring(3);
        } else if (uri.startsWith("/en/")) {
            uri = uri.substring(3);
            prefix = "en/test";
        }

        model.addAttribute("testId", TESTMAP.get(uri)[0]);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        return prefix + uri;

    }
}