package com.neobns.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.context.MessageSource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.neobns.domain.ArticleVO;
import com.neobns.domain.PageMakerVO;
import com.neobns.domain.SearchArticleVO;
import com.neobns.service.ArticleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/article/*")
@AllArgsConstructor
public class ArticleController {

	private ArticleService service;
	SessionLocaleResolver localeResolver;
	MessageSource messageSource;

	@GetMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public void write(PageMakerVO paging, Model model) {
		model.addAttribute("article_type", service.getArticleType());
		model.addAttribute("page", paging);
	}
	
	@GetMapping("/list")
		public void list(SearchArticleVO search, PageMakerVO paging, Model model) {
			log.info("상세검색");
			log.info(search.getS_atc_title());
			log.info(search.getS_atc_type());
			log.info(search.getS_atc_writer());
			log.info(search.getS_start_dt());
			log.info(search.getS_finish_dt());
			model.addAttribute("article_type", service.getArticleType());
			model.addAttribute("list", service.getSearchList(search,paging));
			int total = service.getSearchCnt(search, paging);
			model.addAttribute("page", new PageMakerVO(paging.getCurPage(),paging.getCntPerPage(), total));
			model.addAttribute("search", search);
			
			log.info(total);
			log.info(search.getListLink().substring(1));
			
		}
	

	@PostMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String write(@Valid ArticleVO article, BindingResult bindingResult, @RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		log.info("ArticleController-write()");
		
		if(bindingResult.hasErrors()) {
			log.error("타입 오류 발생...되돌아갑니다");
			rttr.addFlashAttribute("article_type", service.getArticleType());
			rttr.addFlashAttribute("result", "필수 입력 항목입니다");
			return "redirect:/article/write";
		}

		log.info("파일첨부중....");
		String uploadFolder = "C:\\upload\\temp";
		String path=getFolder();
		// 경로에 폴더 생성
		File uploadPath = new File(uploadFolder,path);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		log.info("File Name : " + file.getOriginalFilename());
		String uploadFileName = file.getOriginalFilename();
		// 경로를 뗀 파일명
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;

		File saveFile = new File(uploadPath, uploadFileName);

		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			log.error("파일 저장 오류" + e.getMessage());
		} finally {
			article.setFile_name(uploadFileName);
			article.setFile_path(path);
			service.write(article);
		}

		rttr.addFlashAttribute("result", article.getAtc_seq());
		return "redirect:/article/list";
	}


	@GetMapping("/detail")
	public void detail(@RequestParam("atc_seq") Long atc_seq, SearchArticleVO search, PageMakerVO paging, Model model) {
		log.info("ArticleController-detail or modify");
		// 본인이 읽을경우 증가 안하게
		service.updateCnt(atc_seq);
		model.addAttribute("article", service.detail(atc_seq));
		model.addAttribute("page", paging);
		model.addAttribute("search", search);
		
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@GetMapping("/modify")
	public String modify(@RequestParam("atc_seq") Long atc_seq, SearchArticleVO search, PageMakerVO paging, Model model) {
		log.info("ArticleController- modify");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String writer = service.getWriter(atc_seq);

		log.info("인증 사용자 : " + auth.getName());
		log.info("글의 작성자는 :" + writer);
		log.info(search.getS_atc_type());
		log.info(search.getS_atc_title());
		log.info(search.getS_finish_dt());

		if (auth.getName().equals(writer)) {
			// 본인이 읽을경우 증가 안하게
			service.updateCnt(atc_seq);
			model.addAttribute("article", service.detail(atc_seq));
			model.addAttribute("page", paging);
			model.addAttribute("search", search);
			return "/article/modify";
		} else {
			return "/user/accessDenied";
		}

	}

	@RequestMapping("/download")
	public void downProcess(HttpServletResponse response, @RequestHeader("User-Agent") String userAgent,
			@RequestParam("file_name") String file_name, @RequestParam("file_path") String file_path) throws UnsupportedEncodingException {
		log.info("들어오니");
		String realFileName = file_name.substring(file_name.indexOf("_") + 1);
		log.info("UUID를 뺀 순수 파일명 :" + realFileName);
		log.info("파일명 :" + file_name);
		log.info("파일경로:" + file_path);
		String downloadPath="C:\\upload\\temp\\"+file_path+"\\"+file_name;
		File file = new File(downloadPath);
		InputStream is = null;
		OutputStream os = null;

		String transferName = null;

		if (userAgent.contains("Trident")) {
			log.info("IE browser: 제목변환을 시작합니다");
			transferName = URLEncoder.encode(realFileName, "UTF-8").replaceAll("\\+", " ");
		} else if (userAgent.contains("Edge")) {
			log.info("Edge :제목변환을 시작합니다");
			transferName = URLEncoder.encode(realFileName, "UTF-8");
		} else {
			log.info("Chrome browser :제목변환을 시작합니다");
			transferName = new String(realFileName.getBytes("UTF-8"), "iso_8859_1");
		}

		log.info(transferName);
		try {
			is = new FileInputStream(file);
		} catch (FileNotFoundException e) {
			log.error("저장 경로에 파일이 없습니다");
		}

		response.setContentType("application/actet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + transferName + "\"");

		try {
			os = response.getOutputStream();
			byte[] buffer = new byte[1024];
			int length;
			while ((length = is.read(buffer)) != -1)
				os.write(buffer, 0, length);
		} catch (IOException e) {
			log.error("파일 전송 오류입니다 : " + e.getMessage());
		} finally {
			try {
				os.flush();
				os.close();
				is.close();
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}

	}

	@GetMapping("/delete")
	public String delete(@RequestParam("atc_seq") Long atc_seq, SearchArticleVO search, PageMakerVO paging, RedirectAttributes rttr) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String writer = service.getWriter(atc_seq);

		log.info("인증 사용자 : " + auth.getName());
		log.info("게시글 작성자 :" + writer);
		if (auth.getName().equals(writer)) {
			if (service.delete(atc_seq)) {
				rttr.addFlashAttribute("result", "success");
				rttr.addFlashAttribute("search", search);
			}
			return "redirect:/article/list" + paging.getListLink() +"&"+search.getListLink().substring(1);
		} else {
			return "redirect:/user/accessDenied";
		}

	}

	@PostMapping("/modify")
	public String modify(ArticleVO article, SearchArticleVO search, PageMakerVO paging, @RequestParam("file") MultipartFile file,
			RedirectAttributes rttr) {

		// String writer=service.getWriter(article.getAtc_writer());
		log.info("파일첨부중....");
		String uploadFolder = "C:\\upload\\temp";
		// 경로에 폴더 생성
		File uploadPath = new File(uploadFolder, getFolder());
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		log.info("File Name : " + file.getOriginalFilename());
		String uploadFileName = file.getOriginalFilename();
		// 경로를 뗀 파일명
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;

		File saveFile = new File(uploadPath, uploadFileName);

		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			log.error("파일 저장 오류" + e.getMessage());
		} finally {
			article.setFile_name(uploadFileName);
			article.setFile_path(uploadPath.getAbsolutePath());
			service.modify(article);
		}

		return "redirect:/article/list" + paging.getListLink() +"&"+search.getListLink().substring(1);

	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}

}