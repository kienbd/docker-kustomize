FROM python:alpine
ENV KUBECTL_VERSION=1.16.4 \
    KUSTOMIZE_VERSION=3.4.0 \
    CLI_VERSION=1.16.290

WORKDIR /app

RUN apk add --no-cache \
      curl \
      bash

RUN apk -uv add --no-cache groff jq less && \
    pip install --no-cache-dir awscli==$CLI_VERSION


RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -sLf https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize.tar.gz\
    && tar xf kustomize.tar.gz \
    && mv kustomize /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize \
    && rm -rf ./*

CMD ["kustomize"]
