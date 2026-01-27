#!/bin/bash

# GitHub Profile Deployment Script
# This script helps you deploy your GitHub profile README

echo "================================================"
echo "   GitHub Profile README Deployment Script"
echo "================================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

echo "✅ Git is installed"
echo ""

# Get GitHub username
read -p "Enter your GitHub username (default: abhishtbagewadi): " github_user
github_user=${github_user:-abhishtbagewadi}

echo ""
echo "📝 Repository Details:"
echo "   Username: $github_user"
echo "   Repository: $github_user (special profile repo)"
echo ""

# Initialize git if not already initialized
if [ ! -d .git ]; then
    echo "🔧 Initializing Git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already initialized"
fi

# Add all files
echo ""
echo "📦 Adding files to Git..."
git add .

# Commit changes
echo ""
read -p "Enter commit message (default: 'Initial profile setup'): " commit_msg
commit_msg=${commit_msg:-"Initial profile setup"}

git commit -m "$commit_msg"
echo "✅ Files committed"

# Set main branch
echo ""
echo "🌿 Setting main branch..."
git branch -M main

# Add remote
echo ""
echo "🔗 Setting up remote repository..."
remote_url="https://github.com/$github_user/$github_user.git"

# Check if remote already exists
if git remote | grep -q "origin"; then
    echo "⚠️  Remote 'origin' already exists. Updating..."
    git remote set-url origin "$remote_url"
else
    git remote add origin "$remote_url"
fi

echo "✅ Remote configured: $remote_url"

# Push to GitHub
echo ""
echo "🚀 Ready to push to GitHub!"
echo ""
echo "⚠️  IMPORTANT: Before pushing, make sure you have:"
echo "   1. Created a repository named '$github_user' on GitHub"
echo "   2. Made it PUBLIC"
echo "   3. NOT initialized it with a README (or remove it first)"
echo ""
read -p "Have you created the repository on GitHub? (y/n): " confirm

if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
    echo ""
    echo "🚀 Pushing to GitHub..."

    if git push -u origin main; then
        echo ""
        echo "================================================"
        echo "✅ SUCCESS! Your profile is now live!"
        echo "================================================"
        echo ""
        echo "🌐 View your profile at:"
        echo "   https://github.com/$github_user"
        echo ""
        echo "📝 To update in the future:"
        echo "   1. Edit README.md"
        echo "   2. Run: git add README.md"
        echo "   3. Run: git commit -m 'Update profile'"
        echo "   4. Run: git push"
        echo ""
    else
        echo ""
        echo "❌ Push failed. Possible reasons:"
        echo "   1. Repository doesn't exist"
        echo "   2. Authentication failed"
        echo "   3. Repository already has content"
        echo ""
        echo "Solutions:"
        echo "   1. Create the repository on GitHub: https://github.com/new"
        echo "   2. Use GitHub CLI: gh auth login"
        echo "   3. Or push manually after setup"
        echo ""
        echo "Manual push command:"
        echo "   git push -u origin main"
    fi
else
    echo ""
    echo "📋 Next Steps:"
    echo "   1. Go to: https://github.com/new"
    echo "   2. Create repository named: $github_user"
    echo "   3. Make it PUBLIC"
    echo "   4. Don't initialize with README"
    echo "   5. Run this script again"
    echo ""
    echo "Or push manually:"
    echo "   git push -u origin main"
fi

echo ""
echo "================================================"
