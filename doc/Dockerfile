ARG ZEPHYR_SDK_VERSION=0.16.3

FROM alpine:latest AS sdk_fetcher

ARG ZEPHYR_SDK_VERSION
ARG TARGETARCH

# Map Docker TARGETARCH to Zephyr SDK archive names, download, and extract
RUN set -e; \
    case "${TARGETARCH}" in \
    amd64)  SDK_ARCH="x86_64" ;; \
    arm64)  SDK_ARCH="aarch64" ;; \
    *) echo "Unsupported TARGETARCH: ${TARGETARCH}" >&2; exit 1 ;; \
    esac; \
    apk add --no-cache curl ca-certificates; \
    curl -fL -o /zephyr-sdk.tar.xz "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK_VERSION}/zephyr-sdk-${ZEPHYR_SDK_VERSION}_linux-${SDK_ARCH}.tar.xz"; \
    tar xf /zephyr-sdk.tar.xz

FROM ubuntu:22.04

LABEL version="1.0.0"
LABEL vendor="EPAM"
LABEL team="xen-troops"
LABEL maintainer="volodymyr_babchuk@epam.com"
LABEL maintainer="ruslan_shymkevych@epam.com"
LABEL description="Build environment for xen-troops products with Linux and Zephyr"

SHELL ["/bin/bash", "-c"]

# If your user has other uid/gid, you can overwrite default
# values during the build with command-line options
# `--build-arg USER_ID="$(id -u)" --build-arg USER_GID="$(id -g)"`
ARG USER_ID=1000
ARG USER_GID=1000

# install packages
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    bash-completion \
    build-essential \
    chrpath \
    cmake \
    cpio \
    curl \
    diffstat \
    dosfstools \
    file \
    gawk \
    git \
    git-lfs \
    gosu \
    gperf \
    liblz4-tool \
    locales \
    locales-all \
    mtools \
    ninja-build \
    python3 \
    python3-pip \
    unzip \
    wget \
    xz-utils \
    zstd

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

RUN pip3 install --upgrade \
    git+https://github.com/xen-troops/moulin \
    # Zephyr-specific packages
    west \
    pyelftools

### Zephyr-related part
ARG ZEPHYR_SDK_VERSION
COPY --from=sdk_fetcher /zephyr-sdk-${ZEPHYR_SDK_VERSION} /opt/zephyr-sdk-${ZEPHYR_SDK_VERSION}
# Run Zephyr SDK setup script
WORKDIR /opt/zephyr-sdk-${ZEPHYR_SDK_VERSION}
RUN ./setup.sh -h

# Default runtime identity (can be overridden by -e or build args)
ENV USER_NAME=builder USER_ID=1000 USER_GID=1000

# Use a neutral working directory; entrypoint will ensure permissions
WORKDIR /workspace

# copy a tiny entrypoint
COPY ./doc/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]