package com.neobns.domain;

import lombok.Data;

@Data
public class ComCodeVO{
	private String com_code;
	private String master_com_code;
	private String code_nm;
	private String code_en_nm;
	private String creator_dt;
	private String modified_dt;
}