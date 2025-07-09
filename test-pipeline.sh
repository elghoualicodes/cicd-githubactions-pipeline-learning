#!/bin/bash

# CI/CD Pipeline Testing Script
# This script helps you test different scenarios of your CI/CD pipeline

set -e  # Exit on any error

echo "🚀 CI/CD Pipeline Testing Script"
echo "================================="

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository. Please run this from your project root."
    exit 1
fi

# Check if remote is configured
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "❌ No remote 'origin' configured. Please add your GitHub repository."
    echo "Run: git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
    exit 1
fi

echo "✅ Git repository check passed"

# Function to test main branch deployment
test_main_deployment() {
    echo ""
    echo "🎯 Testing Main Branch (Production Deployment)"
    echo "=============================================="
    
    git checkout main
    echo "timestamp: $(date)" >> .github/test-main-$(date +%s).txt
    git add .
    git commit -m "test: trigger production deployment pipeline"
    git push origin main
    
    echo "✅ Pushed to main branch"
    echo "👉 Check GitHub Actions: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions"
}

# Function to test develop branch deployment
test_develop_deployment() {
    echo ""
    echo "🏗️  Testing Develop Branch (Staging Deployment)"
    echo "==============================================="
    
    git checkout develop
    echo "timestamp: $(date)" >> .github/test-develop-$(date +%s).txt
    git add .
    git commit -m "test: trigger staging deployment pipeline"
    git push origin develop
    
    echo "✅ Pushed to develop branch"
    echo "👉 Check GitHub Actions: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions"
}

# Function to test pull request
test_pull_request() {
    echo ""
    echo "🔄 Testing Pull Request Pipeline"
    echo "================================"
    
    BRANCH_NAME="test/pr-$(date +%s)"
    git checkout develop
    git checkout -b "$BRANCH_NAME"
    
    echo "# PR Test $(date)" >> PR_TEST.md
    git add .
    git commit -m "test: create PR to test pipeline"
    git push origin "$BRANCH_NAME"
    
    echo "✅ Pushed feature branch: $BRANCH_NAME"
    echo "👉 Create PR manually at: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/compare/$BRANCH_NAME?expand=1"
}

# Function to test failing pipeline
test_failing_pipeline() {
    echo ""
    echo "❌ Testing Failing Pipeline"
    echo "==========================="
    
    BRANCH_NAME="test/failing-$(date +%s)"
    git checkout develop
    git checkout -b "$BRANCH_NAME"
    
    # Create a failing test
    cat > failing-test.js << 'EOF'
const request = require('supertest');
const app = require('./app');

describe('Failing Test', () => {
  test('This test should fail', async () => {
    expect(1).toBe(2); // This will fail
  });
});
EOF
    
    git add .
    git commit -m "test: intentionally failing test for pipeline testing"
    git push origin "$BRANCH_NAME"
    
    echo "✅ Pushed branch with failing test: $BRANCH_NAME"
    echo "👉 This should show a failed pipeline in GitHub Actions"
}

# Main menu
echo ""
echo "Choose a test scenario:"
echo "1) Test Main Branch (Production Deploy)"
echo "2) Test Develop Branch (Staging Deploy)"  
echo "3) Test Pull Request Pipeline"
echo "4) Test Failing Pipeline"
echo "5) Run All Tests (except failing test)"
echo "6) Show Pipeline Status"
echo "0) Exit"
echo ""
read -p "Enter your choice (0-6): " choice

case $choice in
    1)
        test_main_deployment
        ;;
    2)
        test_develop_deployment
        ;;
    3)
        test_pull_request
        ;;
    4)
        test_failing_pipeline
        ;;
    5)
        test_develop_deployment
        sleep 2
        test_main_deployment
        sleep 2
        test_pull_request
        ;;
    6)
        echo "👉 Check your pipeline status at:"
        echo "https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions"
        ;;
    0)
        echo "👋 Exiting..."
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Test completed!"
echo "📊 Monitor your pipeline at: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions"
