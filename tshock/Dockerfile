FROM alpine:latest AS build
WORKDIR /terraria
ARG serverzip=https://github.com/Pryaxis/TShock/releases/download/v4.4.0-pre11/TShock4.4.0_Pre11_Terraria1.4.0.5.zip

RUN apk update                                 \
    && apk add ca-certificates wget            \
    && update-ca-certificates                  \
    && wget -O terraria.zip $serverzip         \
    && mkdir out                               \
    && unzip -d out terraria.zip               \
    && printf "npcstream=15" >> out/config.txt

FROM mono:5
WORKDIR /terraria
COPY --from=build /terraria/out .
RUN ["ln", "-s", "/terraria/ServerPlugins", "/plugins"]

ENTRYPOINT [                                            \
    "mono-sgen",        "/terraria/TerrariaServer.exe", \
    "-config",          "/terraria/config.txt",         \
    "-worldselectpath", "/worlds",                      \
    "-configpath",      "/config",                      \
    "-logpath",         "/logs"]

EXPOSE 7777/tcp
VOLUME ["/worlds", "/plugins", "/config", "/logs"]
