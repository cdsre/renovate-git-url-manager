ARG TERRAFORM_VERSION="1.9.7" # github-tags/hashicorp/terraform&versioning=semver

FROM debian:12.7-slim
ARG TERRAFORM_VERSION
ARG TARGETARCH
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m terraform -s /bin/bash \
&& apt-get update && apt-get upgrade -V -y \
&& apt-get install -V -y curl unzip \
&& mkdir -p /tmp/terraform \
&& cd /tmp/terraform && curl -o terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip" \
&& unzip terraform.zip && mv terraform /usr/local/bin/ \
&& find /usr/local/bin/ -type f -exec chmod 755 {} \; \
&& rm -rfv /tmp/* /var/lib/apt/lists/*

USER terraform:terraform
ENTRYPOINT ["terraform"]
CMD ["-help"]
