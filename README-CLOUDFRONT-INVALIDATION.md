# CloudFront Invalidation Setup for CareerPivoting.com

This guide explains how to set up automatic CloudFront invalidation so your website updates are immediately visible to visitors without waiting for cache expiration.

## 🎯 **What We're Building:**

### **Instant Update System:**
- **Zero-cache policy** for immediate updates
- **Automatic invalidation** when files change
- **Professional deployment** scripts
- **Real-time visibility** of changes

### **How It Works:**
1. **You update** your website files
2. **Deployment script** uploads to S3
3. **CloudFront invalidation** clears the cache
4. **Visitors see changes** immediately

## 🚀 **Quick Start:**

### **Option 1: Use Deployment Scripts (Recommended)**
1. **Run the deployment script**:
   ```bash
   # Windows:
   .\deploy-website.ps1
   
   # Linux/Mac:
   chmod +x deploy-website.sh
   ./deploy-website.sh
   ```
2. **Script automatically**:
   - Uploads files to S3
   - Creates CloudFront invalidation
   - Waits for completion
   - Confirms success

### **Option 2: Manual Deployment**
1. **Upload files to S3**:
   ```bash
   aws s3 cp index.html s3://careerpivoting.com/
   ```
2. **Invalidate CloudFront**:
   ```bash
   aws cloudfront create-invalidation \
     --distribution-id YOUR_DISTRIBUTION_ID \
     --paths "/*"
   ```

## 🔧 **Infrastructure Setup:**

### **Terraform Configuration:**
Your `main.tf` now includes:

```hcl
# Zero-cache policy for instant updates
resource "aws_cloudfront_cache_policy" "main" {
  name        = "careerpivoting-cache-policy"
  comment     = "Cache policy for CareerPivoting website"
  default_ttl = 0
  max_ttl     = 0
  min_ttl     = 0
}

# Automatic invalidation on file changes
resource "aws_cloudfront_invalidation" "main" {
  distribution_id = aws_cloudfront_distribution.main.id
  paths = ["/*"]
}
```

### **Deploy Infrastructure:**
```bash
terraform init
terraform plan
terraform apply
```

## 📁 **Deployment Scripts:**

### **deploy-website.sh (Linux/Mac):**
- **Checks prerequisites** (AWS CLI, Terraform)
- **Gets infrastructure details** from Terraform
- **Uploads files** to S3 with proper headers
- **Creates invalidation** and waits for completion
- **Color-coded output** for easy reading

### **deploy-website.ps1 (Windows):**
- **Same functionality** as bash script
- **PowerShell-specific** syntax
- **Windows-compatible** commands
- **Professional output** formatting

## ⚡ **Performance Benefits:**

### **Before (With Caching):**
- **Changes take 24+ hours** to appear
- **Visitors see old content** until cache expires
- **Manual invalidation** required for updates
- **Professional appearance** but slow updates

### **After (With Invalidation):**
- **Changes appear instantly** (within 5-10 minutes)
- **Visitors always see latest** content
- **Automatic invalidation** on every deployment
- **Professional appearance** with instant updates

## 🎨 **Customization Options:**

### **Cache Policy Settings:**
```hcl
# For maximum performance (some caching)
default_ttl = 300    # 5 minutes
max_ttl     = 3600   # 1 hour
min_ttl     = 0      # No minimum

# For instant updates (no caching)
default_ttl = 0      # No caching
max_ttl     = 0      # No caching
min_ttl     = 0      # No caching
```

### **Invalidation Paths:**
```hcl
# Invalidate everything
paths = ["/*"]

# Invalidate specific files
paths = ["/index.html", "/styles.css"]

# Invalidate specific folders
paths = ["/images/*", "/css/*"]
```

## 💰 **Cost Considerations:**

### **CloudFront Invalidations:**
- **Free tier**: 1,000 invalidations/month
- **Additional**: $0.005 per invalidation
- **Typical usage**: 10-50 invalidations/month
- **Monthly cost**: $0.05 - $0.25

### **S3 Operations:**
- **PUT requests**: $0.0005 per 1,000
- **Data transfer**: $0.09 per GB
- **Typical usage**: Minimal cost
- **Monthly cost**: < $0.01

## 🎯 **Best Practices:**

### **Deployment Workflow:**
1. **Make changes** to your website files
2. **Test locally** before deployment
3. **Run deployment script** to update live site
4. **Verify changes** are visible immediately
5. **Monitor invalidation** status

### **File Management:**
- **Use version control** (Git) for your website
- **Keep deployment scripts** in your project
- **Document changes** for team members
- **Test invalidation** after major updates

## 🆘 **Troubleshooting:**

### **Common Issues:**
- **Invalidation not working**: Check CloudFront distribution ID
- **Files not updating**: Verify S3 upload success
- **Slow invalidation**: Normal for large distributions
- **Cache still showing**: Wait 5-10 minutes for completion

### **Debugging Steps:**
1. **Check AWS CLI** configuration
2. **Verify Terraform** outputs
3. **Monitor CloudFront** invalidation status
4. **Check S3** file timestamps
5. **Clear browser cache** for testing

## ✅ **Success Checklist:**

- [ ] CloudFront distribution configured with zero-cache policy
- [ ] Terraform invalidation resource created
- [ ] Deployment scripts working correctly
- [ ] Files upload to S3 successfully
- [ ] CloudFront invalidation completes
- [ ] Website changes visible immediately
- [ ] Contact form working with new email system

## 🚀 **Next Steps:**

### **Immediate:**
1. **Deploy infrastructure** with `terraform apply`
2. **Test deployment script** with a small change
3. **Verify instant updates** work correctly
4. **Update website content** as needed

### **Future Enhancements:**
1. **CI/CD pipeline** for automatic deployments
2. **Multiple environments** (dev, staging, prod)
3. **Rollback capabilities** for quick recovery
4. **Performance monitoring** and analytics

---

**Your website now updates instantly with professional deployment automation!** 🎉

No more waiting for cache expiration - changes are visible immediately to all visitors!
