FROM ubuntu
# 
# # COPY the cache invalidating files
# COPY ./something.txt /root/something.txt
# 
# # Copy out the old version
# # Copy in the new version
# RUN --mount=type=cache,target=/some-cache/ \
#   cp /some-cache/something.txt /root/last.txt && \
#   cp /root/something.txt /some-cache/something.txt
# 
# # Running this image will print both files with their contents
# CMD echo "New: $(cat /root/something.txt)" && echo "Old: $(cat /root/last.txt)"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -qy \
    clang \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV CC=clang
ENV CXX=clang++

ARG PLATFORM

COPY src/ /root/thing/src
COPY CMakeLists.txt /root/thing

WORKDIR /root/thing/build/${PLATFORM}

RUN --mount=type=cache,target=/root/thing/build/ \
  cmake \
    -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY="$(pwd)" \
    -DCMAKE_LIBRARY_OUTPUT_DIRECTORY="$(pwd)" \
    ../.. && make
