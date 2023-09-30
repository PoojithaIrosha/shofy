<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.setAttribute("page", request.getParameter("page"));
    request.setAttribute("search", request.getParameter("search"));
    request.setAttribute("category", request.getParameter("category"));
    request.setAttribute("priceMin", request.getParameter("price-min"));
    request.setAttribute("priceMax", request.getParameter("price-max"));
%>

<layout:extends name="base">
    <layout:put block="main-content" type="REPLACE">
        <!-- breadcrumb area start -->
        <section class="breadcrumb__area include-bg pt-100 pb-50">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-12">
                        <div class="breadcrumb__content p-relative z-index-1">
                            <h3 class="breadcrumb__title">Shop Grid</h3>
                            <div class="breadcrumb__list">
                                <span><a href="#">Home</a></span>
                                <span>Shop Grid</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- breadcrumb area end -->

        <!-- shop area start -->
        <section class="tp-shop-area pb-120">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-lg-4">
                        <div class="tp-shop-sidebar mr-10">
                            <!-- filter -->
                            <div class="tp-shop-widget mb-35">
                                <h3 class="tp-shop-widget-title no-border">Price Filter</h3>

                                <form action="${BASE_URL}products">
                                    <input type="hidden" name="page" value="${page}" />
                                    <input type="hidden" name="search" value="${search}" />
                                    <input type="hidden" name="category" value="${category}" />

                                    <div class="tp-shop-widget-content">
                                        <div class="tp-shop-widget-filter">
                                            <div id="slider-range" class="mb-10"></div>
                                            <div class="tp-shop-widget-filter-info d-flex align-items-center justify-content-between">
                                                <input type="text" name="price-min" id="min-price" style="height: 30px" placeholder="MIN" value="${priceMin}">
                                                <input type="text" name="price-max" id="max-price" style="height: 30px" placeholder="MAX" value="${priceMax}">
                                                <button class="tp-shop-widget-filter-btn" type="submit">Filter</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- product rating -->
                            <div class="tp-shop-widget mb-50">
                                <h3 class="tp-shop-widget-title">Top Rated Products</h3>

                                <div class="tp-shop-widget-content">
                                    <div class="tp-shop-widget-product">
                                        <div class="tp-shop-widget-product-item d-flex align-items-center">
                                            <div class="tp-shop-widget-product-thumb">
                                                <a href="product-details.html">
                                                    <img src="${BASE_URL}assets/img/product/shop/sm/shop-sm-1.jpg"
                                                         alt="">
                                                </a>
                                            </div>
                                            <div class="tp-shop-widget-product-content">
                                                <div class="tp-shop-widget-product-rating-wrapper d-flex align-items-center">
                                                    <div class="tp-shop-widget-product-rating">
                                             <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                    </div>
                                                    <div class="tp-shop-widget-product-rating-number">
                                                        <span>(4.2)</span>
                                                    </div>
                                                </div>
                                                <h4 class="tp-shop-widget-product-title">
                                                    <a href="product-details.html">Smart watches wood...</a>
                                                </h4>
                                                <div class="tp-shop-widget-product-price-wrapper">
                                                    <span class="tp-shop-widget-product-price">$150.00</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tp-shop-widget-product-item d-flex align-items-center">
                                            <div class="tp-shop-widget-product-thumb">
                                                <a href="product-details.html">
                                                    <img src="${BASE_URL}assets/img/product/shop/sm/shop-sm-2.jpg"
                                                         alt="">
                                                </a>
                                            </div>
                                            <div class="tp-shop-widget-product-content">
                                                <div class="tp-shop-widget-product-rating-wrapper d-flex align-items-center">
                                                    <div class="tp-shop-widget-product-rating">
                                             <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                    </div>
                                                    <div class="tp-shop-widget-product-rating-number">
                                                        <span>(4.5)</span>
                                                    </div>
                                                </div>
                                                <h4 class="tp-shop-widget-product-title">
                                                    <a href="product-details.html">Decoration for panda.</a>
                                                </h4>
                                                <div class="tp-shop-widget-product-price-wrapper">
                                                    <span class="tp-shop-widget-product-price">$120.00</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tp-shop-widget-product-item d-flex align-items-center">
                                            <div class="tp-shop-widget-product-thumb">
                                                <a href="product-details.html">
                                                    <img src="${BASE_URL}assets/img/product/shop/sm/shop-sm-3.jpg"
                                                         alt="">
                                                </a>
                                            </div>
                                            <div class="tp-shop-widget-product-content">
                                                <div class="tp-shop-widget-product-rating-wrapper d-flex align-items-center">
                                                    <div class="tp-shop-widget-product-rating">
                                             <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                    </div>
                                                    <div class="tp-shop-widget-product-rating-number">
                                                        <span>(3.5)</span>
                                                    </div>
                                                </div>
                                                <h4 class="tp-shop-widget-product-title">
                                                    <a href="product-details.html">Trending Watch for Man</a>
                                                </h4>
                                                <div class="tp-shop-widget-product-price-wrapper">
                                                    <span class="tp-shop-widget-product-price">$99.00</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tp-shop-widget-product-item d-flex align-items-center">
                                            <div class="tp-shop-widget-product-thumb">
                                                <a href="product-details.html">
                                                    <img src="${BASE_URL}assets/img/product/shop/sm/shop-sm-4.jpg"
                                                         alt="">
                                                </a>
                                            </div>
                                            <div class="tp-shop-widget-product-content">
                                                <div class="tp-shop-widget-product-rating-wrapper d-flex align-items-center">
                                                    <div class="tp-shop-widget-product-rating">
                                             <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                        <span>
                                                <svg width="12" height="12" viewBox="0 0 12 12" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                   <path d="M6 0L7.854 3.756L12 4.362L9 7.284L9.708 11.412L6 9.462L2.292 11.412L3 7.284L0 4.362L4.146 3.756L6 0Z"
                                                         fill="currentColor"/>
                                                </svg>
                                             </span>
                                                    </div>
                                                    <div class="tp-shop-widget-product-rating-number">
                                                        <span>(4.8)</span>
                                                    </div>
                                                </div>
                                                <h4 class="tp-shop-widget-product-title">
                                                    <a href="product-details.html">Minimal Backpack.</a>
                                                </h4>
                                                <div class="tp-shop-widget-product-price-wrapper">
                                                    <span class="tp-shop-widget-product-price">$165.00</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-8">
                        <div class="tp-shop-main-wrapper">

                            <div class="tp-shop-top mb-45">
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="tp-shop-top-left d-flex align-items-center ">
                                            <div class="tp-shop-top-tab tp-tab">
                                                <ul class="nav nav-tabs" id="productTab" role="tablist">
                                                    <li class="nav-item" role="presentation">
                                                        <button class="nav-link active" id="grid-tab"
                                                                data-bs-toggle="tab" data-bs-target="#grid-tab-pane"
                                                                type="button" role="tab" aria-controls="grid-tab-pane"
                                                                aria-selected="true">
                                                            <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                                                 xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M16.3327 6.01341V2.98675C16.3327 2.04675 15.906 1.66675 14.846 1.66675H12.1527C11.0927 1.66675 10.666 2.04675 10.666 2.98675V6.00675C10.666 6.95341 11.0927 7.32675 12.1527 7.32675H14.846C15.906 7.33341 16.3327 6.95341 16.3327 6.01341Z"
                                                                      stroke="currentColor" stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                                <path d="M16.3327 15.18V12.4867C16.3327 11.4267 15.906 11 14.846 11H12.1527C11.0927 11 10.666 11.4267 10.666 12.4867V15.18C10.666 16.24 11.0927 16.6667 12.1527 16.6667H14.846C15.906 16.6667 16.3327 16.24 16.3327 15.18Z"
                                                                      stroke="currentColor" stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                                <path d="M7.33268 6.01341V2.98675C7.33268 2.04675 6.90602 1.66675 5.84602 1.66675H3.15268C2.09268 1.66675 1.66602 2.04675 1.66602 2.98675V6.00675C1.66602 6.95341 2.09268 7.32675 3.15268 7.32675H5.84602C6.90602 7.33341 7.33268 6.95341 7.33268 6.01341Z"
                                                                      stroke="currentColor" stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                                <path d="M7.33268 15.18V12.4867C7.33268 11.4267 6.90602 11 5.84602 11H3.15268C2.09268 11 1.66602 11.4267 1.66602 12.4867V15.18C1.66602 16.24 2.09268 16.6667 3.15268 16.6667H5.84602C6.90602 16.6667 7.33268 16.24 7.33268 15.18Z"
                                                                      stroke="currentColor" stroke-width="1.5"
                                                                      stroke-linecap="round" stroke-linejoin="round"/>
                                                            </svg>
                                                        </button>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="tp-shop-top-result">
                                                <p>Showing 1 of 26 results</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tp-shop-items-wrapper tp-shop-item-primary">
                                <div class="tab-content" id="productTabContent">
                                        <%-- View 1 START --%>
                                    <div class="tab-pane fade show active" id="grid-tab-pane" role="tabpanel"
                                         aria-labelledby="grid-tab" tabindex="0">
                                        <div class="row infinite-container">


                                            <c:if test="${it != null}">
                                                <jsp:useBean id="it" scope="request"
                                                             type="java.util.HashMap<java.lang.String, java.lang.Object>"/>
                                                <c:forEach items='${it.get("products")}' var="product">
                                                    <%-- Product Start --%>
                                                    <div class="col-xl-4 col-md-6 col-sm-6 infinite-item">
                                                        <div class="tp-product-item-2 mb-40">
                                                            <div class="tp-product-thumb-2 p-relative z-index-1 fix w-img">
                                                                <a href="${BASE_URL}products/${product.id}">
                                                                    <img src="${product.images.get(0).imageURL}"
                                                                         alt="">
                                                                </a>
                                                                <!-- product action -->
                                                                <div class="tp-product-action-2 tp-product-action-blackStyle">
                                                                    <div class="tp-product-action-item-2 d-flex flex-column">
                                                                        <a href="${BASE_URL}products/${product.id}"
                                                                                class="tp-product-action-btn-2 tp-product-add-cart-btn">
                                                                            <svg width="17" height="17"
                                                                                 viewBox="0 0 17 17"
                                                                                 fill="none"
                                                                                 xmlns="http://www.w3.org/2000/svg">
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M3.34706 4.53799L3.85961 10.6239C3.89701 11.0923 4.28036 11.4436 4.74871 11.4436H4.75212H14.0265H14.0282C14.4711 11.4436 14.8493 11.1144 14.9122 10.6774L15.7197 5.11162C15.7384 4.97924 15.7053 4.84687 15.6245 4.73995C15.5446 4.63218 15.4273 4.5626 15.2947 4.54393C15.1171 4.55072 7.74498 4.54054 3.34706 4.53799ZM4.74722 12.7162C3.62777 12.7162 2.68001 11.8438 2.58906 10.728L1.81046 1.4837L0.529505 1.26308C0.181854 1.20198 -0.0501969 0.873587 0.00930333 0.526523C0.0705036 0.17946 0.406255 -0.0462578 0.746256 0.00805037L2.51426 0.313534C2.79901 0.363599 3.01576 0.5995 3.04042 0.888012L3.24017 3.26484C15.3748 3.26993 15.4139 3.27587 15.4726 3.28266C15.946 3.3514 16.3625 3.59833 16.6464 3.97849C16.9303 4.35779 17.0493 4.82535 16.9813 5.29376L16.1747 10.8586C16.0225 11.9177 15.1011 12.7162 14.0301 12.7162H14.0259H4.75402H4.74722Z"
                                                                                      fill="currentColor"/>
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M12.6629 7.67446H10.3067C9.95394 7.67446 9.66919 7.38934 9.66919 7.03804C9.66919 6.68673 9.95394 6.40161 10.3067 6.40161H12.6629C13.0148 6.40161 13.3004 6.68673 13.3004 7.03804C13.3004 7.38934 13.0148 7.67446 12.6629 7.67446Z"
                                                                                      fill="currentColor"/>
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M4.38171 15.0212C4.63756 15.0212 4.84411 15.2278 4.84411 15.4836C4.84411 15.7395 4.63756 15.9469 4.38171 15.9469C4.12501 15.9469 3.91846 15.7395 3.91846 15.4836C3.91846 15.2278 4.12501 15.0212 4.38171 15.0212Z"
                                                                                      fill="currentColor"/>
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M4.38082 15.3091C4.28477 15.3091 4.20657 15.3873 4.20657 15.4833C4.20657 15.6763 4.55592 15.6763 4.55592 15.4833C4.55592 15.3873 4.47687 15.3091 4.38082 15.3091ZM4.38067 16.5815C3.77376 16.5815 3.28076 16.0884 3.28076 15.4826C3.28076 14.8767 3.77376 14.3845 4.38067 14.3845C4.98757 14.3845 5.48142 14.8767 5.48142 15.4826C5.48142 16.0884 4.98757 16.5815 4.38067 16.5815Z"
                                                                                      fill="currentColor"/>
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M13.9701 15.0212C14.2259 15.0212 14.4333 15.2278 14.4333 15.4836C14.4333 15.7395 14.2259 15.9469 13.9701 15.9469C13.7134 15.9469 13.5068 15.7395 13.5068 15.4836C13.5068 15.2278 13.7134 15.0212 13.9701 15.0212Z"
                                                                                      fill="currentColor"/>
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M13.9692 15.3092C13.874 15.3092 13.7958 15.3874 13.7958 15.4835C13.7966 15.6781 14.1451 15.6764 14.1443 15.4835C14.1443 15.3874 14.0652 15.3092 13.9692 15.3092ZM13.969 16.5815C13.3621 16.5815 12.8691 16.0884 12.8691 15.4826C12.8691 14.8767 13.3621 14.3845 13.969 14.3845C14.5768 14.3845 15.0706 14.8767 15.0706 15.4826C15.0706 16.0884 14.5768 16.5815 13.969 16.5815Z"
                                                                                      fill="currentColor"/>
                                                                            </svg>
                                                                            <span class="tp-product-tooltip tp-product-tooltip-right">Add to Cart</span>
                                                                        </a>
                                                                        <button type="button"
                                                                                class="tp-product-action-btn-2 tp-product-add-to-wishlist-btn"
                                                                                onclick="addToWishlist('${product.id}')">
                                                                            <svg width="18" height="18"
                                                                                 viewBox="0 0 18 18"
                                                                                 fill="none"
                                                                                 xmlns="http://www.w3.org/2000/svg">
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M1.60355 7.98635C2.83622 11.8048 7.7062 14.8923 9.0004 15.6565C10.299 14.8844 15.2042 11.7628 16.3973 7.98985C17.1806 5.55102 16.4535 2.46177 13.5644 1.53473C12.1647 1.08741 10.532 1.35966 9.40484 2.22804C9.16921 2.40837 8.84214 2.41187 8.60476 2.23329C7.41078 1.33952 5.85105 1.07778 4.42936 1.53473C1.54465 2.4609 0.820172 5.55014 1.60355 7.98635ZM9.00138 17.0711C8.89236 17.0711 8.78421 17.0448 8.68574 16.9914C8.41055 16.8417 1.92808 13.2841 0.348132 8.3872C0.347252 8.3872 0.347252 8.38633 0.347252 8.38633C-0.644504 5.30321 0.459792 1.42874 4.02502 0.284605C5.69904 -0.254635 7.52342 -0.0174044 8.99874 0.909632C10.4283 0.00973263 12.3275 -0.238878 13.9681 0.284605C17.5368 1.43049 18.6446 5.30408 17.6538 8.38633C16.1248 13.2272 9.59485 16.8382 9.3179 16.9896C9.21943 17.0439 9.1104 17.0711 9.00138 17.0711Z"
                                                                                      fill="currentColor"/>
                                                                                <path fill-rule="evenodd"
                                                                                      clip-rule="evenodd"
                                                                                      d="M14.203 6.67473C13.8627 6.67473 13.5743 6.41474 13.5462 6.07159C13.4882 5.35202 13.0046 4.7445 12.3162 4.52302C11.9689 4.41097 11.779 4.04068 11.8906 3.69666C12.0041 3.35175 12.3724 3.16442 12.7206 3.27297C13.919 3.65901 14.7586 4.71561 14.8615 5.96479C14.8905 6.32632 14.6206 6.64322 14.2575 6.6721C14.239 6.67385 14.2214 6.67473 14.203 6.67473Z"
                                                                                      fill="currentColor"/>
                                                                            </svg>
                                                                            <span class="tp-product-tooltip tp-product-tooltip-right">Add To Wishlist</span>
                                                                        </button>
                                                                            <%--                                                                    <button type="button"--%>
                                                                            <%--                                                                            class="tp-product-action-btn-2 tp-product-add-to-compare-btn">--%>
                                                                            <%--                                                                        <svg width="15" height="15" viewBox="0 0 15 15"--%>
                                                                            <%--                                                                             fill="none"--%>
                                                                            <%--                                                                             xmlns="http://www.w3.org/2000/svg">--%>
                                                                            <%--                                                                            <path d="M11.4144 6.16828L14 3.58412L11.4144 1"--%>
                                                                            <%--                                                                                  stroke="currentColor"--%>
                                                                            <%--                                                                                  stroke-width="1.5"--%>
                                                                            <%--                                                                                  stroke-linecap="round"--%>
                                                                            <%--                                                                                  stroke-linejoin="round"/>--%>
                                                                            <%--                                                                            <path d="M1.48883 3.58374L14 3.58374"--%>
                                                                            <%--                                                                                  stroke="currentColor"--%>
                                                                            <%--                                                                                  stroke-width="1.5"--%>
                                                                            <%--                                                                                  stroke-linecap="round"--%>
                                                                            <%--                                                                                  stroke-linejoin="round"/>--%>
                                                                            <%--                                                                            <path d="M4.07446 8.32153L1.48884 10.9057L4.07446 13.4898"--%>
                                                                            <%--                                                                                  stroke="currentColor"--%>
                                                                            <%--                                                                                  stroke-width="1.5"--%>
                                                                            <%--                                                                                  stroke-linecap="round"--%>
                                                                            <%--                                                                                  stroke-linejoin="round"/>--%>
                                                                            <%--                                                                            <path d="M14 10.9058H1.48883"--%>
                                                                            <%--                                                                                  stroke="currentColor"--%>
                                                                            <%--                                                                                  stroke-width="1.5"--%>
                                                                            <%--                                                                                  stroke-linecap="round"--%>
                                                                            <%--                                                                                  stroke-linejoin="round"/>--%>
                                                                            <%--                                                                        </svg>--%>
                                                                            <%--                                                                        <span class="tp-product-tooltip tp-product-tooltip-right">Add To Compare</span>--%>
                                                                            <%--                                                                    </button>--%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="tp-product-content-2 pt-15">
                                                                <div class="tp-product-tag-2">
                                                                    <a href="#">${product.category.name}</a>
                                                                </div>
                                                                <h3 class="tp-product-title-2">
                                                                    <a href="${BASE_URL}products/${product.id}">${product.name}</a>
                                                                </h3>
                                                                <div class="tp-product-rating-icon tp-product-rating-icon-2">
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                </div>
                                                                <div class="tp-product-price-wrapper-2">

                                                                    <fmt:formatNumber value="${product.price}" type="currency" var="newPrice" />
                                                                    <fmt:formatNumber value="${product.price + (product.price / 10) * 100}" type="currency" var="oldPrice" />

                                                                    <span class="tp-product-price-2 new-price">${newPrice}</span>
                                                                    <span class="tp-product-price-2 old-price">${oldPrice}</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%-- Product End --%>
                                                </c:forEach>
                                            </c:if>

                                            <c:if test="${it == null}">
                                                <div class="text-center mt-3">
                                                    <svg height="48" viewBox="0 0 48 48" width="48"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M0 0h48v48H0V0z" fill="none"/>
                                                        <path d="M22 30h4v4h-4zm0-16h4v12h-4zm1.99-10C12.94 4 4 12.95 4 24s8.94 20 19.99 20S44 35.05 44 24 35.04 4 23.99 4zM24 40c-8.84 0-16-7.16-16-16S15.16 8 24 8s16 7.16 16 16-7.16 16-16 16z"/>
                                                    </svg>
                                                    <h3>No Products Found</h3>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                        <%-- View 1 END --%>
                                </div>
                            </div>
                            <div class="infinite-pagination d-none">
                                <a href="shop.html" class="infinite-next-link">Next</a>
                            </div>
                            <div class="tp-shop-pagination mt-20">
                                <div class="tp-pagination">
                                    <nav>
                                        <ul>
                                            <c:if test='${(it.get("page") - 1) >= 1}'>
                                                <li>
                                                    <a href="${BASE_URL}products?page=${(it.get("page")-1)}&search=${it.get("search")}"
                                                       class="tp-pagination-prev prev page-numbers">
                                                        <svg width="15" height="13" viewBox="0 0 15 13" fill="none"
                                                             xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M1.00017 6.77879L14 6.77879" stroke="currentColor"
                                                                  stroke-width="1.5" stroke-linecap="round"
                                                                  stroke-linejoin="round"/>
                                                            <path d="M6.24316 11.9999L0.999899 6.77922L6.24316 1.55762"
                                                                  stroke="currentColor" stroke-width="1.5"
                                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="1" end='${it.get("count")}' var="num">
                                                <li>
                                                    <a href="${BASE_URL}products?page=${num}&search=${it.get("search")}">${num}</a>
                                                </li>
                                            </c:forEach>

                                            <c:if test='${((it.get("page")+1) <= it.get("count"))}'>

                                                <li>
                                                    <a href="${BASE_URL}products?page=${(it.get("page")+1)}&search=${it.get("search")}"
                                                       class="next page-numbers">
                                                        <svg width="15" height="13" viewBox="0 0 15 13" fill="none"
                                                             xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M13.9998 6.77883L1 6.77883" stroke="currentColor"
                                                                  stroke-width="1.5" stroke-linecap="round"
                                                                  stroke-linejoin="round"/>

                                                            <path d="M8.75684 1.55767L14.0001 6.7784L8.75684 12"
                                                                  stroke="currentColor" stroke-width="1.5"
                                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                                        </svg>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- shop area end -->
    </layout:put>
</layout:extends>