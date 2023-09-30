package com.poojithairosha.shofy.mail;

import com.poojithairosha.shofy.model.order.Order;
import com.poojithairosha.shofy.model.order.OrderItem;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class OrderConfirmationMail extends Mailable {
    private final String to;
    private static final SimpleDateFormat SIMPLE_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    private String emailContent;

    public OrderConfirmationMail(String to, Order order) {
        this.to = to;

        emailContent = "<!DOCTYPE html>\n" +
                "<html>\n" +
                "<head>\n" +
                "  <link\n" +
                "          href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css\"\n" +
                "          rel=\"stylesheet\"\n" +
                "          integrity=\"sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN\"\n" +
                "          crossorigin=\"anonymous\"\n" +
                "  />\n" +
                "  <style>\n" +
                "    .tp-order-details {\n" +
                "      padding: 70px 100px 55px;\n" +
                "    }\n" +
                "    @media only screen and (min-width: 1200px) and (max-width: 1399px) {\n" +
                "      .tp-order-details {\n" +
                "        padding: 70px 70px 55px;\n" +
                "      }\n" +
                "    }\n" +
                "    @media only screen and (min-width: 992px) and (max-width: 1199px) {\n" +
                "      .tp-order-details {\n" +
                "        padding: 70px 30px 55px;\n" +
                "      }\n" +
                "    }\n" +
                "    @media only screen and (min-width: 576px) and (max-width: 767px) {\n" +
                "      .tp-order-details {\n" +
                "        padding: 70px 50px 55px;\n" +
                "      }\n" +
                "    }\n" +
                "    @media (max-width: 575px) {\n" +
                "      .tp-order-details {\n" +
                "        padding: 40px 30px 45px;\n" +
                "      }\n" +
                "    }\n" +
                "    .tp-order-details-icon {\n" +
                "      margin-bottom: 22px;\n" +
                "    }\n" +
                "    .tp-order-details-icon span {\n" +
                "      display: inline-block;\n" +
                "      width: 120px;\n" +
                "      height: 120px;\n" +
                "      line-height: 118px;\n" +
                "      text-align: center;\n" +
                "      font-size: 55px;\n" +
                "      color: #ffffff;\n" +
                "      border: 1px solid rgba(255, 255, 255, 0.2);\n" +
                "      border-radius: 50%;\n" +
                "    }\n" +
                "    .tp-order-details-title {\n" +
                "      font-size: 30px;\n" +
                "      font-weight: 600;\n" +
                "      color: #ffffff;\n" +
                "      margin-bottom: 7px;\n" +
                "    }\n" +
                "    .tp-order-details-content p {\n" +
                "      font-size: 16px;\n" +
                "      color: #ffffff;\n" +
                "      line-height: 1.38;\n" +
                "    }\n" +
                "    .tp-order-details-item {\n" +
                "      margin-bottom: 38px;\n" +
                "    }\n" +
                "    .tp-order-details-item-wrapper\n" +
                "    .row\n" +
                "    [class*=\"col-\"]:nth-child(2n)\n" +
                "    .tp-order-details-item {\n" +
                "      padding-left: 40px;\n" +
                "    }\n" +
                "    @media (max-width: 575px) {\n" +
                "      .tp-order-details-item-wrapper\n" +
                "      .row\n" +
                "      [class*=\"col-\"]:nth-child(2n)\n" +
                "      .tp-order-details-item {\n" +
                "        padding-left: 0;\n" +
                "      }\n" +
                "    }\n" +
                "    .tp-order-details-item h4 {\n" +
                "      font-size: 18px;\n" +
                "      color: #ffffff;\n" +
                "      margin-bottom: 0;\n" +
                "      font-weight: 400;\n" +
                "    }\n" +
                "    .tp-order-details-item p {\n" +
                "      font-weight: 700;\n" +
                "      font-size: 18px;\n" +
                "      color: #ffffff;\n" +
                "      margin-bottom: 0;\n" +
                "    }\n" +
                "    .tp-order-info-wrapper {\n" +
                "      padding: 42px 50px;\n" +
                "    }\n" +
                "    @media only screen and (min-width: 992px) and (max-width: 1199px) {\n" +
                "      .tp-order-info-wrapper {\n" +
                "        padding: 42px 40px;\n" +
                "      }\n" +
                "    }\n" +
                "    @media (max-width: 575px) {\n" +
                "      .tp-order-info-wrapper {\n" +
                "        padding: 42px 30px;\n" +
                "      }\n" +
                "    }\n" +
                "    .tp-order-info-title {\n" +
                "      font-size: 26px;\n" +
                "      font-weight: 600;\n" +
                "      margin-bottom: 40px;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li {\n" +
                "      list-style: none;\n" +
                "      padding: 15px 0;\n" +
                "      display: -webkit-box;\n" +
                "      display: -moz-box;\n" +
                "      display: -ms-flexbox;\n" +
                "      display: -webkit-flex;\n" +
                "      display: flex;\n" +
                "      align-items: center;\n" +
                "      justify-content: space-between;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li:not(:last-child) {\n" +
                "      border-bottom: 1px solid #e0e2e3;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li span {\n" +
                "      font-size: 15px;\n" +
                "      color: #010f1c;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-header {\n" +
                "      padding-top: 0;\n" +
                "      padding-bottom: 12px;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-header h4 {\n" +
                "      font-size: 16px;\n" +
                "      font-weight: 500;\n" +
                "      margin-bottom: 0;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-desc p {\n" +
                "      font-size: 15px;\n" +
                "      margin-bottom: 0;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-desc p span {\n" +
                "      font-size: 15px;\n" +
                "      font-weight: 500;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-subtotal span:last-child {\n" +
                "      color: #0989ff;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-shipping span input {\n" +
                "      display: none;\n" +
                "    }\n" +
                "    .tp-order-info-list\n" +
                "    ul\n" +
                "    li.tp-order-info-list-shipping\n" +
                "    span\n" +
                "    input:checked\n" +
                "    ~ label::after {\n" +
                "      border-color: #0989ff;\n" +
                "    }\n" +
                "    .tp-order-info-list\n" +
                "    ul\n" +
                "    li.tp-order-info-list-shipping\n" +
                "    span\n" +
                "    input:checked\n" +
                "    ~ label::before {\n" +
                "      opacity: 1;\n" +
                "      visibility: visible;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-shipping span label {\n" +
                "      font-size: 14px;\n" +
                "      position: relative;\n" +
                "      padding-right: 27px;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-shipping span label span {\n" +
                "      color: #0989ff;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-shipping span label:hover {\n" +
                "      cursor: pointer;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-shipping span label::after {\n" +
                "      position: absolute;\n" +
                "      content: \"\";\n" +
                "      right: 0;\n" +
                "      top: 5px;\n" +
                "      width: 16px;\n" +
                "      height: 16px;\n" +
                "      border-radius: 50%;\n" +
                "      border: 1px solid #bcbcbc;\n" +
                "      -webkit-transition: all 0.2s 0s ease-out;\n" +
                "      -moz-transition: all 0.2s 0s ease-out;\n" +
                "      -ms-transition: all 0.2s 0s ease-out;\n" +
                "      -o-transition: all 0.2s 0s ease-out;\n" +
                "      transition: all 0.2s 0s ease-out;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-shipping span label::before {\n" +
                "      position: absolute;\n" +
                "      content: \"\";\n" +
                "      right: 4px;\n" +
                "      top: 9px;\n" +
                "      width: 8px;\n" +
                "      height: 8px;\n" +
                "      border-radius: 50%;\n" +
                "      background-color: #0989ff;\n" +
                "      visibility: hidden;\n" +
                "      opacity: 0;\n" +
                "      -webkit-transition: all 0.2s 0s ease-out;\n" +
                "      -moz-transition: all 0.2s 0s ease-out;\n" +
                "      -ms-transition: all 0.2s 0s ease-out;\n" +
                "      -o-transition: all 0.2s 0s ease-out;\n" +
                "      transition: all 0.2s 0s ease-out;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-total {\n" +
                "      padding: 14px 0;\n" +
                "    }\n" +
                "    .tp-order-info-list ul li.tp-order-info-list-total span {\n" +
                "      font-size: 16px;\n" +
                "      font-weight: 500;\n" +
                "    }\n" +
                "    .tp-order-inner {\n" +
                "      background-color: #ffffff;\n" +
                "      box-shadow: 0px 30px 70px rgba(1, 15, 28, 0.1);\n" +
                "    }\n" +
                "  </style>\n" +
                "</head>\n" +
                "<body style=\"height: 100vh; display: flex; align-items: center; justify-content: center;\">\n" +
                "<section\n" +
                "        class=\"tp-order-area pb-160\">\n" +
                "  <div class=\"container\">\n" +
                "    <div class=\"tp-order-inner\">\n" +
                "      <div class=\"row gx-0\">\n" +
                "        <div class=\"col-lg-6\" style=\"background-color: #4f3d97\">\n" +
                "          <div class=\"tp-order-details\" data-bg-color=\"#4F3D97\">\n" +
                "            <div class=\"tp-order-details-top text-center mb-70\">\n" +
                "              <div\n" +
                "                      class=\"tp-order-details-icon d-flex justify-content-center\"\n" +
                "              >\n" +
                "                    <span\n" +
                "                            class=\"d-flex align-items-center justify-content-center\"\n" +
                "                    >\n" +
                "                      <svg\n" +
                "                              width=\"52\"\n" +
                "                              height=\"52\"\n" +
                "                              viewBox=\"0 0 52 52\"\n" +
                "                              fill=\"none\"\n" +
                "                              xmlns=\"http://www.w3.org/2000/svg\"\n" +
                "                      >\n" +
                "                        <path\n" +
                "                                d=\"M46 26V51H6V26\"\n" +
                "                                stroke=\"currentColor\"\n" +
                "                                stroke-width=\"2\"\n" +
                "                                stroke-linecap=\"round\"\n" +
                "                                stroke-linejoin=\"round\"\n" +
                "                        />\n" +
                "                        <path\n" +
                "                                d=\"M51 13.5H1V26H51V13.5Z\"\n" +
                "                                stroke=\"currentColor\"\n" +
                "                                stroke-width=\"2\"\n" +
                "                                stroke-linecap=\"round\"\n" +
                "                                stroke-linejoin=\"round\"\n" +
                "                        />\n" +
                "                        <path\n" +
                "                                d=\"M26 51V13.5\"\n" +
                "                                stroke=\"currentColor\"\n" +
                "                                stroke-width=\"2\"\n" +
                "                                stroke-linecap=\"round\"\n" +
                "                                stroke-linejoin=\"round\"\n" +
                "                        />\n" +
                "                        <path\n" +
                "                                d=\"M26 13.5H14.75C13.0924 13.5 11.5027 12.8415 10.3306 11.6694C9.15848 10.4973 8.5 8.9076 8.5 7.25C8.5 5.5924 9.15848 4.00269 10.3306 2.83058C11.5027 1.65848 13.0924 1 14.75 1C23.5 1 26 13.5 26 13.5Z\"\n" +
                "                                stroke=\"currentColor\"\n" +
                "                                stroke-width=\"2\"\n" +
                "                                stroke-linecap=\"round\"\n" +
                "                                stroke-linejoin=\"round\"\n" +
                "                        />\n" +
                "                        <path\n" +
                "                                d=\"M26 13.5H37.25C38.9076 13.5 40.4973 12.8415 41.6694 11.6694C42.8415 10.4973 43.5 8.9076 43.5 7.25C43.5 5.5924 42.8415 4.00269 41.6694 2.83058C40.4973 1.65848 38.9076 1 37.25 1C28.5 1 26 13.5 26 13.5Z\"\n" +
                "                                stroke=\"currentColor\"\n" +
                "                                stroke-width=\"2\"\n" +
                "                                stroke-linecap=\"round\"\n" +
                "                                stroke-linejoin=\"round\"\n" +
                "                        />\n" +
                "                      </svg>\n" +
                "                    </span>\n" +
                "              </div>\n" +
                "              <div class=\"tp-order-details-content\">\n" +
                "                <h3 class=\"tp-order-details-title\">Your Order Confirmed</h3>\n" +
                "                <p>\n" +
                "                  We will send you a shipping confirmation email as soon\n" +
                "                  <br />\n" +
                "                  as your order ships\n" +
                "                </p>\n" +
                "              </div>\n" +
                "            </div>\n" +
                "            <div class=\"tp-order-details-item-wrapper\">\n" +
                "              <div class=\"row\">\n" +
                "                <div class=\"col-sm-6\">\n" +
                "                  <div class=\"tp-order-details-item\">\n" +
                "                    <h4>Order Date:</h4>\n" +
                "                    <p>" + SIMPLE_DATE_FORMAT.format(Timestamp.valueOf(order.getOrderDate())) + "</p>\n" +
                "                  </div>\n" +
                "                </div>\n" +
                "                <div class=\"col-sm-6\">\n" +
                "                  <div class=\"tp-order-details-item\">\n" +
                "                    <h4>Expected Delivery:</h4>\n" +
                "                    <p>" + SIMPLE_DATE_FORMAT.format(Timestamp.valueOf(order.getOrderDate().plusDays(7))) + "</p>\n" +
                "                  </div>\n" +
                "                </div>\n" +
                "                <div class=\"col-sm-6\">\n" +
                "                  <div class=\"tp-order-details-item\">\n" +
                "                    <h4>Order Number:</h4>\n" +
                "                    <p>#" + order.getId() + "</p>\n" +
                "                  </div>\n" +
                "                </div>\n" +
                "                <div class=\"col-sm-6\">\n" +
                "                  <div class=\"tp-order-details-item\">\n" +
                "                    <h4>Order Status:</h4>\n" +
                "                    <p>" + order.getOrderStatus() + "</p>\n" +
                "                  </div>\n" +
                "                </div>\n" +
                "              </div>\n" +
                "            </div>\n" +
                "          </div>\n" +
                "        </div>\n" +
                "        <div class=\"col-lg-6\">\n" +
                "          <div class=\"tp-order-info-wrapper\">\n" +
                "            <h4 class=\"tp-order-info-title\">Order Details</h4>\n" +
                "\n" +
                "            <div class=\"tp-order-info-list\">\n" +
                "              <ul>\n" +
                "                <!-- header -->\n" +
                "                <li class=\"tp-order-info-list-header\">\n" +
                "                  <h4>Product</h4>\n" +
                "                  <h4>Total</h4>\n" +
                "                </li>\n" +
                "\n" +
                "                <!-- item list -->\n" +
                "                {{listItems}}" +
                "\n" +
                "                <!-- subtotal -->\n" +
                "                <li class=\"tp-order-info-list-subtotal\">\n" +
                "                  <span>Subtotal</span>\n" +
                "                  <span>$" + (order.getTotal() - order.getDeliveryFee().getFee()) + "</span>\n" +
                "                </li>\n" +
                "\n" +
                "                <!-- shipping -->\n" +
                "                <!-- shipping -->\n" +
                "                <li class=\"tp-order-info-list-shipping\">\n" +
                "                  <span>Shipping</span>\n" +
                "                  <div\n" +
                "                          class=\"tp-order-info-list-shipping-item d-flex flex-column align-items-end\"\n" +
                "                  >\n" +
                "                        <span>\n" +
                "                          <input id=\"shipping_info\" type=\"checkbox\" checked/>\n" +
                "                          <label for=\"shipping_info\"\n" +
                "                          >" + order.getDeliveryFee().getCity() + ": <span>$" + order.getDeliveryFee().getFee() + "</span></label\n" +
                "                          >\n" +
                "                        </span>\n" +
                "                  </div>\n" +
                "                </li>\n" +
                "\n" +
                "                <!-- total -->\n" +
                "                <li class=\"tp-order-info-list-total\">\n" +
                "                  <span>Total</span>\n" +
                "                  <span>$" + order.getTotal() + "</span>\n" +
                "                </li>\n" +
                "              </ul>\n" +
                "            </div>\n" +
                "          </div>\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "  </div>\n" +
                "</section>\n" +
                "</body>\n" +
                "</html>\n";

        StringBuilder listHTML = new StringBuilder();
        for (OrderItem orderItem : order.getOrderItems()) {
            listHTML.append("<li class='tp-order-info-list-desc'>").append("<p>").append(orderItem.getProduct().getName()).append(" <span> x ").append(orderItem.getQuantity()).append("</span></p>").append("<span>$" + orderItem.getPrice() + "</span>").append("</li>");
        }
        emailContent = emailContent.replace("{{listItems}}", listHTML.toString());
    }

    @Override
    public void buildMessage(Message message) throws MessagingException {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Order Confirmation");
        message.setContent(emailContent, "text/html");
    }
}
