#!/usr/bin/bash         
#The shebang, to define the type of shell used.

cd "$1" || exit 1  #Return error code 1 IF the argument $1 points to a directory that doesn't exist

FIND_ALL_FILES='ls -a'  #The command to get all files, hidden included

FILENAME=""             #Initiate a local, string variable, to carry the file's name.
EXTENSION=""            #Initiate a local, string variable, to carry the file's extension.

for FILENAME in $($FIND_ALL_FILES); do  #Here, the $() means exectute the command in the variable
    EXTENSION=${FILENAME##*.}           #Cut the FILENAME variable till the '.', then, put the rest in EXTENSION
    if [[ -n $EXTENSION && $FILENAME != "Text Files" && $FILENAME != "Images" && $FILENAME != "Bash Scripts" && $FILENAME != "Programming Files" && $FILENAME != "Executables" && $FILENAME != "misc" ]]; then        #If the variable "EXTENSION" is NOT empty
        case $EXTENSION in
            txt)            #For text files
                if [ -d "$1/Text Files" ]; then
                    mv "$1"/"$FILENAME" "$1"/'Text Files'  #Moves the file from this directory to the Text Files directory
                else
                    mkdir "$1"/'Text Files'  #Makes first the directory Text Files
                    mv "$1"/"$FILENAME" "$1"/'Text Files'   #Then moves the file from this directory to the Text Files directory
                fi
                ;;
            jpg | jpeg | hvec)  ##For pictures
                if [ -d "$1/Images" ]; then
                    mv "$1"/"$FILENAME" "$1"/Images   #Moves the file from this directory to the Images directory
                else
                    mkdir "$1"/Images  #Makes first the directory Text Files
                    mv "$1"/"$FILENAME" "$1"/Images   #Then moves the file from this directory to the Images directory
                fi
                ;;
            sh)                 ##For bash
                if [ -d "$1/Bash Scripts" ]; then
                    mv "$1"/"$FILENAME" "$1"/'Bash Scripts'   #Moves the file from this directory to the Bash Scripts directory
                else
                    mkdir "$1"/'Bash Scripts'  #Makes first the directory Text Files
                    mv "$1"/"$FILENAME" "$1"/'Bash Scripts'   #Then moves the file from this directory to the Images directory
                fi
                ;;
            cpp | c | h)        ##For programming scripts (excluding bash)
                if [ -d "$1/Programming Files" ]; then
                    mv "$1"/"$FILENAME" "$1"/'Programming Files'   #Moves the file from this directory to the Programming Files directory
                else
                    mkdir "$1"/'Programming Files'  #Makes first the directory Programming Files Files
                    mv "$1"/"$FILENAME" "$1"/'Programming Files'   #Then moves the file from this directory to the Programming Files directory
                fi
                ;;
            exe | bat)          ##For executables
                if [ -d "$1/Executables" ]; then
                    mv "$1"/"$FILENAME" "$1"/Executables   #Moves the file from this directory to the Executables directory
                else
                    mkdir "$1"/Executables  #Makes first the directory Executables
                    mv "$1"/"$FILENAME" "$1"/Executables   #Then moves the file from this directory to the Executables directory
                fi
                ;;
            *)                  ##Default (i.e. "misc")
                if [ -d "$1/misc" ]; then
                    if [ ! -d "$1/$FILENAME" ] && [ -f "$1/$FILENAME" ]; then
                        mv "$1"/"$FILENAME" "$1"/misc   #Moves the file from this directory to the misc directory
                    fi
                else
                    mkdir "$1"/misc  #Makes first the directory misc
                    mv "$1"/"$FILENAME" "$1"/misc   #Then moves the file from this directory to the misc directory
                fi
                ;;
        esac
    fi
done