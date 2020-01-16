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
            TESTMAP.put("/craftsman-cook-korean-food", new String[] { "14" });
            TESTMAP.put("/word-processor", new String[] { "15" });
            TESTMAP.put("/hairdresser", new String[] { "25" });
            TESTMAP.put("/craftsman-electricity", new String[] { "26" });
            TESTMAP.put("/engineer-electricity", new String[] { "27" });
            TESTMAP.put("/engineer-industrial-safety", new String[] { "28" });
            TESTMAP.put("/industrial-engineer-electricity", new String[] { "29" });
            TESTMAP.put("/engineer-fire-protection-system-electrical", new String[] { "31" });
            TESTMAP.put("/engineer-fire-protection-system-mechanical", new String[] { "33" });
            TESTMAP.put("/craftsman-information-processing", new String[] { "35" });
            TESTMAP.put("/industrial-engineer-hazardous-material", new String[] { "37" });
            TESTMAP.put("/engineer-general-machinery", new String[] { "40" });
            TESTMAP.put("/industrial-engineer-information-processing", new String[] { "41" });
            TESTMAP.put("/industrial-engineer-office-automation", new String[] { "42" });
            TESTMAP.put("/craftsman-hazardous-material", new String[] { "44" });
            TESTMAP.put("/craftsman-computer-graphics-operation", new String[] { "45" });
            TESTMAP.put("/nail-technician", new String[] { "51" });
            TESTMAP.put("/industrial-engineer-industrial-safety", new String[] { "52" });
            TESTMAP.put("/craftsman-web-design", new String[] { "53" });
            TESTMAP.put("/engineer-information-security", new String[] { "54" });
            TESTMAP.put("/esthetician", new String[] { "55" });
            TESTMAP.put("/engineer-air-conditioning-refrigerating-machinery", new String[] { "56" });
            TESTMAP.put("/engineer-chemical-industry", new String[] { "58" });
            TESTMAP.put("/vocational-counselor", new String[] { "60" });
            TESTMAP.put("/craftsman-welding", new String[] { "62" });
            TESTMAP.put("/craftsman-motor-vehicles-maintenance", new String[] { "64" });
            TESTMAP.put("/craftsman-computer-aided-mechanical-drawing", new String[] { "66" });
            TESTMAP.put("/engineer-quality-management", new String[] { "68" });
            TESTMAP.put("/craftsman-computer-aided-architectural-drawing", new String[] { "69" });
            TESTMAP.put("/make-up-artist", new String[] { "73" });
            TESTMAP.put("/engineer-construction-safety", new String[] { "74" });
            TESTMAP.put("/engineer-information-communication", new String[] { "76" });
            TESTMAP.put("/engineer-civil-engineering", new String[] { "78" });
            TESTMAP.put("/craftsman-energy-management", new String[] { "79" });
            TESTMAP.put("/engineer-electric-work", new String[] { "80" });
            TESTMAP.put("/craftsman-information-equipment-operation", new String[] { "81" });
            TESTMAP.put("/craftsman-landscape-architecture", new String[] { "82" });
            TESTMAP.put("/craftsman-bartender", new String[] { "83" });
            TESTMAP.put("/craftsman-gas", new String[] { "84" });
            TESTMAP.put("/industrial-engineer-machinery-design", new String[] { "85" });
            TESTMAP.put("/survey-analyst-junior", new String[] { "87" });
            TESTMAP.put("/engineer-air-pollution-environmental", new String[] { "89" });
            TESTMAP.put("/engineer-industrial-hygiene-management", new String[] { "93" });
            TESTMAP.put("/engineer-water-pollution-environmental", new String[] { "94" });
            TESTMAP.put("/master-craftsman-electricity", new String[] { "95" });
            TESTMAP.put("/craftsman-electronic-apparatus", new String[] { "96" });
            TESTMAP.put("/craftsman-breads-making", new String[] { "97" });
            TESTMAP.put("/engineer-chemical-analysis", new String[] { "98" });
            TESTMAP.put("/engineer-energy-management", new String[] { "99" });
            TESTMAP.put("/engineer-radio-telecommunication-equipment", new String[] { "101" });
            TESTMAP.put("/engineer-gas", new String[] { "102" });
            TESTMAP.put("/craftsman-elevator", new String[] { "103" });
            TESTMAP.put("/craftsman-air-conditioning-and-refrigerating-machinery", new String[] { "104" });
            TESTMAP.put("/craftsman-environmental", new String[] { "105" });
            TESTMAP.put("/engineer-food-processing", new String[] { "106" });
            TESTMAP.put("/industrial-engineer-gas", new String[] { "107" });
            TESTMAP.put("/nursing-assistant", new String[] { "108" });
            TESTMAP.put("/clinical-psychology-practitioner", new String[] { "109" });
            TESTMAP.put("/linux-master-2", new String[] { "110" });
            TESTMAP.put("/1st-grade-social-worker-1", new String[] { "111" });
            TESTMAP.put("/computer-accounting-1", new String[] { "112" });
            TESTMAP.put("/1st-grade-social-worker-2", new String[] { "113" });
            TESTMAP.put("/network-manager-2", new String[] { "114" });
            TESTMAP.put("/1st-grade-social-worker-3", new String[] { "115" });
            TESTMAP.put("/agriculture-insurance-claim-adjuster", new String[] { "116" });
            TESTMAP.put("/diat", new String[] { "117" });
            TESTMAP.put("/linux-master-1", new String[] { "118" });
            TESTMAP.put("/engineer-electronics", new String[] { "120" });
            TESTMAP.put("/computer-tax-1", new String[] { "121" });
        }
    }

    @GetMapping(value = { "/engineer-information-processing", "/kr/engineer-information-processing",
            "/craftsman-computer-graphics-operation", "/engineer-electricity", "/nail-technician",
            "/industrial-engineer-industrial-safety", "/sqlp-professional", "/kr/sqlp-professional",
            "craftsman-web-design", "/computer-specialist-in-spreadsheet-and-database-level-2",
            "/en/aws-certified-developer-associate", "/zh/aws-certified-developer-associate", "/cbp-basic-developer",
            "/kr/cbp-basic-developer", "/sqlp-developer", "/kr/sqlp-developer", "/engineer-transportation",
            "/engineer-architecture", "/engineer-broadcasting-communication", "/engineer-urban-planning",
            "/engineer-information-security", "/esthetician",
            "/computer-specialist-in-spreadsheet-and-database-level-1", "/craftsman-fork-lift-truck-operator",
            "/engineer-air-conditioning-refrigerating-machinery", "/craftsman-cook-korean-food", "/word-processor",
            "/hairdresser", "/craftsman-electricity", "/engineer-industrial-safety", "/industrial-engineer-electricity",
            "/engineer-fire-protection-system-electrical", "/engineer-fire-protection-system-mechanical",
            "/craftsman-information-processing", "/industrial-engineer-hazardous-material",
            "/engineer-general-machinery", "/industrial-engineer-information-processing",
            "/industrial-engineer-office-automation", "/craftsman-hazardous-material", "/engineer-chemical-industry",
            "/vocational-counselor", "/craftsman-welding", "/craftsman-motor-vehicles-maintenance",
            "/craftsman-computer-aided-mechanical-drawing", "/engineer-quality-management",
            "/craftsman-computer-aided-architectural-drawing", "/make-up-artist", "/engineer-construction-safety",
            "/engineer-information-communication", "/engineer-civil-engineering", "/craftsman-energy-management",
            "/engineer-electric-work", "/craftsman-information-equipment-operation",
            "/craftsman-landscape-architecture", "/craftsman-bartender", "/craftsman-gas",
            "/industrial-engineer-machinery-design", "/survey-analyst-junior", "/engineer-air-pollution-environmental",
            "/engineer-industrial-hygiene-management", "/engineer-water-pollution-environmental",
            "/master-craftsman-electricity", "/craftsman-electronic-apparatus", "/craftsman-breads-making",
            "/engineer-chemical-analysis", "/engineer-energy-management", "/engineer-radio-telecommunication-equipment",
            "/engineer-gas", "/craftsman-elevator", "/craftsman-air-conditioning-and-refrigerating-machinery",
            "/craftsman-environmental", "/engineer-food-processing", "/industrial-engineer-gas",
            "/clinical-psychology-practitioner", "/nursing-assistant", "/linux-master-2", "/1st-grade-social-worker-1",
            "/computer-accounting-1", "/1st-grade-social-worker-2", "/1st-grade-social-worker-3", "/network-manager-2",
            "/agriculture-insurance-claim-adjuster", "/diat", "/linux-master-1", "/engineer-electronics",
            "/computer-tax-1" })
    public String question(HttpServletRequest request, Model model, @RequestParam(value = "questId", required = false)
    String questId) {

        String uri = request.getServletPath();
        String prefix = "test";

        if (uri.startsWith("/kr/")) {
            uri = uri.substring(3);
        } else if (uri.startsWith("/en/")) {
            uri = uri.substring(3);
            prefix = "en/test";
        } else if (uri.startsWith("/zh/")) {
            uri = uri.substring(3);
            prefix = "zh/test";
        }

        model.addAttribute("testId", TESTMAP.get(uri)[0]);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        return prefix + uri;

    }

    @GetMapping(value = { "/", "/kr", "/en", "/zh" })
    public String main(HttpServletRequest request) {
        String html = "main";

        if ("/en".equals(request.getRequestURI())) {
            html = "en/main";
        } else if ("/zh".equals(request.getRequestURI())) {
            html = "zh/main";
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

        String testId = TestEnum.AWS_DEV_ASSOCT.getCode();

        model.addAttribute("testId", testId);

        if (StringUtils.isNotBlank(questId)) {
            model.addAttribute("inputQuestId", questId);
        }

        model.addAttribute("testName", TestEnum.getByCode(testId).getKorName());
        return "test";
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

}