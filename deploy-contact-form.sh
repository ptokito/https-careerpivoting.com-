#!/bin/bash

# Contact Form Deployment Script for CareerPivoting.com

echo "🚀 Deploying Contact Form Infrastructure for CareerPivoting.com"
echo "================================================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "📦 Installing dependencies..."
npm install

echo "📁 Creating deployment package..."
zip -r contact-form-lambda.zip contact-form-lambda.js node_modules package.json

echo "🏗️ Deploying infrastructure with Terraform..."
terraform init
terraform plan -out=contact-form-plan.tfplan
terraform apply contact-form-plan.tfplan

echo "✅ Contact form infrastructure deployed successfully!"
echo ""
echo "📧 Your contact form will now send emails to: coach@careerpivoting.com"
echo "🌐 API endpoint will be displayed above"
echo ""
echo "🎯 Next steps:"
echo "1. Update your website with the API endpoint"
echo "2. Test the contact form"
echo "3. Start receiving inquiries from potential clients!"
echo ""
echo "Need help? Check the README or contact support."
