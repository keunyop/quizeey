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
            TESTMAP.put("/craftsman-cook-western-food", new String[] { "14" });
            TESTMAP.put("/craftsman-cook-japanese-food", new String[] { "14" });
            TESTMAP.put("/craftsman-cook-chinese-food", new String[] { "14" });
            TESTMAP.put("/craftsman-cook-blowfish", new String[] { "14" });
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
            TESTMAP.put("/craftsman-3D-printer-operation", new String[] { "122" });
            TESTMAP.put("/engineer-forest", new String[] { "123" });
            TESTMAP.put("/master-craftsman-hazardous-material", new String[] { "124" });
            TESTMAP.put("/barista-2", new String[] { "125" });
            TESTMAP.put("/network-manager-1", new String[] { "126" });
            TESTMAP.put("/pc-mechanic-1", new String[] { "127" });
            TESTMAP.put("/pc-mechanic-2", new String[] { "128" });
            TESTMAP.put("/computerized-accounting-specialist-1", new String[] { "129" });
            TESTMAP.put("/computerized-accounting-specialist-2", new String[] { "130" });
            TESTMAP.put("/computerized-accounting-specialist-3", new String[] { "132" });
            TESTMAP.put("/vocational-counselor-senior", new String[] { "133" });
            TESTMAP.put("/clinical-psychologist", new String[] { "134" });
            TESTMAP.put("/engineer-landscape-architecture", new String[] { "135" });
            TESTMAP.put("/engineer-interior-architecture", new String[] { "136" });
            TESTMAP.put("/specialist-multimedia-contents-producing", new String[] { "137" });
            TESTMAP.put("/craftsman-excavating-machine-operator", new String[] { "138" });
            TESTMAP.put("/craftsman-floral-design", new String[] { "139" });
            TESTMAP.put("/industrial-engineer-electric-work", new String[] { "140" });
            TESTMAP.put("/industrial-engineer-air-conditioning-and-refrigerating-machinery", new String[] { "140" });
            TESTMAP.put("/engineer-plant-protection", new String[] { "142" });
            TESTMAP.put("/aws-certified-solution-architect-associate", new String[] { "143" });
            TESTMAP.put("/craftsman-interior-architecture", new String[] { "144" });
            TESTMAP.put("/industrial-engineer-computer-aided-manufacturing", new String[] { "145" });
            TESTMAP.put("/engineer-building-facilities", new String[] { "147" });
            TESTMAP.put("/industrial-engineer-information-communication", new String[] { "148" });
            TESTMAP.put("/industrial-engineer-motor-vehicles-maintenance", new String[] { "149" });
            TESTMAP.put("/industrial-engineer-machinery-maintenance", new String[] { "150" });
            TESTMAP.put("/industrial-engineer-architecture", new String[] { "151" });
            TESTMAP.put("/craftsman-electronic-cad", new String[] { "152" });
            TESTMAP.put("/craftsman-organic-agriculture", new String[] { "153" });
            TESTMAP.put("/telemarketing-administrator", new String[] { "154" });
            TESTMAP.put("/engineer-wastes-treatment", new String[] { "155" });
            TESTMAP.put("/craftsman-photography", new String[] { "156" });
            TESTMAP.put("/industrial-engineer-manufacturing-automatization", new String[] { "157" });
            TESTMAP.put("/industrial-engineer-electronics", new String[] { "158" });
            TESTMAP.put("/craftsman-plumbing", new String[] { "159" });
            TESTMAP.put("/engineer-biomedical", new String[] { "160" });
            TESTMAP.put("/engineer-computer-system-application", new String[] { "161" });
            TESTMAP.put("/ccna-200-125", new String[] { "166" });
            TESTMAP.put("/craftsman-laundry", new String[] { "167" });
            TESTMAP.put("/comptia-sy0-501", new String[] { "168" });
            TESTMAP.put("/az-103", new String[] { "169" });
            TESTMAP.put("/az-900", new String[] { "170" });
            TESTMAP.put("/az-300", new String[] { "172" });
            TESTMAP.put("/industrial-engineer-construction-safety", new String[] { "173" });
            TESTMAP.put("/ccnp-300-115", new String[] { "174" });
            TESTMAP.put("/industrial-engineer-aircraft-maintenance", new String[] { "175" });
            TESTMAP.put("/craftsman-forest", new String[] { "176" });
            TESTMAP.put("/cissp", new String[] { "177" });
            TESTMAP.put("/industrial-engineer-colorist", new String[] { "178" });
            TESTMAP.put("/engineer-surveying-geo-spatial-information", new String[] { "179" });
            TESTMAP.put("/ccnp-300-101", new String[] { "180" });
            TESTMAP.put("/comptia-220-1001", new String[] { "181" });
            TESTMAP.put("/comptia-n10-007", new String[] { "182" });
            TESTMAP.put("/microsoft-70-740", new String[] { "183" });
            TESTMAP.put("/engineer-plant-maintenance", new String[] { "184" });
            TESTMAP.put("/pmi-pmp", new String[] { "185" });
            TESTMAP.put("/craftsman-chemical-analysis", new String[] { "186" });
            TESTMAP.put("/az-301", new String[] { "187" });
            TESTMAP.put("/engineer-elevator", new String[] { "188" });
            TESTMAP.put("/industrial-engineer-visual-communication-design", new String[] { "189" });
            TESTMAP.put("/ms-100", new String[] { "190" });
            TESTMAP.put("/2V0-21.19", new String[] { "194" });
            TESTMAP.put("/microsoft-70-741", new String[] { "195" });
            TESTMAP.put("/itilfnd-v4", new String[] { "196" });
            TESTMAP.put("/az-500", new String[] { "198" });
            TESTMAP.put("/engineer-ergonomics", new String[] { "199" });
            TESTMAP.put("/engineer-computer", new String[] { "200" });
            TESTMAP.put("/craftsman-confectionary-making", new String[] { "201" });
            TESTMAP.put("/craftsman-inert-gas-arc-welding", new String[] { "202" });
            TESTMAP.put("/ccna-200-301", new String[] { "204" });
            TESTMAP.put("/cas-003", new String[] { "205" });
            TESTMAP.put("/craftsman-computer-aided-milling", new String[] { "206" });
            TESTMAP.put("/craftsman-hydro-pneumatic", new String[] { "207" });
            TESTMAP.put("/cisco-350-401", new String[] { "208" });
            TESTMAP.put("/craftsman-mushroom-seeds", new String[] { "209" });
            TESTMAP.put("/craftsman-production-automatic-operation", new String[] { "210" });
            TESTMAP.put("/engineer-colorist", new String[] { "211" });
            TESTMAP.put("/industrial-engineer-interior-architecture", new String[] { "212" });
            TESTMAP.put("/craftsman-seeds", new String[] { "213" });
            TESTMAP.put("/engineer-seeds", new String[] { "214" });
            TESTMAP.put("/craftsman-computer", new String[] { "215" });
        }
    }

    @GetMapping(value = { "/engineer-information-processing", "/kr/engineer-information-processing",
            "/craftsman-computer-graphics-operation", "/engineer-electricity", "/nail-technician",
            "/industrial-engineer-industrial-safety", "/sqlp-professional", "/kr/sqlp-professional",
            "craftsman-web-design", "/computer-specialist-in-spreadsheet-and-database-level-2",
            "/en/aws-certified-developer-associate", "/cbp-basic-developer", "/kr/cbp-basic-developer",
            "/sqlp-developer", "/kr/sqlp-developer", "/engineer-transportation", "/engineer-architecture",
            "/engineer-broadcasting-communication", "/engineer-urban-planning", "/engineer-information-security",
            "/esthetician", "/computer-specialist-in-spreadsheet-and-database-level-1",
            "/craftsman-fork-lift-truck-operator", "/engineer-air-conditioning-refrigerating-machinery",
            "/craftsman-cook-korean-food", "/word-processor", "/hairdresser", "/craftsman-electricity",
            "/engineer-industrial-safety", "/industrial-engineer-electricity",
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
            "/computer-tax-1", "/craftsman-3D-printer-operation", "/engineer-forest",
            "/master-craftsman-hazardous-material", "/barista-2", "/network-manager-1", "/pc-mechanic-1",
            "/pc-mechanic-2", "/computerized-accounting-specialist-1", "/computerized-accounting-specialist-2",
            "/computerized-accounting-specialist-3", "/vocational-counselor-senior", "/clinical-psychologist",
            "/engineer-landscape-architecture", "/engineer-interior-architecture",
            "/specialist-multimedia-contents-producing", "/craftsman-excavating-machine-operator",
            "/craftsman-cook-western-food", "/craftsman-cook-japanese-food", "/craftsman-cook-chinese-food",
            "/craftsman-cook-blowfish", "/craftsman-floral-design", "/industrial-engineer-electric-work",
            "/industrial-engineer-air-conditioning-and-refrigerating-machinery", "/engineer-plant-protection",
            "/aws-certified-solution-architect-associate", "/en/aws-certified-solution-architect-associate",
            "/craftsman-interior-architecture", "/industrial-engineer-computer-aided-manufacturing",
            "/engineer-building-facilities", "/industrial-engineer-information-communication",
            "/industrial-engineer-motor-vehicles-maintenance", "/industrial-engineer-machinery-maintenance",
            "/industrial-engineer-architecture", "/craftsman-electronic-cad", "/craftsman-organic-agriculture",
            "/telemarketing-administrator", "/engineer-wastes-treatment", "/craftsman-photography",
            "/industrial-engineer-electronics", "/industrial-engineer-manufacturing-automatization",
            "/craftsman-plumbing", "/engineer-biomedical", "/engineer-computer-system-application", "/ccna-200-125",
            "/en/ccna-200-125", "/craftsman-laundry", "/comptia-sy0-501", "/en/comptia-sy0-501", "/az-103",
            "/en/az-103", "/az-900", "/en/az-900", "/az-300", "/en/az-300", "/industrial-engineer-construction-safety",
            "/en/ccnp-300-115", "/ccnp-300-115", "/industrial-engineer-aircraft-maintenance", "/craftsman-forest",
            "/cissp", "/en/cissp", "/industrial-engineer-colorist", "/engineer-surveying-geo-spatial-information",
            "/ccnp-300-101", "/en/ccnp-300-101", "/comptia-220-1001", "/en/comptia-220-1001", "/comptia-n10-007",
            "/en/comptia-n10-007", "/microsoft-70-740", "/en/microsoft-70-740", "/engineer-plant-maintenance",
            "/pmi-pmp", "/en/pmi-pmp", "/craftsman-chemical-analysis", "/az-301", "/en/az-301", "/engineer-elevator",
            "/industrial-engineer-visual-communication-design", "/ms-100", "/en/ms-100", "/2V0-21.19", "/en/2V0-21.19",
            "/microsoft-70-741", "/en/microsoft-70-741", "/itilfnd-v4", "/en/itilfnd-v4", "/az-500", "/en/az-500",
            "/engineer-ergonomics", "/engineer-computer", "/craftsman-confectionary-making",
            "/craftsman-inert-gas-arc-welding", "/ccna-200-301", "/en/ccna-200-301", "/cas-003", "/en/cas-003",
            "/craftsman-computer-aided-milling", "/craftsman-hydro-pneumatic", "/cisco-350-401", "/en/cisco-350-401",
            "/craftsman-mushroom-seeds", "/craftsman-production-automatic-operation", "/engineer-colorist",
            "/industrial-engineer-interior-architecture", "/craftsman-seeds", "/engineer-seeds",
            "/craftsman-computer" })
    public String question(HttpServletRequest request, Model model, @RequestParam(value = "questId", required = false)
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

    @GetMapping(value = { "/", "/kr", "/en", "/app" })
    public String main(HttpServletRequest request) {
        String html = "main";

        String uri = request.getRequestURI();

        if ("/en".equals(uri)) {
            html = "en/main";
        } else if ("/app".equals(uri)) {
            html = "app/main";
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

    @GetMapping(value = { "/community", "/en/community" })
    public String community(HttpServletRequest request) {
        return request.getRequestURI();
    }
}