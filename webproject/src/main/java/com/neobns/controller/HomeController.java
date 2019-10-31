package com.neobns.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.neobns.domain.UserVO;
import com.neobns.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request) {
		logger.info("home");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user_id = auth.getName();
		logger.info(user_id + " ");
		
		try {
			if(!user_id.equals("anonymousUser")) {
				HttpSession httpSession = request.getSession();
				UserVO userVO = userService.getUserService(user_id);
				httpSession.setAttribute("loginUserVO", userVO);
				logger.info(userVO.toString());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "redirect:/article/list";
	}
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Model model, HttpServletRequest request) {
		logger.info("home");
		
		
		return "test";
	}
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public String check(Model model, HttpServletRequest request) {
		logger.info(request.getParameter("user_id"));
		
		
		return "test";
	}
	
}
