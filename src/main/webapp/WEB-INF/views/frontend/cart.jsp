<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="it" scope="request" type="com.poojithairosha.shofy.model.cart.Cart"/>

<layout:extends name="base">

    <layout:put block="header" type="REPLACE">
        <jsp:include page="includes/header-2.jsp"/>
    </layout:put>

    <layout:put block="main-content" type="REPLACE">


        <!-- breadcrumb area start -->
        <section class="breadcrumb__area include-bg pt-95 pb-50">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-12">
                        <div class="breadcrumb__content p-relative z-index-1">
                            <h3 class="breadcrumb__title">Shopping Cart</h3>
                            <div class="breadcrumb__list">
                                <span><a href="#">Home</a></span>
                                <span>Shopping Cart</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- breadcrumb area end -->

        <!-- cart area start -->
        <section class="tp-cart-area pb-120">
            <div class="container">
                <div class="row">
                    <div class="col-xl-9 col-lg-8">
                        <div class="tp-cart-list mb-25 mr-30">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th colspan="2" class="tp-cart-header-product">Product</th>
                                    <th class="tp-cart-header-price">Price</th>
                                    <th class="tp-cart-header-quantity">Quantity</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${it.cartItems}" var="item">
                                    <tr>
                                        <!-- img -->
                                        <td class="tp-cart-img"><a href="${BASE_URL}products/${item.id}"> <img
                                                src="${item.product.images.get(0).imageURL}" alt=""></a></td>
                                        <!-- title -->
                                        <td class="tp-cart-title"><a
                                                href="${BASE_URL}products/${item.id}">${item.product.name}</a></td>
                                        <!-- price -->
                                        <fmt:formatNumber var="price" value="${item.quantity * item.product.price}" type="currency"/>
                                        <td class="tp-cart-price"><span>${price}</span>
                                        </td>
                                        <!-- quantity -->
                                        <td class="tp-cart-quantity">
                                            <div style="display: flex; align-items: center; gap: 10px">
                                            <div class="tp-product-quantity mt-10 mb-10">
                                            <button class="tp-cart-minus" onclick="cartQtyDecrement('${item.product.id}','${item.id}')">
                                            <svg width="10" height="2" viewBox="0 0 10 2" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1 1H9" stroke="currentColor" stroke-width="1.5"
                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            </button>
                                                <input id="qty-${item.id}" class="tp-cart-input" type="text" value="${item.quantity}" onkeyup="cartQtyKeyUp('${item.product.id}','${item.id}');">
                                                <button class="tp-cart-plus" onclick="cartQtyIncrement('${item.product.id}','${item.id}');">
                                            <svg width="10" height="10" viewBox="0 0 10 10" fill="none"
                                                 xmlns="http://www.w3.org/2000/svg">
                                            <path d="M5 1V9" stroke="currentColor" stroke-width="1.5"
                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M1 5H9" stroke="currentColor" stroke-width="1.5"
                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                            </button>
                                            </div>
                                            <div id="update-btn" class="d-none">
                                                <button class="tp-cart-action-btn" onclick="updateQtyBtn('${item.id}')">Update</button>
                                            </div>
                                            </div>
                                        </td>
                                        <!-- action -->
                                        <td class="tp-cart-action">
                                            <button onclick="removeFromCart('${it.id}', '${item.id}');"
                                                    class="tp-cart-action-btn">
                                                <svg width="10" height="10" viewBox="0 0 10 10" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd"
                                                          d="M9.53033 1.53033C9.82322 1.23744 9.82322 0.762563 9.53033 0.46967C9.23744 0.176777 8.76256 0.176777 8.46967 0.46967L5 3.93934L1.53033 0.46967C1.23744 0.176777 0.762563 0.176777 0.46967 0.46967C0.176777 0.762563 0.176777 1.23744 0.46967 1.53033L3.93934 5L0.46967 8.46967C0.176777 8.76256 0.176777 9.23744 0.46967 9.53033C0.762563 9.82322 1.23744 9.82322 1.53033 9.53033L5 6.06066L8.46967 9.53033C8.76256 9.82322 9.23744 9.82322 9.53033 9.53033C9.82322 9.23744 9.82322 8.76256 9.53033 8.46967L6.06066 5L9.53033 1.53033Z"
                                                          fill="currentColor"/>
                                                </svg>
                                                <span>Remove</span>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="tp-cart-bottom">
                            <div class="row align-items-end">
                                <div class="col-xl-6 col-md-8">
                                    <div class="tp-cart-coupon">
<%--                                        <form action="#">--%>
                                            <div class="tp-cart-coupon-input-box">
                                                <label>Coupon Code:</label>
                                                <div class="tp-cart-coupon-input d-flex align-items-center">
                                                    <input type="text" placeholder="Enter Coupon Code">
                                                    <button type="submit">Apply</button>
                                                </div>
                                            </div>
<%--                                        </form>--%>
                                    </div>
                                </div>
                                <div class="col-xl-6 col-md-4">
                                    <div class="tp-cart-update text-md-end">
<%--                                        <button type="button" class="tp-cart-update-btn">Update Cart</button>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-lg-4 col-md-6">
                        <div class="tp-cart-checkout-wrapper">
                            <div class="tp-cart-checkout-top d-flex align-items-center justify-content-between">
                                <span class="tp-cart-checkout-top-title">Subtotal</span>
                                <fmt:formatNumber var="total" value="${it.total}" type="currency"/>
                                <span class="tp-cart-checkout-top-price">${total}</span>
                            </div>
                            <div class="tp-cart-checkout-shipping">
                                <h4 class="tp-cart-checkout-shipping-title">Shipping</h4>

                                <div class="tp-cart-checkout-shipping-option-wrapper">
                                    <div class="tp-cart-checkout-shipping-option">
                                        <input id="flat_rate" type="radio" name="shipping">
                                        <label for="flat_rate">Flat rate: <span>$20.00</span></label>
                                    </div>
                                    <div class="tp-cart-checkout-shipping-option">
                                        <input id="local_pickup" type="radio" name="shipping">
                                        <label for="local_pickup">Local pickup: <span> $25.00</span></label>
                                    </div>
                                    <div class="tp-cart-checkout-shipping-option">
                                        <input id="free_shipping" type="radio" name="shipping">
                                        <label for="free_shipping">Free shipping</label>
                                    </div>
                                </div>
                            </div>
                            <div class="tp-cart-checkout-total d-flex align-items-center justify-content-between">
                                <span>Total</span>
                                <span>${it.total}</span>
                            </div>
                            <div class="tp-cart-checkout-proceed">
                                <a href="checkout.html" class="tp-cart-checkout-btn w-100">Proceed to Checkout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- cart area end -->
    </layout:put>
</layout:extends>