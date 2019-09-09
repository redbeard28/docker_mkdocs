<h1>
  <span>Docker mkdocs</span>
</h1>

## What for ?
It's a simple repo with light Dockerfile(s).
The mean of that repo is to be called by others repos to construct a simple documentation.
it's use the host_path to mount into the container the docs folder of your mkdocs.

## Dockerfiles

### Dockerfile_serve

Use it to just load your markdown pages with a local folder.
** Don't use it for Production purpose** 

For production purpose, please consider to build your webpages and put it in a **Apache/Nginx** server !


### Exemple

```bash
#!/bin/bash

git clone https://github.com/redbeard28/docset.git .
sudo docker run --rm -v docset:/work -p 8001:8000 redbeard28/docs:$TAG serve -a 0.0.0.0:8000 &
```

### TODO: Dockerfile_html2dash

Use it to convert your mkdocs to docset for dash/zeal/velocity

Please go to [docset repo](https://github.com/redbeard28/docset.git)