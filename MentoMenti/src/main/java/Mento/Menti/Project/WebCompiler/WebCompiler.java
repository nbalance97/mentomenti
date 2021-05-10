package Mento.Menti.Project.WebCompiler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

public class WebCompiler {
	public static WebCompiler instance = null;
	public String shared_document = "/docshare";
	// local에서 컴파일할때는 c:/Temp로 수정하면 됨.
	
	public boolean[] docker_status = {false, false, false};
	
	public static WebCompiler getInstance() {
		if (instance == null)
			instance = new WebCompiler();
		return instance;
	}
	
	public String getJavaDefault() {
		String java_default = 
				"public class MentoMenti {\n\t"+
				"public static void main(String args[]) {\n\n\t"+
		    	"}\n"+
				"}";
		return java_default;
	}
	
	public String getDockerName(int idx) {
		if (idx == 0)
			return "mmenti1";
		if (idx == 1)
			return "mmenti2";
		if (idx == 2)
			return "mmenti3";
		return null;
	}
	
	public String compile(String SRC, String input, String mode) throws Exception {
		for (int i = 0; i<docker_status.length; i++) { // 현재 이용가능한 도커 검색
			if (docker_status[i] == false) {
				docker_status[i] = true;
				String docker_name = getDockerName(i); // 도커명 가져옴
				setFile(docker_name, mode, SRC);
				
				/* 컴파일 파트 */
			 	ArrayList<String> dockercmd = setCommand(docker_name, mode);
			 	executeCMD(dockercmd, docker_name, input);
			 	
			 	/* 가져오는 파트 */
			 	File result = new File(shared_document + "/" + docker_name + "/compileResult.txt"); 
			 	File err = new File(shared_document + "/" + docker_name + "/compileErr.txt");
			 	
			 	FileReader fr = new FileReader(result);
			 	FileReader errfr = new FileReader(err);
			 	StringBuffer temp = new StringBuffer("");
			 	StringBuffer errtemp = new StringBuffer("");
			 	int ch = 0;
			 	while ((ch = fr.read()) != -1)
			 		temp.append((char)ch);
			 	while ((ch = errfr.read()) != -1)
			 		errtemp.append((char)ch);
			 	
			 	docker_status[i] = false;
			 	
			 	if (errtemp.length() > 0) // 에러 존재시 에러 리턴
			 		return errtemp.toString();
			 	else
			 		return temp.toString();
			}
		}
		System.out.println("이용 가능한 도커가 없습니다.");
		return null; // 
	}
	
	public String compileC(String SRC, String input) {
		/* C언어 컴파일 실행 함수 */
		try {
			return compile(SRC, input, "C");
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String compilePython(String SRC, String input) { 
		/* 파이썬 컴파일 실행 함수 */
		try {
			return compile(SRC, input, "python");
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String compileJava(String SRC, String input) {
		try {
			return compile(SRC, input, "java");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public ArrayList<String> setCommand(String docker, String mode) { 
		ArrayList<String> cmd = new ArrayList<String>();
		if (mode.contentEquals("python")){
		 	cmd.add("sh"); 
		 	cmd.add(shared_document + "/" + docker + "/compilePython.sh");
		} else if (mode.contentEquals("C")) {
			cmd.add("sh");
			cmd.add(shared_document + "/" + docker + "/compileC.sh");
		} else if (mode.contentEquals("java")) {
			cmd.add("sh");
			cmd.add(shared_document + "/" + docker + "/compileJava.sh");
		}
		return cmd;
	}
	
	public void setFile(String docker, String mode, String SRC) throws Exception {
		/* 컴파일러에 맞추어서 파일 저장 */
		FileWriter fw = null;

		if (mode.contentEquals("python")) {
		 	fw = new FileWriter(shared_document + "/" + docker + "/MentoMenti.py");
		 	fw.write(SRC);
		} else if (mode.contentEquals("C")) {
		 	fw = new FileWriter(shared_document + "/" + docker + "/MentoMenti.c");
		 	fw.write(SRC);
		} else if (mode.contentEquals("java")) {
		 	fw = new FileWriter(shared_document + "/" + docker + "/MentoMenti.java");
		 	fw.write(SRC);
		}
		
		if (fw != null) {
		 	fw.flush();
		 	fw.close();
		}
	}
	
	
	public boolean executeCMD(ArrayList<String> cmd, String docker, String input) throws Exception {
		ProcessBuilder processbuilder = new ProcessBuilder(cmd);
		
		/* input file creation */
	 	FileWriter fw = new FileWriter(shared_document + "/" + docker + "/input.txt");
	 	fw.write(input);
	 	fw.flush();
	 	fw.close();
	 	
		Process process = processbuilder.start();
	 	process.waitFor();
	 	return true;
	}
	
}
