# MOCO(모코 : 모두의 코딩교실) 웹 사이트
2021-1 경기대학교 캡스톤디자인 프로젝트

<h2> 프로젝트 개요 </h2>

- 코딩 멘토-멘티 스터디 통합 플랫폼 제작
- 스터디 그룹 개설과 가입, 그룹 별 커뮤니티 및 관리 기능 제공
- 음성 공유, 채팅, 화면 공유, 웹 컴파일러, 화이트보드 등 실시간 수업 진행을 위한 기능 제공

<h2> 개발 환경 </h2>

- Eclipse IDE에서 개발 진행
- Spring Boot 기반 JSP 프로젝트
- HTML, CSS, Javascript, jQuery 등 사용
- WebRTC 프레임워크 활용
- Github을 이용한 형상 관리

<h2> 서버 환경 </h2>

- Naver Cloud Platform
- Ubuntu 18.04
- Docker 컨테이너
- MySQL 데이터베이스
- coturn 서버
<div align="center">
  <img src="https://user-images.githubusercontent.com/75527311/134560252-d0c0263b-0b9a-4651-bfcb-aeefc24a57f4.png" width="700"/>
</div>
  
<h2> 개발 로그 </h2>

- JSP, CSS, Javascript를 활용하여 전체 페이지 구성
- Bootstrap 템플릿을 응용하여 PC, 모바일 반응형 웹 지원
- WebRTC를 활용하여 PeerConnection 연결 / 마이크 공유 / 화면 공유 구현
- Docker 컨테이너 구성하여 Docker 컨테이너 내에서 웹 컴파일러 동작하도록 구현
- 웹 컴파일러 Ajax 활용하여 비동기 구현
- 화면 공유 시 필요에 의해 도메인 / 인증서 받음 (certbot)
- WebSocket 데이터 전송을 활용한 화이트보드 구현 

<h2>프로젝트 결과물</h2>

### 회원가입 및 로그인
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123451228-7e369e80-d618-11eb-9465-b585f7d05815.png"/>
  <p>사용자 정보를 입력하여 회원가입 진행, 각 입력값의 유효성 검사를 거침</p>
  <img src="https://user-images.githubusercontent.com/76891875/123451199-77a82700-d618-11eb-8869-9964d5427bc4.png"/>
  <p>아이디, 비밀번호를 입력하여 로그인 진행</p>
</div>

### 메인 화면
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123451709-b807a500-d618-11eb-9e80-4b5bd2c4a143.png"/>
  <img src="https://user-images.githubusercontent.com/76891875/123451763-c3f36700-d618-11eb-85ce-535846aaa66f.png"/>
  <p>슬라이드를 이용하여 웹 사이트 소개, 제공하는 기능 설명</p>
</div>

### 가이드 페이지

<div align="center">
  <img src="https://user-images.githubusercontent.com/75527311/134555797-b0caeb6d-79b3-4b02-a09d-ee767d4b4b77.png" width="500"/>
  <p>사용자에게 웹 사이트의 이용 방법 등 자세한 설명을 제공하는 페이지</p>
</div>

### 공지사항, 자유게시판
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123451832-d2da1980-d618-11eb-800b-5e9725727b2d.png"/>
  <img src="https://user-images.githubusercontent.com/76891875/123451839-d4a3dd00-d618-11eb-90c5-390457ca2e43.png"/>
  <p>관리자만 작성할 수 있는 공지사항과 모든 사용자가 이용할 수 있는 자유게시판</p><br>
  <img src="https://user-images.githubusercontent.com/75527311/134556102-171bdad0-af0d-405e-9a86-96af020bde4b.png" width="500"/>
  <p>게시글 내용 확인 및 댓글 작성 가능</p>
</div>

### 그룹 관련 페이지
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123451909-e38a8f80-d618-11eb-81d5-f9e3c69c20fa.png"/>
  <p>개설된 그룹 목록 확인 페이지, 분류 별 그룹 확인 또는 검색 기능 이용 가능</p>
  
  <img src="https://user-images.githubusercontent.com/76891875/123451919-e5545300-d618-11eb-947f-2d502e2d80cb.png"/>
  <p>사용자가 직접 그룹을 개설하여 멤버를 모집할 수 있음</p>
  
  <img src="https://user-images.githubusercontent.com/76891875/123451973-ef765180-d618-11eb-9133-1e91eef5a63b.png" width="500"/>
  <p>그룹 별 스터디 과목과 인원 수를 확인하고 그룹에 가입하기</p>
  <br>
  
  <img src="https://user-images.githubusercontent.com/76891875/123452142-1765b500-d619-11eb-9e62-1b2e3ce88735.png" width="500"/>
  <p>사용자가 개설한 / 가입한 그룹 목록 확인</p>
  
  <img src="https://user-images.githubusercontent.com/76891875/123452157-1a60a580-d619-11eb-8533-232f4363e40e.png"/>
  <p>각 그룹 전용 페이지, 가입 멤버 확인과 게시판 기능 이용 가능</p>
  
  <img src="https://user-images.githubusercontent.com/76891875/123452162-1c2a6900-d619-11eb-8e6d-e0b3c04e1e89.png"/>
  <p>멘토는 멤버 강퇴, 그룹 소개글 수정, 그룹 해체 기능으로 그룹 관리 가능</p>
</div>

### 수업 페이지
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123452289-3a906480-d619-11eb-862a-4066b5c95c6b.png"/>
  <p>현재 수업에 참여 중인 멤버 확인 및 채팅 기능</p>
  
  <img src="https://user-images.githubusercontent.com/76891875/123452335-47ad5380-d619-11eb-9fcf-2bdde189a905.png"/>
  <img src="https://user-images.githubusercontent.com/76891875/123452351-4bd97100-d619-11eb-94b6-133c4cafbd33.png"/>
  <p>화면 공유 기능을 이용하여 멘토가 수업을 진행할 수 있음</p>
</div>

### 웹 컴파일러
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123452384-53991580-d619-11eb-83c9-3d68d6e1262e.png" width="500"/>
  <p>코딩 스터디를 위한 C, Java, Python 웹 컴파일러 기능 제공</p>
</div>

### 화이트보드
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123452427-5dbb1400-d619-11eb-93dd-2f9db6766fb5.png" width="500"/>
  <p>사진 첨부 및 멘토와 멘티가 동시에 필기할 수 있는 화이트보드 기능</p>
</div>

### 알림 기능
<div align="center">
  <img src="https://user-images.githubusercontent.com/76891875/123452172-1f255980-d619-11eb-9611-6cc14db334a6.png"/>
  <img src="https://user-images.githubusercontent.com/76891875/123452240-2ea4a280-d619-11eb-970d-cb4e6058cccc.png"/>
  <p>수업 시작, 그룹 공지사항 등록, 작성한 글에 추가된 댓글 알림 등 확인</p>
</div>


<h2> 시퀀스 다이어그램 </h2>

### 수업 진행
<div align="center">
  <img src="https://user-images.githubusercontent.com/75527311/134560730-2f0cb407-6f40-4b7a-83a5-0cde377687fd.png"/>
</div>

### 그룹
<div align="center">
  <img src="https://user-images.githubusercontent.com/75527311/134560778-c0ae506f-84c6-42f2-9514-72a91ccc2f7b.png"/>
</div>

### 게시판
<div align="center">
  <img src="https://user-images.githubusercontent.com/75527311/134560804-c7bd9b44-c6d3-4853-a5eb-c1c4c7f4590f.png"/>
</div>

