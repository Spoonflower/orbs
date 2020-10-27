FROM cimg/base:2020.01

USER root

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -f awscliv2.zip \
 && rm -rf ./aws

ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_REGION=us-east-1

USER circleci

