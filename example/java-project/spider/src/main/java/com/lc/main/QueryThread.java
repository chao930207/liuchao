package com.lc.main;

import static java.lang.System.out;
import static com.lc.spider.HttpGetUtils.get;
import static com.lc.spider.DownloadUtils.get;
import static com.lc.spider.RegexStringUtils.regexString;

import java.util.Date;
import java.util.List;

import com.lc.entity.SpiderQueue;

/**
 * <pre>
 * 爬取<code>url</code>数据线程
 * </pre>
 * 
 * @author LChao
 *
 */
public class QueryThread implements Runnable {
	
	/**
	 * <pre>
	 * 开始爬取以及处理数据
	 * </pre>
	 */
	private void dealData(String url) {

		SpiderQueue.addUnvisitedUrl(url);
		
		while (!SpiderQueue.unVisitedUrlsEmpty() && SpiderQueue.getVisited() < 100000000) {
			
			String regex_url = "(/item/\\d{1,5}[_\\d{0,2}]*.html)";
			String regex_img = "(http://pic.yiipic.com/uploadfile/\\d{4}/\\d{4}/\\d+.jpg)";
			String regex_title = "<title>([\\w*|\\W*|[\\u4e00-\\u9fa5]*]*\\d+P])[_\\w*|\\W*|[\\u4e00-\\u9fa5]*]*_美图录</title>";

			String get_url = String.valueOf(SpiderQueue.getUnVisitedUrl());
			String result = get(get_url);
			SpiderQueue.addVisitedUrl(get_url);

			List<String> urls = regexString(result, regex_url);

			for (String e_url : urls) {
				SpiderQueue.addUnvisitedUrl("http://www.meitulu.com" + e_url);
			}
			
			List<String> title = regexString(result, regex_title);
			List<String> src = regexString(result, regex_img);
			
			if (src != null && title != null) {
				String path = String.valueOf(title.get(0));

				for (int i = 0, length = src.size(); i < length; i++) {
					String filename = get(src.get(i), path);
					out.println(filename + " " + new Date());
				}
			}
		}
	}

	public void run() {
		// TODO Auto-generated method stub
		String url = Thread.currentThread().getName();
		this.dealData(url);
	}

}
