package com.neobns.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;
import lombok.Getter;
import lombok.ToString;

@Data
@ToString
public class PageMakerVO {

	  private int curPage;
	  private int cntPerPage;
	  private int startPage;
	  private int endPage;
	  private boolean prev, next;

	  private long total;
	  
	  public PageMakerVO() {
		  this.curPage=1;
		  this.cntPerPage=10;
	  }
	  
	  public PageMakerVO(int curPage, int cntPerpage) {
		  this.curPage=curPage;
		  this.cntPerPage=cntPerpage;
	  }
	  public PageMakerVO(int curPage, int cntPerPage ,long total) {

		this.curPage=curPage;
		this.cntPerPage=cntPerPage;
	    this.total = total;

	    this.endPage = (int) (Math.ceil(curPage / 10.0)) * 10;

	    this.startPage = this.endPage - 9;

	    int realEnd = (int) (Math.ceil((total * 1.0) / cntPerPage));

	    if (realEnd < this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;

	    this.next = this.endPage < realEnd;
	  }
	  
	  public String getListLink() {
			UriComponentsBuilder builder= UriComponentsBuilder.fromPath("")
					.queryParam("curPage", this.curPage)
					.queryParam("cntPerPage", this.cntPerPage);
			
			return builder.toUriString();
		}
	  
	}
