package com.neobns.mapper;

import com.neobns.domain.UserVO;

public interface UserMapper {
	
	UserVO getUser(String user_id) throws Exception;
	
	void insertUser(UserVO regUserVO) throws Exception;
	
	void updateUser(UserVO modifyVO) throws Exception;

	int checkUserID(String user_id)	throws Exception;
	
	/*
	int loginCheck(UserVO loginUserVO) throws Exception;
	
	
	UserVO select() throws Exception;
	*/
}
