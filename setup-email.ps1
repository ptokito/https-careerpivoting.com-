# Email Setup Script for CareerPivoting.com
# PowerShell version for Windows users
# Setting up 3 main business email addresses

Write-Host "🚀 Setting up email for CareerPivoting.com" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "📧 Your 3 Business Email Addresses:" -ForegroundColor Cyan
Write-Host "  • coach@careerpivoting.com (Main coaching email)" -ForegroundColor White
Write-Host "  • info@careerpivoting.com (General inquiries)" -ForegroundColor White
Write-Host "  • support@careerpivoting.com (Customer support)" -ForegroundColor White
Write-Host ""

Write-Host "📋 Step 1: Deploy Terraform Infrastructure" -ForegroundColor Yellow
Write-Host "Run: terraform init && terraform plan && terraform apply" -ForegroundColor White
Write-Host ""

Write-Host "📋 Step 2: Verify Domain in SES Console" -ForegroundColor Yellow
Write-Host "1. Go to AWS SES Console (us-east-1 region)" -ForegroundColor White
Write-Host "2. Check 'Verified Identities' section" -ForegroundColor White
Write-Host "3. Your domain should show as 'Pending verification'" -ForegroundColor White
Write-Host "4. Wait for DNS verification to complete (can take up to 72 hours)" -ForegroundColor White
Write-Host ""

Write-Host "📋 Step 3: Request Production Access (if needed)" -ForegroundColor Yellow
Write-Host "1. In SES Console, go to 'Account dashboard'" -ForegroundColor White
Write-Host "2. Click 'Request production access' if you're in sandbox mode" -ForegroundColor White
Write-Host "3. Fill out the form explaining your use case" -ForegroundColor White
Write-Host "4. Wait for approval (usually 24-48 hours)" -ForegroundColor White
Write-Host ""

Write-Host "📋 Step 4: Create Your 3 Email Addresses" -ForegroundColor Yellow
Write-Host "1. In SES Console, go to 'Verified identities'" -ForegroundColor White
Write-Host "2. Click on your domain" -ForegroundColor White
Write-Host "3. Go to 'Email addresses' tab" -ForegroundColor White
Write-Host "4. Create these email addresses:" -ForegroundColor White
Write-Host "   • coach@careerpivoting.com" -ForegroundColor Cyan
Write-Host "   • info@careerpivoting.com" -ForegroundColor Cyan
Write-Host "   • support@careerpivoting.com" -ForegroundColor Cyan
Write-Host "5. Verify each email address (check your inbox for verification emails)" -ForegroundColor White
Write-Host ""

Write-Host "📋 Step 5: Configure Email Client (Optional)" -ForegroundColor Yellow
Write-Host "For sending emails programmatically, you can use:" -ForegroundColor White
Write-Host "- AWS SDK for your preferred language" -ForegroundColor White
Write-Host "- AWS CLI" -ForegroundColor White
Write-Host "- Third-party email clients that support SMTP" -ForegroundColor White
Write-Host ""

Write-Host "📋 Step 6: Test Email Functionality" -ForegroundColor Yellow
Write-Host "1. Send test emails from AWS SES Console to each address" -ForegroundColor White
Write-Host "2. Verify they're received correctly" -ForegroundColor White
Write-Host "3. Check spam folders if needed" -ForegroundColor White
Write-Host ""

Write-Host "💰 Cost Breakdown:" -ForegroundColor Cyan
Write-Host "- Amazon SES: $0.10 per 1,000 emails sent" -ForegroundColor White
Write-Host "- Route 53: $0.50/month per hosted zone (you already have this)" -ForegroundColor White
Write-Host "- No additional charges for receiving emails" -ForegroundColor White
Write-Host ""

Write-Host "🔧 Alternative: Amazon WorkMail" -ForegroundColor Magenta
Write-Host "If you prefer a full email service like Gmail/Outlook:" -ForegroundColor White
Write-Host "- Cost: $4/user/month" -ForegroundColor White
Write-Host "- Includes web interface, mobile apps, calendar, contacts" -ForegroundColor White
Write-Host "- Easier to use but more expensive" -ForegroundColor White
Write-Host ""

Write-Host "📧 Email Usage Examples:" -ForegroundColor Green
Write-Host "• coach@careerpivoting.com: Client communications, coaching sessions" -ForegroundColor White
Write-Host "• info@careerpivoting.com: Website contact forms, general inquiries" -ForegroundColor White
Write-Host "• support@careerpivoting.com: Technical support, billing questions" -ForegroundColor White
Write-Host ""

Write-Host "✅ Setup Complete!" -ForegroundColor Green
Write-Host "Your 3 business email addresses will be ready once verification is complete." -ForegroundColor White
Write-Host ""
Write-Host "Need help? Check AWS SES documentation or contact AWS support." -ForegroundColor Gray
