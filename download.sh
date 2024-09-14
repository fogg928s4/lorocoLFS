#reads line by line from packages.csv
#Packages is
    # NAME | VERSION | URL | MD5
cat packages.csv | while read line; 
do
  #cut goes to a specific line and skips to a; with -d\
  NAME="`echo $line | cut -d\; -f1`" #were telling it to skip from ;
  VERSION="`echo $line | cut -d\; -f2`" #f2, second instance
  URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`" # for the version match
  MD5SUM="`echo $line | cut -d\; -f4`"
  #its `` not '' :(
  #from the url extract the name of the file
  #bast name last part of url string
  CACHEFILE="$(basename "$URL")"
  
  
  #for debugggins that its actually doing that
  #prof deleted this but i like it too much
  echo NAME $NAME VERSION $VERSION
  echo FROM URL $URL
  echo MD5 $MD5SUM
  echo FILENAME $CACHEFILE

  #check if file alr downlaod to avoid traffic overload
  if [ ! -f "$CACHEFILE" ]; then
    echo "Downloading $NAME from $URL ....."
    #downloads the file
    wget "$URL"
    
    #checks if the md5 is right cus u know man in the middle
    #if md5 wrong ehhh remove the file
    #md5 does not like me apparently
    #echo "IM LOSING IT"
    #echo "$MD5SUM  $CACHEFILE"
    
    #this was a way to check the md5sum but its too inconvenient and does not checks the file itself 
    #if [[ $(md5sum "$CACHEFILE" | cut -d ' ' -f1) != "$MD5SUM" ]]; then
    if ! echo "$MD5SUM  $CACHEFILE" | md5sum -c >/dev/null; then
      rm -f "$CACHEFILE"
      echo "Verification of $CACHEFILE failed! MD5 mismatch!"
      exit 1
    else
      echo "Download succesful of $CACHEFILE"
    fi
  fi
  
done

