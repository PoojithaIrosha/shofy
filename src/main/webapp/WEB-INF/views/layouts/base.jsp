<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Shofy</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="${BASE_URL}assets/img/logo/favicon.png">

    <!-- CSS here -->
    <link rel="stylesheet" href="${BASE_URL}assets/css/bootstrap.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/animate.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/swiper-bundle.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/slick.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/magnific-popup.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/font-awesome-pro.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/flaticon_shofy.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/spacing.css">
    <link rel="stylesheet" href="${BASE_URL}assets/css/main.css">
</head>
<body>
<!--[if lte IE 9]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade
    your browser</a> to improve your experience and security.</p>
<![endif]-->


<!-- pre loader area start -->
<div id="loading">
    <div id="loading-center">
        <div id="loading-center-absolute">
            <!-- loading content here -->
            <div class="tp-preloader-content">
                <div class="tp-preloader-logo">
                    <div class="tp-preloader-circle">
                        <svg width="190" height="190" viewBox="0 0 380 380" fill="none"
                             xmlns="http://www.w3.org/2000/svg">
                            <circle stroke="#D9D9D9" cx="190" cy="190" r="180" stroke-width="6"
                                    stroke-linecap="round"></circle>
                            <circle stroke="red" cx="190" cy="190" r="180" stroke-width="6"
                                    stroke-linecap="round"></circle>
                        </svg>
                    </div>
                    <img src="${BASE_URL}assets/img/logo/preloader/preloader-icon.svg" alt="">
                </div>
                <h3 class="tp-preloader-title">Shofy</h3>
                <p class="tp-preloader-subtitle">Loading</p>
            </div>
        </div>
    </div>
</div>
<!-- pre loader area end -->

<!-- back to top start -->
<div class="back-to-top-wrapper">
    <button id="back_to_top" type="button" class="back-to-top-btn">
        <svg width="12" height="7" viewBox="0 0 12 7" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M11 6L6 1L1 6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                  stroke-linejoin="round"/>
        </svg>
    </button>
</div>
<!-- back to top end -->

<!-- offcanvas area start -->
<div class="offcanvas__area offcanvas__radius">
    <div class="offcanvas__wrapper">
        <div class="offcanvas__close">
            <button class="offcanvas__close-btn offcanvas-close-btn">
                <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M11 1L1 11" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                          stroke-linejoin="round"/>
                    <path d="M1 1L11 11" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                          stroke-linejoin="round"/>
                </svg>
            </button>
        </div>
        <div class="offcanvas__content">
            <div class="offcanvas__top mb-70 d-flex justify-content-between align-items-center">
                <div class="offcanvas__logo logo">
                    <a href="index.html">
                        <img src="${BASE_URL}assets/img/logo/logo.svg" alt="logo">
                    </a>
                </div>
            </div>
            <div class="offcanvas__category pb-40">
                <button class="tp-offcanvas-category-toggle">
                    <i class="fa-solid fa-bars"></i>
                    All Categories
                </button>
                <div class="tp-category-mobile-menu">

                </div>
            </div>
            <div class="tp-main-menu-mobile fix d-lg-none mb-40"></div>

            <div class="offcanvas__contact align-items-center d-none">
                <div class="offcanvas__contact-icon mr-20">
                     <span>
                        <img src="${BASE_URL}assets/img/icon/contact.png" alt="">
                     </span>
                </div>
                <div class="offcanvas__contact-content">
                    <h3 class="offcanvas__contact-title">
                        <a href="tel:098-852-987">004524865</a>
                    </h3>
                </div>
            </div>
            <div class="offcanvas__btn">
                <a href="contact.html" class="tp-btn-2 tp-btn-border-2">Contact Us</a>
            </div>
        </div>
        <div class="offcanvas__bottom">
            <div class="offcanvas__footer d-flex align-items-center justify-content-between">
                <div class="offcanvas__currency-wrapper currency">
                    <span class="offcanvas__currency-selected-currency tp-currency-toggle"
                          id="tp-offcanvas-currency-toggle">Currency : USD</span>
                    <ul class="offcanvas__currency-list tp-currency-list">
                        <li>USD</li>
                        <li>ERU</li>
                        <li>BDT</li>
                        <li>INR</li>
                    </ul>
                </div>
                <div class="offcanvas__select language">
                    <div class="offcanvas__lang d-flex align-items-center justify-content-md-end">
                        <div class="offcanvas__lang-img mr-15">
                            <img src="${BASE_URL}assets/img/icon/language-flag.png" alt="">
                        </div>
                        <div class="offcanvas__lang-wrapper">
                            <span class="offcanvas__lang-selected-lang tp-lang-toggle" id="tp-offcanvas-lang-toggle">English</span>
                            <ul class="offcanvas__lang-list tp-lang-list">
                                <li>Spanish</li>
                                <li>Portugese</li>
                                <li>American</li>
                                <li>Canada</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="body-overlay"></div>
<!-- offcanvas area end -->

<!-- mobile menu area start -->
<div id="tp-bottom-menu-sticky" class="tp-mobile-menu d-lg-none">
    <div class="container">
        <div class="row row-cols-5">
            <div class="col">
                <div class="tp-mobile-item text-center">
                    <a href="shop.html" class="tp-mobile-item-btn">
                        <i class="flaticon-store"></i>
                        <span>Store</span>
                    </a>
                </div>
            </div>
            <div class="col">
                <div class="tp-mobile-item text-center">
                    <button class="tp-mobile-item-btn tp-search-open-btn">
                        <i class="flaticon-search-1"></i>
                        <span>Search</span>
                    </button>
                </div>
            </div>
            <div class="col">
                <div class="tp-mobile-item text-center">
                    <a href="wishlist.html" class="tp-mobile-item-btn">
                        <i class="flaticon-love"></i>
                        <span>Wishlist</span>
                    </a>
                </div>
            </div>
            <div class="col">
                <div class="tp-mobile-item text-center">
                    <a href="profile.html" class="tp-mobile-item-btn">
                        <i class="flaticon-user"></i>
                        <span>Account</span>
                    </a>
                </div>
            </div>
            <div class="col">
                <div class="tp-mobile-item text-center">
                    <button class="tp-mobile-item-btn tp-offcanvas-open-btn">
                        <i class="flaticon-menu-1"></i>
                        <span>Menu</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- mobile menu area end -->

<!-- search area start -->
<section class="tp-search-area">
    <div class="container">
        <div class="row">
            <div class="col-xl-12">
                <div class="tp-search-form">
                    <div class="tp-search-close text-center mb-20">
                        <button class="tp-search-close-btn tp-search-close-btn"></button>
                    </div>
                    <form action="#">
                        <div class="tp-search-input mb-10">
                            <input type="text" placeholder="Search for product...">
                            <button type="submit"><i class="flaticon-search-1"></i></button>
                        </div>
                        <div class="tp-search-category">
                            <span>Search by : </span>
                            <a href="#">Men, </a>
                            <a href="#">Women, </a>
                            <a href="#">Children, </a>
                            <a href="#">Shirt, </a>
                            <a href="#">Demin</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- search area end -->

<layout:block name="header">
    <jsp:include page="../frontend/includes/header.jsp"/>
</layout:block>

<main>
    <layout:block name="main-content"></layout:block>
</main>

<jsp:include page="../frontend/includes/footer.jsp"/>

<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="toast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <img src="${BASE_URL}assets/img/logo/favicon.png" class="rounded me-2" alt="...">
            <strong class="me-auto">Shofy</strong>
            <small id="toast-status"></small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toast-body">
            Hello, world! This is a toast message.
        </div>
    </div>
</div>

<layout:block name="scripts">

<!-- JS here -->
<script src="${BASE_URL}assets/js/vendor/jquery.js"></script>
<script src="${BASE_URL}assets/js/vendor/waypoints.js"></script>
<script src="${BASE_URL}assets/js/bootstrap-bundle.js"></script>
<script src="${BASE_URL}assets/js/bootstrap-min.js"></script>
<script src="${BASE_URL}assets/js/meanmenu.js"></script>
<script src="${BASE_URL}assets/js/swiper-bundle.js"></script>
<script src="${BASE_URL}assets/js/slick.js"></script>
<script src="${BASE_URL}assets/js/range-slider.js"></script>
<script src="${BASE_URL}assets/js/magnific-popup.js"></script>
<script src="${BASE_URL}assets/js/nice-select.js"></script>
<script src="${BASE_URL}assets/js/purecounter.js"></script>
<script src="${BASE_URL}assets/js/countdown.js"></script>
<script src="${BASE_URL}assets/js/wow.js"></script>
<script src="${BASE_URL}assets/js/isotope-pkgd.js"></script>
<script src="${BASE_URL}assets/js/imagesloaded-pkgd.js"></script>
<script src="${BASE_URL}assets/js/ajax-form.js"></script>
<script src="${BASE_URL}assets/js/main.js"></script>
<script src="${BASE_URL}assets/js/script.js"></script>
<script type="text/javascript">
    const BASE_URL = '${BASE_URL}';
</script>
</layout:block>
</body>

</html>
