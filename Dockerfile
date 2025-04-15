FROM docker:stable
RUN apk update && apk add --no-cache bash
COPY start-graph-node.sh /start-graph-node.sh
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /start-graph-node.sh
RUN chmod +x /wait-for-it.sh
ENTRYPOINT ["/start-graph-node.sh"]
