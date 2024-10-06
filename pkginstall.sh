#this will install the packages that were compiled in binutil.sh
#parameters

CHAPTER="$1"
PACKAGE="$2"

#from download to read the correct ver of binutils
#grep will throw any pacakage that we dont care
pwd

cat packages.csv | grep -i "^$PACKAGE"| grep -i -v "\.patch;" | while read line; 
do
    VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"  
    CACHEFILE="$(basename "$URL")"
    #sed recognizes file name and destroys the tar 
    #dir name is for a file thats the same but without the xtension
    DIRNAME="$(echo $CACHEFILE | sed 's/\(.*\)\.tar\..*/\1/')"

    mkdir -pv "$DIRNAME"

    echo "Extrating file $CACHEFILE ..."
    tar -xf "$CACHEFILE" -C "$DIRNAME"
    #some tar have the same folder name inside like /bin/bin/[what i want]
    
    #like cd but we dont move juss stacks them
    pushd "$DIRNAME"
        #if only one file in list (its ls -1A, not -la)
        if [ "$(ls -1a | wc -l)" == "1" ]; then
            mv $(ls -1A)/* ./
            #since we didnt move technically we use . instead of ..
        fi

        echo "Compiling $PACKAGE ..."
        sleep 5    
        #now another file that compilse and a tee for log
        mkdir -pv "../log/ch$CHAPTER/"

        if ! source "../ch$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/ch$CHAPTER/$PACKAGE.log"; then
            echo "Compiling of $PACKAGE failed miserable. Stop"
            popd
            exit 1
        fi
       
        echo "Done compiling package :D"
    popd



done