package Mento.Menti.Project.controller;
 
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import Mento.Menti.Project.dto.PostDTO;

@Controller
public class HomeController {
	public static DAOConfiguration dao; // 실제로 사용하는 static 저장소

	@Autowired
	private DAOConfiguration temp;
	
	@PostConstruct
	private void initDao() {
		dao = temp;
	}
	
    @RequestMapping(value="/")
    public String index() {    
        return "home";
    }
    
    @RequestMapping(value="/compiler")
    public String index2() throws Exception{
    	System.out.println(dao);
    	List<PostDTO> temp = dao.getPostDAO().selectPosts();
    	PostDTO post = temp.get(0);
    	System.out.println(post.getTitle() + " // " + post.getUserid() + " // ");
    	System.out.println(post.getGroupid() + " // " + post.getPostdate() + " // ");
    	System.out.println(post.getContent() + " // " + post.getViewcount() + " // ");
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
    
    @RequestMapping(value="/practiceMentee")//실습화면-멘티레이아웃1
    public String index8() {
    	return "/studyPage/practiceMentee";
    }
    
    @RequestMapping(value="/practiceMento")//실습화면-멘티레이아웃2
    public String index11() {
    	return "/studyPage/practiceMento";
    }
    
    @RequestMapping(value="/openedGroups") //개설된 그룹
    public String index12() {
    	return "openedGroups";
    }
    
    @RequestMapping(value="/freeBoard") //자유게시판
    public String index13() {
    	return "freeBoard";
    }
    @RequestMapping(value="/personalInfoPage") //회원 정보 확인
    public String index14() {
    	return "personalInfoPage";
    }
    
    @RequestMapping(value="/personalInfoChange") //회원 정보 수정
    public String index15() {
    	return "personalInfoChange";
    }
    
    @RequestMapping(value="/writepage") //회원 정보 수정
    public String index16() {
    	return "writepage";
    }
    
    @RequestMapping(value="/tmp") //테스트용
    public String index20() {
    	return "tmp";
    }
    
    @RequestMapping(value="/chat") //채팅
    public String index100() {
    	return "chatPage";
    }
    @RequestMapping(value="/screenShare") //화면공유
    public String index101() {
    	return "screenShare";
    }
    @RequestMapping(value="/testPage")//수업화면-멘토 다시 레이아웃 채팅 넣어봄
    public String index102() {
    	return "/studyPage/debugStudy_test";
    }
}
