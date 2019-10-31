package com.neobns.domain;

import lombok.Data;

@Data
public class UserVO {
	private String user_seq;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_gender;
	private String user_reg_dt;
	private String user_use_state;
	private String user_authority;


}
