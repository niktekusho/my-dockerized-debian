FROM nikgatto/my-dockerized-debian-base:latest

ENV NODE_VERSION=10.15.3

# Install nvm in the default user "user"
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

ENV NVM_DIR="$HOME/.nvm"

RUN . "$NVM_DIR/nvm.sh" && \
	nvm install ${NODE_VERSION} && \
	nvm alias default ${NODE_VERSION} && \
	nvm use default

# Update paths
ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules \
	PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install Yarn
RUN wget -qO- https://yarnpkg.com/install.sh | bash

# Update paths
ENV PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Install needed dependencies
USER root
RUN apt-get update && apt-get install -y make g++
USER user

ENV ABRICOTINE_VERSION=0.7.0
COPY ./scripts/install/install-abricotine.sh ${INST_SCRIPTS}/
RUN ${INST_SCRIPTS}/install-abricotine.sh
