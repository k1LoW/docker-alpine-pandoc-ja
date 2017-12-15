# alpine-pandoc-ja [![Docker Automated build](https://img.shields.io/docker/automated/k1low/alpine-pandoc-ja.svg?style=flat-square)](https://hub.docker.com/r/k1low/alpine-pandoc-ja/) [![Docker Automated build](https://img.shields.io/docker/build/k1low/alpine-pandoc-ja.svg?style=flat-square)](https://hub.docker.com/r/k1low/alpine-pandoc-ja/)

Pandoc for Japanese based on Alpine Linux.

## Usage

```sh
$ docker pull k1low/alpine-pandoc-ja
$ docker run -it --rm -v `pwd`:/workspace k1low/alpine-pandoc-ja pandoc input.md -f markdown -o output.pdf -V documentclass=ltjarticle -V classoption=a4j -V geometry:margin=1in --pdf-engine=lualatex
```

### Use Template

```
$ mkdir templates
$ wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex -O templates/eisvogel.tex
$ docker run -it --rm -v `pwd`:/workspace -v `pwd`/templates:/root/.pandoc/templates k1low/pandoc:latest pandoc input.md -f markdown -o output.pdf -V documentclass=ltjarticle -V classoption=a4j -V geometry:margin=1in -V CJKmainfont=IPAexGothic --pdf-engine=lualatex --template eisvogel.tex --listings
```

## Reference Dockerfile

- [portown/alpine-pandoc](https://github.com/portown/alpine-pandoc)
- [paperist/alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja)


