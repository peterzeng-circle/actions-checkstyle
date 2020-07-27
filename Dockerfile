FROM openjdk:8-alpine

# Specify viewdog version and a stable commit hash
ENV REVIEWDOG_COMMIT=144be8f5064d263cdd674952163da0cebd0247d0
ENV REVIEWDOG_VERSION=v0.10.0

# Grab checkstyle
RUN wget -O - -q https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.33/checkstyle-8.33-all.jar > /checkstyle.jar

# Grab reviewdog
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/${REVIEWDOG_COMMIT}/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}

# Install git
RUN apk add --no-cache git

# Add the script and checkstyle
COPY entrypoint.sh /entrypoint.sh
COPY checkstyle-circle.xml /checkstyle-circle.xml

ENTRYPOINT ["/entrypoint.sh"]
