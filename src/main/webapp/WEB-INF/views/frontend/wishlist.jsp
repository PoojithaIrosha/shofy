<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                            <h3 class="breadcrumb__title">Wishlist</h3>
                            <div class="breadcrumb__list">
                                <span><a href="#">Home</a></span>
                                <span>Wishlist</span>
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
                    <div class="col-xl-12">
                        <div class="tp-cart-list mb-45 mr-30">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th colspan="2" class="tp-cart-header-product">Product</th>
                                    <th class="tp-cart-header-price">Price</th>
                                    <th>Action</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <jsp:useBean id="it" scope="request" type="com.poojithairosha.shofy.model.wishlist.Wishlist"/>
                                <c:forEach items="${it.wishlistItems}" var="wishlistItem">
                                    <%-- Product Start--%>
                                    <tr>
                                        <!-- img -->
                                        <td class="tp-cart-img"><a href="${BASE_URL}products/${wishlistItem.id}"> <img
                                                src="${wishlistItem.product.images.get(0).imageURL}" alt=""></a></td>
                                        <!-- title -->
                                        <td class="tp-cart-title"><a href="${BASE_URL}products/${wishlistItem.id}">${wishlistItem.product.name}</a></td>
                                        <!-- price -->
                                        <fmt:formatNumber var="price" value="${wishlistItem.product.price}" type="currency"/>
                                        <td class="tp-cart-price"><span>${price}</span></td>
                                        <td class="tp-cart-add-to-cart">
                                            <button type="submit" class="tp-btn tp-btn-2 tp-btn-blue" onclick="addToCart('${wishlistItem.product.id}', '1');removeFromWishlist('${it.id}', '${wishlistItem.id}');">Add To Cart</button>
                                        </td>

                                        <!-- action -->
                                        <td class="tp-cart-action">
                                            <button class="tp-cart-action-btn" onclick="removeFromWishlist('${it.id}', '${wishlistItem.id}')">
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
                                    <%-- Product End--%>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="tp-cart-bottom">
                            <div class="row align-items-end">
                                <div class="col-xl-6 col-md-4">
                                    <div class="tp-cart-update">
                                        <a href="${BASE_URL}user/cart" class="tp-cart-update-btn">Go To Cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- cart area end -->

    </layout:put>
</layout:extends>
      