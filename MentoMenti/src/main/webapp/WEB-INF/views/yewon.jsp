<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en"><head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MOCO</title>

    <!-- Custom fonts for this template-->
    <link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="menuPart1.jsp" %>


                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">공지사항</h1>
                    <p class="mb-4">모두의 코딩교실의 공지사항입니다.</p>
					
					<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; background:white">
                                    <thead>
                                        <tr role="row"><th tabindex="0" rowspan="1" colspan="1" style="width: 100px;">공지 번호</th><th tabindex="0" rowspan="1" colspan="1" style="width: 61px;">제목</th><th tabindex="0" rowspan="1" colspan="1" style="width: 49px;">작성자</th><th tabindex="0" rowspan="1" colspan="1" style="width: 31px;">조회수</th></tr>
                                    </thead>
                                    <tbody>
                                    	<tr role="row" class="odd">
                                            <td class="">2</td>
                                            <td>모코 이용방법</td>
                                            <td>정예원</td>
                                            <td>128</td>
                                        </tr>
                                        <tr role="row" class="odd">
                                            <td class="">1</td>
                                            <td>모코 사이트 소개</td>
                                            <td>정예원</td>
                                            <td>61</td>
                                        </tr>
                                   	</tbody>
                                </table>
                        </div>
                    </div>


<%@include file="menuPart2.jsp"%>