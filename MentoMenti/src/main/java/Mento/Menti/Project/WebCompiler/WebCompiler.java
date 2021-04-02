package Mento.Menti.Project.WebCompiler;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class WebCompiler {
	
	public StringBuffer compile(String SRC) { 
		/* 컴파일 실행 함수 */
		try {
		 	FileWriter fw = new FileWriter("C:/Temp/MentoMenti.py");
		 	fw.write(SRC);
		 	fw.flush();
		 	fw.close();
		 		
		 	/* 저장한 코드로 python 컴파일 및 결과를 BufferedReader로 가져옴 */
		 	List cmd = new ArrayList();
		 	cmd.add("python"); 
		 	cmd.add("C:/Temp/MentoMenti.py");
		 	
		 	ProcessBuilder processBuilder = new ProcessBuilder(cmd);
		 	Process process = processBuilder.start();
		 	BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
		 	String line;
		 	StringBuffer result = new StringBuffer();
		 	while ((line = br.readLine()) != null) {
		 		result.append(line);
		 		result.append("\n");
		 	}

		 	return result;
		}
		catch (Exception e) {
			System.out.println("예기치 못한 에러가 발생했습니다.");
			return null;
		}
	}
	
}
