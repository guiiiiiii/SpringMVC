package com.neobns.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.neobns.domain.ArticleVO;
import com.neobns.domain.ComCodeVO;
import com.neobns.domain.PageMakerVO;
import com.neobns.domain.SearchArticleVO;
import com.neobns.mapper.ArticleMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ArticleService{
	
	private ArticleMapper mapper;
	
	public void write(ArticleVO article) {
		// TODO Auto-generated method stub
		log.info("서비스: 글 작성");
		mapper.insertSelectKey(article);
	}

	public ArticleVO detail(Long atc_seq) {
		log.info("서비스: 글 정보를 읽어옵니다");
		return mapper.detail(atc_seq);
	}

	public boolean modify(ArticleVO article) {
		log.info("서비스: 게시글을 수정합니다");
		return mapper.update(article)==1;
	}

	public boolean delete(Long atc_seq) {
		log.info("서비스: 글 삭제");
		return mapper.delete(atc_seq)==1;
	}


	public void updateCnt(Long atc_seq) {
		mapper.updateCnt(atc_seq);
		
	}

	public List<ComCodeVO> getArticleType() {
		log.info("게시판 종류 가져옵니다");
		return mapper.getArticleType();
	}

	public String getWriter(Long atc_seq) {
		return mapper.getWriter(atc_seq);
	}

	public List<ArticleVO> getSearchList(SearchArticleVO search,PageMakerVO paging) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search",search);
		map.put("paging", paging);
		
		return mapper.getSearch(map);
	}

	public int getSearchCnt(SearchArticleVO search, PageMakerVO paging) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search",search);
		map.put("paging", paging);
		
		return mapper.getSearchCnt(map);
	}

	
	
	
}