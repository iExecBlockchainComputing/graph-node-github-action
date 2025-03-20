FROM docker:stable
COPY start-graph-node.sh /start-graph-node.sh
RUN chmod +x /start-graph-node.sh
ENTRYPOINT ["/start-graph-node.sh"]
