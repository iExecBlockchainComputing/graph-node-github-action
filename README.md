# Graph Node in GitHub Actions 🚀

This GitHub Action starts a Graph Node container using Docker. It’s perfect for testing or deploying a Graph Node
environment with a custom configuration in your CI/CD workflows. 🎯

## Table of Contents 📚

- [Features](#features-✨)
- [Usage](#usage-🚀)
- [Inputs](#inputs-🔧)
- [Example Workflow](#example-workflow-📄)
- [License](#license-📄)

## Features ✨

- **Start a Graph Node container**: Launches a Docker container running Graph Node with a customizable image and
  version.
- **Flexible configuration**: Set the container name, ports for GraphQL and admin endpoints, and connection parameters
  for PostgreSQL, IPFS, and Ethereum.

## Usage 🚀

To use this action in your workflow, simply add a step referencing this action. Ensure your environment has Docker
installed and that the required ports are available.

## Inputs 🔧

| Input            | Description                                 | Required | Default                    |
|------------------|---------------------------------------------|----------|----------------------------|
| `image`          | The Graph Node Docker image to use          | No       | `graphprotocol/graph-node` |
| `version`        | The version of the Docker image to use      | No       | `latest`                   |
| `container-name` | The name of the container                   | No       | `graph-node`               |
| `port`           | The port for the GraphQL endpoint           | No       | `8000`                     |
| `admin-port`     | The port for the Graph Node admin interface | No       | `8020`                     |
| `postgres_host`  | The PostgreSQL host                         | Yes      | -                          |
| `postgres_user`  | The PostgreSQL user                         | Yes      | -                          |
| `postgres_port`  | The PostgreSQL port                         | No       | `5432`                     |
| `postgres_db`    | The PostgreSQL database name                | Yes      | -                          |
| `ipfs_host`      | The IPFS host                               | Yes      | -                          |
| `ipfs_port`      | The IPFS port                               | No       | `5001`                     |
| `ethereum`       | The Ethereum network URL (RPC endpoint)     | Yes      | -                          |

## Example Workflow 📄

Create a `.github/workflows/main.yml` file in your repository with the following content:

```yaml
name: CI Workflow - Graph Node

on:
  push:
    branches:
      - main

jobs:
  graphnode:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Start Graph Node
        uses: your-username/graph-node-action@v1.0.0
        with:
          postgres_host: 'your-postgres-host'
          postgres_user: 'your-postgres-user'
          postgres_db: 'your-postgres-db'
          ipfs_host: 'your-ipfs-host'
          ethereum: 'https://mainnet.infura.io/v3/your-infura-key'
```

## License 📄

This project is licensed under the [MIT License](./LICENSE).
