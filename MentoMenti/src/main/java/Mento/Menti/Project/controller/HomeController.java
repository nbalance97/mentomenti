package Mento.Menti.Project.controller;
 
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import Mento.Menti.Project.dto.PostDTO;
import Mento.Menti.Project.dto.UserDTO;

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
    
    /*
    @RequestMapping(value="/insert")
    // select문, insert문 전용 테스트 함수
    public String insert() throws Exception {
    	UserDTO insUser = new UserDTO(null, null, null, null, null, null, null, false, null);
    	insUser.setEmail("a@naver.com");
     	List<UserDTO> temp = dao.getUserDAO().searchUser(insUser);
     	for (UserDTO u: temp)
     		System.out.println(u.getId() + "//" + u.getPw());
    	return "insert";
    }
    */
    /*  User 리스트중 첫번쨰 user의 데이터를 수정 후 insert
     *  List<UserDTO> temp = dao.getUserDAO().selectUsers();
    	UserDTO user = temp.get(0);
    	user.setId("user4"); 
    	dao.getUserDAO().insertUsers(user);
     */
    
    @RequestMapping(value="/compiler")
    public String index2() throws Exception{
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
    
    @RequestMapping(value="/processLogin") //로그인 진행
    public String index21() {
    	return "/process/processLogin";
    }
    
    @RequestMapping(value="/createGroupPage") //로그인 진행
    public String index22() {
    	return "createGroupPage";
    }
    
    @RequestMapping(value="/chat") //채팅
    public String index100() {
    	return "chatPage";
    }
    
    @RequestMapping(value="/chat2") //채팅2
    public String index1001() {
    	return "chat";
    }
    
    @RequestMapping(value="/screenShare") //화면공유
    public String index101() {
    	return "screenShare";
    }
    
    @RequestMapping(value="/audio") //목소리 공유
    public String index102() {
    	return "audio";
    }
    
    @RequestMapping(value="/testPage")//수업화면-멘토 다시 레이아웃 채팅 넣어봄
    public String index103() {
    	return "/studyPage/debugStudy_test";
    }
}
