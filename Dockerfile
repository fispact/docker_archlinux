FROM archlinux/base:latest
MAINTAINER UKAEA <admin@fispact.ukaea.uk>

# Build-time metadata as defined at http://label-schema.org
ARG PROJECT_NAME
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="$PROJECT_NAME" \
      org.label-schema.description="Arch Linux docker image for FISPACT-II" \
      org.label-schema.url="http://fispact.ukaea.uk/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/fispact/docker_archlinux" \
      org.label-schema.vendor="UKAEA" \
      org.label-schema.version=$VERSION \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.schema-version="1.0"

ENV RUN_SCRIPT ~/.bashrc

# Install additional packages
RUN pacman -Syu && \
    pacman -S make git cmake less rsync doxygen cpio nano bash bash-completion && \
    pacman -S python3 gcc gcc-gfortran && \
    # pip3 packages
    pip3 install --upgrade pip && \
    pip3 install pytest pytest-xdist pypact

WORKDIR /

# Run the tests
CMD bash $RUN_SCRIPT
