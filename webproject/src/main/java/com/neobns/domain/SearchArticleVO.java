package com.neobns.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class SearchArticleVO{
	private String s_atc_type;
	private String s_atc_title;
	private String s_atc_writer;
	private String s_start_dt;
	private String s_finish_dt;
	
	public String getListLink() {
		UriComponentsBuilder builder= UriComponentsBuilder.fromPath("")
				.queryParam("s_atc_type", this.getS_atc_type())
				.queryParam("s_atc_title", this.getS_atc_title())
				.queryParam("s_atc_writer", this.getS_atc_writer())
				.queryParam("s_start_dt", this.getS_start_dt())
				.queryParam("s_finish_dt", this.getS_finish_dt());
		
		return builder.toUriString();
	}
}