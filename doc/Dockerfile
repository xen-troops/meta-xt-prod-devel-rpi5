ARG ZEPHYR_SDK_VERSION=0.16.3

FROM alpine:latest AS sdk_fetcher

ARG ZEPHYR_SDK_VERSION
ADD https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK_VERSION}/zephyr-sdk-${ZEPHYR_SDK_VERSION}_linux-x86_64.tar.xz /zephyr-sdk.tar.xz
RUN tar xf /zephyr-sdk.tar.xz

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

# Create non-root user
ENV USER_NAME=builder
RUN groupadd --gid "${USER_GID}" "${USER_NAME}" \
    && useradd --uid ${USER_ID} --gid ${USER_GID} --create-home --shell /bin/bash ${USER_NAME} \
    && mkdir -p /home/$USER_NAME/workspace \
    && chown $USER_NAME:$USER_NAME /home/$USER_NAME/workspace

# Switch the user from root to $USER_NAME (builder)
USER $USER_NAME
WORKDIR /home/$USER_NAME/workspace

# Create dummy ~/.gitconfig
RUN git config --global user.name "Isolated Builder"  &&  git config --global user.email "builder@example.com"
