# CI/CD Testing Guide

## Prerequisites
1. GitHub account
2. Repository created on GitHub
3. Local Git repository connected to GitHub

## Testing Steps

### 1. Initial Setup Test
```bash
# Check current status
git status
git log --oneline

# Verify remote is set
git remote -v
```

### 2. Test Push to Main Branch (Production Deploy)
```bash
# Make sure you're on main branch
git checkout main

# Make a small change to trigger the pipeline
echo "# Testing CI/CD Pipeline" >> TESTING.md
git add TESTING.md
git commit -m "test: trigger CI/CD pipeline on main branch"
git push origin main
```

### 3. Test Push to Develop Branch (Staging Deploy)
```bash
# Switch to develop branch
git checkout develop

# Make a change
echo "console.log('Staging test');" >> app.js
git add app.js
git commit -m "test: trigger staging deployment"
git push origin develop
```

### 4. Test Pull Request (PR Testing)
```bash
# Create a feature branch
git checkout -b feature/test-pr
git checkout develop

# Create a new feature branch from develop
git checkout -b feature/add-version-endpoint

# Add a new endpoint
# (This will be done via file editing)

git add .
git commit -m "feat: add version endpoint"
git push origin feature/add-version-endpoint

# Then create a PR from GitHub web interface
```

### 5. Test Failure Scenarios
```bash
# Create a branch with failing tests
git checkout -b test/failing-tests

# Modify test to fail
# (This will be done via file editing)

git add .
git commit -m "test: intentionally failing test"
git push origin test/failing-tests
```

## What to Watch For

### ✅ Successful Pipeline Indicators:
- All jobs show green checkmarks
- Tests pass
- Build completes successfully
- Security scan passes
- Appropriate deployment job runs based on branch

### ❌ Failure Indicators:
- Red X marks on failed jobs
- Test failures in logs
- Build errors
- Security vulnerabilities found
- Deployment failures

## Monitoring Your Pipeline

1. **GitHub Actions Tab**: `https://github.com/YOUR_USERNAME/YOUR_REPO/actions`
2. **Check individual workflow runs**
3. **Review logs for each job**
4. **Monitor artifact uploads/downloads**
