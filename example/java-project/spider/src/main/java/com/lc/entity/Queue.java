package com.lc.entity;

import java.util.LinkedList;

/**
 * <pre>自定义队列，用于存储<code>url</code></pre>
 * 
 * @author LChao
 */
public class Queue {

	/**
	 * <pre>定义一个队列，使用<code>LinkedList</code>实现</pre>
	 * 
	 * @author LChao
	 */
	private LinkedList<Object> queue = new LinkedList<Object>();
	
	/**
	 * <pre>将<code>url</code>加入到队列中</pre>
	 * 
	 * @param o
	 * @author LChao
	 */
	public void addAttribute(Object o) {
		queue.addLast(o);
	}
	
	/**
	 * <pre>移除队列中第一项并将其返回</pre>
	 * 
	 * @return Object
	 * @author LChao
	 */
	public Object getAttribute() {
		return queue.removeFirst();
	}
	
	/**
	 * <pre>判断队列中是否包含该<code>url</code>，并返回<code>true</code>或<code>false</code></pre>
	 * 
	 * @param o
	 * @return boolean
	 * @author LChao
	 */
	public boolean contains(Object o) {
		return queue.contains(o);
	}
	
	/**
	 * <pre>判断队列是否为空，并返回<code>true</code>或<code>false</code></pre>
	 * 
	 * @return boolean
	 * @author LChao
	 */
	public boolean isEmpty() {
		return queue.isEmpty();
	}
}
