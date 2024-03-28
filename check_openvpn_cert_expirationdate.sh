#!

for cert in $*
do
  echo -e "\nCertificate: ${cert}"
  openssl x509 -enddate -noout -subject -in ${cert}
done

