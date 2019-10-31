package com.neobns.controller;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.neobns.domain.PageMakerVO;
import com.neobns.domain.SearchUserVO;
import com.neobns.domain.UserVO;
import com.neobns.service.AdminService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	@Autowired
	AdminService service;

	
	@RequestMapping(value="/manageUser", method=RequestMethod.GET)
	public void userList(PageMakerVO paging, SearchUserVO search ,Model model) {
		log.info("manageUser VIEW"  + paging.getCurPage() + " " );
		try {
			model.addAttribute("user_list", service.getUserList(search,paging));
			model.addAttribute("page", new PageMakerVO(paging.getCurPage(),paging.getCntPerPage(), service.getUserCnt(search, paging)));
			model.addAttribute("search", search);
			log.info("user_list");
			log.info(search.getListLink());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	@Secured("ROLE_ADMIN")
	@RequestMapping(value="/manageUser", method=RequestMethod.GET, params="change")
	public String changeUserState(PageMakerVO paging, SearchUserVO search, RedirectAttributes rttr, @RequestParam String user_seq, @RequestParam String user_use_state) throws UnsupportedEncodingException {
		log.info("user_seq : " + user_seq + "user_use_state : " + user_use_state);
		service.changeUserState(user_seq, user_use_state);
		
		rttr.addFlashAttribute("search", search);
		rttr.addFlashAttribute("paging", paging);
		String uri = new String(search.getListLink().getBytes("UTF-8"), "iso_8859_1");
		return "redirect:/admin/manageUser" +paging.getListLink()+"&"+uri.substring(1); 
	}
	
	//admin이 여러종류(ex ROLE_ADMIN, ROLE_MANAGER) @Secured({"ROLE_ADMIN", "ROLE_MANAGER"})
	@Secured("ROLE_ADMIN")
	@GetMapping("/searchUser")
	public String searchUser(PageMakerVO paging, UserVO user,Model model) throws Exception {
		//검색한 결과대로 가져오기
		log.info(user.getUser_id());
		log.info(user.getUser_gender());
		log.info(user.getUser_name());
		log.info(user.getUser_use_state());
		model.addAttribute("user_list",service.getSearchList(user,paging));
		
		return "/admin/manageUser";
	}

}
