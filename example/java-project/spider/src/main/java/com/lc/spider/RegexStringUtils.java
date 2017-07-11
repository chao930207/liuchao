package com.lc.spider;

import static java.lang.System.out;
import static java.util.regex.Pattern.compile;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexStringUtils {

    public static List<String> regexString(String targetStr, String patternStr) {
    	
    	List<String> list = new ArrayList<String>();
        Pattern pattern = compile(patternStr);

        Matcher matcher = pattern.matcher(targetStr);

        if (matcher.find()) {
        	matcher.reset();
        	while (matcher.find()) {
        		list.add(matcher.group(1));
        	}
            return list;
        } else {
        	out.println("Not Found!");
        	return null;
        }
    }
}
