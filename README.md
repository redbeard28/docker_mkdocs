<h1>
  <span>Docker mkdocs</span>
</h1>

## What for ?
It's a simple repo with light Dockerfile(s).
The mean of that repo is to be called by others repos to construct a simple documentation.
it's use the host_path to mount into the container the docs folder of your mkdocs.

## Dockerfiles

### MKDOCS - Dockerfile

The Docker file in the root repo (docker_mkdocs/Dockerfile) is used with mkdocs command.

```bash
docker container run -it --rm -v /tmp/docset:/work redbeard28/mkdocs:0.1 -h

Usage: mkdocs [OPTIONS] COMMAND [ARGS]...

  MkDocs - Project documentation with Markdown.

Options:
  -V, --version  Show the version and exit.
  -q, --quiet    Silence warnings
  -v, --verbose  Enable verbose output
  -h, --help     Show this message and exit.

Commands:
  build      Build the MkDocs documentation
  gh-deploy  Deploy your documentation to GitHub Pages
  new        Create a new MkDocs project
  serve      Run the builtin development server

```

Use it to just load your markdown pages with a local folder.
** Don't use it for Production purpose** 

For production purpose, please consider to build your webpages and put it in a **Apache/Nginx** server !


### Serve exemple

```bash
#!/bin/bash

git clone https://github.com/redbeard28/docset.git .
sudo docker run --rm -d -v docset:/work -p 8001:8000 redbeard28/mkdocs:$TAG serve -a 0.0.0.0:8000
```

### Build exemple

```bash
#!/bin/bash

git clone https://github.com/redbeard28/docset.git .
sudo docker run --rm -v docset:/work -p 8001:8000 redbeard28/mkdocs:$TAG build
```

### html2dash Dockerfile

Use it to convert your mkdocs to docset for dash/zeal/velocity
```bash
#!/bin/bash

git clone https://github.com/redbeard28/docset.git .
docker run -i --rm -v ./docset:/work redbeard28/html2dash:0.1 -d Redbeard28 -i redbeard28/docset:1.0 -m html

```
Please go to [docset repo](https://github.com/redbeard28/docset.git)