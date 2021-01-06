---
title: "Java进行访问Https"
date: 2017-10-27T14:47:00+08:00
draft: false
---
1. 导入证书
   ```bash
   keytool -import -file test.crt -keystore ca_certs
   ```
2. 信任所有证书
   ```java
   HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
               @Override
            public boolean verify(String s, SSLSession sslSession) {
                return true;
            }
			});

			try {
				SSLContext sslc = SSLContext.getInstance("TLS");
				sslc.init(null, new TrustManager[]{new X509TrustManager() {
					@Override
					public void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
					}

					@Override
					public void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
					}

					@Override
					public X509Certificate[] getAcceptedIssuers() {
						return null;
					}
				}}, null);
			} catch (Exception e) {
				e.printStackTrace();
			}
	```
3. 使用httpUrlConnection正常连接Http