package Mento.Menti.Project.controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
 
@Controller
public class HomeController {
    
    @RequestMapping(value="/")
    public String index() {
        
        return "home";
    }
    
    @RequestMapping(value="/compiler")
    public String index2() {
    	return "CompileTestView";
    }
    
}
