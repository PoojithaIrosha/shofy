package com.poojithairosha.shofy.mail;

import com.poojithairosha.shofy.util.Env;
import io.rocketbase.mail.model.HtmlTextEmail;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;

public class ForgotPasswordMail extends Mailable {

    private String to;
    private String verificationCode;
    private String firstName;
    private String email;

    public ForgotPasswordMail(String to, String verificationCode, String firstName, String email) {
        this.to = to;
        this.verificationCode = verificationCode;
        this.firstName = firstName;
        this.email = email;
    }

    @Override
    public void buildMessage(Message message) throws MessagingException {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Forgot Password - Shofy");

        HtmlTextEmail build = getEmailTemplateBuilder().header().logo("https://i.ibb.co/PCzXXMb/logo.png").logoHeight(60)
                .and()
                .text("Hello, " + firstName + "!").h1().center().and()
                .text("We are sending this email because you requested a password reset. Click on the link to create a new password").and()
                .button("Do this Next", Env.get("app.baseurl") + "/auth/reset-password?code=" + verificationCode).blue().and()
                .html("If you have any questions, feel free to <a href=\"mailto:info@shofy.com\">email our customer success team</a>. (We're lightning quick at replying.)").and()
                .text("If you didn't request a password reset, you can ignore this email. Your password will not be changed").and()
                .copyright("shofy").url("https://www.shofy.com").suffix(". All rights reserved.").and()
                .footerText("[Shofy, LLC]\n" +
                        "1234 Street Rd.\n" +
                        "Suite 1234").and()
                .build();


        message.setContent(build.getHtml(), "text/html");

    }
}
