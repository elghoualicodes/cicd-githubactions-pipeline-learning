# CI/CD Demo Application

A simple Node.js Express application demonstrating CI/CD pipeline with GitHub Actions and Docker.

## Features

- Express.js web server
- Health check endpoint
- Jest testing suite
- GitHub Actions CI/CD pipeline
- Docker containerization
- Security auditing

## Endpoints

- `GET /` - Returns a hello message
- `GET /health` - Health check endpoint

## Getting Started

### Prerequisites

- Node.js 18 or higher
- npm

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

### Running the Application

#### Development
```bash
npm start
```

The server will start on port 3000 (or the port specified in the PORT environment variable).

#### Testing
```bash
npm test
```

#### Building
```bash
npm run build
```

### Docker

Build the Docker image:
```bash
docker build -t cicd-demo .
```

Run the container:
```bash
docker run -p 3000:3000 cicd-demo
```

## CI/CD Pipeline

The project includes two GitHub Actions workflows:

1. **Basic CI/CD Pipeline** (`.github/workflows/ci-cd.yml`)
   - Runs tests and builds the application
   - Performs security audits
   - Deploys to staging (develop branch) and production (main branch)

2. **Advanced CI/CD Pipeline** (`.github/workflows/advanced-ci-cd.yml`)
   - Matrix testing across multiple Node.js versions
   - Code coverage reporting
   - Docker image building and pushing

## Project Structure

```
├── app.js              # Main application file
├── app.test.js         # Test suite
├── package.json        # Project dependencies and scripts
├── Dockerfile          # Docker container configuration
├── .dockerignore       # Docker ignore file
├── .github/
│   └── workflows/
│       ├── ci-cd.yml           # Basic CI/CD pipeline
│       └── advanced-ci-cd.yml  # Advanced CI/CD pipeline
└── README.md           # This file
```
