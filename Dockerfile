FROM alpine:latest AS build
WORKDIR /terraria
ARG serverzip=https://terraria.org/system/dedicated_servers/archives/000/000/038/original/terraria-server-1404.zip
RUN wget -O terraria.zip $serverzip \
    && unzip terraria.zip \
    && mv */Linux out \
    && printf "worldpath=/worlds\nnpcstream=15" >> out/config

FROM debian:8-slim
WORKDIR /terraria
COPY --from=build /terraria/out .
RUN ["chmod", "+x", "TerrariaServer.bin.x86_64"]
ENTRYPOINT ["/terraria/TerrariaServer.bin.x86_64", "-config", "/terraria/config"]
EXPOSE 7777/tcp
VOLUME /worlds