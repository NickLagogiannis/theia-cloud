FROM node:20-bookworm as build-stage
RUN apt-get update && apt-get install -y libxkbfile-dev libsecret-1-dev
WORKDIR /home/theia
ADD demo/dockerfiles/demo-theia-monitor-theia/package.json ./package.json

## Link package from local
ADD node ./node
WORKDIR /home/theia/node
RUN npm ci && npm run build -w monitor-theia
###
RUN npm cache clean --force
###
RUN npm install

WORKDIR /home/theia


#### Ensure the path to the package is correct
COPY demo/dockerfiles/demo-theia-monitor-theia/tree-editor-v0.0.4.tgz ./tree-editor-v0.0.4.tgz

RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    sed -i '/__tests__\|test\|tests\|powered-test/ s/^/#/' .yarnclean && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

FROM node:20-bookworm-slim as production-stage

# Use fixed user id 101 to guarantee it matches the app definition
RUN adduser --system --group --uid 101 theia
RUN chmod g+rw /home && \
    mkdir -p /home/project && \
    mkdir -p /home/theia && \
    chown -R theia:theia /home/theia && \
    chown -R theia:theia /home/project;
RUN apt-get update && apt-get install -y wget apt-transport-https && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /usr/share/keyrings/adoptium.asc && \
    echo "deb [signed-by=/usr/share/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && apt-get install -y git openssh-client openssh-server bash libsecret-1-0 temurin-17-jdk maven && \
    apt-get purge -y wget && \
    apt-get clean
ENV HOME /home/theia
ENV THEIA_MINI_BROWSER_HOST_PATTERN {{hostname}}
ENV THEIA_WEBVIEW_ENDPOINT {{hostname}}
WORKDIR /home/theia
COPY --from=build-stage --chown=theia:theia /home/theia /home/theia
EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins
ENV USE_LOCAL_GIT true
USER theia

WORKDIR /home/theia
ENTRYPOINT [ "node", "/home/theia/src-gen/backend/main.js" ]
CMD [ "/home/project", "--hostname=0.0.0.0" ]