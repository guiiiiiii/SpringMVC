package com.neobns.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.neobns.domain.UserVO;
import com.neobns.service.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginSuccessHandlerImpl implements AuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

	@Autowired
	UserService service;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {

		String user_id = auth.getName();

		try {
			if (!user_id.equals("anonymousUser")) {
				HttpSession httpSession = request.getSession();
				UserVO userVO = service.getUserService(user_id);
				httpSession.setAttribute("loginUserVO", userVO);
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		resultRedirectStrategy(request, response, auth);

	}

	protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		SavedRequest savedRequest = requestCache.getRequest(request, response);

		List<String> roleNames = new ArrayList<>();

		authentication.getAuthorities().forEach(authority -> {

			roleNames.add(authority.getAuthority());

		});

		if (savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStratgy.sendRedirect(request, response, targetUrl);
			
		} else {
			if (roleNames.contains("ROLE_ADMIN")) {
				redirectStratgy.sendRedirect(request, response, "/admin/manageUser");
			}
			else {
				redirectStratgy.sendRedirect(request, response, "/");
			}

		}

	}

}