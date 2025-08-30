# Email Quick Reference - CareerPivoting.com

## 📧 Your 3 Business Email Addresses

| Email Address | Purpose | Primary Use Cases |
|---------------|---------|-------------------|
| **`coach@careerpivoting.com`** | Main coaching email | • Direct client communications<br>• Coaching session confirmations<br>• Course enrollment confirmations<br>• Personal coaching inquiries |
| **`info@careerpivoting.com`** | General inquiries | • Website contact forms<br>• General business questions<br>• Partnership opportunities<br>• Media requests |
| **`support@careerpivoting.com`** | Customer support | • Technical support tickets<br>• Course access issues<br>• Billing questions<br>• Account problems |

## 🚀 Quick Setup Commands

```bash
# Deploy infrastructure
terraform init
terraform plan
terraform apply

# Run setup guide (Windows)
.\setup-email.ps1

# Run setup guide (Linux/Mac)
chmod +x setup-email.sh
./setup-email.sh
```

## 💰 Cost Summary

- **Amazon SES**: $0.10 per 1,000 emails sent
- **Route 53**: $0.50/month (already included)
- **Total**: ~$0.50/month for typical business usage

## 🔧 Technical Details

- **Service**: Amazon SES (Simple Email Service)
- **Region**: us-east-1 (required for CloudFront compatibility)
- **Security**: SPF, DKIM, and domain verification included
- **Delivery**: High deliverability with AWS infrastructure

## 📱 How to Use

### After Setup:
1. **Domain verified** in AWS SES Console
2. **All 3 email addresses created** and verified
3. **Production access granted** (if needed)
4. **Test emails sent** and received successfully

### Email Client Options:
- **AWS SES Console**: Web-based email management
- **SMTP**: Use with any email client
- **AWS SDK**: Programmatic email sending
- **AWS CLI**: Command-line operations

## 🎯 Business Workflow

### `coach@careerpivoting.com`
- **Input**: Client inquiries, session requests
- **Output**: Coaching confirmations, course details
- **Integration**: Personal coaching system

### `info@careerpivoting.com`
- **Input**: Website contact forms, general questions
- **Output**: Business information, partnership details
- **Integration**: Website contact forms

### `support@careerpivoting.com`
- **Input**: Technical issues, course problems
- **Output**: Support tickets, solutions
- **Integration**: Customer support system

## 🚨 Important Notes

- **DNS propagation** can take up to 72 hours
- **Sandbox mode** initially (limited to verified addresses)
- **Production access** required to send to any email address
- **Rate limits** apply (200 emails/second by default)

## 📞 Need Help?

- **Setup Scripts**: `setup-email.ps1` (Windows) or `setup-email.sh` (Linux/Mac)
- **Documentation**: `README-EMAIL-SETUP.md`
- **AWS Resources**: SES Console, Route 53, CloudFormation
- **Support**: AWS Documentation and Community Forums

---

**Status**: Ready for deployment with Terraform
**Next Step**: Run `terraform apply` to create infrastructure
