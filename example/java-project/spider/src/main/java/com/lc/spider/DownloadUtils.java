package com.lc.spider;

import static java.lang.System.out;
import static org.apache.http.impl.client.HttpClients.createDefault;
import static com.lc.spider.RegexStringUtils.regexString;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;

public class DownloadUtils {

	public static String get(String url, String path) {
		String filename = "";
		String regex_img_title = "(\\d+).jpg";
		
		List<String> img_list = regexString(url, regex_img_title);
		String img_title = img_list.get(0).toString();
		
		try {
			CloseableHttpClient httpclient = createDefault();
			HttpGet httpGet = new HttpGet(url);
			CloseableHttpResponse response = httpclient.execute(httpGet);

			try {
				if (response != null && response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
					out.println(response.getStatusLine());
					HttpEntity entity = response.getEntity();
					filename = download(entity, path, img_title);
				}
			} finally {
				httpclient.close();
				response.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return filename;
	}

	private static String download(HttpEntity resEntity, String path, String img_title) {
		// 图片要保存的路径
		String dirPath = "d:\\Resources\\img\\" + path + "\\";
		// 图片名称
		String fileName = img_title + ".png";
		// 如果没有目录先创建目录，如果没有文件名先创建文件名
		File file = new File(dirPath);
		if (file == null || !file.exists()) {
			file.mkdir();
		}
		String realPath = dirPath.concat(fileName);
		File filePath = new File(realPath);
		if (filePath == null || !filePath.exists()) {
			try {
				filePath.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 得到输入流，然后把输入流放入缓冲区中，缓冲区--->输出流flush，关闭资源
		BufferedOutputStream out = null;
		InputStream in = null;
		
		try {
			if (resEntity == null) {
				return null;
			}
			
			in = resEntity.getContent();
			out = new BufferedOutputStream(new FileOutputStream(filePath));
			byte[] bytes = new byte[1024];
			int len = -1;
			
			while ((len = in.read(bytes)) != -1) {
				out.write(bytes, 0, len);
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (IOException e) {
			}
		}
		return filePath.toString();
	}
}
