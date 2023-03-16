FROM rust:bullseye as builder
RUN apt-get update && apt-get install -y cmake
WORKDIR /colink-greetings
COPY src ./src/
COPY Cargo.toml Cargo.lock colink.toml ./
RUN cargo install --path .

FROM debian:bullseye-slim
COPY --from=builder /usr/local/cargo/bin/colink-protocol-greetings-docker /usr/local/bin/colink-protocol-greetings-docker
ENTRYPOINT colink-protocol-greetings-docker
