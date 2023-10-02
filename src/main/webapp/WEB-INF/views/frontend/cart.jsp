<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<layout:extends name="base">


    <layout:put block="title" type="REPLACE">
        <title>Cart - Shofy</title>
    </layout:put>

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
                                    <th class="tp-cart-header-quantity">Color</th>
                                    <th class="tp-cart-header-price">Price</th>
                                    <th class="tp-cart-header-quantity">Quantity</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:if test="${it != null && it.cartItems.size() > 0}">

                                    <jsp:useBean id="it" scope="request"
                                                 type="com.poojithairosha.shofy.model.cart.Cart"/>
                                    <c:forEach items="${it.cartItems}" var="item">
                                        <tr>
                                            <!-- img -->
                                            <td class="tp-cart-img"><a href="${BASE_URL}products/${item.product.id}">
                                                <img
                                                        src="${item.product.images.get(0).imageURL}" alt=""></a></td>
                                            <!-- title -->
                                            <td class="tp-cart-title"><a
                                                    href="${BASE_URL}products/${item.product.id}">${item.product.name}</a>
                                            </td>

                                            <!-- color -->
                                            <td>
                                                <div class="tp-product-details-variation-list">
                                                    <button type="button" class="color tp-color-variation-btn active">
                                                        <span class="d-none" id="color-id">${item.color.id}</span>
                                                        <span data-bg-color="${item.color.color}"></span>
                                                        <span class="tp-color-variation-tootltip">${item.color.color}</span>
                                                    </button>
                                                </div>
                                            </td>

                                            <!-- price -->
                                            <fmt:formatNumber var="price" value="${item.quantity * item.product.price}"
                                                              type="currency"/>
                                            <td class="tp-cart-price"><span>${price}</span>
                                            </td>


                                            <!-- quantity -->
                                            <td class="tp-cart-quantity">
                                                <div style="display: flex; align-items: center; gap: 10px">
                                                    <div class="tp-product-quantity mt-10 mb-10">
                                                        <button class="tp-cart-minus"
                                                                onclick="cartQtyDecrement('${item.product.id}','${item.id}')">
                                                            <svg width="10" height="2" viewBox="0 0 10 2" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M1 1H9" stroke="currentColor"
                                                                      stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                            </svg>
                                                        </button>
                                                        <input id="qty-${item.id}" class="tp-cart-input" type="text"
                                                               value="${item.quantity}"
                                                               onkeyup="cartQtyKeyUp('${item.product.id}','${item.id}');">
                                                        <button class="tp-cart-plus"
                                                                onclick="cartQtyIncrement('${item.product.id}','${item.id}');">
                                                            <svg width="10" height="10" viewBox="0 0 10 10" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M5 1V9" stroke="currentColor"
                                                                      stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                                <path d="M1 5H9" stroke="currentColor"
                                                                      stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                            </svg>
                                                        </button>
                                                    </div>
                                                    <div id="update-btn" class="d-none">
                                                        <button class="tp-cart-action-btn"
                                                                onclick="updateQtyBtn('${item.id}')">Update
                                                        </button>
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
                                </c:if>

                                <c:if test="${it == null || it.cartItems.size() <= 0}">
                                    <tr>
                                        <td colspan="6" class="text-center">
                                            <?xml version="1.0" ?>
                                            <svg height="48" viewBox="0 0 48 48" width="48"
                                                 xmlns="http://www.w3.org/2000/svg">
                                                <path d="M0 0h48v48H0V0z" fill="none"/>
                                                <path d="M22 30h4v4h-4zm0-16h4v12h-4zm1.99-10C12.94 4 4 12.95 4 24s8.94 20 19.99 20S44 35.05 44 24 35.04 4 23.99 4zM24 40c-8.84 0-16-7.16-16-16S15.16 8 24 8s16 7.16 16 16-7.16 16-16 16z"/>
                                            </svg>
                                            <h5>Cart is Empty!</h5>
                                        </td>
                                    </tr>
                                </c:if>
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
                                    <div class="d-flex align-items-center justify-content-between">
                                        <span>Standard charges may apply</span>
                                        <svg height="42px" version="1.1" viewBox="0 0 60 52" width="50px"
                                             xmlns="http://www.w3.org/2000/svg"
                                             xmlns:xlink="http://www.w3.org/1999/xlink"><title/>
                                            <desc/>
                                            <defs/>
                                            <g fill="none" fill-rule="evenodd" id="People" stroke="none"
                                               stroke-width="1">
                                                <g fill="#000000" id="Icon-17"
                                                   transform="translate(0.000000, -8.000000)">
                                                    <path d="M40,59 C40,59.552 39.552,60 39,60 L37,60 C36.448,60 36,59.552 36,59 C36,58.448 36.448,58 37,58 L39,58 C39.552,58 40,58.448 40,59 M60,59 C60,59.552 59.552,60 59,60 L43,60 C42.448,60 42,59.552 42,59 C42,58.448 42.448,58 43,58 L59,58 C59.552,58 60,58.448 60,59 M32,59 C32,59.552 31.552,60 31,60 L21,60 C20.448,60 20,59.552 20,59 C20,58.448 20.448,58 21,58 L31,58 C31.552,58 32,58.448 32,59 M16,59 C16,59.552 15.552,60 15,60 L1,60 C0.448,60 0,59.552 0,59 C0,58.448 0.448,58 1,58 L15,58 C15.552,58 16,58.448 16,59 M2,39 C2,38.448 2.448,38 3,38 L5.84,38 L5.417,35.147 C5.336,34.601 5.713,34.092 6.259,34.011 C6.809,33.934 7.315,34.307 7.396,34.853 L7.863,38 L15,38 C15.552,38 16,38.448 16,39 C16,39.552 15.552,40 15,40 L3,40 C2.448,40 2,39.552 2,39 M3,30 L4.559,30 L4.136,27.147 C4.055,26.601 4.432,26.092 4.978,26.011 C5.528,25.935 6.034,26.307 6.114,26.853 L6.582,30 L15,30 C15.552,30 16,30.448 16,31 C16,31.552 15.552,32 15,32 L3,32 C2.448,32 2,31.552 2,31 C2,30.448 2.448,30 3,30 M15,50 C14.449,50 14,49.551 14,49 C14,48.449 14.449,48 15,48 C15.551,48 16,48.449 16,49 C16,49.551 15.551,50 15,50 M15,46 C13.346,46 12,47.346 12,49 C12,50.654 13.346,52 15,52 C16.654,52 18,50.654 18,49 C18,47.346 16.654,46 15,46 M49,50 C48.449,50 48,49.551 48,49 C48,48.449 48.449,48 49,48 C49.551,48 50,48.449 50,49 C50,49.551 49.551,50 49,50 M49,46 C47.346,46 46,47.346 46,49 C46,50.654 47.346,52 49,52 C50.654,52 52,50.654 52,49 C52,47.346 50.654,46 49,46 M49,54 C46.243,54 44,51.757 44,49 C44,46.243 46.243,44 49,44 C51.757,44 54,46.243 54,49 C54,51.757 51.757,54 49,54 M58.707,33.293 L55.966,30.552 L55,19 C55,16.243 52.757,14 50,14 L43,14 C42.448,14 42,14.448 42,15 C42,15.552 42.448,16 43,16 L50,16 C51.626,16 53,17.374 53.003,19.083 L53.913,30 L50.618,30 L51.895,27.447 C52.142,26.953 51.941,26.353 51.447,26.105 C50.952,25.858 50.353,26.059 50.105,26.553 L48.382,30 L43,30 C42.448,30 42,30.448 42,31 C42,31.552 42.448,32 43,32 L54.586,32 L57.293,34.707 C57.863,35.277 57.998,36.588 58,37 L58,48 L55.92,48 C55.433,44.613 52.52,42 49,42 C45.14,42 42,45.14 42,49 C42,52.86 45.14,56 49,56 C52.52,56 55.433,53.387 55.92,50 L59,50 C59.552,50 60,49.552 60,49 L60,37 C60,36.753 59.964,34.549 58.707,33.293 M15,54 C12.243,54 10,51.757 10,49 C10,46.243 12.243,44 15,44 C17.757,44 20,46.243 20,49 C20,51.757 17.757,54 15,54 M39,8 L7,8 C4.243,8 2,10.243 2,13 C2,13.05 2.004,13.099 2.011,13.148 L3.339,22 L1,22 C0.448,22 0,22.448 0,23 C0,23.552 0.448,24 1,24 L15,24 C15.552,24 16,23.552 16,23 C16,22.448 15.552,22 15,22 L5.361,22 L4.001,12.931 C4.038,11.309 5.369,10 7,10 L38,10 L38,48 L21.92,48 C21.433,44.613 18.52,42 15,42 C11.14,42 8,45.14 8,49 C8,52.86 11.14,56 15,56 C18.52,56 21.433,53.387 21.92,50 L39,50 C39.552,50 40,49.552 40,49 L40,9 C40,8.448 39.552,8 39,8"
                                                          id="truck"/>
                                                </g>
                                            </g>
                                        </svg>
                                    </div>
                                </div>
                            </div>

                            <div class="tp-cart-checkout-shipping d-flex align-items-center justify-content-between">
                                <h4 class="tp-cart-checkout-shipping-title">Discount</h4>
                                <span>$0.00</span>
                            </div>

                            <div class="tp-cart-checkout-total d-flex align-items-center justify-content-between">
                                <span>Total</span>
                                <span>${total}</span>
                            </div>

                            <div class="tp-cart-checkout-proceed">`
                                <c:if test="${it.cartItems.size() <= 0}">
                                    <a href="#" class="tp-cart-checkout-btn w-100">Proceed to
                                        Checkout</a>
                                </c:if>
                                <c:if test="${it.cartItems.size() > 0}">
                                    <a href="${BASE_URL}user/checkout" class="tp-cart-checkout-btn w-100">Proceed to
                                        Checkout</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- cart area end -->
    </layout:put>
</layout:extends>