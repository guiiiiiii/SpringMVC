package com.neobns.domain;


import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class ArticleVO{
	private long atc_seq;
	@NotEmpty
	private String atc_type;
	@NotEmpty
	private String atc_title;
	@NotEmpty
	private String atc_content;
	private String atc_writer;
	private String atc_reg_dt;
	private long atc_hits;
	private char atc_hide_yn;
	private String file_name;
	private String file_path;
}