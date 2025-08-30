#!/bin/bash

# Website Deployment Script for CareerPivoting.com
# This script uploads files to S3 and invalidates CloudFront for instant updates

echo "🚀 Deploying CareerPivoting.com Website with Instant Updates"
echo "=============================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}❌ AWS CLI is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo -e "${RED}❌ Terraform is not installed. Please install it first.${NC}"
    exit 1
fi

# Get the S3 bucket name and CloudFront distribution ID from Terraform
echo -e "${BLUE}📋 Getting infrastructure details from Terraform...${NC}"

# Initialize Terraform if needed
if [ ! -d ".terraform" ]; then
    echo -e "${YELLOW}🔧 Initializing Terraform...${NC}"
    terraform init
fi

# Get outputs
S3_BUCKET=$(terraform output -raw s3_bucket_name 2>/dev/null)
CLOUDFRONT_ID=$(terraform output -raw cloudfront_distribution_id 2>/dev/null)

if [ -z "$S3_BUCKET" ] || [ -z "$CLOUDFRONT_ID" ]; then
    echo -e "${RED}❌ Could not get S3 bucket or CloudFront ID from Terraform outputs${NC}"
    echo -e "${YELLOW}💡 Make sure you've run 'terraform apply' first${NC}"
    exit 1
fi

echo -e "${GREEN}✅ S3 Bucket: ${S3_BUCKET}${NC}"
echo -e "${GREEN}✅ CloudFront Distribution: ${CLOUDFRONT_ID}${NC}"

# Upload website files to S3
echo -e "${BLUE}📤 Uploading website files to S3...${NC}"

# Upload main website files
echo -e "${BLUE}📄 Uploading main website files...${NC}"

# Upload index.html
aws s3 cp index.html s3://${S3_BUCKET}/index.html \
    --content-type "text/html" \
    --cache-control "no-cache, no-store, must-revalidate" \
    --metadata-directive REPLACE

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ index.html uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload index.html${NC}"
    exit 1
fi

# Upload blog files
echo -e "${BLUE}📝 Uploading blog files...${NC}"

# Upload blog.html
aws s3 cp blog.html s3://${S3_BUCKET}/blog.html \
    --content-type "text/html" \
    --cache-control "no-cache, no-store, must-revalidate" \
    --metadata-directive REPLACE

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ blog.html uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload blog.html${NC}"
    exit 1
fi

# Upload blog-salary-history.html
aws s3 cp blog-salary-history.html s3://${S3_BUCKET}/blog-salary-history.html \
    --content-type "text/html" \
    --cache-control "no-cache, no-store, must-revalidate" \
    --metadata-directive REPLACE

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ blog-salary-history.html uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload blog-salary-history.html${NC}"
    exit 1
fi

# Upload blog-stop-being-sheep.html
aws s3 cp blog-stop-being-sheep.html s3://${S3_BUCKET}/blog-stop-being-sheep.html \
    --content-type "text/html" \
    --cache-control "no-cache, no-store, must-revalidate" \
    --metadata-directive REPLACE

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ blog-stop-being-sheep.html uploaded successfully${NC}"
else
    echo -e "${RED}❌ Failed to upload blog-stop-being-sheep.html${NC}"
    exit 1
fi

# Upload any other website files (CSS, JS, images, etc.)
if [ -f "styles.css" ]; then
    aws s3 cp styles.css s3://${S3_BUCKET}/styles.css \
        --content-type "text/css" \
        --cache-control "no-cache, no-store, must-revalidate"
    echo -e "${GREEN}✅ styles.css uploaded successfully${NC}"
fi

if [ -f "script.js" ]; then
    aws s3 cp script.js s3://${S3_BUCKET}/script.js \
        --content-type "application/javascript" \
        --cache-control "no-cache, no-store, must-revalidate"
    echo -e "${GREEN}✅ script.js uploaded successfully${NC}"
fi

# Create CloudFront invalidation for instant updates
echo -e "${BLUE}🔄 Creating CloudFront invalidation for instant updates...${NC}"

INVALIDATION_ID=$(aws cloudfront create-invalidation \
    --distribution-id ${CLOUDFRONT_ID} \
    --paths "/*" \
    --query 'Invalidation.Id' \
    --output text)

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ CloudFront invalidation created: ${INVALIDATION_ID}${NC}"
    
    # Wait for invalidation to complete
    echo -e "${YELLOW}⏳ Waiting for invalidation to complete...${NC}"
    
    while true; do
        STATUS=$(aws cloudfront get-invalidation \
            --distribution-id ${CLOUDFRONT_ID} \
            --id ${INVALIDATION_ID} \
            --query 'Invalidation.Status' \
            --output text)
        
        if [ "$STATUS" = "Completed" ]; then
            echo -e "${GREEN}✅ CloudFront invalidation completed!${NC}"
            break
        elif [ "$STATUS" = "InProgress" ]; then
            echo -e "${YELLOW}⏳ Invalidation still in progress...${NC}"
            sleep 10
        else
            echo -e "${RED}❌ Invalidation failed with status: ${STATUS}${NC}"
            break
        fi
    done
else
    echo -e "${RED}❌ Failed to create CloudFront invalidation${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Website deployment completed successfully!${NC}"
echo ""
echo -e "${BLUE}🌐 Your website is now live at: https://careerpivoting.com${NC}"
echo -e "${BLUE}📝 Blog is available at: https://careerpivoting.com/blog.html${NC}"
echo -e "${BLUE}💰 Salary history post: https://careerpivoting.com/blog-salary-history.html${NC}"
echo -e "${BLUE}📧 Contact form will send emails to: coach@careerpivoting.com${NC}"
echo -e "${BLUE}⚡ Changes are immediately visible thanks to CloudFront invalidation${NC}"
echo ""
echo -e "${YELLOW}💡 Pro tip: Run this script whenever you update your website files${NC}"
echo -e "${YELLOW}💡 The script automatically handles S3 uploads and cache invalidation${NC}"
