#!/bin/bash

# Email Setup Script for CareerPivoting.com
# Setting up 3 main business email addresses

echo "🚀 Setting up email for CareerPivoting.com"
echo "================================================"
echo ""
echo "📧 Your 3 Business Email Addresses:"
echo "  • coach@careerpivoting.com (Main coaching email)"
echo "  • info@careerpivoting.com (General inquiries)"
echo "  • support@careerpivoting.com (Customer support)"
echo ""

echo "📋 Step 1: Deploy Terraform Infrastructure"
echo "Run: terraform init && terraform plan && terraform apply"
echo ""

echo "📋 Step 2: Verify Domain in SES Console"
echo "1. Go to AWS SES Console (us-east-1 region)"
echo "2. Check 'Verified Identities' section"
echo "3. Your domain should show as 'Pending verification'"
echo "4. Wait for DNS verification to complete (can take up to 72 hours)"
echo ""

echo "📋 Step 3: Request Production Access (if needed)"
echo "1. In SES Console, go to 'Account dashboard'"
echo "2. Click 'Request production access' if you're in sandbox mode"
echo "3. Fill out the form explaining your use case"
echo "4. Wait for approval (usually 24-48 hours)"
echo ""

echo "📋 Step 4: Create Your 3 Email Addresses"
echo "1. In SES Console, go to 'Verified identities'"
echo "2. Click on your domain"
echo "3. Go to 'Email addresses' tab"
echo "4. Create these email addresses:"
echo "   • coach@careerpivoting.com"
echo "   • info@careerpivoting.com"
echo "   • support@careerpivoting.com"
echo "5. Verify each email address (check your inbox for verification emails)"
echo ""

echo "📋 Step 5: Configure Email Client (Optional)"
echo "For sending emails programmatically, you can use:"
echo "- AWS SDK for your preferred language"
echo "- AWS CLI"
echo "- Third-party email clients that support SMTP"
echo ""

echo "📋 Step 6: Test Email Functionality"
echo "1. Send test emails from AWS SES Console to each address"
echo "2. Verify they're received correctly"
echo "3. Check spam folders if needed"
echo ""

echo "💰 Cost Breakdown:"
echo "- Amazon SES: $0.10 per 1,000 emails sent"
echo "- Route 53: $0.50/month per hosted zone (you already have this)"
echo "- No additional charges for receiving emails"
echo ""

echo "🔧 Alternative: Amazon WorkMail"
echo "If you prefer a full email service like Gmail/Outlook:"
echo "- Cost: $4/user/month"
echo "- Includes web interface, mobile apps, calendar, contacts"
echo "- Easier to use but more expensive"
echo ""

echo "📧 Email Usage Examples:"
echo "• coach@careerpivoting.com: Client communications, coaching sessions"
echo "• info@careerpivoting.com: Website contact forms, general inquiries"
echo "• support@careerpivoting.com: Technical support, billing questions"
echo ""

echo "✅ Setup Complete!"
echo "Your 3 business email addresses will be ready once verification is complete."
echo ""
echo "Need help? Check AWS SES documentation or contact AWS support."
