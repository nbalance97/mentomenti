package Mento.Menti.Project.WebCompiler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

public class WebCompiler {
	public static WebCompiler instance = null;
	
	public static WebCompiler getInstance() {
		if (instance == null)
			instance = new WebCompiler();
		return instance;
	}

	public String compileC(String SRC, String input) {
		/* C언어 컴파일 실행 함수 */
		try {
			setFile("C", SRC);
			/* 컴파일 파트 */
		 	ArrayList<String> command = setCommand("C");
		 	executeCMD(command, null);
		 	
		 	/* 실행 파트 */
		 	command.clear();
		 	command.add("c:/Temp/MentoMenti.exe");
		 	String temp = executeCMD(command, input);
		 	File f = new File("C:/Temp/MentoMenti.exe"); // 파일 삭제
		 	f.delete();
		 	
		 	return temp;
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String compilePython(String SRC, String input) { 
		/* 파이썬 컴파일 실행 함수 */
		try {
			/* 파이썬 같은 경우는 인터프리터라서 컴파일->실행 필요 X */
			setFile("python", SRC);
		 	ArrayList<String> command = setCommand("python");
		 	return executeCMD(command, input);
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String compileJava(String SRC, String input) {
		try {
			setFile("java", SRC);
			ArrayList<String> command = setCommand("java");
			executeCMD(command, null);
			
			command.clear();
			command.add("java");
			command.add("MentoMenti");
			return executeCMD(command, input);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<String> setCommand(String mode) { 
		ArrayList<String> cmd = new ArrayList<String>();
		if (mode.contentEquals("python")){
		 	cmd.add("python"); 
		 	cmd.add("C:/Temp/MentoMenti.py");
		} else if (mode.contentEquals("C")) {
			cmd.add("gcc");
			cmd.add("-o");
			cmd.add("C:/Temp/MentoMenti.exe");
			cmd.add("C:/Temp/MentoMenti.c"); 
		} else if (mode.contentEquals("java")) {
			cmd.add("javac");
			cmd.add("C:/Temp/MentoMenti.java");
			cmd.add("--release");
			cmd.add("8");
		}
		return cmd;
	}
	
	public void setFile(String mode, String SRC) throws Exception {
		/* 컴파일러에 맞추어서 파일 저장 */
		FileWriter fw = null;
		if (mode.contentEquals("python")) {
		 	fw = new FileWriter("C:/Temp/MentoMenti.py");
		 	fw.write(SRC);
		} else if (mode.contentEquals("C")) {
		 	fw = new FileWriter("C:/Temp/MentoMenti.c");
		 	fw.write(SRC);
		} else if (mode.contentEquals("java")) {
		 	fw = new FileWriter("C:/Temp/MentoMenti.java");
		 	fw.write(SRC);
		}
		
		if (fw != null) {
		 	fw.flush();
		 	fw.close();
		}
	}
	
	
	public String executeCMD(ArrayList<String> cmd, String input) throws Exception {
		System.out.println(cmd);
		ProcessBuilder processbuilder = new ProcessBuilder(cmd);
		processbuilder = processbuilder.directory(new File("c:/Temp"));
		Process process = processbuilder.start();
	 	
	 	/* 입력 값 받고 적용하기 위한 writer 설정 */
		if (input != null) {
		 	PrintWriter writer = new PrintWriter(process.getOutputStream());
		 	writer.write(input + "\n"); // 맨 마지막에 enter 눌른거 표시하기 위해 \n 추가
		 	writer.flush();
		}
	 	
	 	/* 실행 결과 가져오는 파트 */
	 	BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
	 	String line;
	 	StringBuffer result = new StringBuffer();
	 	while ((line = br.readLine()) != null) {
	 		result.append(line);
	 		result.append("\n");
	 	}
	 	
	 	process.waitFor();
	 	return result.toString().trim(); // 공백 모두 제거한 실행결과 반환
	}
	
}
