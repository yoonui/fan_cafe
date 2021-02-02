package com.Kwak.ChulBae;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {	
		return "home";
	}
	
	@RequestMapping(value = "/profile")
	public String profile() {	
		return "profile";
	}
	
	@RequestMapping(value = "/login")
	public String login() {	
		return "login";
	}
	
	@RequestMapping(value = "/bbs1")
	public String bbs1() {	
		return "bbs1";
	}
	@RequestMapping(value = "/bbs2")
	public String bbs2() {	
		return "bbs2";
	}
	@RequestMapping(value = "/bbs3")
	public String bbs3() {	
		return "bbs3";
	}
	@RequestMapping(value = "/bbs4")
	public String bbs4() {	
		return "bbs4";
	}
	@RequestMapping(value = "/bbs5")
	public String bbs5() {	
		return "bbs5";
	}
	@RequestMapping(value = "/bbs6")
	public String bbs6() {	
		return "bbs6";
	}
	
	@RequestMapping(value = "/join")
	public String join() {	
		return "join";
	}

	@RequestMapping(value = "/loginAction")
	public String loginAction() {	
		return "loginAction";
	}
	
	@RequestMapping(value = "/joinAction")
	public String joinAction() {	
		return "joinAction";
	}
	
	@RequestMapping(value = "/logoutAction")
	public String logoutAction() {	
		return "logoutAction";
	}
	
	@RequestMapping(value = "/mypage")
	public String mypage() {	
		return "mypage";
	}
	
	@RequestMapping(value = "/write")
	public String write() {	
		return "write";
	}
	
	@RequestMapping(value = "/writeAction")
	public String writeAction() {	
		return "writeAction";
	}
	
	@RequestMapping(value = "/view")
	public String view() {	
		return "view";
	}
	
	@RequestMapping(value = "/update")
	public String update() {	
		return "update";
	}
	
	@RequestMapping(value = "/updateAction")
	public String updateAction() {	
		return "updateAction";
	}
	
	@RequestMapping(value = "/deleteAction")
	public String deleteAction() {	
		return "deleteAction";
	}
	
	@RequestMapping(value = "/mypageAction")
	public String mypageAction() {	
		return "mypageAction";
	}
	
}

