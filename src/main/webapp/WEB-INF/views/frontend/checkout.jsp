<%@ page import="com.poojithairosha.shofy.model.user.User" %>
<%@ page import="com.poojithairosha.shofy.model.cart.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poojithairosha.shofy.model.order.DeliveryFee" %>
<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="it" scope="request" type="java.util.HashMap<java.lang.String, java.lang.Object>"/>

<%
    request.setAttribute("user", (User) it.get("user"));
    request.setAttribute("cart", (Cart) it.get("cart"));
    request.setAttribute("buyNow", it.get("buyNow"));
    request.setAttribute("deliveryFees", it.get("deliveryFees"));
%>
<layout:extends name="base">


    <layout:put block="title" type="REPLACE">
        <title>Checkout - Shofy</title>
    </layout:put>

    <layout:put block="header" type="REPLACE">
        <jsp:include page="includes/header-2.jsp"/>
    </layout:put>

    <layout:put block="main-content" type="REPLACE">


        <!-- breadcrumb area start -->
        <section class="breadcrumb__area include-bg pt-95 pb-50" data-bg-color="#EFF1F5">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-12">
                        <div class="breadcrumb__content p-relative z-index-1">
                            <h3 class="breadcrumb__title">Checkout</h3>
                            <div class="breadcrumb__list">
                                <span><a href="#">Home</a></span>
                                <span>Checkout</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- breadcrumb area end -->

        <!-- checkout area start -->
        <section class="tp-checkout-area pb-120" data-bg-color="#EFF1F5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="tp-checkout-bill-area">
                            <h3 class="tp-checkout-bill-title">Billing Details</h3>
                            <div class="tp-checkout-bill-form">
                                <form action="#">
                                    <div class="tp-checkout-bill-inner">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="tp-checkout-input">
                                                    <label>First Name <span>*</span></label>
                                                    <input id="firstName" type="text" placeholder="First Name"
                                                           value="${user.firstName}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="tp-checkout-input">
                                                    <label>Last Name <span>*</span></label>
                                                    <input id="lastName" type="text" placeholder="Last Name"
                                                           value="${user.lastName}">
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="tp-checkout-input">
                                                    <label>Phone <span>*</span></label>
                                                    <input id="mobile" type="text" placeholder=""
                                                           value="${user.mobileNumber}">
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="tp-checkout-input">
                                                    <label>Email address <span>*</span></label>
                                                    <input id="email" type="email" placeholder="" value="${user.email}">
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="tp-checkout-input">
                                                    <label>Street address</label>
                                                    <input id="addressLine1" type="text"
                                                           placeholder="House number and street name"
                                                           value="${user.userAddress.addressLine1}">
                                                </div>

                                                <div class="tp-checkout-input">
                                                    <input id="addressLine2" type="text"
                                                           placeholder="Apartment, suite, unit, etc. (optional)"
                                                           value="${user.userAddress.addressLine2}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="tp-checkout-input">
                                                    <label>Town / City</label>
                                                    <input id="city" type="text" placeholder=""
                                                           value="${user.userAddress.city}">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="tp-checkout-input">
                                                    <label>Postcode ZIP</label>
                                                    <input id="zipCode" type="text" placeholder=""
                                                           value="${user.userAddress.zipCode}">
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <!-- checkout place order -->
                        <div class="tp-checkout-place white-bg">
                            <h3 class="tp-checkout-place-title mb-3">Your Order</h3>

                            <div class="tp-order-info-list">
                                <ul>

                                    <!-- header -->
                                    <li class="tp-order-info-list-header">
                                        <h4>Product</h4>
                                        <h4>Total</h4>
                                    </li>

                                    <!-- item list -->
                                    <c:forEach items="${cart.cartItems}" var="cartItem">
                                        <li class="tp-order-info-list-desc">
                                            <p>${cartItem.product.name} <span> x ${cartItem.quantity}</span></p>
                                            <fmt:formatNumber var="itemPrice"
                                                              value="${cartItem.product.price * cartItem.quantity}"
                                                              type="currency"/>
                                            <span>${itemPrice}</span>
                                        </li>
                                    </c:forEach>

                                    <!-- subtotal -->
                                    <li class="tp-order-info-list-subtotal">
                                        <span>Subtotal</span>
                                        <fmt:formatNumber var="subTotal" value="${cart.total}" type="currency"/>
                                        <span>${subTotal}</span>
                                    </li>

                                    <!-- shipping -->
                                    <li class="tp-order-info-list-shipping">
                                        <span>Shipping</span>
                                        <div class="tp-order-info-list-shipping-item d-flex flex-column align-items-end">
                                            <c:forEach items="${deliveryFees}" var="deliveryFee" varStatus="dfv">
                                                <fmt:formatNumber var="deliveryPriceFmt" value="${deliveryFee.fee}"
                                                                  type="currency"/>
                                                <span>
                                                    <input class="delivery-fee-radio ${dfv.index == 0 ? "active" : ""}"
                                                           id="${deliveryFee.city}" type="radio" name="shipping"
                                                           value="${deliveryFee.id}" ${dfv.index == 0 ? "checked" : ""}
                                                           onchange="changeDelivery('${cart.total}', '${deliveryFee.fee}');">
                                                    <label for="${deliveryFee.city}">${deliveryFee.city}: <span>${deliveryPriceFmt}</span></label>
                                                </span>
                                            </c:forEach>
                                        </div>
                                    </li>

                                    <!-- total -->
                                    <li class="tp-order-info-list-total">
                                        <span>Total</span>
                                        <fmt:formatNumber value="${cart.total + deliveryFees.get(0).fee}"
                                                          type="currency" var="total"/>
                                        <span id="total">${total}</span>
                                        <span class="d-none"
                                              id="total-unformatted">${cart.total + deliveryFees.get(0).fee}</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="tp-checkout-payment">
                                <div class="tp-checkout-payment-item paypal-payment">
                                    <input type="radio" id="payhere" name="payment" checked>
                                    <label for="payhere">PayHere <img
                                            src="${BASE_URL}assets/img/icon/payment-option.png"
                                            alt=""> </label>
                                </div>
                            </div>
                            <div class="tp-checkout-agree">
                                <div class="tp-checkout-option">
                                    <input id="read_all" type="checkbox" checked>
                                    <label for="read_all">I have read and agree to the website.</label>
                                </div>
                            </div>
                            <div class="tp-checkout-btn-wrapper">
                                <c:if test="${buyNow}">
                                    <button class="tp-checkout-btn w-100" onclick="buyNow('${cart.cartItems.get(0).product.id}', '${cart.cartItems.get(0).quantity}', '${cart.cartItems.get(0).color.id}')">Place Order</button>
                                </c:if>

                                <c:if test="${!buyNow}">
                                    <button class="tp-checkout-btn w-100" onclick="checkout()">Place Order</button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- checkout area end -->
    </layout:put>
    <layout:put block="scripts" type="APPEND">
        <script type="text/javascript" src="https://www.payhere.lk/lib/payhere.js"></script>
    </layout:put>
</layout:extends>

