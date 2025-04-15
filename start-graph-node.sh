#!/bin/bash
# Use bash instead of sh to avoid syntax issues with wait-for-it.sh

echo "::group::Mapping input values"
# Map input values from the GitHub Actions workflow to shell variables
GRAPH_NODE_IMAGE=${1}
GRAPH_NODE_VERSION=${2}
GRAPH_NODE_NAME=${3}
GRAPH_NODE_PORT=${4}
GRAPH_NODE_ADMIN_PORT=${5}
GRAPH_NODE_POSTGRES_HOST=${6}
GRAPH_NODE_POSTGRES_USER=${7}
GRAPH_NODE_POSTGRES_PASS=${8}
GRAPH_NODE_POSTGRES_PORT=${9}
GRAPH_NODE_POSTGRES_DB=${10}
GRAPH_NODE_IPFS_HOST=${11}
GRAPH_NODE_IPFS_PORT=${12}
GRAPH_NODE_ETHEREUM=${13}
echo "Inputs mapped."
echo "::endgroup::"

echo "::group::Validating required parameters"
if [ -z "$GRAPH_NODE_IMAGE" ]; then
  echo "Missing required argument: GRAPH_NODE_IMAGE"
  exit 2
fi

if [ -z "$GRAPH_NODE_VERSION" ]; then
  echo "Missing required argument: GRAPH_NODE_VERSION"
  exit 2
fi

if [ -z "$GRAPH_NODE_NAME" ]; then
  echo "Missing required argument: GRAPH_NODE_NAME"
  exit 2
fi

if [ -z "$GRAPH_NODE_PORT" ]; then
  echo "Missing required argument: GRAPH_NODE_PORT"
  exit 2
fi

if [ -z "$GRAPH_NODE_ADMIN_PORT" ]; then
  echo "Missing required argument: GRAPH_NODE_ADMIN_PORT"
  exit 2
fi

if [ -z "$GRAPH_NODE_POSTGRES_HOST" ]; then
  echo "Missing required argument: GRAPH_NODE_POSTGRES_HOST"
  exit 2
fi

if [ -z "$GRAPH_NODE_POSTGRES_USER" ]; then
  echo "Missing required argument: GRAPH_NODE_POSTGRES_USER"
  exit 2
fi

if [ -z "$GRAPH_NODE_POSTGRES_PASS" ]; then
  echo "Missing required argument: GRAPH_NODE_POSTGRES_PASS"
  exit 2
fi

if [ -z "$GRAPH_NODE_POSTGRES_PORT" ]; then
  echo "Missing required argument: GRAPH_NODE_POSTGRES_PORT"
  exit 2
fi

if [ -z "$GRAPH_NODE_POSTGRES_DB" ]; then
  echo "Missing required argument: GRAPH_NODE_POSTGRES_DB"
  exit 2
fi

if [ -z "$GRAPH_NODE_IPFS_HOST" ]; then
  echo "Missing required argument: GRAPH_NODE_IPFS_HOST"
  exit 2
fi

if [ -z "$GRAPH_NODE_IPFS_PORT" ]; then
  echo "Missing required argument: GRAPH_NODE_IPFS_PORT"
  exit 2
fi

if [ -z "$GRAPH_NODE_ETHEREUM" ]; then
  echo "Missing required argument: GRAPH_NODE_ETHEREUM"
  exit 2
fi

echo "All required parameters are set."
echo "::endgroup::"

wait_for_graph_node () {
  echo "::group::Waiting for Graph Node to accept connections"
  bash ./wait-for-it.sh localhost:${GRAPH_NODE_PORT} -t 0
  echo "::endgroup::"
}

echo "::group::Starting Graph Node container"
docker run -d \
  --name "${GRAPH_NODE_NAME}" \
  -p "${GRAPH_NODE_PORT}:8000" \
  -p "${GRAPH_NODE_ADMIN_PORT}:8020" \
  -e postgres_host="${GRAPH_NODE_POSTGRES_HOST}" \
  -e postgres_port="${GRAPH_NODE_POSTGRES_PORT}" \
  -e postgres_user="${GRAPH_NODE_POSTGRES_USER}" \
  -e postgres_pass="${GRAPH_NODE_POSTGRES_PASS}" \
  -e postgres_db="${GRAPH_NODE_POSTGRES_DB}" \
  -e ipfs="${GRAPH_NODE_IPFS_HOST}:${GRAPH_NODE_IPFS_PORT}" \
  -e ethereum="${GRAPH_NODE_ETHEREUM}" \
  -e GRAPH_LOG=debug \
  "${GRAPH_NODE_IMAGE}:${GRAPH_NODE_VERSION}"

if [ $? -ne 0 ]; then
  echo "Error starting Graph Node container"
  exit 2
fi
echo "Graph Node container started."
echo "::endgroup::"

wait_for_graph_node

echo "::group::Graph Node is up and running!"
echo "Success! Graph Node is up and running!"
echo "::endgroup::"
