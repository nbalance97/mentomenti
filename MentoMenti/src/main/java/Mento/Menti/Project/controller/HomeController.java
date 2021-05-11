package Mento.Menti.Project.controller;
 
import Mento.Menti.Project.controller.DAOConfiguration;

import java.io.File;
import java.util.StringTokenizer;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@PostConstruct
	private void initDao() {
		dao = temp;
	}

    @RequestMapping(value="/")
    public String index() {    
        return "loginPage";
    }
    
    @RequestMapping(value="/bh3")
    public String indexxx() {
    	return "BH_fileupload";
    }
    
    @PostMapping("/upload")
    public String fileUpload_example(@RequestParam("files") MultipartFile file) throws Exception {
    	String root = System.getProperty("user.dir"); // Project의 root directory
    	String uploadPath = "src/main/resources/uploaded";
    	String filePath = root + "/" + uploadPath + "/" + file.getOriginalFilename();
    	File dest = new File(filePath);
    	file.transferTo(dest);
    	
    	return "BH_fileupload";
    }
    
    @RequestMapping(value="/compiler")
    public String index2() throws Exception{
    	return "CompileTestView";
    }
    
    @RequestMapping(value="/BH")
    public String bhidx() throws Exception {
    	return "BH_screenshare";
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
    
    @RequestMapping(value="/main") //로그인 화면
    public String index7() {
    	return "main";
    }
    
    @RequestMapping(value="/practice")//실습화면-레이아웃 연습용
    public String index8() {
    	return "/studyPage/practicePage";
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
    	return "personalInfoPage";
    }
    
    @RequestMapping(value="/personalInfoChange") //회원 정보 수정 페이지
    public String index15() {
    	return "personalInfoChange";
    }
    
    @RequestMapping(value="/writepage") //게시물 작성 페이지
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
    
    @RequestMapping(value="/processLogout") //로그아웃 진행
    public String index23() {
    	return "/process/processLogout";
    }
    
    @RequestMapping(value="/processPersonalInfoChange") //회원 정보 수정 진행
    public String changePersonalInfo(@RequestParam("profileImg") MultipartFile img, @RequestParam("userid") String id) throws Exception {
    	if (!img.isEmpty()) {	//프로필 이미지를 새로 업로드 했을 때만 실행
	    	//업로드 경로
	    	String root = System.getProperty("user.dir");
	    	String uploadPath = "src/main/resources/static/img/user";
	    	
	    	//기존에 있던 프로필 이미지 삭제
	    	File existsPng = new File(root + "/" + uploadPath + "/" + id + ".png");
	    	File existsJpg = new File(root + "/" + uploadPath + "/" + id + ".jpg");
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
	    	String filePath = root + "/" + uploadPath + "/" + id + "." + extension.toLowerCase();
	    	
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
    public String index41() {
    	return "/notificationListPage";
    }
    
    @RequestMapping(value="/errorpage") //알림 목록 페이지
    public String index42() {
    	return "/errorpage";
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
    
    @RequestMapping(value="/board")//화이트보드
    public String index104() {
    	return "/whiteBoard2";
    }
    
    @RequestMapping(value="/confirmId")//아이디 중복체크
    public String index105() {
    	return "/process/confirmId";
    }
    @RequestMapping(value="/activity")//나의 활동 = 내댓글, 게시글,,,
    public String index91() {
    	return "/myActivity";
    }
    
    @RequestMapping(value="/bh2")
    public String index93() {
    	return "/BH_whiteboard";
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
    
    @RequestMapping(value="/caro")//메인  - 자동화
    public String index97() {
    	return "/mainCaro";
    }
}