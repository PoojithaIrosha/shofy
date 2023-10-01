package com.poojithairosha.shofy.mail;

import com.poojithairosha.shofy.provider.MailServiceProvider;
import com.poojithairosha.shofy.util.Env;
import io.rocketbase.mail.EmailTemplateBuilder;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public abstract class Mailable implements Runnable {

    private final MailServiceProvider mailServiceProvider;
    private EmailTemplateBuilder.EmailTemplateConfigBuilder emailTemplateBuilder;

    public Mailable() {
        this.mailServiceProvider = MailServiceProvider.getInstance();
        emailTemplateBuilder = EmailTemplateBuilder.builder();
    }

    @Override
    public void run() {
        try {
            Session session = Session.getInstance(mailServiceProvider.getProperties(), mailServiceProvider.getAuthenticator());
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Env.get("app.email")));
            buildMessage(message);
            if(message.getRecipients(Message.RecipientType.TO).length > 0) {
                Transport.send(message);
                System.out.println("MailServiceProvider: Message sent successfully...");
            } else {
                System.out.println("MailServiceProvider: No recipients found...");
            }
        }  catch (Exception e) {
            e.printStackTrace();
        }
    }

    public abstract void buildMessage(Message message) throws MessagingException;

    public EmailTemplateBuilder.EmailTemplateConfigBuilder getEmailTemplateBuilder() {
        return emailTemplateBuilder;
    }
}
