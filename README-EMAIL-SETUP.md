# Email Setup for CareerPivoting.com

This guide will help you set up your 3 main business email addresses using Amazon SES on AWS:

- **`coach@careerpivoting.com`** - Main coaching email
- **`info@careerpivoting.com`** - General inquiries  
- **`support@careerpivoting.com`** - Customer support

## 🚀 Quick Start

1. **Deploy the infrastructure:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

2. **Run the setup script:**
   ```bash
   # On Windows (PowerShell):
   .\setup-email.ps1
   
   # On Linux/Mac:
   chmod +x setup-email.sh
   ./setup-email.sh
   ```

## 📧 Your Email Addresses

### Primary Business Emails
| Email Address | Purpose | Use Case |
|---------------|---------|----------|
| `coach@careerpivoting.com` | Main coaching email | Client communications, course inquiries, coaching sessions |
| `info@careerpivoting.com` | General inquiries | Website contact forms, general questions, partnerships |
| `support@careerpivoting.com` | Customer support | Technical issues, course access problems, billing questions |

### Amazon SES (Simple Email Service)
- **Purpose**: Handle sending and receiving emails for all 3 addresses
- **Cost**: $0.10 per 1,000 emails sent
- **Features**: High deliverability, scalable, integrates with AWS services

## 🔧 Technical Details

### DNS Records Added
- **MX Records**: Direct incoming emails to AWS SES
- **TXT Records**: SPF records for email authentication
- **CNAME Records**: DKIM keys for email security
- **Verification Records**: Prove domain ownership to AWS

### Security Features
- **SPF**: Prevents email spoofing
- **DKIM**: Digital signatures for email authenticity
- **Domain verification**: Ensures only you can send from your domain

## 📋 Step-by-Step Setup

### Phase 1: Infrastructure (Terraform)
1. Run `terraform apply` to create all AWS resources
2. Wait for DNS propagation (can take up to 72 hours)
3. Verify domain in AWS SES Console

### Phase 2: Email Configuration
1. Request production access in SES (if in sandbox mode)
2. Create all 3 email addresses:
   - `coach@careerpivoting.com`
   - `info@careerpivoting.com`
   - `support@careerpivoting.com`
3. Verify each email address
4. Test sending and receiving

### Phase 3: Email Client Setup
1. Choose your email client (web, mobile, desktop)
2. Configure SMTP settings for sending
3. Set up email forwarding if needed

## 💰 Cost Breakdown

| Service | Cost | Notes |
|---------|------|-------|
| Amazon SES | $0.10/1,000 emails | Only pay for emails sent |
| Route 53 | $0.50/month | You already have this |
| **Total** | **~$0.50/month** | For typical business usage |

## 🔄 Alternative: Amazon WorkMail

If you prefer a full email service like Gmail/Outlook:

**Pros:**
- Web interface and mobile apps
- Calendar and contacts included
- Easier to use
- No technical setup required

**Cons:**
- More expensive ($4/user/month)
- Less customizable
- Tied to AWS ecosystem

## 📱 Email Client Options

### For Sending Emails
- **AWS SDK**: Programmatic email sending
- **AWS CLI**: Command-line email operations
- **SMTP**: Use with any email client

### For Reading Emails
- **Web Interface**: AWS SES Console
- **Email Forwarding**: Forward to Gmail/Outlook
- **Third-party Clients**: Thunderbird, Apple Mail, etc.

## 🚨 Important Notes

1. **Sandbox Mode**: New SES accounts start in sandbox mode (limited to verified addresses)
2. **Production Access**: Request this to send to any email address
3. **DNS Propagation**: Changes can take up to 72 hours
4. **Email Limits**: SES has rate limits (200 emails/second by default)

## 🆘 Troubleshooting

### Common Issues
- **Domain not verified**: Check DNS records and wait for propagation
- **Emails in spam**: Verify SPF and DKIM records are correct
- **Sending limits**: Request production access if in sandbox mode

### Getting Help
- AWS SES Documentation
- AWS Support (if you have a support plan)
- AWS Community Forums

## ✅ Success Checklist

- [ ] Terraform infrastructure deployed
- [ ] Domain verified in SES Console
- [ ] Production access granted (if needed)
- [ ] All 3 email addresses created and verified:
  - [ ] `coach@careerpivoting.com`
  - [ ] `info@careerpivoting.com`
  - [ ] `support@careerpivoting.com`
- [ ] Test emails sent and received
- [ ] Email client configured (optional)

## 🎯 Next Steps

After setting up your 3 email addresses:

1. **Integrate with your website**: Add contact forms that send to `info@careerpivoting.com`
2. **Set up email automation**: Welcome emails from `coach@careerpivoting.com`, course confirmations
3. **Configure support system**: Route support tickets to `support@careerpivoting.com`
4. **Monitor deliverability**: Check bounce and complaint rates
5. **Scale up**: Add more email addresses as your business grows

## 📧 Email Usage Examples

### `coach@careerpivoting.com`
- Direct client communications
- Coaching session confirmations
- Course enrollment confirmations
- Personal coaching inquiries

### `info@careerpivoting.com`
- Website contact forms
- General business inquiries
- Partnership opportunities
- Media requests

### `support@careerpivoting.com`
- Technical support tickets
- Course access issues
- Billing questions
- Account problems

---

**Need help?** The setup scripts (`setup-email.ps1` or `setup-email.sh`) will guide you through each step!
