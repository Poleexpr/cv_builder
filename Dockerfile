ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

RUN if command -v apt > /dev/null; then \
      sed -i 's/archive.ubuntu.com/mirror.yandex.ru/g' /etc/apt/sources.list && \
      apt-get update -o Acquire::http::Timeout=30 -o Acquire::ForceIPv4=true && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        texlive-base \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        texlive-generic-recommended \
        texlive-pictures \
        texlive-science \
        texlive-lang-cyrillic \
        cm-super \
        dvipng && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*; \
    elif command -v yum > /dev/null; then \
      yum update -y && \
      yum install -y \
        texlive-collection-latexrecommended \
        texlive-collection-fontsrecommended \
        texlive-collection-fontsextra \
        texlive-collection-pictures \
        texlive-collection-science \
        texlive-collection-langcyrillic && \
      yum clean all; \
    fi

WORKDIR /resume
COPY CV/ ./CV/
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]