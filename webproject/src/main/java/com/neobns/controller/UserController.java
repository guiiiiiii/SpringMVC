package com.neobns.controller;

import java.io.UnsupportedEncodingException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.neobns.domain.UserVO;
import com.neobns.service.UserService;

@RequestMapping(value="/user/*")
@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@PreAuthorize("!isAuthenticated()")
	@GetMapping("/login")
	public void login() {
		logger.info("login Form");
		
	}
	
	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public String accessDenied(Locale locale, Model model) {
		logger.info("Welcome Access Denied!");
		
		return "user/accessDenied";
	}

	@PreAuthorize("!isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		logger.info("register Form");
		
	}
	
	@PreAuthorize("!isAuthenticated()")
	@PostMapping("/register")
	public String register(UserVO regUserVO, HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		logger.info("register ");
		try {
			if(userService.checkIdService(regUserVO.getUser_id()) == 0) {
				logger.info("0");
				userService.registerService(regUserVO);
				model.addAttribute("adduser","");
			} else {
				logger.info("1");
				model.addAttribute("regUserVO", regUserVO);
				return "user/register";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info(regUserVO.toString());

		return "redirect:/user/login";
	}

	
	@GetMapping("/modify")
	public void modify(HttpServletRequest request, HttpSession session, Model model) {
		logger.info("modify Form");
		session = request.getSession();
		UserVO loginUserVO = (UserVO) session.getAttribute("loginUserVO");
		logger.info(loginUserVO.toString());
	}
	
	@PostMapping("/modify")
	public String modify(UserVO modifyUserVO, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		logger.info("modify");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		HttpSession session = request.getSession();
		UserVO loginUserVO = (UserVO) session.getAttribute("loginUserVO");
		String current_pw = request.getParameter("cur_user_pw");
		
		try {
			if(userService.modifyService(loginUserVO, modifyUserVO, current_pw)) {
				new SecurityContextLogoutHandler().logout(request, response, auth);
				return "redirect:/";
			} else {
				return "redirect:/user/modify?error";
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			logger.warn("MODIFY FAIL");
			return "redirect:/modify";
		}
	}
	

	
}
