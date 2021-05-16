package Mento.Menti.Project.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import Mento.Menti.Project.WebCompiler.WebCompiler;
import Mento.Menti.Project.dto.WebCompilerDTO;

@RestController
public class WC_Controller {
	
	@CrossOrigin("*")
    @RequestMapping(value="/WebCompile")
    public @ResponseBody String Compile(WebCompilerDTO data) {
    	WebCompiler WC = WebCompiler.getInstance();
    	System.out.println(data.toString());
    	String temp = "";
		if (data.getMode().equals("python")) {
			temp = WC.compilePython(data.getSrc(), data.getInput());
		} else if (data.getMode().equals("C")) {
			temp = WC.compileC(data.getSrc(), data.getInput());
		} else if (data.getMode().equals("java")) {
			temp = WC.compileJava(data.getSrc(), data.getInput());
		}
		
		return temp;
    }
}
