package Mento.Menti.Project.WebCompiler;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class WebCompiler {
	
	public String compile(String SRC, String input) { 
		/* 컴파일 실행 함수 */
		try {
		 	FileWriter fw = new FileWriter("C:/Temp/MentoMenti.py");
		 	fw.write(SRC);
		 	fw.flush();
		 	fw.close();
		 		
		 	/* 저장한 코드로 python 컴파일 및 결과를 BufferedReader로 가져옴 */
		 	List command = new ArrayList();
		 	command.add("python"); 
		 	command.add("C:/Temp/MentoMenti.py");
		 	
		 	ProcessBuilder processBuilder = new ProcessBuilder(command);
		 	Process process = processBuilder.start();
		 	
		 	/* 입력 값 받기 위한 writer 설정 */
		 	PrintWriter writer = new PrintWriter(process.getOutputStream());
		 	writer.write(input + "\n"); // 맨 마지막에 enter 눌른거 표시하기 위해 \n 추가
		 	writer.flush();
		 	
		 	BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
		 	String line;
		 	StringBuffer result = new StringBuffer();
		 	while ((line = br.readLine()) != null) {
		 		result.append(line);
		 		result.append("\n");
		 	}
		 	
		 	return result.toString().trim(); // 공백 모두 제거
		}
		catch (Exception e) {
			System.out.println("예기치 못한 에러가 발생했습니다.");
			return null;
		}
	}
	
}
