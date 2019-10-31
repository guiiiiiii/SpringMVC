package com.neobns.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neobns.controller.UserController;
import com.neobns.domain.UserVO;
import com.neobns.mapper.UserMapper;

@Service
public class UserService {

	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	@Autowired
	UserMapper userMapper;

	@Autowired
	PasswordEncoder passwordEncoder;

	public UserVO getUserService(String user_id) throws Exception {
		return userMapper.getUser(user_id);
	}

	public int checkIdService(String user_id) throws Exception {
		return userMapper.checkUserID(user_id);
	}
	
	public void registerService(UserVO regUserVO) {
		String bcryptoPW = passwordEncoder.encode(regUserVO.getUser_pw());
		logger.info(regUserVO.getUser_pw());
		logger.info(bcryptoPW);
		regUserVO.setUser_pw(bcryptoPW);
		try {
			userMapper.insertUser(regUserVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean modifyService(UserVO loginUserVO, UserVO modifyUserVO, String current_pw) throws Exception {
		logger.info("modifyService()");
		logger.info(modifyUserVO.toString());
		String bcryptoPW =  passwordEncoder.encode(modifyUserVO.getUser_pw());
		
		if(passwordEncoder.matches(current_pw, loginUserVO.getUser_pw())) {
			logger.info("true");
			modifyUserVO.setUser_seq(loginUserVO.getUser_seq());
			modifyUserVO.setUser_pw(bcryptoPW);
			logger.info(modifyUserVO.toString());
			userMapper.updateUser(modifyUserVO);
			return true;
		} else {
			logger.info("false");
			return false;
			
		}
		
	}

}
