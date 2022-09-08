#!/bin/bash

if ! type curl > /dev/null 2>&1; then
  echo
  echo "CURL is required."
  echo
  exit 1
fi

if [ $# -eq 0 ]; then
  echo
  echo "Usage: $0 example.com"
  echo 
  exit 0
fi

URL=$1
PEM_BUNDLE=ssl-bundle.pem
GET_ISSUER='(?<=CA Issuers - URI:)http.+\w'
GET_CERT='/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'

CERT_URL=`openssl s_client -connect ${URL}:443 2>&1 < /dev/null | \
  sed -ne "${GET_CERT}" | \
  tee ${PEM_BUNDLE} | \
  openssl x509 -text -noout | \
  grep -Po "${GET_ISSUER}"`

while [ ${CERT_URL} ]; do
  CERT_URL=`curl -s ${CERT_URL} | \
    openssl x509 -text -inform der | \
    sed -ne "${GET_CERT}" | \
    tee -a ${PEM_BUNDLE} | \
    openssl x509 -text -noout | \
    grep -Po "${GET_ISSUER}"`
done

openssl x509 -outform der -in ${PEM_BUNDLE} -out ${PEM_BUNDLE%.pem}.der

