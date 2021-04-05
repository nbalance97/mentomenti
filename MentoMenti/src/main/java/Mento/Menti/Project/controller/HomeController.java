package Mento.Menti.Project.controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller
public class HomeController {
    
    @RequestMapping(value="/")
    public String index() {      
        return "home";
    }
    
    @RequestMapping(value="/compiler")
    public String index2() {
    	return "CompileTestView";
    }
    
    @RequestMapping(value="/yewon")
    public String index3() {
    	return "yewon";
    }

    @RequestMapping(value="/studyPage/studyPageMentor")//수업화면-멘토
    public String index4() {
    	return "/studyPage/studyPageMentor";
    }
    
    @RequestMapping(value="/loginPage") //로그인 화면
    public String index5() {
    	return "loginPage";
    }
    
    @RequestMapping(value="/notice") //공지사항
    public String index6() {
    	return "notice";
    }
    
    @RequestMapping(value="/main") //로그인 화면
    public String index7() {
    	return "main";
    }
    
    @RequestMapping(value="/studyPage/debugStudy")//수업화면-멘토 다시 레이아웃
    public String index8() {
    	return "/studyPage/debugStudy";
    }
    @RequestMapping(value="/practice")//실습화면-멘티레이아웃1
    public String index9() {
    	return "/studyPage/practicePage";
    }
    @RequestMapping(value="/practice2")//실습화면-멘티레이아웃2
    public String index10() {
    	return "/studyPage/practicePage2";
    }
    @RequestMapping(value="/practiceMento")//실습화면-멘티레이아웃2
    public String index11() {
    	return "/studyPage/practiceMento";
    }
}
