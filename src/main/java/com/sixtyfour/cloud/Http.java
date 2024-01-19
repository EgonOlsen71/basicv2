package com.sixtyfour.cloud;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import com.sixtyfour.Logger;

/**
 * Some simple http stuff...
 * 
 * @author EgonOlsen
 *
 */
public class Http {
	
	/**
	 * 
	 * @param baseUrl
	 * @param prgIn
	 */
	public void run(String baseUrl, InputStream prgIn) {
		baseUrl=baseUrl.trim();
		if (baseUrl.endsWith("/")) {
			baseUrl = baseUrl.substring(0, baseUrl.length()-1);
		}
		String url = (baseUrl+"/v1/runners:run_prg");
		byte[] data = null;
		try (ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
			prgIn.transferTo(bos);
			data = bos.toByteArray();
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
		post(url, data);
	}
	
	/**
	 * 
	 * @param url
	 * @param data
	 */
	public void post(String url, byte[] data) {
		try {
			Logger.log("Starting compiled program on Ultimate64...");
			HttpClient client = HttpClient.newHttpClient();
			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(url))
					.POST(HttpRequest.BodyPublishers.ofByteArray(data)).build();
			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
			if (response.statusCode()!=200) {
				throw new RuntimeException("Return code: "+response.statusCode());
			}
		} catch (Exception e) {
			Logger.log("Failed to POST to " + url, e);
			throw new RuntimeException(e);
		}
	}
}
