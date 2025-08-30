# Test Deployment Script for CareerPivoting.com
# This script tests the deployment infrastructure without making changes

Write-Host "🧪 Testing CareerPivoting.com Deployment Infrastructure" -ForegroundColor Cyan
Write-Host "=========================================================" -ForegroundColor Cyan

# Test 1: Check if Terraform is working
Write-Host "`n📋 Test 1: Terraform Infrastructure Check" -ForegroundColor Yellow
try {
    terraform version
    Write-Host "✅ Terraform is working" -ForegroundColor Green
} catch {
    Write-Host "❌ Terraform is not working" -ForegroundColor Red
    exit 1
}

# Test 2: Check if AWS CLI is working
Write-Host "`n📋 Test 2: AWS CLI Check" -ForegroundColor Yellow
try {
    $awsVersion = aws --version
    Write-Host "✅ AWS CLI is working: $awsVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ AWS CLI is not working" -ForegroundColor Red
    exit 1
}

# Test 3: Check if Terraform outputs are available
Write-Host "`n📋 Test 3: Terraform Outputs Check" -ForegroundColor Yellow
try {
    # Initialize Terraform if needed
    if (-not (Test-Path ".terraform")) {
        Write-Host "🔧 Initializing Terraform..." -ForegroundColor Yellow
        terraform init
    }
    
    # Get outputs
    $S3_BUCKET = terraform output -raw s3_bucket_name 2>$null
    $CLOUDFRONT_ID = terraform output -raw cloudfront_distribution_id 2>$null
    
    if ($S3_BUCKET -and $CLOUDFRONT_ID) {
        Write-Host "✅ S3 Bucket: $S3_BUCKET" -ForegroundColor Green
        Write-Host "✅ CloudFront Distribution: $CLOUDFRONT_ID" -ForegroundColor Green
    } else {
        Write-Host "❌ Terraform outputs not available" -ForegroundColor Red
        Write-Host "💡 Run 'terraform apply' first to create infrastructure" -ForegroundColor Yellow
        exit 1
    }
} catch {
    Write-Host "❌ Error checking Terraform outputs" -ForegroundColor Red
    exit 1
}

# Test 4: Check if website files exist
Write-Host "`n📋 Test 4: Website Files Check" -ForegroundColor Yellow
$requiredFiles = @("index.html")
$missingFiles = @()

foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "✅ $file exists" -ForegroundColor Green
    } else {
        Write-Host "❌ $file missing" -ForegroundColor Red
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "❌ Missing required files: $($missingFiles -join ', ')" -ForegroundColor Red
    exit 1
}

# Test 5: Check AWS credentials
Write-Host "`n📋 Test 5: AWS Credentials Check" -ForegroundColor Yellow
try {
    $identity = aws sts get-caller-identity --query 'Arn' --output text
    Write-Host "✅ AWS credentials working: $identity" -ForegroundColor Green
} catch {
    Write-Host "❌ AWS credentials not working" -ForegroundColor Red
    Write-Host "💡 Run 'aws configure' to set up your credentials" -ForegroundColor Yellow
    exit 1
}

# Test 6: Check S3 bucket access
Write-Host "`n📋 Test 6: S3 Bucket Access Check" -ForegroundColor Yellow
try {
    $bucketExists = aws s3 ls "s3://$S3_BUCKET" 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ S3 bucket access working" -ForegroundColor Green
    } else {
        Write-Host "❌ Cannot access S3 bucket" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Error checking S3 bucket access" -ForegroundColor Red
    exit 1
}

# Test 7: Check CloudFront distribution access
Write-Host "`n📋 Test 7: CloudFront Distribution Check" -ForegroundColor Yellow
try {
    $distribution = aws cloudfront get-distribution --id $CLOUDFRONT_ID --query 'Distribution.Status' --output text
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ CloudFront distribution access working" -ForegroundColor Green
        Write-Host "📊 Distribution status: $distribution" -ForegroundColor Blue
    } else {
        Write-Host "❌ Cannot access CloudFront distribution" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Error checking CloudFront distribution" -ForegroundColor Red
    exit 1
}

# All tests passed
Write-Host "`n🎉 All Tests Passed!" -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "✅ Your deployment infrastructure is ready!" -ForegroundColor Green
Write-Host "✅ You can now run the deployment scripts:" -ForegroundColor Green
Write-Host "`n🚀 To deploy your website:" -ForegroundColor Blue
Write-Host "   Windows: .\deploy-website.ps1" -ForegroundColor White
Write-Host "   Linux/Mac: ./deploy-website.sh" -ForegroundColor White
Write-Host "`n💡 Your website will be available at: https://careerpivoting.com" -ForegroundColor Cyan
Write-Host "💡 Contact form will send emails to: coach@careerpivoting.com" -ForegroundColor Cyan
Write-Host "💡 Updates will be visible immediately thanks to CloudFront invalidation" -ForegroundColor Cyan
