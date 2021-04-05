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

    @RequestMapping(value="/studyPageMentor")///studyPage/studyPageMentor
    public String index4() {
    	return "studyPageMentor";
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
    
    @RequestMapping(value="/openedGroups") //개설된 그룹
    public String index8() {
    	return "openedGroups";
    }
    
    @RequestMapping(value="/freeBoard") //자유게시판
    public String index9() {
    	return "freeBoard";
    }
}
