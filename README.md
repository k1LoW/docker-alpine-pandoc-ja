# alpine-pandoc-ja

Pandoc for Japanese based on Alpine Linux

## Usage

```sh
$ docker pull k1low/alpine-pandoc-ja
$ docker run -it --rm -v `pwd`:/workspace k1low/alpine-pandoc-ja pandoc input.md -f markdown -o output.pdf -V documentclass=ltjarticle -V classoption=a4j -V geometry:margin=1in --pdf-engine=lualatex
```

## Reference Dockerfile

- [portown/alpine-pandoc](https://github.com/portown/alpine-pandoc)
- [paperist/alpine-texlive-ja](https://github.com/Paperist/docker-alpine-texlive-ja)


