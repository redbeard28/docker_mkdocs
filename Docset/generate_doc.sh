#!/bin/bash
job_name=`basename $0`


# Fonction d aide
usage() {
clear
echo "
########################################
#
#   $(pwd)/$job_name -d my_docset_path -i redbeard28/docset:1.0 -m html -p 'redbeard28/index.html'
#
#########################################
option -d =>    /tmp/docs                                 =>  destination path of your docset
option -i =>    redbeard28/docset:1.0                     => Image Name
option -m =>    html or serve                             => Generate html files or make server
option -p =>    redbeard28/index.html                     => Tell where is your index.html page with full path from Documents
"
}

#################################
### Recuperation des entrees
while getopts d:m:p:h OPTION
do
  case "$OPTION" in
  d)
    DOCSET_PATH="$OPTARG"
    ;;
  p)
    PATH_INDEX="$OPTARG"
    ;;
  m)
    TYPE="$OPTARG"
    ;;
  h)
    usage
    exit 0 ;;
  \?)
    echo "option inconnue"
    usage
    exit 3
    ;;
  esac
done
#################################

generate_html() {

    mkdocs build -c --config-file mkdocs.yml
    mkdocs build --config-file mkdocs.yml
    sleep 5

    mkdir redbeard28
    cp -rf docs/* redbeard28/
    python /html2dash.py -n redbeard28 -d release -i docs_src/images/icon.png redbeard28 -p $PATH_INDEX
    sleep 5
    # Fix for icon.ico bug
    cp docs_src/images/favicon.ico release/redbeard28.docset/icon.ico
    cd release && tar --exclude='.DS_Store' -cvzf ../docs_src/feeds/redbeard28.tgz redbeard28.docset
    cp ../docs_src/feeds/redbeard28.tgz ../docs/feeds/redbeard28.tgz
}



case "$TYPE" in
  html)
        generate_html
        ;;
  h)
    usage
    exit 0 ;;
  \?)
    echo "option inconnue"
    usage
    exit 3
    ;;

esac
