# SSL certificate chain retriever
Retrieves and saves full SSL certificate chain for a given website, in PEM and DER formates.

Usage: `./cert-retriever example.com`

Output: two bundles of certificates, `ssl-bundle.pem` and `ssl-bundle.der`

Скрипт скачивает SSL-сертификаты для указанного сайта и упаковывает их в два файла `ssl-bundle.pem` и `ssl-bundle.der`, в PEM и DER формате соответственно. 
