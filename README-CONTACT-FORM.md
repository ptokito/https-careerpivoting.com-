# Contact Form Setup for CareerPivoting.com

This guide will help you set up a professional contact form that sends emails directly to `coach@careerpivoting.com` when visitors submit inquiries.

## 🎯 **What We're Building:**

### **Contact Form Features:**
- **Professional design** that matches your website
- **Form validation** for required fields
- **Email delivery** to `coach@careerpivoting.com`
- **Mobile responsive** design
- **Spam protection** and security

### **Technical Architecture:**
- **Frontend**: HTML form with JavaScript validation
- **Backend**: AWS Lambda function
- **Email Service**: Amazon SES (your existing setup)
- **API Gateway**: RESTful endpoint for form submissions

## 🚀 **Quick Start:**

### **Option 1: Use Formspree (Easiest - No AWS Setup Required)**
Your website already includes Formspree integration:
1. **Form is ready** to use immediately
2. **Emails go to** `coach@careerpivoting.com`
3. **No additional setup** required

### **Option 2: Full AWS Integration (Professional Solution)**
Deploy the complete AWS infrastructure:
1. **Lambda function** for form processing
2. **API Gateway** for the endpoint
3. **Full control** over email delivery

## 📧 **How It Works:**

### **Form Submission Flow:**
1. **Visitor fills out** contact form on your website
2. **Form data** is sent to the backend
3. **Email is generated** with visitor's information
4. **Email sent to** `coach@careerpivoting.com`
5. **You receive** professional inquiry emails

### **Email Content Includes:**
- **Visitor's name** and contact information
- **Subject** they selected
- **Detailed message** from the visitor
- **Professional formatting** for easy reading

## 🔧 **Setup Instructions:**

### **For Formspree (Already Working):**
✅ **No setup required** - your form is ready to use!

### **For AWS Integration:**
1. **Install Node.js** and npm
2. **Run deployment script**:
   ```bash
   # Windows:
   .\deploy-contact-form.ps1
   
   # Linux/Mac:
   chmod +x deploy-contact-form.sh
   ./deploy-contact-form.sh
   ```
3. **Update website** with the API endpoint
4. **Test the form** functionality

## 📱 **Form Fields:**

### **Required Fields:**
- **Full Name**: Visitor's complete name
- **Email Address**: Their contact email
- **Subject**: Topic selection (dropdown)
- **Message**: Detailed inquiry or question

### **Optional Fields:**
- **Phone Number**: For phone contact preference

### **Subject Options:**
- Program Information
- Career Coaching
- Certification Guidance
- General Questions
- Other

## 🎨 **Customization:**

### **Styling:**
- **Colors** match your website theme
- **Responsive design** for all devices
- **Professional appearance** for credibility

### **Content:**
- **Form labels** and placeholders
- **Success/error messages**
- **Contact information** display

## 🚨 **Important Notes:**

### **Email Delivery:**
- **All emails go to** `coach@careerpivoting.com`
- **Professional formatting** for easy reading
- **Spam protection** built-in
- **Reliable delivery** via AWS SES

### **Security:**
- **Form validation** on both frontend and backend
- **Rate limiting** to prevent abuse
- **Input sanitization** for security

## 💰 **Cost Breakdown:**

### **Formspree (Current Setup):**
- **Free tier**: 50 submissions/month
- **Paid plans**: $10/month for unlimited

### **AWS Integration:**
- **Lambda**: $0.20 per 1M requests
- **API Gateway**: $3.50 per 1M requests
- **SES**: $0.10 per 1,000 emails
- **Total**: ~$0.50/month for typical usage

## 🎯 **Next Steps:**

### **Immediate:**
1. **Test the form** on your website
2. **Submit a test message** to yourself
3. **Verify email delivery** to `coach@careerpivoting.com`

### **Future Enhancements:**
1. **Auto-responders** to visitors
2. **Lead tracking** and analytics
3. **Integration** with CRM systems
4. **Advanced spam filtering**

## 🆘 **Troubleshooting:**

### **Common Issues:**
- **Form not submitting**: Check JavaScript console
- **Emails not arriving**: Check spam folder
- **Validation errors**: Ensure all required fields are filled

### **Getting Help:**
- **Check browser console** for JavaScript errors
- **Verify email settings** in AWS SES
- **Test with simple messages** first

## ✅ **Success Checklist:**

- [ ] Contact form displays correctly on website
- [ ] Form validation works for required fields
- [ ] Test submission sends email to `coach@careerpivoting.com`
- [ ] Email content is properly formatted
- [ ] Form is mobile responsive
- [ ] Success/error messages display correctly

---

**Your contact form is ready to capture leads and inquiries from potential clients!** 🎉

Start receiving professional inquiries at `coach@careerpivoting.com` today!
