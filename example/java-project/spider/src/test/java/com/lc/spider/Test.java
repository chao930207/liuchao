package com.lc.spider;

import java.util.List;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String url = "http://www.meitulu.com/item/8661.html";
		
        String regex_title = "<title>([\\w*|\\W*|[\\u4e00-\\u9fa5]*]*\\d+P])_[\\w*|\\W*|[\\u4e00-\\u9fa5]*]*_美图录</title>";
        
        String result = HttpGetUtils.get(url);
        System.out.println(result);
        
        List<String> title = RegexStringUtils.regexString(result, regex_title);
        
        System.out.println(title);
	}
}
