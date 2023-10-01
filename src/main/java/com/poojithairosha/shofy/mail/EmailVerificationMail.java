package com.poojithairosha.shofy.mail;

import com.poojithairosha.shofy.util.Env;
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
        message.setContent("<div style=\"display: flex; flex-direction:column; align-items: center;\">\n" +
                "      <h1\n" +
                "        style=\"font-family: monospace; font-weight: bolder\"\n" +
                "      >\n" +
                "        SHOFY - Email Verification\n" +
                "    </h1>\n" +
                "      <table style=\"font-family: monospace\">\n" +
                "        <tr>\n" +
                "          <td>Name:</td>\n" +
                "          <td>" + firstName + "</td>\n" +
                "        </tr>\n" +
                "        <tr>\n" +
                "          <td>Email:</td>\n" +
                "          <td>" + email + "</td>\n" +
                "        </tr>\n" +
                "      </table>\n" +
                "      <br />\n" +
                "      <span style=\"font-family: monospace; color: gray;\">Please verify your email address by pressing the below button</span>\n" +
                "      <br>\n" +
                "      <a\n" +
                "        href=\"" + Env.get("app.baseurl") + "/auth/verify-email?code=" + verificationCode + "\"\n" +
                "        style=\"\n" +
                "          background-color: crimson;\n" +
                "          border: none;\n" +
                "          color: white;\n" +
                "          padding: 10px 50px;\n" +
                "          border-radius: 5px;\n" +
                "          text-decoration: none;\n" +
                "          text-transform: uppercase;\n" +
                "          font-family: monospace;\n" +
                "          letter-spacing: 1px;\n" +
                "        \"\n" +
                "        >Verify Email</a\n" +
                "      >\n" +
                "    </div>", "text/html");
    }
}
