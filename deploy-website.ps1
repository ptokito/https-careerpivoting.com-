# Website Deployment Script for CareerPivoting.com
# This script uploads files to S3 and invalidates CloudFront for instant updates

Write-Host "Deploying CareerPivoting.com Website with Instant Updates" -ForegroundColor Green
Write-Host "==============================================================" -ForegroundColor Green

# Check if AWS CLI is installed
try {
    $awsVersion = aws --version
    Write-Host "AWS CLI found: $awsVersion" -ForegroundColor Green
} catch {
    Write-Host "AWS CLI is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

# Check if Terraform is installed
try {
    $terraformVersion = terraform --version
    Write-Host "Terraform found: $terraformVersion" -ForegroundColor Green
} catch {
    Write-Host "Terraform is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

# Get the S3 bucket name and CloudFront distribution ID from Terraform
Write-Host "Getting infrastructure details from Terraform..." -ForegroundColor Blue

# Initialize Terraform if needed
if (-not (Test-Path ".terraform")) {
    Write-Host "Initializing Terraform..." -ForegroundColor Yellow
    terraform init
}

# Get outputs
$S3_BUCKET = terraform output -raw s3_bucket_name 2>$null
$CLOUDFRONT_ID = terraform output -raw cloudfront_distribution_id 2>$null

if (-not $S3_BUCKET -or -not $CLOUDFRONT_ID) {
    Write-Host "Could not get S3 bucket or CloudFront ID from Terraform outputs" -ForegroundColor Red
    Write-Host "Make sure you've run 'terraform apply' first" -ForegroundColor Yellow
    exit 1
}

Write-Host "S3 Bucket: $S3_BUCKET" -ForegroundColor Green
Write-Host "CloudFront Distribution: $CLOUDFRONT_ID" -ForegroundColor Green

# Upload website files to S3
Write-Host "Uploading website files to S3..." -ForegroundColor Blue

# Upload main website files
Write-Host "Uploading main website files..." -ForegroundColor Blue

# Upload index.html
$uploadResult = aws s3 cp index.html "s3://$S3_BUCKET/index.html" `
    --content-type "text/html" `
    --cache-control "no-cache, no-store, must-revalidate" `
    --metadata-directive REPLACE

if ($LASTEXITCODE -eq 0) {
    Write-Host "index.html uploaded successfully" -ForegroundColor Green
} else {
    Write-Host "Failed to upload index.html" -ForegroundColor Red
    exit 1
}

# Upload blog files
Write-Host "Uploading blog files..." -ForegroundColor Blue

# Upload blog.html
$uploadResult = aws s3 cp blog.html "s3://$S3_BUCKET/blog.html" `
    --content-type "text/html" `
    --cache-control "no-cache, no-store, must-revalidate" `
    --metadata-directive REPLACE

if ($LASTEXITCODE -eq 0) {
    Write-Host "blog.html uploaded successfully" -ForegroundColor Green
} else {
    Write-Host "Failed to upload blog.html" -ForegroundColor Red
    exit 1
}

# Upload blog-salary-history.html
$uploadResult = aws s3 cp blog-salary-history.html "s3://$S3_BUCKET/blog-salary-history.html" `
    --content-type "text/html" `
    --cache-control "no-cache, no-store, must-revalidate" `
    --metadata-directive REPLACE

if ($LASTEXITCODE -eq 0) {
    Write-Host "blog-salary-history.html uploaded successfully" -ForegroundColor Green
} else {
    Write-Host "Failed to upload blog-salary-history.html" -ForegroundColor Red
    exit 1
}

# Upload blog-stop-being-sheep.html
$uploadResult = aws s3 cp blog-stop-being-sheep.html "s3://$S3_BUCKET/blog-stop-being-sheep.html" `
    --content-type "text/html" `
    --cache-control "no-cache, no-store, must-revalidate" `
    --metadata-directive REPLACE

if ($LASTEXITCODE -eq 0) {
    Write-Host "blog-stop-being-sheep.html uploaded successfully" -ForegroundColor Green
} else {
    Write-Host "Failed to upload blog-stop-being-sheep.html" -ForegroundColor Red
    exit 1
}

# Upload any other website files (CSS, JS, images, etc.)
if (Test-Path "styles.css") {
    aws s3 cp styles.css "s3://$S3_BUCKET/styles.css" `
        --content-type "text/css" `
        --cache-control "no-cache, no-store, must-revalidate"
    Write-Host "styles.css uploaded successfully" -ForegroundColor Green
}

if (Test-Path "script.js") {
    aws s3 cp script.js "s3://$S3_BUCKET/script.js" `
        --content-type "application/javascript" `
        --cache-control "no-cache, no-store, must-revalidate"
    Write-Host "script.js uploaded successfully" -ForegroundColor Green
}

# Create CloudFront invalidation for instant updates
Write-Host "Creating CloudFront invalidation for instant updates..." -ForegroundColor Blue

$INVALIDATION_ID = aws cloudfront create-invalidation `
    --distribution-id $CLOUDFRONT_ID `
    --paths "/*" `
    --query 'Invalidation.Id' `
    --output text

if ($LASTEXITCODE -eq 0) {
    Write-Host "CloudFront invalidation created: $INVALIDATION_ID" -ForegroundColor Green
    
    # Wait for invalidation to complete
    Write-Host "Waiting for invalidation to complete..." -ForegroundColor Yellow
    
    do {
        Start-Sleep -Seconds 10
        $STATUS = aws cloudfront get-invalidation `
            --distribution-id $CLOUDFRONT_ID `
            --id $INVALIDATION_ID `
            --query 'Invalidation.Status' `
            --output text
        
        if ($STATUS -eq "InProgress") {
            Write-Host "Invalidation still in progress..." -ForegroundColor Yellow
        }
    } while ($STATUS -eq "InProgress")
    
    if ($STATUS -eq "Completed") {
        Write-Host "CloudFront invalidation completed!" -ForegroundColor Green
    } else {
        Write-Host "Invalidation failed with status: $STATUS" -ForegroundColor Red
    }
} else {
    Write-Host "Failed to create CloudFront invalidation" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Website deployment completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Your website is now live at: https://careerpivoting.com" -ForegroundColor Blue
Write-Host "Blog is available at: https://careerpivoting.com/blog.html" -ForegroundColor Blue
Write-Host "Salary history post: https://careerpivoting.com/blog-salary-history.html" -ForegroundColor Blue
Write-Host "Contact form will send emails to: coach@careerpivoting.com" -ForegroundColor Blue
Write-Host "Changes are immediately visible thanks to CloudFront invalidation" -ForegroundColor Blue
Write-Host ""
Write-Host "Pro tip: Run this script whenever you update your website files" -ForegroundColor Yellow
Write-Host "The script automatically handles S3 uploads and cache invalidation" -ForegroundColor Yellow
