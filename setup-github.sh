#!/bin/bash

# GitHub Repository Setup Script
echo "🔗 GitHub Repository Setup"
echo "=========================="

echo ""
echo "📋 Steps to set up your GitHub repository:"
echo ""

echo "1️⃣  Create a new repository on GitHub:"
echo "   - Go to https://github.com/new"
echo "   - Repository name: cicd-demo (or your preferred name)"
echo "   - Description: Node.js CI/CD demo application"
echo "   - Make it Public or Private (your choice)"
echo "   - ⚠️  DO NOT initialize with README, .gitignore, or license (we already have these files)"
echo "   - Click 'Create repository'"
echo ""

echo "2️⃣  Copy the repository URL (HTTPS or SSH):"
echo "   Example: https://github.com/yourusername/cicd-demo.git"
echo ""

read -p "3️⃣  Enter your GitHub repository URL: " repo_url

if [ -z "$repo_url" ]; then
    echo "❌ Repository URL is required!"
    exit 1
fi

echo ""
echo "4️⃣  Setting up remote origin..."

# Remove existing remote if it exists
git remote remove origin 2>/dev/null || true

# Add the new remote
git remote add origin "$repo_url"

echo "✅ Remote origin set to: $repo_url"

echo ""
echo "5️⃣  Verifying setup..."
git remote -v

echo ""
echo "6️⃣  Initial push to GitHub..."
echo "Pushing main branch..."
git push -u origin main

echo "Pushing develop branch..."
git push -u origin develop

echo ""
echo "🎉 Setup complete!"
echo ""
echo "🔍 Your CI/CD pipeline will now run when you:"
echo "   ✅ Push to main branch → Production deployment"
echo "   ✅ Push to develop branch → Staging deployment"  
echo "   ✅ Create pull request to main → PR testing"
echo ""
echo "📊 Monitor your pipelines at:"
echo "   https://github.com/$(echo $repo_url | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions"
echo ""
echo "🧪 To test your pipeline, run:"
echo "   ./test-pipeline.sh"
