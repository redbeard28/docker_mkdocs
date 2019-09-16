#!/bin/bash
job_name=`basename $0`


# Fonction d aide
usage() {
clear
echo "
########################################
#
#   $(pwd)/$job_name -d /tmp/mydocs -i redbeard28/docset:1.0 -m html -V 0.0.3
#
#########################################
option -d =>    /tmp/docs                                                   =>  path of your markdown
option -i =>    redbeard28/docset:1.0                                       => Image Name
option -m =>    html or serve                                               => Generate html files or make server
"
}

#################################
### Recuperation des entrees
while getopts d:D:i:m:h OPTION
do
  case "$OPTION" in
  d)
    DOCS_PATH="$OPTARG"
    ;;
  i)
    IMAGE_NAME="$OPTARG"
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
    echo "

    ############################
    #
    # Create HTML in  $DOCS_PATH/site
    #
    #
    ############################

    "
    #cd $DOCS_PATH
    mkdir Redbeard28
    mkdocs build
    sleep 5
    python /html2dash.py -n Redbeard28 -d Redbeard28 -i docs_src/images/icon.png docs
    # Fix for icon.ico bug
    cp docs_src/images/favicon.ico Redbeard28/Redbeard28.docset/icon.ico
    tar --exclude='.DS_Store' -cvzf docs_src/feeds/redbeard28.tgz Redbeard28/Redbeard28.docset
    ls -l Redbeard28
    # Add new version
    #sed -i "s/TOTO/${VERSION}/g" ${DOCS_PATH}/docs_src/feeds/redbeard28.xml
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
