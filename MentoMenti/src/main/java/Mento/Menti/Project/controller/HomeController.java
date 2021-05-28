package Mento.Menti.Project.controller;
 
import Mento.Menti.Project.WebCompiler.WebCompiler;
import Mento.Menti.Project.controller.DAOConfiguration;

import java.io.File;
import java.util.StringTokenizer;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


@Controller
public class HomeController {
	public static DAOConfiguration dao; // 실제로 사용하는 static 저장소

	@Autowired
	private DAOConfiguration temp;
	
	@Autowired
	ServletContext servletContext;
	
	@PostConstruct
	private void initDao() {
		dao = temp;
	}

    @RequestMapping(value="/")
    public String index() {    
        return "main";
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
    
    @RequestMapping(value="/main") //메인
    public String index7() {
    	return "main";
    }
    
    @RequestMapping(value="/signup")//회원가입
    public String index9() {
    	return "/signUpPage";
    }
    @RequestMapping(value="/processSignUp") //회원가입
    public String index10() {
    	return "/process/processSignUp";
    }
    
    @RequestMapping(value="/practiceMento")//실습화면-현재쓰는거
    public String index11() {
    	return "/studyPage/practiceMento";
    }
    
    @RequestMapping(value="/personalInfoPage") //회원 정보 확인 페이지
    public String index14() {
    	return "/myPage/personalInfoPage";
    }
    
    @RequestMapping(value="/personalInfoChkPw") //회원 정보 수정 페이지 전 비밀번호 체크 페이지
    public String chkPwPage() {
    	return "/myPage/personalInfoChkPw";
    }
    
    @RequestMapping(value="/processChkPw") //비밀번호 체크 진행
    public String processChkPw() {
    	return "/process/processChkPw";
    }
    
    @RequestMapping(value="/personalInfoChange") //회원 정보 수정 페이지
    public String index15() {
    	return "/myPage/personalInfoChange";
    }
    
    @RequestMapping(value="/writepage") //게시물 작성 페이지
    public String index16() {
    	return "writepage";
    }
    
    @RequestMapping(value="/processLogin") //로그인 진행
    public String index21() {
    	return "/process/processLogin";
    }
    
    @RequestMapping(value="/processLogout") //로그아웃 진행
    public String index23() {
    	return "/process/processLogout";
    }
    
    @RequestMapping(value="/processPersonalInfoChange") //회원 정보 수정 진행
    public String changePersonalInfo(@RequestParam("profileImg") MultipartFile img, @RequestParam("userid") String id) throws Exception {
    	if (!img.isEmpty()) {
	    	//업로드 경로
	    	//String root = System.getProperty("user.dir");
	    	
	    	String uploadPath = "/root/user";

	    	//String uploadPath = "src/main/resources/static/img/user";
	    	//File existsPng = new File(root + "/" + uploadPath + "/" + id + ".png");
	    	//File existsJpg = new File(root + "/" + uploadPath + "/" + id + ".jpg");
	    	
	    	//기존에 있던 프로필 이미지 삭제
	    	File existsPng = new File(uploadPath + "/" + id + ".png");	//원래 "\\"대신 "/" 였는데 수정해봄
	    	File existsJpg = new File(uploadPath + "/" + id + ".jpg");
	    	if(existsPng.exists()) {
	    		existsPng.delete();
	    	}
	    	if (existsJpg.exists()) {
	    		existsJpg.delete();
	    	}

	    	//업로드 이미지 확장자
	    	StringTokenizer st = new StringTokenizer(img.getOriginalFilename(), ".");
	    	String extension = null;
	    	while(st.hasMoreTokens())
	    		extension = st.nextToken();
	    	//String filePath = root + "/" + uploadPath + "/" + id + "." + extension.toLowerCase();
	    	String filePath = uploadPath + "/" + id + "." + extension.toLowerCase();
	    	System.out.println(filePath);

	    	//이미지 파일 저장
	    	File dest = new File(filePath);
	    	img.transferTo(dest);
    	}
    	return "/process/processPersonalInfoChange";
    }
    
    @RequestMapping(value="/rejectedAccess") //접근 권한 없음 알림 페이지
    public String index40() {
    	return "/process/rejectedAccess";
    }
    
    @RequestMapping(value="/notifications") //알림 목록 페이지
    public String notificationList() {
    	return "/notificationListPage";
    }
    
    @RequestMapping(value="/processDeleteNotification") //알림 삭제 진행
    public String deleteNotification() {
    	return "/process/processDeleteNotification";
    }
    
    
    
    /*공지사항, 자유게시판 관련 페이지*/
    @RequestMapping(value="/notice") //공지사항
    public String noticeList() {
    	return "/post/notice";
    }
    
    @RequestMapping(value="/writeNoticePage") //공지사항 작성 페이지
    public String writeNoticePage() {
    	return "/post/writeNoticePage";
    }
    
    @RequestMapping(value="/noticeContent") //공지사항 내용 페이지
    public String noticeContent() {
    	return "/post/noticeContent";
    }
    
    @RequestMapping(value="/freeBoard") //자유게시판
    public String freeBoard() {
    	return "/post/freeBoard";
    }
    
    @RequestMapping(value="/writePostPage") //자유게시판 게시물 작성 페이지
    public String writePostPage() {
    	return "/post/writePostPage";
    }
    
    @RequestMapping(value="/postContent") //자유게시판 게시물 내용 페이지
    public String postContent() {
    	return "/post/postContent";
    }
    
    @RequestMapping(value="/modifyPostPage") //게시물 수정 페이지
    public String modifyPostPage() {
    	return "/post/modifyPostPage";
    }
    
    
    /*게시물 관련 process*/
    @RequestMapping(value="/processWriteNotice") //공지사항 작성 진행
    public String processWriteNotice() {
    	return "/process/processWriteNotice";
    }
    
    @RequestMapping(value="/processWritePost") //자유게시판 게시물 작성 진행
    public String processWritePost() {
    	return "/process/processWritePost";
    }
    
    @RequestMapping(value="/processAddComment") //댓글 등록 진행
    public String processAddComment() {
    	return "/process/processAddComment";
    }
    
    @RequestMapping(value="/processDeleteComment") //댓글 삭제 진행
    public String processDeleteComment() {
    	return "/process/processDeleteComment";
    }
    
    @RequestMapping(value="/processDeletePost") //게시물 삭제 진행
    public String processDeletePost() {
    	return "/process/processDeletePost";
    }
    
    @RequestMapping(value="/processModifyPost") //게시물 수정 진행
    public String processModifyPost() {
    	return "/process/processModifyPost";
    }

    
    /*그룹 관련 페이지*/
    @RequestMapping(value="/openedGroups") //개설된 그룹
    public String openedGroups() {
    	return "/group/openedGroups";
    }
    
    @RequestMapping(value="/createGroupPage") //그룹 개설 페이지
    public String createGroupPage() {
    	return "/group/createGroupPage";
    }
    
    @RequestMapping(value="/processCreateGroup") //그룹 개설 진행
    public String creatingGroup() {
    	return "/process/processCreateGroup";
    }
    
    @RequestMapping(value="/processJoinGroup") //그룹 가입 진행
    public String processJoinGroup() {
    	return "/process/processJoinGroup";
    }
    
    @RequestMapping(value="/joininggroups") //가입한 그룹 목록 페이지
    public String joiningGroups() {
    	return "/group/joininggroups";
    	//return "/group/newjoingroup";	//페이지 수정 완료 후 반영할 예정
    }
    
    @RequestMapping(value="/group") //그룹 별 페이지
    public String grouppage() {
    	return "/group/grouppage";
    }
    
    @RequestMapping(value="/processDeleteGroup") //그룹 해체 진행
    public String deleteGroup() {
    	return "/process/processDeleteGroup";
    }
    
    @RequestMapping(value="/processLeaveGroup") //그룹 탈퇴 진행
    public String processLeaveGroup() {
    	return "/process/processLeaveGroup";
    }
    
    @RequestMapping(value="/groupnotice") //그룹 내 공지사항
    public String groupNotice() {
    	return "/group/groupnotice";
    }
    
    @RequestMapping(value="/groupNoticeContent")	//그룹 공지사항 내용 페이지
    public String groupNoticeContent() {
    	return "/group/groupNoticeContent";
    } 
    
    @RequestMapping(value="/writeGroupNoticePage")	//그룹 공지사항 작성 페이지
    public String writeGroupNoticePage() {
    	return "/group/writeGroupNoticePage";
    }
    
    @RequestMapping(value="/groupQnA") // 그룹 QnA 목록 페이지
    public String groupQnAList() {
    	return "/group/groupQnA";
    }
    
    @RequestMapping(value="/groupPostContent")	//그룹 Q&A 게시물 내용 페이지
    public String groupQnAContent() {
    	return "/group/groupPostContent";
    } 
   
    @RequestMapping(value="/writeGroupPostPage")	//그룹 Q&A 작성 페이지
    public String writeGroupQnAPage() {
    	return "/group/writeGroupPostPage";
    }
       
    @RequestMapping(value="/modifyGroupPostPage")	//그룹 게시물 수정 페이지
    public String modifyGroupPostPage() {
    	return "/group/modifyGroupPostPage";
    }  
    
    @RequestMapping(value="/groupManage")	//그룹 관리 페이지
    public String groupManagePage() {
    	return "/group/groupManagePage";
    }
   
    @RequestMapping(value="/processWithdraw")	//그룹 멤버 강퇴 페이지
    public String groupWithdraw() {
    	return "/process/processWithdraw";
    }
    
    @RequestMapping(value="/processModifyGroup")	//그룹 정보 수정 진행
    public String groupModify() {
    	return "/process/processModifyGroup";
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
    
    @RequestMapping(value="/board")//화이트보드
    public String index104() {
    	return "/whiteBoard2";
    }
    
    @RequestMapping(value="/confirmId")//아이디 중복체크
    public String index105() {
    	return "/process/confirmId";
    }
    
    @RequestMapping(value="/activity") //나의 활동 (작성한 게시물, 댓글 목록)
    public String index91() {
    	return "/myPage/myActivity";
    }
    
    @RequestMapping(value="/canvas")
    public String index94() {
    	return "/studyPage/canvas";
    }
    
    @RequestMapping(value="/confirmNick")//닉네임 중복체크
    public String index95() {
    	return "/process/confirmNick";
    }
    @RequestMapping(value="/confirmNick_ch")//닉네임 중복체크-개인정보변경
    public String index96() {
    	return "/process/confirmNick_ch";
    }
    
    @RequestMapping(value="/adminPage") //관리자 메인 = 관리자 사용자 페이지
    public String adminMainPage() {
    	return "/admin/adminUserPage";
    }
    
    @RequestMapping(value="/adminUserPage") //관리자 사용자 페이지
    public String adminUserPage() {
    	return "/admin/adminUserPage";
    }
    
    @RequestMapping(value="/adminPostPage") //관리자 게시물 페이지
    public String adminPostPage() {
    	return "/admin/adminPostPage";
    }
    
    @RequestMapping(value="/adminCommentPage") //관리자 댓글 페이지
    public String adminCommentPage() {
    	return "/admin/adminCommentPage";
    }
    
    @RequestMapping(value="/adminGroupPage") //관리자 그룹 페이지
    public String adminGroupPage() {
    	return "/admin/adminGroupPage";
    }
    
    @RequestMapping(value="/pwsearch") //비번찾기 페이지
    public String index98() {
    	return "/pwSearchPage";
    }
    
    @RequestMapping(value="/processPwsearch") //비번찾기 프로세스
    public String index99() {
    	return "/process/processPwsearch";
    }
    @RequestMapping(value="/confirmPw") //비번찾기 팝업
    public String index111() {
    	return "/process/confirmPw";
    }
    
    @RequestMapping(value="/processDeleteUser") //사용자 사이트 탈퇴
    public String deleteUser() {
    	return "/process/processDeleteUser";
    }
    @RequestMapping(value="/explain") //모코 설명 페이지
    public String index113() {
    	return "/mocoExplain";
    }
    @RequestMapping(value="/test") //메인연습페이지
    public String index114() {
    	return "/main2";
    }
    @RequestMapping(value="/compiler") //컴파일러팝업
    public String index200() {
    	return "studyPage/compiler";
    }
}