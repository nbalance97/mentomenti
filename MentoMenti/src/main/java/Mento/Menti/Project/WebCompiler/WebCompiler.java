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
	
	public String compileC(String SRC, String input) {
		/* 컴파일 실행 함수 */
		try {
			setFile("c", SRC);
		 	ArrayList<String> command = setCommand("c");
		 	return executeCMD(command, input);
		}
		catch (Exception e) {
			System.out.println("[C]예기치 못한 에러가 발생했습니다.");
			return null;
		}
	}
	
	public String compilePython(String SRC, String input) { 
		/* 컴파일 실행 함수 */
		try {
			setFile("python", SRC);
		 	ArrayList<String> command = setCommand("python");
		 	return executeCMD(command, input);
		}
		catch (Exception e) {
			System.out.println("[Python]예기치 못한 에러가 발생했습니다.");
			return null;
		}
	}
	
	public ArrayList<String> setCommand(String mode) { 
		ArrayList<String> cmd = new ArrayList<String>();
		if (mode.contentEquals("python")){
		 	cmd.add("python"); 
		 	cmd.add("C:/Temp/MentoMenti.py");
		} else if (mode.contentEquals("c")) {
			cmd.add("gcc");
			cmd.add("-o");
			cmd.add("C:/Temp/MentoMenti.exe");
			cmd.add("C:/Temp/MentoMenti.c"); // 여기까지 gcc 컴파일
			cmd.add("C:/Temp/MentoMenti.exe"); // 컴파일 결과 실행
		}
		
		return cmd;
	
	}
	
	public void setFile(String mode, String SRC) throws Exception {
		FileWriter fw = null;
		if (mode.contentEquals("python")) {
		 	fw = new FileWriter("C:/Temp/MentoMenti.py");
		 	fw.write(SRC);
		} else if (mode.contentEquals("c")) {
		 	fw = new FileWriter("C:/Temp/MentoMenti.c");
		 	fw.write(SRC);
		}
		
		if (fw != null) {
		 	fw.flush();
		 	fw.close();
		}
	}
	
	
	public String executeCMD(ArrayList<String> cmd, String input) throws Exception {
		ProcessBuilder processbuilder = new ProcessBuilder(cmd);
		Process process = processbuilder.start();
	 	
	 	/* 입력 값 받고 적용하기 위한 writer 설정 */
	 	PrintWriter writer = new PrintWriter(process.getOutputStream());
	 	writer.write(input + "\n"); // 맨 마지막에 enter 눌른거 표시하기 위해 \n 추가
	 	writer.flush();
	 	
	 	/* 실행 결과 가져오는 파트 */
	 	BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
	 	String line;
	 	StringBuffer result = new StringBuffer();
	 	while ((line = br.readLine()) != null) {
	 		result.append(line);
	 		result.append("\n");
	 	}
	 	
	 	return result.toString().trim(); // 공백 모두 제거한 실행결과 반환
	}
	
}
