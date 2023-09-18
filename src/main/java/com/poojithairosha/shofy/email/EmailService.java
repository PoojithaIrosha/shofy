package com.poojithairosha.shofy.email;

import java.util.Properties;

import com.poojithairosha.shofy.exception.CustomException;
import com.poojithairosha.shofy.util.ThreadPoolExecutorUtil;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.Authenticator;
import jakarta.ws.rs.core.Response;

public class EmailService {

    public static void sendEmail(String email, String subject, String body) {
        ThreadPoolExecutorUtil.getExecutor().execute(() -> {
            //provide recipient's email ID
            String to = email;

            //provide sender's email ID
            String from = "poojithairosha9311@gmail.com";

            //provide Mailtrap's username
            final String username = "b9ee5552a992f1";

            //provide Mailtrap's password
            final String password = "1fd59c623841f9";

            //provide Mailtrap's host address
            String host = "sandbox.smtp.mailtrap.io";

            //configure Mailtrap's SMTP server details
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.trust", "sandbox.smtp.mailtrap.io");

            Authenticator authenticator = new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            };
            Session session = Session.getInstance(props, authenticator);

            //create a MimeMessage object
            Message message = new MimeMessage(session);
            //set From email field
            try {
                message.setFrom(new InternetAddress(from));

                //set To email field
                message.setRecipients(Message.RecipientType.TO,
                        InternetAddress.parse(to));
                //set email subject field
                message.setSubject(subject);
                //set the content of the email message
                message.setContent(body, "text/html");
                //send the email message
                Transport.send(message);

                System.out.println("Email Message Sent Successfully");
            } catch (MessagingException e) {
                throw new CustomException(Response.Status.INTERNAL_SERVER_ERROR, e.getMessage());
            }
        });
    }
}
