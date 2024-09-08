#reads line by line
cat packages.csv | while read line; do
  NAME=   echo $line | cut -d\; -f1 #were telling it to skip
