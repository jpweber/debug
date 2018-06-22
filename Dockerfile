FROM alpine:3.7
ENV HOME=/config

RUN apk --update upgrade && \
    apk add curl && \
    curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN set -x && \
    apk add --no-cache curl ca-certificates bash iputils bind-tools busybox-extras && \
    chmod +x /usr/local/bin/kubectl && \
    # Create non-root user (with a randomly chosen UID/GUI).
    adduser kubectl -Du 2342 -h /config && \
    # Basic check it works.
    kubectl version --client && \
    rm -rf /var/cache/apk/*
CMD ["sleep", "86500"]
