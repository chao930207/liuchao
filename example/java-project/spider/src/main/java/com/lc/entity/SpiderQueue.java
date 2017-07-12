package com.lc.entity;

import java.util.HashSet;
import java.util.Set;

/**
 * <pre>
 * 自定义类，用于保存已访问队列和待访问队列
 * </pre>
 * 
 * @author LChao
 */
public class SpiderQueue {

	/**
	 * <pre>
	 * 已访问的<code>url</code>集合，即<code>Visited</code>
	 * </pre>
	 * 
	 * @author LChao
	 */
	private static Set<Object> visitedUrl = new HashSet();

	/**
	 * <pre>
	 * 待访问的<code>url</code>集合，即<code>unVisited</code>
	 * </pre>
	 * 
	 * @author LChao
	 */
	private static Queue unVisitedUrl = new Queue();

	/**
	 * <pre>
	 * 添加到访问过的 <code>url</code>队列中
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static void addVisitedUrl(String url) {
		visitedUrl.add(url);
	}

	/**
	 * <pre>
	 * 移除访问过的 <code>url</code>
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static void removeVisitedUrl(String url) {
		visitedUrl.remove(url);
	}

	/**
	 * <pre>
	 * 获得已经访问的 <code>url</code>数目
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static int getVisited() {
		return visitedUrl.size();
	}

	/**
	 * <pre>
	 * 获得UnVisited队列
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static Queue getUnVisited() {
		return unVisitedUrl;
	}

	/**
	 * <pre>
	 * 未访问的<code>unVisitedUrl</code>出队列
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static synchronized Object getUnVisitedUrl() {
		return unVisitedUrl.getAttribute();
	}

	/**
	 * <pre>
	 * 保证添加<code>url</code>到<code>unVisitedUrl</code>的时候每个<code>url</code>只被访问一次
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static void addUnvisitedUrl(String url) {
		if (url != null && !url.trim().equals("") && !visitedUrl.contains(url) && !unVisitedUrl.contains(url))
			unVisitedUrl.addAttribute(url);
	}

	/**
	 * <pre>
	 * 判断未访问的<code>url</code>队列中是否为空
	 * </pre>
	 * 
	 * @author LChao
	 */
	public static boolean unVisitedUrlsEmpty() {
		return unVisitedUrl.isEmpty();
	}
}
