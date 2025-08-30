const AWS = require('aws-sdk');
const ses = new AWS.SES({ region: 'us-east-1' });

exports.handler = async (event) => {
    try {
        // Parse the request body
        const body = JSON.parse(event.body);
        const { name, email, phone, subject, message } = body;
        
        // Validate required fields
        if (!name || !email || !subject || !message) {
            return {
                statusCode: 400,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Headers': 'Content-Type',
                    'Access-Control-Allow-Methods': 'POST, OPTIONS'
                },
                body: JSON.stringify({
                    error: 'Missing required fields'
                })
            };
        }
        
        // Create email content
        const emailContent = `
New Contact Form Submission from CareerPivoting.com

Name: ${name}
Email: ${email}
Phone: ${phone || 'Not provided'}
Subject: ${subject}

Message:
${message}

---
This message was sent from the contact form on careerpivoting.com
        `;
        
        // Send email using SES
        const params = {
            Source: 'coach@careerpivoting.com',
            Destination: {
                ToAddresses: ['coach@careerpivoting.com']
            },
            Message: {
                Subject: {
                    Data: `New Contact Form: ${subject} - ${name}`,
                    Charset: 'UTF-8'
                },
                Body: {
                    Text: {
                        Data: emailContent,
                        Charset: 'UTF-8'
                    }
                }
            }
        };
        
        await ses.sendEmail(params).promise();
        
        // Return success response
        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST, OPTIONS'
            },
            body: JSON.stringify({
                message: 'Email sent successfully',
                ok: true
            })
        };
        
    } catch (error) {
        console.error('Error:', error);
        
        return {
            statusCode: 500,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST, OPTIONS'
            },
            body: JSON.stringify({
                error: 'Internal server error',
                message: 'Failed to send email'
            })
        };
    }
};
