package com.neobns.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neobns.domain.PageMakerVO;
import com.neobns.domain.SearchUserVO;
import com.neobns.domain.UserVO;
import com.neobns.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminService {

	@Autowired
	private AdminMapper mapper;
	
	
	public List<UserVO> getUserList(SearchUserVO search, PageMakerVO paging) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search",search);
		map.put("paging", paging);
		
		return mapper.getUserList(map);
	}
	
	public long getUserCnt(SearchUserVO search, PageMakerVO paging) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search",search);
		map.put("paging", paging);
		return mapper.getUserCnt(map);
	}
	
	public boolean changeUserState(String user_seq, String user_use_state){
		try {
			if(user_use_state.equals("Y")) {
				user_use_state = "N";
			} else {
				user_use_state = "Y";
			}
			mapper.updateUserState(user_seq, user_use_state);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public List<UserVO> getSearchList(UserVO user, PageMakerVO paging){
		return mapper.getSearchList(user,paging);
	}
}
