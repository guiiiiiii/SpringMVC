package com.neobns.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.neobns.domain.PageMakerVO;
import com.neobns.domain.UserVO;

public interface AdminMapper {
	
	public List<UserVO> getUserList(Map<String, Object> map) throws Exception;
	
	public long getUserCnt(Map<String, Object> map) throws Exception;
	
	public void updateUserState(@Param("user_seq") String user_seq, @Param("user_use_state") String user_use_state) throws Exception;

	public List<UserVO> getSearchList(@Param("user") UserVO user,@Param("paging") PageMakerVO paging);
}
