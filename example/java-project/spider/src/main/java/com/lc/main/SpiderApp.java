package com.lc.main;

import java.util.List;

import com.lc.spider.DownloadUtils;
import com.lc.spider.HttpGetUtils;
import com.lc.spider.RegexStringUtils;

public class SpiderApp {
    public static void main( String[] args ) {
    	
        /*String url = "http://www.meitulu.com/item/5779.html";
        //String regex_url = "http://(www.meitulu.com/item/\\d{1,4}[_\\d{0,2}]*.html)";
        String regex_img = "(http://pic.yiipic.com/uploadfile/\\d{4}/\\d{4}/\\d+.jpg)";
        String regex_title = "<title>([\\w*|\\W*|[\\u4e00-\\u9fa5]*]*\\d+P])[_\\w*|\\W*|[\\u4e00-\\u9fa5]*]*_美图录</title>";
        
        String result = HttpGetUtils.get(url);
        
        List<String> title = RegexStringUtils.regexString(result, regex_title);
        List<String> src = RegexStringUtils.regexString(result, regex_img);
        
        String path = title.get(0).toString();
        
        for (int i = 0, length = src.size(); i < length; i++) {
        	String filename = DownloadUtils.get(src.get(i), path);
        	System.out.println(filename);
        }*/
    	
    	QueryThread spiderThread = new QueryThread();
    	
    	new Thread(spiderThread, "https://www.meitulu.com").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/nvshen/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/nenmo/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/jipin/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/shaofu/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/changtui/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/youhuo/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/loli/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/qingchun/").start();
    	new Thread(spiderThread, "https://www.meitulu.com/t/youwu/").start();
    	
    }
    
}
