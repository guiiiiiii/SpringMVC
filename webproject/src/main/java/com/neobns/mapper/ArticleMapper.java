package com.neobns.mapper;

import java.util.List;
import java.util.Map;

import com.neobns.domain.ArticleVO;
import com.neobns.domain.ComCodeVO;

public interface ArticleMapper{
	
	public void insert(ArticleVO article);
	
	public void insertSelectKey(ArticleVO article);
	
	//�� ��ȸ
	public ArticleVO detail(Long atc_seq);
	
	public int delete(Long atc_seq);
	
	public int update(ArticleVO article);
	
	public void updateCnt(Long atc_seq);
	
	public List<ComCodeVO> getArticleType();
	
	public String getWriter(Long atc_seq);
	
	public List<ArticleVO> getSearch(Map<String, Object> map);
	
	public int getSearchCnt(Map<String, Object> map);
}