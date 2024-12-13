FROM ghcr.io/eclipse-theia/theia-ide/theia-ide:1.56.1 

COPY /tree-editor-v0.0.4.tgz ./tree-editor-v0.0.4.tgz

RUN yarn add file:./tree-editor-v0.0.4.tgz

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




ENV THEIA_MINI_BROWSER_HOST_PATTERN {{hostname}}
ENV THEIA_WEBVIEW_ENDPOINT {{hostname}}

# Copy project
COPY --chown=theia:theia project /home/project
COPY --chown=theia:theia settings.json /home/theia/theia-blueprint/applications/browser/.theia/settings.json

# Build projects once
RUN mvn clean verify -f /home/project/java/pom.xml && \
    cd /home/project/web && \
    npm install && npm run build && \
    cd /home/theia
