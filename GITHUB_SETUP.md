# GitHub Setup Instructions

Follow these steps to connect your local repository to GitHub and test the CI/CD pipeline:

## Step 1: Create a GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in to your account
2. Click the "+" icon in the top right corner and select "New repository"
3. Name your repository: `cicd-demo` (or any name you prefer)
4. Make sure it's set to **Public** (private repos have limited GitHub Actions minutes)
5. **DO NOT** initialize with README, .gitignore, or license (we already have these files)
6. Click "Create repository"

## Step 2: Connect Local Repository to GitHub

After creating the repository, GitHub will show you commands. Use these commands in your terminal:

```bash
# Add the remote origin (replace YOUR_USERNAME with your actual GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/cicd-demo.git

# Push the main branch
git push -u origin main

# Push the develop branch
git push -u origin develop
```

## Step 3: Test the CI/CD Pipeline

### Option A: Test with a simple change
1. Make a small change to the code (e.g., edit the message in app.js)
2. Commit and push to the develop branch:
   ```bash
   git checkout develop
   git add .
   git commit -m "Test CI/CD pipeline"
   git push origin develop
   ```
3. Go to your GitHub repository and check the "Actions" tab to see the pipeline running

### Option B: Test with a Pull Request
1. Make changes on the develop branch
2. Create a Pull Request from develop to main on GitHub
3. The CI/CD pipeline will run automatically on the PR

## Step 4: Monitor the Pipeline

1. Go to your GitHub repository
2. Click on the "Actions" tab
3. You should see your workflows running:
   - "CI/CD Pipeline" - Basic pipeline
   - "Advanced CI/CD Pipeline" - Matrix testing across Node.js versions

## What the Pipeline Does

### Basic CI/CD Pipeline (`ci-cd.yml`)
- ✅ Checks out code
- ✅ Sets up Node.js 18
- ✅ Installs dependencies
- ✅ Runs tests
- ✅ Builds application
- ✅ Runs security audit
- ✅ Deploys to staging (develop branch) or production (main branch)

### Advanced CI/CD Pipeline (`advanced-ci-cd.yml`)
- ✅ Tests on Node.js versions 16, 18, and 20
- ✅ Runs linting (ESLint)
- ✅ Generates test coverage
- ✅ Builds and pushes Docker images (requires Docker Hub secrets)

## Expected Results

When you push code, you should see:
- ✅ All tests passing
- ✅ Build successful
- ✅ Security audit complete
- ✅ Deployment steps executed

## Troubleshooting

If the pipeline fails:
1. Check the "Actions" tab for detailed error logs
2. Common issues:
   - Node.js version mismatches
   - Missing dependencies
   - Test failures
   - Security vulnerabilities

## Next Steps

Once basic CI/CD is working, you can:
1. Add Docker Hub integration for image building
2. Set up actual deployment to cloud services
3. Add more comprehensive testing
4. Configure notifications and monitoring
