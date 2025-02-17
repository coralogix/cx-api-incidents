FROM golang:1.23.0-bookworm as builder

RUN apt update && apt install -y protobuf-compiler curl git

RUN go install golang.org/dl/go1.23.0@latest \
    && go1.23.0 download

RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest \
    && go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
    && go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

WORKDIR /app

ADD . /app

RUN curl -sSL "https://github.com/coralogix/protofetch/releases/download/v0.1.8/protofetch_$(uname -m)-unknown-linux-musl.tar.gz" -o "protofetch.tar.gz"
RUN tar -xvf "protofetch.tar.gz" -C /

RUN curl -sSL "https://github.com/bufbuild/buf/releases/download/v1.47.2/buf-Linux-$(uname -m)" -o "/bin/buf"
RUN chmod +x "/bin/buf"

ADD . /branch

RUN --mount=type=ssh \
    --mount=type=secret,id=known_hosts,target=/root/.ssh/known_hosts \
    git clone git@github.com:coralogix/cx-api-incidents.git /master 

WORKDIR /master
RUN --mount=type=ssh \
    --mount=type=secret,id=known_hosts,target=/root/.ssh/known_hosts \
    if [ -f protofetch.toml ]; then protofetch fetch -f ; fi

WORKDIR /branch
RUN --mount=type=ssh \
    --mount=type=secret,id=known_hosts,target=/root/.ssh/known_hosts \
    protofetch fetch -f

RUN buf lint

RUN bash build_facade_files.sh
