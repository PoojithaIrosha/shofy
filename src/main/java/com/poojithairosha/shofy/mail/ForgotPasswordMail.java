package com.poojithairosha.shofy.mail;

import com.poojithairosha.shofy.util.Env;
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
        message.setContent("<div style=\"display: flex; flex-direction:column; align-items: center;\">\n" +
                "      <h1\n" +
                "        style=\"font-family: monospace; font-weight: bolder\"\n" +
                "      >\n" +
                "        SHOFY - Password Reset\n" +
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
                "      <span style=\"font-family: monospace; color: gray;\">Please press the button RESET PASSWORD</span>\n" +
                "      <br>\n" +
                "      <a\n" +
                "        href=\"" + Env.get("app.baseurl") + "/auth/reset-password?code=" + verificationCode + "\"\n" +
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
                "        >Reset Password</a\n" +
                "      >\n" +
                "    </div>", "text/html");

    }
}
