FROM frolvlad/alpine-glibc

LABEL maintainer="k1LoW <k1lowxb@gmail.com>" \
      description="Pandoc for Japanese based on Alpine Linux."

# Install Pandoc
ENV PANDOC_VERSION=2.0.2 \
    PANDOC_DOWNLOAD_URL=https://github.com/jgm/pandoc/archive/$PANDOC_VERSION.tar.gz \
    PANDOC_DOWNLOAD_SHA512=5830e0d8670a0bf80d9e8a84412d9f3782d5a6d9cf384fc7a853ad7f4e41a94ed51322ca73b86ad93528a7ec82eaf343704db811ece3455e68f1049761544a88 \
    PANDOC_ROOT=/usr/local/pandoc \
    PATH=$PATH:$PANDOC_ROOT/bin

RUN apk add --no-cache \
    gmp \
    libffi \
 && apk add --no-cache --virtual build-dependencies \
    --repository "http://nl.alpinelinux.org/alpine/edge/community" \
    ghc \
    cabal \
    linux-headers \
    musl-dev \
    zlib-dev \
    curl \
 && mkdir -p /pandoc-build && cd /pandoc-build \
 && curl -fsSL "$PANDOC_DOWNLOAD_URL" -o pandoc.tar.gz \
 && echo "$PANDOC_DOWNLOAD_SHA512  pandoc.tar.gz" | sha512sum -c - \
 && tar -xzf pandoc.tar.gz && rm -f pandoc.tar.gz \
 && ( cd pandoc-$PANDOC_VERSION && cabal update && cabal install --only-dependencies \
    && cabal configure --prefix=$PANDOC_ROOT \
    && cabal build \
    && cabal copy \
    && cd .. ) \
 && rm -Rf pandoc-$PANDOC_VERSION/ \
 && apk del --purge build-dependencies \
 && rm -Rf /root/.cabal/ /root/.ghc/ \
 && cd / && rm -Rf /pandoc-build

# Install Tex Live
ENV TEXLIVE_VERSION=2017 \
    PATH=/usr/local/texlive/$TEXLIVE_VERSION/bin/x86_64-linux:$PATH

RUN apk --no-cache add perl wget xz tar fontconfig-dev \
 && mkdir -p /tmp/src/install-tl-unx \
 && wget -qO- ftp://tug.org/texlive/historic/$TEXLIVE_VERSION/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/src/install-tl-unx --strip-components=1 \
 && printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/src/install-tl-unx/texlive.profile \
 && /tmp/src/install-tl-unx/install-tl \
      --profile=/tmp/src/install-tl-unx/texlive.profile \
 && tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet \
 && tlmgr update --self && tlmgr update --all \
 && tlmgr install \
      collection-basic collection-latex \
      collection-latexrecommended collection-latexextra \
      collection-fontsrecommended collection-langjapanese latexmk \
      luatexbase ctablestack fontspec luaotfload lualatex-math \
      sourcesanspro sourcecodepro \
 && rm -Rf /tmp/src \
 && apk --no-cache del xz tar fontconfig-dev

VOLUME ["/workspace", "/root/.pandoc/templates"]
WORKDIR /workspace
