FROM alpine:3.11
ENV KUBECTL_VERSION=1.16.4 \
    KUSTOMIZE_VERSION=3.4.0 \
    AWSCLI_VERSION=1.16.290

WORKDIR /app

RUN apk -v --update add --no-cache \
        sed \
        grep \
        curl \
        bash \
        python \
        py-pip \
        groff \
        less \
        && \
    pip install --no-cache-dir awscli==$AWSCLI_VERSION && \
    apk -v --purge del py-pip

RUN curl -sLf https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -sLf https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz -o kustomize.tar.gz\
    && tar xf kustomize.tar.gz \
    && mv kustomize /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize \
    && rm -rf ./*

CMD ["bash"]
