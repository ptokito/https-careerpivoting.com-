# Contact Form Deployment Script for CareerPivoting.com

Write-Host "🚀 Deploying Contact Form Infrastructure for CareerPivoting.com" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js found: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js is not installed. Please install Node.js first." -ForegroundColor Red
    exit 1
}

# Check if npm is installed
try {
    $npmVersion = npm --version
    Write-Host "✅ npm found: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ npm is not installed. Please install npm first." -ForegroundColor Red
    exit 1
}

Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
npm install

Write-Host "📁 Creating deployment package..." -ForegroundColor Yellow
if (Test-Path "contact-form-lambda.zip") {
    Remove-Item "contact-form-lambda.zip"
}
Compress-Archive -Path "contact-form-lambda.js", "node_modules", "package.json" -DestinationPath "contact-form-lambda.zip"

Write-Host "🏗️ Deploying infrastructure with Terraform..." -ForegroundColor Yellow
terraform init
terraform plan -out=contact-form-plan.tfplan
terraform apply contact-form-plan.tfplan

Write-Host "✅ Contact form infrastructure deployed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📧 Your contact form will now send emails to: coach@careerpivoting.com" -ForegroundColor Cyan
Write-Host "🌐 API endpoint will be displayed above" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎯 Next steps:" -ForegroundColor Yellow
Write-Host "1. Update your website with the API endpoint" -ForegroundColor White
Write-Host "2. Test the contact form" -ForegroundColor White
Write-Host "3. Start receiving inquiries from potential clients!" -ForegroundColor White
Write-Host ""
Write-Host "Need help? Check the README or contact support." -ForegroundColor Gray
