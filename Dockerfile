ARG BASE_IMAGE=ubuntu:22.04
FROM ${BASE_IMAGE}

RUN if command -v apt > /dev/null; then \
      apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y \
        texlive-fonts-recommended \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-base  && \
      rm -rf /var/lib/apt/lists/*; \
    elif command -v yum > /dev/null; then \
      yum update -y && \
      yum install -y \
        texlive-collection-latexrecommended \
        texlive-collection-fontsrecommended \
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