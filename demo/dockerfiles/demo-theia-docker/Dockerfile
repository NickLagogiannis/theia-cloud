# Base image
FROM ghcr.io/eclipse-theia/theia-ide/theia-ide:1.56.1

# Theia configurations
ENV THEIA_MINI_BROWSER_HOST_PATTERN={{hostname}}
ENV THEIA_WEBVIEW_ENDPOINT={{hostname}}

# Set environment variables for Ant
ENV ANT_VERSION=1.8.0
ENV ANT_HOME=/home/tools/ant/ant-$ANT_VERSION
ENV PATH=$ANT_HOME/bin:$PATH

# Disable interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Switch to root to install prerequisites
USER root

# Update and install prerequisites
RUN apt-get update && \
    apt-get install -y wget openjdk-17-jdk && \
    apt-get clean

# Download and extract Apache Ant
RUN mkdir -p /home/tools/ant && \
    wget https://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz -C /home/tools/ant && \
    mv /home/tools/ant/apache-ant-${ANT_VERSION} $ANT_HOME && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz

# Ensure PATH is set for all users
RUN echo "export ANT_HOME=$ANT_HOME" >> /etc/profile.d/ant.sh && \
    echo "export PATH=$ANT_HOME/bin:\$PATH" >> /etc/profile.d/ant.sh && \
    chmod +x /etc/profile.d/ant.sh

# # Verify Ant installation as root
# RUN /bin/sh -c ". /etc/profile.d/ant.sh && ant -version"

# Switch back to Theia user
USER theia

#Copy ant project 

COPY mywinecellar /home/project




# Copy project
# COPY --chown=theia:theia project /home/project
# COPY --chown=theia:theia settings.json /home/theia/theia-blueprint/applications/browser/.theia/settings.json

# # Build projects once
# RUN mvn clean verify -f /home/project/java/pom.xml && \
#     cd /home/project/web && \
#     npm install && npm run build && \
#     cd /home/theia
