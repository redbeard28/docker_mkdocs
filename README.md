<h1>
  <span>Docker mkdocs</span>
</h1>

## What for ?
It's a simple repo with light Dockerfile.
The mean of that repo is to be called by others repos to construct a simple documentation.
it's use the host_path to mount into the container the docs folder of your mkdocs.

### Exemple

```bash
#!/bin/bash

doc_path='~/GitHub/somesDocs'

if [ ! -d $doc_path ];then
    mkdir -p $doc_path
fi

somesDocs_container=`docker ps -s |grep somesDocs|awk '{ print $1 }'`
somesDocs_images=`docker images|grep somesDocs|awk '{ print $3 }'`

echo ""
echo "# Stoping container ${somesDocs_container}"
sudo docker stop $somesDocs_container

echo ""
echo "## Delete container ${somesDocs_container}"
sudo docker rm $somesDocs_container

echo ""
echo "### Delete image ${somesDocs_images}"
sudo docker rmi $somesDocs_images

echo ""
echo "# Deplacement vers $doc_path"
cd $doc_path

echo ""
echo "## Build de somesDocs"
sudo docker build -t redbeard28/somesDocs github.com/redbeard28/docker_mkdocs

### Serve your project  

echo ""
echo "## Starting somesDocs ..."
cd $doc_path
git clone https://github.com/redbeard28/redbeard-consulting_docs.git .
sudo docker run --rm -v `pwd`:/docs -p 8001:8000 redbeard28/somesDocs serve -a 0.0.0.0:8000 &
```

