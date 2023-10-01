package com.poojithairosha.shofy.mail;

import com.poojithairosha.shofy.util.Env;
import io.rocketbase.mail.model.HtmlTextEmail;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;

public class EmailVerificationMail extends Mailable {
    private final String to;
    private final String verificationCode;
    private final String firstName;
    private final String email;

    public EmailVerificationMail(String to, String verificationCode, String firstName, String email) {
        this.to = to;
        this.verificationCode = verificationCode;
        this.firstName = firstName;
        this.email = email;
    }

    @Override
    public void buildMessage(Message message) throws MessagingException {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Email Verification - Shofy");

        HtmlTextEmail build = getEmailTemplateBuilder()
                .header()
                .logo("https://i.ibb.co/PCzXXMb/logo.png")
                .logoHeight(80)
                .and()
                .text("Welcome, " + firstName + "!").h1().center().and()
                .text("Thanks for trying Shofy. We’re thrilled to have you on board. To get the most out of Shofy, do this primary next step:").and()
                .button("Do this Next", Env.get("app.baseurl") + "/auth/verify-email?code=" + verificationCode).blue().and()
                .text("For reference, here's your login information:").and()
                .attribute()
                .keyValue("Login Page", Env.get("app.baseurl") + "/auth/login")
                .keyValue("Username", email)
                .and()
                .html("If you have any questions, feel free to <a href=\"mailto:info@shofy.com\">email our customer success team</a>. (We're lightning quick at replying.)").and()
                .text("Cheers,\n" +
                        "The Shofy Team").and()
                .copyright("Shofy").url("https://www.shofy.com").suffix(". All rights reserved.").and()
                .footerText("Shofy \n" +
                        "1234 Street Rd.\n" +
                        "Suite 1234").and()
                .build();

        message.setContent(build.getHtml(), "text/html");
    }
}
