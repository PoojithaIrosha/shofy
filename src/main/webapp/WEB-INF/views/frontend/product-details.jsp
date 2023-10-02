<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="it" scope="request" type="java.util.HashMap<java.lang.String, java.lang.Object>"/>

<layout:extends name="base">

    <layout:put block="title" type="REPLACE">
        <title>${it.get("product").name} - Shofy</title>
    </layout:put>

    <layout:put block="main-content" type="REPLACE">

        <!-- breadcrumb area start -->
        <section class="breadcrumb__area breadcrumb__style-2 include-bg pt-50 pb-20">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-12">
                        <div class="breadcrumb__content p-relative z-index-1">
                            <div class="breadcrumb__list has-icon">
                           <span class="breadcrumb-icon">
                              <svg width="17" height="17" viewBox="0 0 17 17" fill="none"
                                   xmlns="http://www.w3.org/2000/svg">
                                 <path d="M1.42393 16H15.5759C15.6884 16 15.7962 15.9584 15.8758 15.8844C15.9553 15.8104 16 15.71 16 15.6054V6.29143C16 6.22989 15.9846 6.1692 15.9549 6.11422C15.9252 6.05923 15.8821 6.01147 15.829 5.97475L8.75305 1.07803C8.67992 1.02736 8.59118 1 8.5 1C8.40882 1 8.32008 1.02736 8.24695 1.07803L1.17098 5.97587C1.11791 6.01259 1.0748 6.06035 1.04511 6.11534C1.01543 6.17033 0.999976 6.23101 1 6.29255V15.6063C1.00027 15.7108 1.04504 15.8109 1.12451 15.8847C1.20398 15.9585 1.31165 16 1.42393 16ZM10.1464 15.2107H6.85241V10.6202H10.1464V15.2107ZM1.84866 6.48977L8.4999 1.88561L15.1517 6.48977V15.2107H10.9946V10.2256C10.9946 10.1209 10.95 10.0206 10.8704 9.94654C10.7909 9.87254 10.683 9.83096 10.5705 9.83096H6.42848C6.316 9.83096 6.20812 9.87254 6.12858 9.94654C6.04904 10.0206 6.00435 10.1209 6.00435 10.2256V15.2107H1.84806L1.84866 6.48977Z"
                                       fill="#55585B" stroke="#55585B" stroke-width="0.5"/>
                              </svg>
                           </span>
                                <span><a href="#">Home</a></span>
                                <span><a href="#">${it.get("product").category.name}</a></span>
                                <span>${it.get("product").name}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- breadcrumb area end -->

        <!-- product details area start -->
        <section class="tp-product-details-area">
            <div class="tp-product-details-top pb-115">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-7 col-lg-6">
                            <div class="tp-product-details-thumb-wrapper tp-tab d-sm-flex">
                                <nav>
                                    <div class="nav nav-tabs flex-sm-column " id="productDetailsNavThumb"
                                         role="tablist">

                                        <c:forEach items='${it.get("product").images}' var="image" varStatus="num">
                                            <button class="nav-link ${num.index == 0 ? "active" : ""}"
                                                    id="nav-${image.id}-tab"
                                                    data-bs-toggle="tab"
                                                    data-bs-target="#nav-${image.id}" type="button" role="tab"
                                                    aria-controls="nav-${image.id}"
                                                    aria-selected="true">
                                                <img src="${image.imageURL}"
                                                     alt="">
                                            </button>
                                        </c:forEach>
                                    </div>
                                </nav>
                                <div class="tab-content m-img" id="productDetailsNavContent">
                                    <c:forEach items='${it.get("product").images}' var="image" varStatus="status">
                                        <div class="tab-pane fade ${status.index == 0 ? "show active" : ""}"
                                             id="nav-${image.id}" role="tabpanel"
                                             aria-labelledby="nav-${image.id}-tab" tabindex="0">
                                            <div class="tp-product-details-nav-main-thumb">
                                                <img src="${image.imageURL}"
                                                     alt="">
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div> <!-- col end -->
                        <div class="col-xl-5 col-lg-6">
                            <div class="tp-product-details-wrapper">
                                <div class="tp-product-details-category">
                                    <span>${it.get("product").category.name}</span>
                                </div>
                                <h3 class="tp-product-details-title">${it.get("product").name}</h3>

                                <!-- inventory details -->
                                <div class="tp-product-details-inventory d-flex align-items-center mb-10">
                                    <div class="tp-product-details-stock mb-10">
                                        <span>${it.get("product").quantity > 0 ? "In Stock" : "Out of Stock"}</span>
                                    </div>
                                    <div class="tp-product-details-rating-wrapper d-flex align-items-center mb-10">
                                        <div class="tp-product-details-rating">
                                            <span><i class="fa-solid fa-star"></i></span>
                                            <span><i class="fa-solid fa-star"></i></span>
                                            <span><i class="fa-solid fa-star"></i></span>
                                            <span><i class="fa-solid fa-star"></i></span>
                                            <span><i class="fa-solid fa-star"></i></span>
                                        </div>
                                        <div class="tp-product-details-reviews">
                                            <span>(36 Reviews)</span>
                                        </div>
                                    </div>
                                </div>
                                <p>${it.get("product").description}... <a href="#nav-description-tab">See more</a></p>
                                <h6>${it.get("product").quantity} Qty Available</h6>

                                <!-- price -->
                                <div class="tp-product-details-price-wrapper mb-20">
                                    <fmt:formatNumber value='${it.get("product").price - (it.get("product").price * 100) / 10}' type="currency"
                                                      var="oldPrice"/>
                                    <fmt:formatNumber value='${it.get("product").price}' type="currency"
                                                      var="newPrice"/>
                                    <span class="tp-product-details-price old-price me-1">${oldPrice}</span>
                                    <span class="tp-product-details-price new-price">${newPrice}</span>
                                </div>

                                <!-- variations -->
                                <div class="tp-product-details-variation">
                                    <!-- single item -->
                                    <div class="tp-product-details-variation-item">
                                        <h4 class="tp-product-details-variation-title">Color :</h4>
                                        <div class="tp-product-details-variation-list">
                                            <c:if test='${it.get("product").colors.size() > 0}'>
                                                <c:forEach items='${it.get("product").colors}' var="color" varStatus="loop">
                                                    <button id="color-btn-${loop.index}" type="button"
                                                            class="color tp-color-variation-btn"
                                                            onclick="selectColor('${loop.index}');">
                                                        <span class="d-none" id="color-id">${color.id}</span>
                                                        <span data-bg-color="${color.color}"></span>
                                                        <span class="tp-color-variation-tootltip">${color.color}</span>
                                                    </button>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <!-- actions -->
                                <div class="tp-product-details-action-wrapper">
                                    <h3 class="tp-product-details-action-title">Quantity</h3>
                                    <div class="tp-product-details-action-item-wrapper d-flex align-items-center">
                                        <div class="tp-product-details-quantity">
                                            <div class="tp-product-quantity mb-15 mr-15">
                                                <button class="tp-cart-minus" onclick="decrementQty('${it.get("product").id}');">
                                                    <svg width="11" height="2" viewBox="0 0 11 2" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M1 1H10" stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                    </svg>
                                                </button>
                                                <input id="qty-${it.get("product").id}" class="tp-cart-input" type="text" value="1">
                                                <button class="tp-cart-plus" onclick="incrementQty('${it.get("product").id}');">
                                                    <svg width="11" height="12" viewBox="0 0 11 12" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M1 6H10" stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M5.5 10.5V1.5" stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                    </svg>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="tp-product-details-add-to-cart mb-15 w-100">
                                            <button class="tp-product-details-add-to-cart-btn w-100"
                                                    onclick="addToCartPD('${it.get("product").id}')">Add To Cart
                                            </button>
                                        </div>
                                    </div>
                                    <button class="tp-product-details-buy-now-btn w-100"
                                            onclick="buyNowCheckout('${it.get("product").id}');">Buy Now
                                    </button>
                                </div>
                                <div class="tp-product-details-action-sm">
                                    <button type="button" class="tp-product-details-action-sm-btn">
                                        <svg width="14" height="16" viewBox="0 0 14 16" fill="none"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1 3.16431H10.8622C12.0451 3.16431 12.9999 4.08839 12.9999 5.23315V7.52268"
                                                  stroke="currentColor" stroke-width="1.5" stroke-miterlimit="10"
                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M3.25177 0.985168L1 3.16433L3.25177 5.34354" stroke="currentColor"
                                                  stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"
                                                  stroke-linejoin="round"/>
                                            <path d="M12.9999 12.5983H3.13775C1.95486 12.5983 1 11.6742 1 10.5295V8.23993"
                                                  stroke="currentColor" stroke-width="1.5" stroke-miterlimit="10"
                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M10.748 14.7774L12.9998 12.5983L10.748 10.4191"
                                                  stroke="currentColor" stroke-width="1.5" stroke-miterlimit="10"
                                                  stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                        Compare
                                    </button>
                                    <button type="button" class="tp-product-details-action-sm-btn"
                                            onclick="addToWishlist('${it.get("product").id}');">
                                        <svg width="17" height="16" viewBox="0 0 17 16" fill="none"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                  d="M2.33541 7.54172C3.36263 10.6766 7.42094 13.2113 8.49945 13.8387C9.58162 13.2048 13.6692 10.6421 14.6635 7.5446C15.3163 5.54239 14.7104 3.00621 12.3028 2.24514C11.1364 1.8779 9.77578 2.1014 8.83648 2.81432C8.64012 2.96237 8.36757 2.96524 8.16974 2.81863C7.17476 2.08487 5.87499 1.86999 4.69024 2.24514C2.28632 3.00549 1.68259 5.54167 2.33541 7.54172ZM8.50115 15C8.4103 15 8.32018 14.9784 8.23812 14.9346C8.00879 14.8117 2.60674 11.891 1.29011 7.87081C1.28938 7.87081 1.28938 7.8701 1.28938 7.8701C0.462913 5.33895 1.38316 2.15812 4.35418 1.21882C5.7492 0.776121 7.26952 0.97088 8.49895 1.73195C9.69029 0.993159 11.2729 0.789057 12.6401 1.21882C15.614 2.15956 16.5372 5.33966 15.7115 7.8701C14.4373 11.8443 8.99571 14.8088 8.76492 14.9332C8.68286 14.9777 8.592 15 8.50115 15Z"
                                                  fill="currentColor"/>
                                            <path d="M8.49945 13.8387L8.42402 13.9683L8.49971 14.0124L8.57526 13.9681L8.49945 13.8387ZM14.6635 7.5446L14.5209 7.4981L14.5207 7.49875L14.6635 7.5446ZM12.3028 2.24514L12.348 2.10211L12.3478 2.10206L12.3028 2.24514ZM8.83648 2.81432L8.92678 2.93409L8.92717 2.9338L8.83648 2.81432ZM8.16974 2.81863L8.25906 2.69812L8.25877 2.69791L8.16974 2.81863ZM4.69024 2.24514L4.73548 2.38815L4.73552 2.38814L4.69024 2.24514ZM8.23812 14.9346L8.16727 15.0668L8.16744 15.0669L8.23812 14.9346ZM1.29011 7.87081L1.43266 7.82413L1.39882 7.72081H1.29011V7.87081ZM1.28938 7.8701L1.43938 7.87009L1.43938 7.84623L1.43197 7.82354L1.28938 7.8701ZM4.35418 1.21882L4.3994 1.36184L4.39955 1.36179L4.35418 1.21882ZM8.49895 1.73195L8.42 1.85949L8.49902 1.90841L8.57801 1.85943L8.49895 1.73195ZM12.6401 1.21882L12.6853 1.0758L12.685 1.07572L12.6401 1.21882ZM15.7115 7.8701L15.5689 7.82356L15.5686 7.8243L15.7115 7.8701ZM8.76492 14.9332L8.69378 14.8011L8.69334 14.8013L8.76492 14.9332ZM2.19287 7.58843C2.71935 9.19514 4.01596 10.6345 5.30013 11.744C6.58766 12.8564 7.88057 13.6522 8.42402 13.9683L8.57487 13.709C8.03982 13.3978 6.76432 12.6125 5.49626 11.517C4.22484 10.4185 2.97868 9.02313 2.47795 7.49501L2.19287 7.58843ZM8.57526 13.9681C9.12037 13.6488 10.4214 12.8444 11.7125 11.729C12.9999 10.6167 14.2963 9.17932 14.8063 7.59044L14.5207 7.49875C14.0364 9.00733 12.7919 10.4 11.5164 11.502C10.2446 12.6008 8.9607 13.3947 8.42364 13.7093L8.57526 13.9681ZM14.8061 7.59109C15.1419 6.5613 15.1554 5.39131 14.7711 4.37633C14.3853 3.35729 13.5989 2.49754 12.348 2.10211L12.2576 2.38816C13.4143 2.75381 14.1347 3.54267 14.4905 4.48255C14.8479 5.42648 14.8379 6.52568 14.5209 7.4981L14.8061 7.59109ZM12.3478 2.10206C11.137 1.72085 9.72549 1.95125 8.7458 2.69484L8.92717 2.9338C9.82606 2.25155 11.1357 2.03494 12.2577 2.38821L12.3478 2.10206ZM8.74618 2.69455C8.60221 2.8031 8.40275 2.80462 8.25906 2.69812L8.08043 2.93915C8.33238 3.12587 8.67804 3.12163 8.92678 2.93409L8.74618 2.69455ZM8.25877 2.69791C7.225 1.93554 5.87527 1.71256 4.64496 2.10213L4.73552 2.38814C5.87471 2.02742 7.12452 2.2342 8.08071 2.93936L8.25877 2.69791ZM4.64501 2.10212C3.39586 2.49722 2.61099 3.35688 2.22622 4.37554C1.84299 5.39014 1.85704 6.55957 2.19281 7.58826L2.478 7.49518C2.16095 6.52382 2.15046 5.42513 2.50687 4.48154C2.86175 3.542 3.58071 2.7534 4.73548 2.38815L4.64501 2.10212ZM8.50115 14.85C8.43415 14.85 8.36841 14.8341 8.3088 14.8023L8.16744 15.0669C8.27195 15.1227 8.38645 15.15 8.50115 15.15V14.85ZM8.30897 14.8024C8.19831 14.7431 6.7996 13.9873 5.26616 12.7476C3.72872 11.5046 2.07716 9.79208 1.43266 7.82413L1.14756 7.9175C1.81968 9.96978 3.52747 11.7277 5.07755 12.9809C6.63162 14.2373 8.0486 15.0032 8.16727 15.0668L8.30897 14.8024ZM1.29011 7.72081C1.31557 7.72081 1.34468 7.72745 1.37175 7.74514C1.39802 7.76231 1.41394 7.78437 1.42309 7.8023C1.43191 7.81958 1.43557 7.8351 1.43727 7.84507C1.43817 7.8504 1.43869 7.85518 1.43898 7.85922C1.43913 7.86127 1.43923 7.8632 1.43929 7.865C1.43932 7.86591 1.43934 7.86678 1.43936 7.86763C1.43936 7.86805 1.43937 7.86847 1.43937 7.86888C1.43937 7.86909 1.43937 7.86929 1.43938 7.86949C1.43938 7.86959 1.43938 7.86969 1.43938 7.86979C1.43938 7.86984 1.43938 7.86992 1.43938 7.86994C1.43938 7.87002 1.43938 7.87009 1.28938 7.8701C1.13938 7.8701 1.13938 7.87017 1.13938 7.87025C1.13938 7.87027 1.13938 7.87035 1.13938 7.8704C1.13938 7.8705 1.13938 7.8706 1.13938 7.8707C1.13938 7.8709 1.13938 7.87111 1.13938 7.87131C1.13939 7.87173 1.13939 7.87214 1.1394 7.87257C1.13941 7.87342 1.13943 7.8743 1.13946 7.8752C1.13953 7.87701 1.13962 7.87896 1.13978 7.88103C1.14007 7.88512 1.14059 7.88995 1.14151 7.89535C1.14323 7.90545 1.14694 7.92115 1.15585 7.93861C1.16508 7.95672 1.18114 7.97896 1.20762 7.99626C1.2349 8.01409 1.26428 8.02081 1.29011 8.02081V7.72081ZM1.43197 7.82354C0.623164 5.34647 1.53102 2.26869 4.3994 1.36184L4.30896 1.0758C1.23531 2.04755 0.302663 5.33142 1.14679 7.91665L1.43197 7.82354ZM4.39955 1.36179C5.7527 0.932384 7.22762 1.12136 8.42 1.85949L8.57791 1.60441C7.31141 0.820401 5.74571 0.619858 4.30881 1.07585L4.39955 1.36179ZM8.57801 1.85943C9.73213 1.14371 11.2694 0.945205 12.5951 1.36192L12.685 1.07572C11.2763 0.632908 9.64845 0.842602 8.4199 1.60447L8.57801 1.85943ZM12.5948 1.36184C15.4664 2.27018 16.3769 5.34745 15.5689 7.82356L15.8541 7.91663C16.6975 5.33188 15.7617 2.04893 12.6853 1.07581L12.5948 1.36184ZM15.5686 7.8243C14.9453 9.76841 13.2952 11.4801 11.7526 12.7288C10.2142 13.974 8.80513 14.7411 8.69378 14.8011L8.83606 15.0652C8.9555 15.0009 10.3826 14.2236 11.9413 12.9619C13.4957 11.7037 15.2034 9.94602 15.8543 7.91589L15.5686 7.8243ZM8.69334 14.8013C8.6337 14.8337 8.56752 14.85 8.50115 14.85V15.15C8.61648 15.15 8.73201 15.1217 8.83649 15.065L8.69334 14.8013Z"
                                                  fill="currentColor"/>
                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                  d="M12.8384 6.93209C12.5548 6.93209 12.3145 6.71865 12.2911 6.43693C12.2427 5.84618 11.8397 5.34743 11.266 5.1656C10.9766 5.07361 10.8184 4.76962 10.9114 4.48718C11.0059 4.20402 11.3129 4.05023 11.6031 4.13934C12.6017 4.45628 13.3014 5.32371 13.3872 6.34925C13.4113 6.64606 13.1864 6.90622 12.8838 6.92993C12.8684 6.93137 12.8538 6.93209 12.8384 6.93209Z"
                                                  fill="currentColor"/>
                                            <path d="M12.8384 6.93209C12.5548 6.93209 12.3145 6.71865 12.2911 6.43693C12.2427 5.84618 11.8397 5.34743 11.266 5.1656C10.9766 5.07361 10.8184 4.76962 10.9114 4.48718C11.0059 4.20402 11.3129 4.05023 11.6031 4.13934C12.6017 4.45628 13.3014 5.32371 13.3872 6.34925C13.4113 6.64606 13.1864 6.90622 12.8838 6.92993C12.8684 6.93137 12.8538 6.93209 12.8384 6.93209"
                                                  stroke="currentColor" stroke-width="0.3"/>
                                        </svg>
                                        Add Wishlist
                                    </button>
                                    <button type="button" class="tp-product-details-action-sm-btn">
                                        <svg width="17" height="16" viewBox="0 0 17 16" fill="none"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <path d="M8.575 12.6927C8.775 12.6927 8.94375 12.6249 9.08125 12.4895C9.21875 12.354 9.2875 12.1878 9.2875 11.9907C9.2875 11.7937 9.21875 11.6275 9.08125 11.492C8.94375 11.3565 8.775 11.2888 8.575 11.2888C8.375 11.2888 8.20625 11.3565 8.06875 11.492C7.93125 11.6275 7.8625 11.7937 7.8625 11.9907C7.8625 12.1878 7.93125 12.354 8.06875 12.4895C8.20625 12.6249 8.375 12.6927 8.575 12.6927ZM8.55625 5.0638C8.98125 5.0638 9.325 5.17771 9.5875 5.40553C9.85 5.63335 9.98125 5.92582 9.98125 6.28294C9.98125 6.52924 9.90625 6.77245 9.75625 7.01258C9.60625 7.25272 9.3625 7.5144 9.025 7.79763C8.7 8.08087 8.44063 8.3795 8.24688 8.69352C8.05313 9.00754 7.95625 9.29385 7.95625 9.55246C7.95625 9.68792 8.00938 9.79567 8.11563 9.87572C8.22188 9.95576 8.34375 9.99578 8.48125 9.99578C8.63125 9.99578 8.75625 9.94653 8.85625 9.84801C8.95625 9.74949 9.01875 9.62635 9.04375 9.47857C9.08125 9.23228 9.16562 9.0137 9.29688 8.82282C9.42813 8.63195 9.63125 8.42568 9.90625 8.20402C10.2812 7.89615 10.5531 7.58829 10.7219 7.28042C10.8906 6.97256 10.975 6.62775 10.975 6.246C10.975 5.59333 10.7594 5.06996 10.3281 4.67589C9.89688 4.28183 9.325 4.0848 8.6125 4.0848C8.1375 4.0848 7.7 4.17716 7.3 4.36187C6.9 4.54659 6.56875 4.81751 6.30625 5.17463C6.20625 5.31009 6.16563 5.44863 6.18438 5.59025C6.20313 5.73187 6.2625 5.83962 6.3625 5.91351C6.5 6.01202 6.64688 6.04281 6.80313 6.00587C6.95937 5.96892 7.0875 5.88272 7.1875 5.74726C7.35 5.5256 7.54688 5.35627 7.77813 5.23929C8.00938 5.1223 8.26875 5.0638 8.55625 5.0638ZM8.5 15.7775C7.45 15.7775 6.46875 15.5897 5.55625 15.2141C4.64375 14.8385 3.85 14.3182 3.175 13.6532C2.5 12.9882 1.96875 12.2062 1.58125 11.3073C1.19375 10.4083 1 9.43547 1 8.38873C1 7.35431 1.19375 6.38762 1.58125 5.48866C1.96875 4.58969 2.5 3.80772 3.175 3.14273C3.85 2.47775 4.64375 1.95438 5.55625 1.57263C6.46875 1.19088 7.45 1 8.5 1C9.5375 1 10.5125 1.19088 11.425 1.57263C12.3375 1.95438 13.1313 2.47775 13.8063 3.14273C14.4813 3.80772 15.0156 4.58969 15.4094 5.48866C15.8031 6.38762 16 7.35431 16 8.38873C16 9.43547 15.8031 10.4083 15.4094 11.3073C15.0156 12.2062 14.4813 12.9882 13.8063 13.6532C13.1313 14.3182 12.3375 14.8385 11.425 15.2141C10.5125 15.5897 9.5375 15.7775 8.5 15.7775ZM8.5 14.6692C10.2625 14.6692 11.7656 14.0534 13.0094 12.822C14.2531 11.5905 14.875 10.1128 14.875 8.38873C14.875 6.6647 14.2531 5.18695 13.0094 3.95549C11.7656 2.72404 10.2625 2.10831 8.5 2.10831C6.7125 2.10831 5.20312 2.72404 3.97188 3.95549C2.74063 5.18695 2.125 6.6647 2.125 8.38873C2.125 10.1128 2.74063 11.5905 3.97188 12.822C5.20312 14.0534 6.7125 14.6692 8.5 14.6692Z"
                                                  fill="currentColor" stroke="currentColor" stroke-width="0.3"/>
                                        </svg>
                                        Ask a question
                                    </button>
                                </div>
                                <div class="tp-product-details-query">
                                    <div class="tp-product-details-query-item d-flex align-items-center">
                                        <span>SKU:  </span>
                                        <p>${it.get("product").id}</p>
                                    </div>
                                    <div class="tp-product-details-query-item d-flex align-items-center">
                                        <span>Category:  </span>
                                        <p>${it.get("product").category.name}</p>
                                    </div>
                                    <div class="tp-product-details-query-item d-flex align-items-center">
                                        <span>Brand: </span>
                                        <p>${it.get("product").brand.name}</p>
                                    </div>
                                </div>
                                <div class="tp-product-details-social">
                                    <span>Share: </span>
                                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                                    <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                                    <a href="#"><i class="fa-brands fa-vimeo-v"></i></a>
                                </div>
                                <div class="tp-product-details-msg mb-15">
                                    <ul>
                                        <li>30 days easy returns</li>
                                        <li>Order yours before 2.30pm for same day dispatch</li>
                                    </ul>
                                </div>
                                <div class="tp-product-details-payment d-flex align-items-center flex-wrap justify-content-between">
                                    <p>Guaranteed safe <br> & secure checkout</p>
                                    <img src="${BASE_URL}assets/img/product/icons/payment-option.png" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tp-product-details-bottom pb-140">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="tp-product-details-tab-nav tp-tab">
                                <nav>
                                    <div class="nav nav-tabs justify-content-center p-relative tp-product-tab"
                                         id="navPresentationTab" role="tablist">
                                        <button class="nav-link active" id="nav-description-tab" data-bs-toggle="tab"
                                                data-bs-target="#nav-description" type="button" role="tab"
                                                aria-controls="nav-description" aria-selected="true">Description
                                        </button>
                                        <button class="nav-link" id="nav-review-tab" data-bs-toggle="tab"
                                                data-bs-target="#nav-review" type="button" role="tab"
                                                aria-controls="nav-review" aria-selected="false">Reviews (2)
                                        </button>

                                        <span id="productTabMarker" class="tp-product-details-tab-line"></span>
                                    </div>
                                </nav>
                                <div class="tab-content" id="navPresentationTabContent">
                                    <div class="tab-pane fade show active" id="nav-description" role="tabpanel"
                                         aria-labelledby="nav-description-tab" tabindex="0">
                                        <div class="tp-product-details-desc-wrapper pt-80">
                                            <div class="row justify-content-center">
                                                    ${it.get("product").description}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-review" role="tabpanel"
                                         aria-labelledby="nav-review-tab" tabindex="0">
                                        <div class="tp-product-details-review-wrapper pt-60">
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="tp-product-details-review-statics">
                                                        <!-- number -->
                                                        <div class="tp-product-details-review-number d-inline-block mb-50">
                                                            <h3 class="tp-product-details-review-number-title">Customer
                                                                reviews</h3>
                                                            <div class="tp-product-details-review-summery d-flex align-items-center">
                                                                <div class="tp-product-details-review-summery-value">
                                                                    <span>4.5</span>
                                                                </div>
                                                                <div class="tp-product-details-review-summery-rating d-flex align-items-center">
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <p>(36 Reviews)</p>
                                                                </div>
                                                            </div>
                                                            <div class="tp-product-details-review-rating-list">
                                                                <!-- single item -->
                                                                <div class="tp-product-details-review-rating-item d-flex align-items-center">
                                                                    <span>5 Start</span>
                                                                    <div class="tp-product-details-review-rating-bar">
                                                                        <span class="tp-product-details-review-rating-bar-inner"
                                                                              data-width="82%"></span>
                                                                    </div>
                                                                    <div class="tp-product-details-review-rating-percent">
                                                                        <span>82%</span>
                                                                    </div>
                                                                </div> <!-- end single item -->

                                                                <!-- single item -->
                                                                <div class="tp-product-details-review-rating-item d-flex align-items-center">
                                                                    <span>4 Start</span>
                                                                    <div class="tp-product-details-review-rating-bar">
                                                                        <span class="tp-product-details-review-rating-bar-inner"
                                                                              data-width="30%"></span>
                                                                    </div>
                                                                    <div class="tp-product-details-review-rating-percent">
                                                                        <span>30%</span>
                                                                    </div>
                                                                </div> <!-- end single item -->

                                                                <!-- single item -->
                                                                <div class="tp-product-details-review-rating-item d-flex align-items-center">
                                                                    <span>3 Start</span>
                                                                    <div class="tp-product-details-review-rating-bar">
                                                                        <span class="tp-product-details-review-rating-bar-inner"
                                                                              data-width="15%"></span>
                                                                    </div>
                                                                    <div class="tp-product-details-review-rating-percent">
                                                                        <span>15%</span>
                                                                    </div>
                                                                </div> <!-- end single item -->

                                                                <!-- single item -->
                                                                <div class="tp-product-details-review-rating-item d-flex align-items-center">
                                                                    <span>2 Start</span>
                                                                    <div class="tp-product-details-review-rating-bar">
                                                                        <span class="tp-product-details-review-rating-bar-inner"
                                                                              data-width="6%"></span>
                                                                    </div>
                                                                    <div class="tp-product-details-review-rating-percent">
                                                                        <span>6%</span>
                                                                    </div>
                                                                </div> <!-- end single item -->

                                                                <!-- single item -->
                                                                <div class="tp-product-details-review-rating-item d-flex align-items-center">
                                                                    <span>1 Start</span>
                                                                    <div class="tp-product-details-review-rating-bar">
                                                                        <span class="tp-product-details-review-rating-bar-inner"
                                                                              data-width="10%"></span>
                                                                    </div>
                                                                    <div class="tp-product-details-review-rating-percent">
                                                                        <span>10%</span>
                                                                    </div>
                                                                </div> <!-- end single item -->
                                                            </div>
                                                        </div>

                                                        <!-- reviews -->
                                                        <div class="tp-product-details-review-list pr-110">
                                                            <h3 class="tp-product-details-review-title">Rating &
                                                                Review</h3>
                                                            <div class="tp-product-details-review-avater d-flex align-items-start">
                                                                <div class="tp-product-details-review-avater-thumb">
                                                                    <a href="#">
                                                                        <img src="${BASE_URL}assets/img/users/user-3.jpg"
                                                                             alt="">
                                                                    </a>
                                                                </div>
                                                                <div class="tp-product-details-review-avater-content">
                                                                    <div class="tp-product-details-review-avater-rating d-flex align-items-center">
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                    </div>
                                                                    <h3 class="tp-product-details-review-avater-title">
                                                                        Eleanor Fant</h3>
                                                                    <span class="tp-product-details-review-avater-meta">06 March, 2023 </span>

                                                                    <div class="tp-product-details-review-avater-comment">
                                                                        <p>Designed very similarly to the nearly double
                                                                            priced Galaxy tab S6, with the only removal
                                                                            being.</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="tp-product-details-review-avater d-flex align-items-start">
                                                                <div class="tp-product-details-review-avater-thumb">
                                                                    <a href="#">
                                                                        <img src="${BASE_URL}assets/img/users/user-2.jpg"
                                                                             alt="">
                                                                    </a>
                                                                </div>
                                                                <div class="tp-product-details-review-avater-content">
                                                                    <div class="tp-product-details-review-avater-rating d-flex align-items-center">
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                        <span><i class="fa-solid fa-star"></i></span>
                                                                    </div>
                                                                    <h3 class="tp-product-details-review-avater-title">
                                                                        Shahnewaz Sakil</h3>
                                                                    <span class="tp-product-details-review-avater-meta">06 March, 2023 </span>

                                                                    <div class="tp-product-details-review-avater-comment">
                                                                        <p>This review is for the Samsung Tab S6 Lite,
                                                                            64gb wifi in blue. purchased this product
                                                                            performed.</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> <!-- end col -->
                                                <div class="col-lg-6">
                                                    <div class="tp-product-details-review-form">
                                                        <h3 class="tp-product-details-review-form-title">Review this
                                                            product</h3>
                                                        <p>Your email address will not be published. Required fields are
                                                            marked *</p>
                                                        <form action="#">
                                                            <div class="tp-product-details-review-form-rating d-flex align-items-center">
                                                                <p>Your Rating :</p>
                                                                <div class="tp-product-details-review-form-rating-icon d-flex align-items-center">
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                    <span><i class="fa-solid fa-star"></i></span>
                                                                </div>
                                                            </div>
                                                            <div class="tp-product-details-review-input-wrapper">
                                                                <div class="tp-product-details-review-input-box">
                                                                    <div class="tp-product-details-review-input">
                                                                        <textarea id="msg" name="msg"
                                                                                  placeholder="Write your review here..."></textarea>
                                                                    </div>
                                                                    <div class="tp-product-details-review-input-title">
                                                                        <label for="msg">Your Name</label>
                                                                    </div>
                                                                </div>
                                                                <div class="tp-product-details-review-input-box">
                                                                    <div class="tp-product-details-review-input">
                                                                        <input name="name" id="name" type="text"
                                                                               placeholder="Shahnewaz Sakil">
                                                                    </div>
                                                                    <div class="tp-product-details-review-input-title">
                                                                        <label for="name">Your Name</label>
                                                                    </div>
                                                                </div>
                                                                <div class="tp-product-details-review-input-box">
                                                                    <div class="tp-product-details-review-input">
                                                                        <input name="email" id="email" type="email"
                                                                               placeholder="shofy@mail.com">
                                                                    </div>
                                                                    <div class="tp-product-details-review-input-title">
                                                                        <label for="email">Your Email</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="tp-product-details-review-suggetions mb-20">
                                                                <div class="tp-product-details-review-remeber">
                                                                    <input id="remeber" type="checkbox">
                                                                    <label for="remeber">Save my name, email, and
                                                                        website in this browser for the next time I
                                                                        comment.</label>
                                                                </div>
                                                            </div>
                                                            <div class="tp-product-details-review-btn-wrapper">
                                                                <button class="tp-product-details-review-btn">Submit
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- product details area end -->

        <!-- related product area start -->
        <section class="tp-related-product pt-95 pb-120">
            <div class="container">
                <div class="row">
                    <div class="tp-section-title-wrapper-6 text-center mb-40">
                        <span class="tp-section-title-pre-6">Next day Products</span>
                        <h3 class="tp-section-title-6">Related Products</h3>
                    </div>
                </div>

                <div class="row">
                    <div class="col-xl-12">
                        <div class="tp-product-tab-content">
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="new-tab-pane" role="tabpanel"
                                     aria-labelledby="new-tab" tabindex="0">
                                    <div class="row">
                                        <c:forEach items='${it.get("relatedProducts")}' var="product">
                                            <div class="col-xl-3 col-lg-3 col-sm-6">
                                                <div class="tp-product-item p-relative transition-3 mb-25">
                                                    <div class="tp-product-thumb p-relative fix m-img">
                                                        <a href="${BASE_URL}products/${product.id}">
                                                            <img src="${product.images.get(0).imageURL}"
                                                                 alt="product-image">
                                                        </a>

                                                        <!-- product badge -->
                                                        <div class="tp-product-badge">
                                                            <span class="product-hot">New</span>
                                                        </div>

                                                        <!-- product action -->
                                                        <div class="tp-product-action">
                                                            <div class="tp-product-action-item d-flex flex-column">
                                                                <a href="${BASE_URL}products/${product.id}"
                                                                   class="tp-product-action-btn tp-product-add-cart-btn">
                                                                    <svg width="20" height="20" viewBox="0 0 20 20"
                                                                         fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M3.93795 5.34749L4.54095 12.5195C4.58495 13.0715 5.03594 13.4855 5.58695 13.4855H5.59095H16.5019H16.5039C17.0249 13.4855 17.4699 13.0975 17.5439 12.5825L18.4939 6.02349C18.5159 5.86749 18.4769 5.71149 18.3819 5.58549C18.2879 5.45849 18.1499 5.37649 17.9939 5.35449C17.7849 5.36249 9.11195 5.35049 3.93795 5.34749ZM5.58495 14.9855C4.26795 14.9855 3.15295 13.9575 3.04595 12.6425L2.12995 1.74849L0.622945 1.48849C0.213945 1.41649 -0.0590549 1.02949 0.0109451 0.620487C0.082945 0.211487 0.477945 -0.054513 0.877945 0.00948704L2.95795 0.369487C3.29295 0.428487 3.54795 0.706487 3.57695 1.04649L3.81194 3.84749C18.0879 3.85349 18.1339 3.86049 18.2029 3.86849C18.7599 3.94949 19.2499 4.24049 19.5839 4.68849C19.9179 5.13549 20.0579 5.68649 19.9779 6.23849L19.0289 12.7965C18.8499 14.0445 17.7659 14.9855 16.5059 14.9855H16.5009H5.59295H5.58495Z"
                                                                              fill="currentColor"/>
                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M14.8979 9.04382H12.1259C11.7109 9.04382 11.3759 8.70782 11.3759 8.29382C11.3759 7.87982 11.7109 7.54382 12.1259 7.54382H14.8979C15.3119 7.54382 15.6479 7.87982 15.6479 8.29382C15.6479 8.70782 15.3119 9.04382 14.8979 9.04382Z"
                                                                              fill="currentColor"/>
                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M5.15474 17.702C5.45574 17.702 5.69874 17.945 5.69874 18.246C5.69874 18.547 5.45574 18.791 5.15474 18.791C4.85274 18.791 4.60974 18.547 4.60974 18.246C4.60974 17.945 4.85274 17.702 5.15474 17.702Z"
                                                                              fill="currentColor"/>

                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M5.15374 18.0409C5.04074 18.0409 4.94874 18.1329 4.94874 18.2459C4.94874 18.4729 5.35974 18.4729 5.35974 18.2459C5.35974 18.1329 5.26674 18.0409 5.15374 18.0409ZM5.15374 19.5409C4.43974 19.5409 3.85974 18.9599 3.85974 18.2459C3.85974 17.5319 4.43974 16.9519 5.15374 16.9519C5.86774 16.9519 6.44874 17.5319 6.44874 18.2459C6.44874 18.9599 5.86774 19.5409 5.15374 19.5409Z"
                                                                              fill="currentColor"/>
                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M16.435 17.702C16.736 17.702 16.98 17.945 16.98 18.246C16.98 18.547 16.736 18.791 16.435 18.791C16.133 18.791 15.89 18.547 15.89 18.246C15.89 17.945 16.133 17.702 16.435 17.702Z"
                                                                              fill="currentColor"/>

                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M16.434 18.0409C16.322 18.0409 16.23 18.1329 16.23 18.2459C16.231 18.4749 16.641 18.4729 16.64 18.2459C16.64 18.1329 16.547 18.0409 16.434 18.0409ZM16.434 19.5409C15.72 19.5409 15.14 18.9599 15.14 18.2459C15.14 17.5319 15.72 16.9519 16.434 16.9519C17.149 16.9519 17.73 17.5319 17.73 18.2459C17.73 18.9599 17.149 19.5409 16.434 19.5409Z"
                                                                              fill="currentColor"/>
                                                                    </svg>

                                                                    <span class="tp-product-tooltip">Add to Cart</span>
                                                                </a>
                                                                <button type="button"
                                                                        class="tp-product-action-btn tp-product-add-to-wishlist-btn" onclick="addToWishlist('${product.id}')">
                                                                    <svg width="20" height="19" viewBox="0 0 20 19"
                                                                         fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M1.78158 8.88867C3.15121 13.1386 8.5623 16.5749 10.0003 17.4255C11.4432 16.5662 16.8934 13.0918 18.219 8.89257C19.0894 6.17816 18.2815 2.73984 15.0714 1.70806C13.5162 1.21019 11.7021 1.5132 10.4497 2.4797C10.1879 2.68041 9.82446 2.68431 9.56069 2.48555C8.23405 1.49079 6.50102 1.19947 4.92136 1.70806C1.71613 2.73887 0.911158 6.17718 1.78158 8.88867ZM10.0013 19C9.88015 19 9.75999 18.9708 9.65058 18.9113C9.34481 18.7447 2.14207 14.7852 0.386569 9.33491C0.385592 9.33491 0.385592 9.33394 0.385592 9.33394C-0.71636 5.90244 0.510636 1.59018 4.47199 0.316764C6.33203 -0.283407 8.35911 -0.019371 9.99836 1.01242C11.5868 0.0108324 13.6969 -0.26587 15.5198 0.316764C19.4851 1.59213 20.716 5.90342 19.615 9.33394C17.9162 14.7218 10.6607 18.7408 10.353 18.9094C10.2436 18.9698 10.1224 19 10.0013 19Z"
                                                                              fill="currentColor"/>
                                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                                              d="M15.7806 7.42904C15.4025 7.42904 15.0821 7.13968 15.0508 6.75775C14.9864 5.95687 14.4491 5.2807 13.6841 5.03421C13.2983 4.9095 13.0873 4.49737 13.2113 4.11446C13.3373 3.73059 13.7467 3.52209 14.1335 3.6429C15.4651 4.07257 16.398 5.24855 16.5123 6.63888C16.5445 7.04127 16.2446 7.39397 15.8412 7.42612C15.8206 7.42807 15.8011 7.42904 15.7806 7.42904Z"
                                                                              fill="currentColor"/>
                                                                    </svg>

                                                                    <span class="tp-product-tooltip">Add To Wishlist</span>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- product content -->
                                                    <div class="tp-product-content">
                                                        <div class="tp-product-category">
                                                            <a href="${BASE_URL}products">${product.category.name}</a>
                                                        </div>
                                                        <h3 class="tp-product-title">
                                                            <a href="${BASE_URL}products/${product.id}">
                                                                    ${product.name}
                                                            </a>
                                                        </h3>
                                                        <div class="tp-product-rating d-flex align-items-center">
                                                            <div class="tp-product-rating-icon">
                                                                <span><i class="fa-solid fa-star"></i></span>
                                                                <span><i class="fa-solid fa-star"></i></span>
                                                                <span><i class="fa-solid fa-star"></i></span>
                                                                <span><i class="fa-solid fa-star"></i></span>
                                                                <span><i
                                                                        class="fa-solid fa-star-half-stroke"></i></span>
                                                            </div>
                                                            <div class="tp-product-rating-text">
                                                                <span>(7 Review)</span>
                                                            </div>
                                                        </div>
                                                        <div class="tp-product-price-wrapper">
                                                            <fmt:formatNumber var="oldPrice" value="${product.price - (product.price * 100) / 10}" type="currency"/>
                                                            <fmt:formatNumber var="price" value="${product.price}" type="currency"/>
                                                            <span class="tp-product-price old-price">${oldPrice}</span>
                                                            <span class="tp-product-price new-price">${price}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- related product area end -->

    </layout:put>

</layout:extends>
