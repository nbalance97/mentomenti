<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.FileWriter, java.io.Reader" %>
<%@ page import="java.io.InputStream, java.io.InputStreamReader, java.io.BufferedReader" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		request.setCharacterEncoding("UTF-8");
 		response.setCharacterEncoding("UTF-8"); 
 		
 		String Code = request.getParameter("CodeText");
 		System.out.println(Code);
 		
 		FileWriter fw = new FileWriter("C:/Temp/MentoMenti.py");
 		fw.write(Code);
 		fw.flush();
 		fw.close();
 		
 		String cmd = "python C:/Temp/MentoMenti.py";
 		Process process = Runtime.getRuntime().exec(cmd);
 		BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
 		String line;
 		StringBuffer result = new StringBuffer();
 		while ((line = br.readLine()) != null) {
 			result.append(line);
 			result.append("<br>");
 		}
 		
 		out.println(result);
 	%>
 	
 	
</body>
</html>