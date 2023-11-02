FROM n8nio/n8n:latest

USER root

WORKDIR /home/node/packages/cli
ENTRYPOINT []

RUN mkdir /skypro-n8n-nodes
COPY . /skypro-n8n-nodes

ENV NODE_ENV=dev
RUN cd /skypro-n8n-nodes && npm install && npm run build && npm pack
ENV NODE_ENV=production
RUN cd /usr/local/lib/node_modules/n8n && npm install /skypro-n8n-nodes/skypro-n8n-nodes-0.1.0.tgz \
  && mkdir -p ~/.n8n/custom && cd ~/.n8n/custom && npm install /skypro-n8n-nodes/skypro-n8n-nodes-0.1.0.tgz

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
