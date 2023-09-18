<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>

<layout:extends name="base">

    <layout:put block="header" type="REPLACE">
        <header>
            <div class="tp-header-area tp-header-style-primary tp-header-height">
                <!-- header top start  -->
                <div class="tp-header-top-2 p-relative z-index-11 tp-header-top-border d-none d-md-block">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="tp-header-info d-flex align-items-center">
                                    <div class="tp-header-info-item">
                                        <a href="#">
                                 <span>
                                    <svg width="8" height="15" viewBox="0 0 8 15" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                       <path d="M8 0H5.81818C4.85376 0 3.92883 0.383116 3.24688 1.06507C2.56493 1.74702 2.18182 2.67194 2.18182 3.63636V5.81818H0V8.72727H2.18182V14.5455H5.09091V8.72727H7.27273L8 5.81818H5.09091V3.63636C5.09091 3.44348 5.16753 3.25849 5.30392 3.1221C5.44031 2.98571 5.6253 2.90909 5.81818 2.90909H8V0Z"
                                             fill="currentColor"/>
                                    </svg>
                                 </span> 7500k Followers
                                        </a>
                                    </div>
                                    <div class="tp-header-info-item">
                                        <a href="tel:402-763-282-46">
                                 <span>
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                       <path fill-rule="evenodd" clip-rule="evenodd"
                                             d="M1.359 2.73916C1.59079 2.35465 2.86862 0.958795 3.7792 1.00093C4.05162 1.02426 4.29244 1.1883 4.4881 1.37943H4.48885C4.93737 1.81888 6.22423 3.47735 6.29648 3.8265C6.47483 4.68282 5.45362 5.17645 5.76593 6.03954C6.56213 7.98771 7.93402 9.35948 9.88313 10.1549C10.7455 10.4679 11.2392 9.44752 12.0956 9.62511C12.4448 9.6981 14.1042 10.9841 14.5429 11.4333V11.4333C14.7333 11.6282 14.8989 11.8698 14.9214 12.1422C14.9553 13.1016 13.4728 14.3966 13.1838 14.5621C12.502 15.0505 11.6125 15.0415 10.5281 14.5373C7.50206 13.2784 2.66618 8.53401 1.38384 5.39391C0.893174 4.31561 0.860062 3.42016 1.359 2.73916Z"
                                             stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                             stroke-linejoin="round"/>
                                       <path d="M9.84082 1.18318C12.5534 1.48434 14.6952 3.62393 15 6.3358"
                                             stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                             stroke-linejoin="round"/>
                                       <path d="M9.84082 3.77927C11.1378 4.03207 12.1511 5.04544 12.4039 6.34239"
                                             stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                             stroke-linejoin="round"/>
                                    </svg>
                                 </span> +(402) 763 282 46
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="tp-header-top-right tp-header-top-black d-flex align-items-center justify-content-end">
                                    <div class="tp-header-top-menu d-flex align-items-center justify-content-end">
                                        <div class="tp-header-top-menu-item tp-header-lang">
                                            <span class="tp-header-lang-toggle"
                                                  id="tp-header-lang-toggle">English</span>
                                            <ul>
                                                <li>
                                                    <a href="#">Spanish</a>
                                                </li>
                                                <li>
                                                    <a href="#">Russian</a>
                                                </li>
                                                <li>
                                                    <a href="#">Portuguese</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="tp-header-top-menu-item tp-header-currency">
                                            <span class="tp-header-currency-toggle"
                                                  id="tp-header-currency-toggle">USD</span>
                                            <ul>
                                                <li>
                                                    <a href="#">EUR</a>
                                                </li>
                                                <li>
                                                    <a href="#">CHF</a>
                                                </li>
                                                <li>
                                                    <a href="#">GBP</a>
                                                </li>
                                                <li>
                                                    <a href="#">KWD</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="tp-header-top-menu-item tp-header-setting">
                                            <span class="tp-header-setting-toggle"
                                                  id="tp-header-setting-toggle">Setting</span>
                                            <ul>
                                                <li>
                                                    <a href="${BASE_URL}user/profile">My Profile</a>
                                                </li>
                                                <li>
                                                    <a href="${BASE_URL}user/wishlist">Wishlist</a>
                                                </li>
                                                <li>
                                                    <a href="${BASE_URL}user/cart">Cart</a>
                                                </li>
                                                <li>
                                                    <a href="${BASE_URL}auth/login">Logout</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- header bottom start -->
                <div id="header-sticky" class="tp-header-bottom-2 tp-header-sticky">
                    <div class="container">
                        <div class="tp-mega-menu-wrapper p-relative">
                            <div class="row align-items-center">
                                <div class="col-xl-2 col-lg-5 col-md-5 col-sm-4 col-6">
                                    <div class="logo">
                                        <a href="${BASE_URL}">
                                            <img src="${BASE_URL}assets/img/logo/logo.svg" alt="logo">
                                        </a>
                                    </div>
                                </div>
                                <div class="col-xl-5 d-none d-xl-block">
                                    <div class="main-menu menu-style-2">
                                        <nav class="tp-main-menu-content">
                                            <ul>
                                                <li class="has-dropdown has-mega-menu">
                                                    <a href="${BASE_URL}">Home</a>
                                                    <div class="home-menu tp-submenu tp-mega-menu">
                                                        <div class="row row-cols-1 row-cols-lg-4 row-cols-xl-5">
                                                            <div class="col">
                                                                <div class="home-menu-item ">
                                                                    <a href="${BASE_URL}">
                                                                        <div class="home-menu-thumb p-relative fix">
                                                                            <img src="${BASE_URL}assets/img/menu/menu-home-1.jpg"
                                                                                 alt="">
                                                                        </div>
                                                                        <div class="home-menu-content">
                                                                            <h5 class="home-menu-title">
                                                                                Electronics </h5>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col">
                                                                <div class="home-menu-item ">
                                                                    <a href="index-2.html">
                                                                        <div class="home-menu-thumb p-relative fix">
                                                                            <img src="${BASE_URL}assets/img/menu/menu-home-2.jpg"
                                                                                 alt="">
                                                                        </div>
                                                                        <div class="home-menu-content">
                                                                            <h5 class="home-menu-title">Fashion</h5>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col">
                                                                <div class="home-menu-item ">
                                                                    <a href="index-3.html">
                                                                        <div class="home-menu-thumb p-relative fix">
                                                                            <img src="${BASE_URL}assets/img/menu/menu-home-3.jpg"
                                                                                 alt="">
                                                                        </div>
                                                                        <div class="home-menu-content">
                                                                            <h5 class="home-menu-title">Beauty</h5>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col">
                                                                <div class="home-menu-item ">
                                                                    <a href="index-4.html">
                                                                        <div class="home-menu-thumb p-relative fix">
                                                                            <img src="${BASE_URL}assets/img/menu/menu-home-4.jpg"
                                                                                 alt="">
                                                                        </div>
                                                                        <div class="home-menu-content">
                                                                            <h5 class="home-menu-title">Jewelry </h5>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col">
                                                                <div class="home-menu-item ">
                                                                    <a href="index-5.html">
                                                                        <div class="home-menu-thumb p-relative fix">
                                                                            <img src="${BASE_URL}assets/img/menu/menu-home-5.jpg"
                                                                                 alt="">
                                                                        </div>
                                                                        <div class="home-menu-content">
                                                                            <h5 class="home-menu-title">Grocery</h5>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="has-dropdown has-mega-menu">
                                                    <a href="shop.html">Shop</a>
                                                    <div class="shop-mega-menu tp-submenu tp-mega-menu">
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="shop-mega-menu-list">
                                                                    <a href="shop.html" class="shop-mega-menu-title">Shop
                                                                        Pages</a>
                                                                    <ul>
                                                                        <li><a href="shop-category.html">Grid
                                                                            Category</a></li>
                                                                        <li><a href="shop.html">Grid Layout</a></li>
                                                                        <li><a href="shop-list.html">List Layout</a>
                                                                        </li>
                                                                        <li><a href="shop-masonary.html">Masonary
                                                                            Layout</a></li>
                                                                        <li><a href="shop-full-width.html">Full width
                                                                            Layout</a></li>
                                                                        <li><a href="shop-1600.html">1600px Layout</a>
                                                                        </li>
                                                                        <li><a href="shop.html">Left Sidebar</a></li>
                                                                        <li><a href="shop-right-sidebar.html">Right
                                                                            Sidebar</a></li>
                                                                        <li><a href="shop-no-sidebar.html">Hidden
                                                                            Sidebar</a></li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="shop-mega-menu-list">
                                                                    <a href="shop.html" class="shop-mega-menu-title">Features</a>
                                                                    <ul>
                                                                        <li><a href="shop-filter-dropdown.html">Filter
                                                                            Dropdown</a></li>
                                                                        <li><a href="shop-filter-offcanvas.html">Filters
                                                                            Offcanvas</a></li>
                                                                        <li><a href="shop.html">Filters Sidebar</a></li>
                                                                        <li><a href="shop-load-more.html">Load More
                                                                            button</a></li>
                                                                        <li><a href="shop-infinite-scroll.html">Infinit
                                                                            scrolling</a></li>
                                                                        <li><a href="shop-list.html">Collections
                                                                            list</a></li>
                                                                        <li><a href="shop.html">Hidden search</a></li>
                                                                        <li><a href="shop.html">Search Full screen</a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="shop-mega-menu-list">
                                                                    <a href="shop.html" class="shop-mega-menu-title">Hover
                                                                        Style</a>
                                                                    <ul>
                                                                        <li><a href="shop.html">Hover Style 1</a></li>
                                                                        <li><a href="shop.html">Hover Style 2</a></li>
                                                                        <li><a href="shop.html">Hover Style 3</a></li>
                                                                        <li><a href="shop.html">Hover Style 4</a></li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <div class="shop-mega-menu-img">
                                                                    <img src="${BASE_URL}assets/img/menu/product/menu-product-img-1.jpg"
                                                                         alt="">
                                                                    <div class="shop-mega-menu-btn">
                                                                        <a href="shop-category.html"
                                                                           class="tp-menu-showcase-btn tp-menu-showcase-btn-2">Phones</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-3">
                                                                <div class="shop-mega-menu-img">
                                                                    <img src="${BASE_URL}assets/img/menu/product/menu-product-img-2.jpg"
                                                                         alt="">
                                                                    <div class="shop-mega-menu-btn">
                                                                        <a href="shop-category.html"
                                                                           class="tp-menu-showcase-btn tp-menu-showcase-btn-2">Cameras</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="has-dropdown has-mega-menu ">

                                                    <a href="shop.html">Products</a>
                                                    <ul class="tp-submenu tp-mega-menu mega-menu-style-2">
                                                        <!-- first col -->
                                                        <li class="has-dropdown">
                                                            <a href="shop.html" class="mega-menu-title">Shop Page</a>
                                                            <ul class="tp-submenu">
                                                                <li><a href="shop-category.html">Only Categories</a>
                                                                </li>
                                                                <li><a href="shop-filter-offcanvas.html">Shop Grid</a>
                                                                </li>
                                                                <li><a href="shop.html">Shop Grid with Sideber</a></li>
                                                                <li><a href="shop-list.html">Shop List</a></li>
                                                                <li><a href="shop-category.html">Categories</a></li>
                                                                <li><a href="product-details.html">Product Details</a>
                                                                </li>
                                                                <li><a href="product-details-progress.html">Product
                                                                    Details Progress</a></li>
                                                            </ul>
                                                        </li>
                                                        <!-- third col -->
                                                        <li class="has-dropdown">
                                                            <a href="product-details.html" class="mega-menu-title">Products</a>
                                                            <ul class="tp-submenu">

                                                                <li><a href="product-details.html">Product Simple</a>
                                                                </li>
                                                                <li><a href="product-details-video.html">With Video</a>
                                                                </li>
                                                                <li><a href="product-details-countdown.html">With
                                                                    Countdown Timer</a></li>
                                                                <li><a href="product-details-presentation.html">Product
                                                                    Presentation</a></li>
                                                                <li><a href="product-details-swatches.html">Variations
                                                                    Swatches</a></li>
                                                                <li><a href="product-details-list.html">List View</a>
                                                                </li>
                                                                <li><a href="product-details-gallery.html">Details
                                                                    Gallery</a></li>
                                                                <li><a href="product-details-slider.html">With
                                                                    Slider</a></li>
                                                            </ul>
                                                        </li>
                                                        <!-- third col -->
                                                        <li class="has-dropdown">
                                                            <a href="shop.html" class="mega-menu-title">eCommerce</a>
                                                            <ul class="tp-submenu">
                                                                <li><a href="${BASE_URL}user/cart">Shopping Cart</a></li>
                                                                <li><a href="order.html">Track Your Order</a></li>
                                                                <li><a href="compare.html">Compare</a></li>
                                                                <li><a href="${BASE_URL}user/wishlist">Wishlist</a></li>
                                                                <li><a href="checkout.html">Checkout</a></li>
                                                                <li><a href="${BASE_URL}user/profile">My account</a></li>
                                                            </ul>
                                                        </li>

                                                        <!-- second col -->
                                                        <li class="has-dropdown">
                                                            <a href="shop.html" class="mega-menu-title">More Pages</a>
                                                            <ul class="tp-submenu">


                                                                <li><a href="about.html">About</a></li>
                                                                <li><a href="login.html">Login</a></li>
                                                                <li><a href="register.html">Register</a></li>
                                                                <li><a href="forgot.html">Forgot Password</a></li>
                                                                <li><a href="404.html">404 Error</a></li>
                                                            </ul>
                                                        </li>

                                                    </ul>
                                                </li>
                                                <li><a href="coupon.html">Coupons</a></li>
                                                <li class="has-dropdown">
                                                    <a href="blog.html">Blog</a>
                                                    <ul class="tp-submenu">
                                                        <li><a href="blog.html">Blog Standard</a></li>
                                                        <li><a href="blog-grid.html">Blog Grid</a></li>
                                                        <li><a href="blog-list.html">Blog List</a></li>
                                                        <li><a href="blog-details-2.html">Blog Details Full Width</a>
                                                        </li>
                                                        <li><a href="blog-details.html">Blog Details</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="contact.html">Contact</a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                    <div class="tp-category-menu-wrapper d-none">
                                        <nav class="tp-category-menu-content">
                                            <ul>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="16" height="17" viewBox="0 0 16 17" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path d="M5.90532 14.8316V12.5719C5.9053 11.9971 6.37388 11.5301 6.95443 11.5262H9.08101C9.66434 11.5262 10.1372 11.9944 10.1372 12.5719V12.5719V14.8386C10.1371 15.3266 10.5305 15.7254 11.0233 15.7368H12.441C13.8543 15.7368 15 14.6026 15 13.2035V13.2035V6.77525C14.9925 6.22482 14.7314 5.70794 14.2911 5.37171L9.44253 1.50496C8.59311 0.83168 7.38562 0.83168 6.5362 1.50496L1.70886 5.37873C1.26693 5.7136 1.00544 6.23133 1 6.78227V13.2035C1 14.6026 2.1457 15.7368 3.55899 15.7368H4.97671C5.48173 15.7368 5.89114 15.3315 5.89114 14.8316V14.8316"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        New Arrivals</a>
                                                </li>
                                                <li class="has-dropdown">
                                                    <a href="shop.html" class="has-mega-menu">
                                           <span>
                                              <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path d="M2.6856 4.54975C2.6856 3.52014 3.51984 2.6859 4.54945 2.68508H5.3977C5.88984 2.68508 6.36136 2.48971 6.71089 2.14348L7.30359 1.54995C8.02984 0.819578 9.21031 0.816281 9.94068 1.54253L9.9415 1.54336L9.94892 1.54995L10.5425 2.14348C10.892 2.49053 11.3635 2.68508 11.8556 2.68508H12.7031C13.7327 2.68508 14.5677 3.51932 14.5677 4.54975V5.39636C14.5677 5.88849 14.7623 6.36084 15.1093 6.71037L15.7029 7.3039C16.4332 8.03015 16.4374 9.21061 15.7111 9.94098L15.7103 9.94181L15.7029 9.94923L15.1093 10.5428C14.7623 10.8915 14.5677 11.363 14.5677 11.8551V12.7034C14.5677 13.733 13.7335 14.5672 12.7039 14.5672H12.7031H11.854C11.3619 14.5672 10.8895 14.7626 10.5408 15.1096L9.94727 15.7024C9.22185 16.4327 8.04221 16.4368 7.31183 15.7122C7.31101 15.7114 7.31019 15.7106 7.30936 15.7098L7.30194 15.7024L6.70924 15.1096C6.36054 14.7626 5.88819 14.568 5.39605 14.5672H4.54945C3.51984 14.5672 2.6856 13.733 2.6856 12.7034V11.8535C2.6856 11.3613 2.49023 10.8898 2.14318 10.5411L1.55047 9.94758C0.820097 9.22215 0.815976 8.04251 1.5414 7.31214C1.5414 7.31132 1.54223 7.31049 1.54305 7.30967L1.55047 7.30225L2.14318 6.70872C2.49023 6.35919 2.6856 5.88767 2.6856 5.39471V4.54975"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M6.50787 10.7453L10.745 6.50812" stroke="currentColor"
                                                       stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M10.6823 10.6862H10.6897" stroke="currentColor"
                                                       stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                 <path d="M6.56053 6.56446H6.56795" stroke="currentColor"
                                                       stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Electronics</a>

                                                    <ul class="mega-menu tp-submenu">
                                                        <li>
                                                            <a href="shop.html" class="mega-menu-title">Featured</a>
                                                            <ul>
                                                                <li>
                                                                    <a href="shop.html"><img
                                                                            src="${BASE_URL}assets/img/header/menu/menu-1.jpg"
                                                                            alt=""></a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">New Arrivals</a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Best Seller</a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Top Rated</a>
                                                                </li>
                                                            </ul>
                                                        </li>

                                                        <li>
                                                            <a href="shop.html" class="mega-menu-title">Computer &
                                                                Laptops</a>
                                                            <ul>
                                                                <li>
                                                                    <a href="shop.html"><img
                                                                            src="${BASE_URL}assets/img/header/menu/menu-2.jpg"
                                                                            alt=""></a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Top Brands</a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Weekly Best Selling</a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Most Viewed</a>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <a href="shop.html" class="mega-menu-title">Accessories</a>
                                                            <ul>
                                                                <li>
                                                                    <a href="shop.html"><img
                                                                            src="${BASE_URL}assets/img/header/menu/menu-3.jpg"
                                                                            alt=""></a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Headphones</a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">TWS Earphone</a>
                                                                </li>
                                                                <li>
                                                                    <a href="shop.html">Gaming Headset</a>
                                                                </li>
                                                            </ul>
                                                        </li>

                                                    </ul>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="17" height="17" viewBox="0 0 17 17" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path d="M14.5 8.5V16H2.50003V8.5" stroke="currentColor"
                                                       stroke-width="1.4" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M16 4.75H1V8.5H16V4.75Z" stroke="currentColor"
                                                       stroke-width="1.4" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M8.5 16V4.75" stroke="currentColor" stroke-width="1.4"
                                                       stroke-linecap="round" stroke-linejoin="round"/>
                                                 <path d="M8.49997 4.75H5.12497C4.62769 4.75 4.15077 4.55246 3.79914 4.20083C3.44751 3.84919 3.24997 3.37228 3.24997 2.875C3.24997 2.37772 3.44751 1.90081 3.79914 1.54917C4.15077 1.19754 4.62769 1 5.12497 1C7.74997 1 8.49997 4.75 8.49997 4.75Z"
                                                       stroke="currentColor" stroke-width="1.4" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M8.5 4.75H11.875C12.3723 4.75 12.8492 4.55246 13.2008 4.20083C13.5525 3.84919 13.75 3.37228 13.75 2.875C13.75 2.37772 13.5525 1.90081 13.2008 1.54917C12.8492 1.19754 12.3723 1 11.875 1C9.25 1 8.5 4.75 8.5 4.75Z"
                                                       stroke="currentColor" stroke-width="1.4" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Gifts</a>
                                                </li>
                                                <li class="has-dropdown">
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="17" height="16" viewBox="0 0 17 16" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path d="M14.5 1H2.5C1.67157 1 1 1.67157 1 2.5V10C1 10.8284 1.67157 11.5 2.5 11.5H14.5C15.3284 11.5 16 10.8284 16 10V2.5C16 1.67157 15.3284 1 14.5 1Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M5.5 14.5H11.5" stroke="currentColor" stroke-width="1.5"
                                                       stroke-linecap="round" stroke-linejoin="round"/>
                                                 <path d="M8.5 11.5V14.5" stroke="currentColor" stroke-width="1.5"
                                                       stroke-linecap="round" stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Computers</a>

                                                    <ul class="tp-submenu">
                                                        <li class="has-dropdown">
                                                            <a href="shop.html">Desktop</a>
                                                            <ul class="tp-submenu">
                                                                <li><a href="shop.html">Gaming</a></li>
                                                                <li><a href="shop.html">WorkSpace</a></li>
                                                                <li><a href="shop.html">Customize</a></li>
                                                                <li><a href="shop.html">Luxury</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="shop.html">Laptop</a></li>
                                                        <li><a href="shop.html">Console</a></li>
                                                        <li><a href="shop.html">Top Rated</a></li>
                                                    </ul>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="15" height="18" viewBox="0 0 15 18" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path d="M12.375 1H2.625C1.72754 1 1 1.72754 1 2.625V15.625C1 16.5225 1.72754 17.25 2.625 17.25H12.375C13.2725 17.25 14 16.5225 14 15.625V2.625C14 1.72754 13.2725 1 12.375 1Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M7.5 14H7.50875" stroke="currentColor" stroke-width="1.5"
                                                       stroke-linecap="round" stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Smartphones & Tablets</a>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M9 1C13.4176 1 17 4.5816 17 9C17 13.4184 13.4176 17 9 17C4.5816 17 1 13.4184 1 9C1 4.5816 4.5816 1 9 1Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M11.5263 8.99592C11.5263 8.31286 8.02529 6.12769 7.62814 6.5206C7.23099 6.9135 7.19281 11.0413 7.62814 11.4712C8.06348 11.9027 11.5263 9.67898 11.5263 8.99592Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        TV, Video & Musice</a>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="18" height="16" viewBox="0 0 18 16" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M11.6292 1.26076C12.5027 1.60843 12.7699 2.81924 13.1271 3.20843C13.4843 3.59762 13.9955 3.72995 14.2783 3.72995C15.7814 3.72995 17 4.94854 17 6.45081V11.4627C17 13.4778 15.3654 15.1124 13.3503 15.1124H4.64973C2.63373 15.1124 1 13.4778 1 11.4627V6.45081C1 4.94854 2.21859 3.72995 3.72173 3.72995C4.00368 3.72995 4.51481 3.59762 4.87287 3.20843C5.23005 2.81924 5.49643 1.60843 6.36995 1.26076C7.24432 0.913081 10.7557 0.913081 11.6292 1.26076Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M13.7527 5.97314H13.7605" stroke="currentColor"
                                                       stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M11.7491 9.11086C11.7491 7.59215 10.5184 6.36145 8.99974 6.36145C7.48104 6.36145 6.25034 7.59215 6.25034 9.11086C6.25034 10.6296 7.48104 11.8603 8.99974 11.8603C10.5184 11.8603 11.7491 10.6296 11.7491 9.11086Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Cameras</a>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="17" height="17" viewBox="0 0 17 17" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M2.30431 1C1.58423 1 1 1.59405 1 2.32534V3.10537C1 3.64706 1.20599 4.16798 1.57446 4.55981L5.61258 8.8536L5.61436 8.8509C6.39393 9.64899 6.83254 10.7279 6.83254 11.8528V15.6626C6.83254 15.9172 7.09891 16.0798 7.32 15.9597L9.61963 14.7066C9.96679 14.517 10.1834 14.1486 10.1834 13.7487V11.8428C10.1834 10.7242 10.6158 9.64989 11.3883 8.8536L15.4264 4.55981C15.794 4.16798 16 3.64706 16 3.10537V2.32534C16 1.59405 15.4167 1 14.6966 1H2.30431Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Cooking</a>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="18" height="16" viewBox="0 0 18 16" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path d="M15.7462 7.16473V13.167C15.7462 13.6457 15.556 14.1049 15.2175 14.4434C14.8789 14.782 14.4197 14.9722 13.941 14.9722H4.3058C3.82703 14.9722 3.3679 14.782 3.02936 14.4434C2.69083 14.1049 2.50061 13.6457 2.50061 13.167V9.36255"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M3.46186 1.00001C3.18176 0.999863 2.90854 1.08659 2.6798 1.24825C2.45106 1.4099 2.27807 1.63852 2.18471 1.9026L1.11062 5.01655C0.713475 6.15382 1.41752 7.16021 2.71274 7.16021C3.18296 7.14863 3.64325 7.02257 4.05374 6.79294C4.46424 6.56331 4.81255 6.23705 5.0685 5.84243C5.20151 6.24071 5.46067 6.58479 5.80676 6.82258C6.15285 7.06036 6.56702 7.17889 6.98651 7.16021C7.18566 6.7642 7.4909 6.43132 7.86823 6.19871C8.24556 5.96611 8.68013 5.84294 9.1234 5.84294C9.56666 5.84294 10.0012 5.96611 10.3785 6.19871C10.7558 6.43132 11.0611 6.7642 11.2603 7.16021V7.16021C11.679 7.17789 12.0922 7.0589 12.4373 6.82119C12.7825 6.58348 13.041 6.23994 13.1738 5.84243C13.431 6.23686 13.7802 6.56288 14.1914 6.79243C14.6026 7.02199 15.0633 7.1482 15.5341 7.16021C16.8293 7.16021 17.5288 6.15382 17.1362 5.01655L16.0621 1.9026C15.9685 1.6378 15.7948 1.40866 15.5652 1.24694C15.3355 1.08522 15.0613 0.998927 14.7804 1.00001H3.46186Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M11.0707 14.9722H7.19861V11.4701C7.19861 10.983 7.3921 10.5158 7.73656 10.1713C8.08102 9.82685 8.54822 9.63333 9.03536 9.63333H9.22041C9.70755 9.63333 10.1747 9.82685 10.5192 10.1713C10.8637 10.5158 11.0572 10.983 11.0572 11.4701L11.0707 14.9722Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                              </svg>
                                           </span>
                                                        Accessories</a>
                                                </li>
                                                <li>
                                                    <a href="shop.html">
                                           <span>
                                              <svg width="18" height="17" viewBox="0 0 18 17" fill="none"
                                                   xmlns="http://www.w3.org/2000/svg">
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M6.92384 11.3525C10.1178 11.3525 12.8477 11.8365 12.8477 13.7698C12.8477 15.7032 10.136 16.201 6.92384 16.201C3.72902 16.201 1 15.7213 1 13.7871C1 11.8529 3.71084 11.3525 6.92384 11.3525Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path fill-rule="evenodd" clip-rule="evenodd"
                                                       d="M6.92383 8.59311C4.82685 8.59311 3.1264 6.89354 3.1264 4.79656C3.1264 2.69958 4.82685 1 6.92383 1C9.01994 1 10.7204 2.69958 10.7204 4.79656C10.7282 6.88575 9.03986 8.58532 6.95067 8.59311H6.92383Z"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M12.8906 7.60761C14.2768 7.41281 15.3443 6.22319 15.3469 4.78336C15.3469 3.3643 14.3123 2.18681 12.9556 1.96429"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 <path d="M14.7195 10.9416C16.0623 11.1416 17 11.6126 17 12.5823C17 13.2498 16.5584 13.6827 15.845 13.9537"
                                                       stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                                       stroke-linejoin="round"/>
                                                 </svg>
                                           </span>
                                                        Sports</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                                <div class="col-xl-5 col-lg-7 col-md-7 col-sm-8 col-6">
                                    <div class="tp-header-bottom-right d-flex align-items-center justify-content-end pl-30">
                                        <div class="tp-header-search-2 d-none d-sm-block">
                                            <form action="#">
                                                <input type="text" placeholder="Search for Products...">
                                                <button type="submit">
                                                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M9 17C13.4183 17 17 13.4183 17 9C17 4.58172 13.4183 1 9 1C4.58172 1 1 4.58172 1 9C1 13.4183 4.58172 17 9 17Z"
                                                              stroke="currentColor" stroke-width="2"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M18.9999 19L14.6499 14.65" stroke="currentColor"
                                                              stroke-width="2" stroke-linecap="round"
                                                              stroke-linejoin="round"/>
                                                    </svg>
                                                </button>
                                            </form>
                                        </div>
                                        <div class="tp-header-action d-flex align-items-center ml-30">
                                            <div class="tp-header-action-item d-none d-lg-block">
                                                <a href="compare.html" class="tp-header-action-btn">
                                                    <svg width="20" height="19" viewBox="0 0 20 19" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M14.8396 17.3319V3.71411" stroke="currentColor"
                                                              stroke-width="1.5" stroke-linecap="round"
                                                              stroke-linejoin="round"/>
                                                        <path d="M19.1556 13L15.0778 17.0967L11 13"
                                                              stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M4.91115 1.00056V14.6183" stroke="currentColor"
                                                              stroke-width="1.5" stroke-linecap="round"
                                                              stroke-linejoin="round"/>
                                                        <path d="M0.833496 5.09667L4.91127 1L8.98905 5.09667"
                                                              stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                    </svg>
                                                </a>
                                            </div>
                                            <div class="tp-header-action-item d-none d-lg-block">
                                                <a href="${BASE_URL}user/wishlist" class="tp-header-action-btn">
                                                    <svg width="22" height="20" viewBox="0 0 22 20" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                              d="M11.239 18.8538C13.4096 17.5179 15.4289 15.9456 17.2607 14.1652C18.5486 12.8829 19.529 11.3198 20.1269 9.59539C21.2029 6.25031 19.9461 2.42083 16.4289 1.28752C14.5804 0.692435 12.5616 1.03255 11.0039 2.20148C9.44567 1.03398 7.42754 0.693978 5.57894 1.28752C2.06175 2.42083 0.795919 6.25031 1.87187 9.59539C2.46978 11.3198 3.45021 12.8829 4.73806 14.1652C6.56988 15.9456 8.58917 17.5179 10.7598 18.8538L10.9949 19L11.239 18.8538Z"
                                                              stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M7.26062 5.05302C6.19531 5.39332 5.43839 6.34973 5.3438 7.47501"
                                                              stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                    </svg>
                                                    <span class="tp-header-action-badge">4</span>
                                                </a>
                                            </div>
                                            <div class="tp-header-action-item">
                                                <button class="tp-header-action-btn cartmini-open-btn">
                                                    <svg width="21" height="22" viewBox="0 0 21 22" fill="none"
                                                         xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd" clip-rule="evenodd"
                                                              d="M6.48626 20.5H14.8341C17.9004 20.5 20.2528 19.3924 19.5847 14.9348L18.8066 8.89359C18.3947 6.66934 16.976 5.81808 15.7311 5.81808H5.55262C4.28946 5.81808 2.95308 6.73341 2.4771 8.89359L1.69907 14.9348C1.13157 18.889 3.4199 20.5 6.48626 20.5Z"
                                                              stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M6.34902 5.5984C6.34902 3.21232 8.28331 1.27803 10.6694 1.27803V1.27803C11.8184 1.27316 12.922 1.72619 13.7362 2.53695C14.5504 3.3477 15.0081 4.44939 15.0081 5.5984V5.5984"
                                                              stroke="currentColor" stroke-width="1.5"
                                                              stroke-linecap="round" stroke-linejoin="round"/>
                                                        <path d="M7.70365 10.1018H7.74942" stroke="currentColor"
                                                              stroke-width="1.5" stroke-linecap="round"
                                                              stroke-linejoin="round"/>
                                                        <path d="M13.5343 10.1018H13.5801" stroke="currentColor"
                                                              stroke-width="1.5" stroke-linecap="round"
                                                              stroke-linejoin="round"/>
                                                    </svg>
                                                    <span class="tp-header-action-badge">13</span>
                                                </button>
                                            </div>
                                            <div class="tp-header-action-item tp-header-hamburger mr-20 d-xl-none">
                                                <button type="button" class="tp-offcanvas-open-btn">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="16"
                                                         viewBox="0 0 30 16">
                                                        <rect x="10" width="20" height="2" fill="currentColor"/>
                                                        <rect x="5" y="7" width="25" height="2" fill="currentColor"/>
                                                        <rect x="10" y="14" width="20" height="2" fill="currentColor"/>
                                                    </svg>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
    </layout:put>

    <layout:put block="main-content" type="REPLACE">
        <!-- breadcrumb area start -->
        <section class="breadcrumb__area include-bg text-center pt-95 pb-50">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-12">
                        <div class="breadcrumb__content p-relative z-index-1">
                            <h3 class="breadcrumb__title">Register Now</h3>
                            <div class="breadcrumb__list">
                                <span><a href="#">Home</a></span>
                                <span>Register</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- breadcrumb area end -->

        <!-- login area start -->
        <section class="tp-login-area pb-140 p-relative z-index-1 fix">
            <div class="tp-login-shape">
                <img class="tp-login-shape-1" src="${BASE_URL}assets/img/login/login-shape-1.png" alt="">
                <img class="tp-login-shape-2" src="${BASE_URL}assets/img/login/login-shape-2.png" alt="">
                <img class="tp-login-shape-3" src="${BASE_URL}assets/img/login/login-shape-3.png" alt="">
                <img class="tp-login-shape-4" src="${BASE_URL}assets/img/login/login-shape-4.png" alt="">
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-8">
                        <div class="tp-login-wrapper">
                            <div class="tp-login-top text-center mb-30">
                                <h3 class="tp-login-title">Sign Up Shofy.</h3>
                                <p>Already have an account? <span><a href="${BASE_URL}auth/login">Sign In</a></span></p>
                            </div>
                            <div class="tp-login-option">
                                <div class="tp-login-social mb-10 d-flex flex-wrap align-items-center justify-content-center">
                                    <div id="g_id_onload"
                                         data-client_id="180225818516-i4ihldr9n6ckr823m6bch0b93t8s2kub.apps.googleusercontent.com"
                                         data-context="signin"
                                         data-ux_mode="popup"
                                         data-callback="googleSignIn"
                                         data-auto_prompt="false">
                                    </div>

                                    <div class="g_id_signin"
                                         data-type="standard"
                                         data-shape="rectangular"
                                         data-theme="outline"
                                         data-text="continue_with"
                                         data-size="large"
                                         data-logo_alignment="center"
                                    >
                                    </div>
                                </div>
                                <div class="tp-login-mail text-center mb-40">
                                    <p>or Sign up with <a href="#">Email</a></p>
                                </div>
                                <div class="tp-login-input-wrapper">
                                    <div class="tp-login-input-box">
                                        <div class="tp-login-input">
                                            <input id="fname" type="text" placeholder="John">
                                        </div>
                                        <div class="tp-login-input-title">
                                            <label for="fname">Your First Name</label>
                                        </div>
                                    </div>
                                    <div class="tp-login-input-box">
                                        <div class="tp-login-input">
                                            <input id="lname" type="text" placeholder="Smith">
                                        </div>
                                        <div class="tp-login-input-title">
                                            <label for="lname">Your Last Name</label>
                                        </div>
                                    </div>
                                    <div class="tp-login-input-box">
                                        <div class="tp-login-input">
                                            <input id="mobile" type="text" placeholder="+94 71 234 6879">
                                        </div>
                                        <div class="tp-login-input-title">
                                            <label for="mobile">Your Mobile Number</label>
                                        </div>
                                    </div>
                                    <div class="tp-login-input-box">
                                        <div class="tp-login-input">
                                            <input id="email" type="email" placeholder="shofy@mail.com">
                                        </div>
                                        <div class="tp-login-input-title">
                                            <label for="email">Your Email</label>
                                        </div>
                                    </div>
                                    <div class="tp-login-input-box">
                                        <div class="tp-login-input">
                                            <input id="password" type="password" placeholder="Min. 6 character">
                                        </div>
                                        <div class="tp-login-input-eye" id="password-show-toggle">
                                    <span id="open-eye" class="open-eye">
                                       <svg width="18" height="14" viewBox="0 0 18 14" fill="none"
                                            xmlns="http://www.w3.org/2000/svg">
                                          <path d="M1 6.77778C1 6.77778 3.90909 1 9 1C14.0909 1 17 6.77778 17 6.77778C17 6.77778 14.0909 12.5556 9 12.5556C3.90909 12.5556 1 6.77778 1 6.77778Z"
                                                stroke="currentColor" stroke-width="1.2" stroke-linecap="round"
                                                stroke-linejoin="round"/>
                                          <path d="M9.00018 8.94466C10.2052 8.94466 11.182 7.97461 11.182 6.77799C11.182 5.58138 10.2052 4.61133 9.00018 4.61133C7.79519 4.61133 6.81836 5.58138 6.81836 6.77799C6.81836 7.97461 7.79519 8.94466 9.00018 8.94466Z"
                                                stroke="currentColor" stroke-width="1.2" stroke-linecap="round"
                                                stroke-linejoin="round"/>
                                       </svg>
                                    </span>
                                            <span id="close-eye" class="open-close">
                                       <svg width="19" height="18" viewBox="0 0 19 18" fill="none"
                                            xmlns="http://www.w3.org/2000/svg">
                                          <path d="M6.8822 11.7457C6.72311 11.7457 6.56402 11.6871 6.43842 11.5615C5.7518 10.8749 5.375 9.9622 5.375 8.99926C5.375 6.99803 6.99943 5.3736 9.00066 5.3736C9.9636 5.3736 10.8763 5.7504 11.5629 6.43701C11.6801 6.55424 11.7471 6.71333 11.7471 6.8808C11.7471 7.04827 11.6801 7.20736 11.5629 7.32459L7.32599 11.5615C7.20039 11.6871 7.0413 11.7457 6.8822 11.7457ZM9.00066 6.6296C7.69442 6.6296 6.631 7.69302 6.631 8.99926C6.631 9.41793 6.73986 9.81985 6.94082 10.1715L10.1729 6.93941C9.82125 6.73845 9.41933 6.6296 9.00066 6.6296Z"
                                                fill="#1C274C"/>
                                          <path opacity="0.5"
                                                d="M3.63816 14.4503C3.49582 14.4503 3.3451 14.4001 3.22787 14.2996C2.33192 13.5376 1.52808 12.5998 0.841463 11.5112C-0.0461127 10.1296 -0.0461127 7.87721 0.841463 6.48723C2.88456 3.28861 5.8571 1.44647 8.99711 1.44647C10.8393 1.44647 12.6563 2.08285 14.2472 3.28024C14.5235 3.48957 14.5821 3.88312 14.3728 4.15944C14.1635 4.43576 13.7699 4.49437 13.4936 4.28504C12.1204 3.24674 10.5629 2.70248 8.99711 2.70248C6.29252 2.70248 3.70515 4.32691 1.89651 7.16547C1.2685 8.14516 1.2685 9.85332 1.89651 10.833C2.52451 11.8127 3.24462 12.6584 4.04009 13.345C4.29966 13.5711 4.33315 13.9646 4.10707 14.2326C3.98984 14.3749 3.814 14.4503 3.63816 14.4503Z"
                                                fill="#1C274C"/>
                                          <path opacity="0.5"
                                                d="M9.00382 16.552C7.89017 16.552 6.80163 16.3259 5.75496 15.8821C5.43678 15.7482 5.28606 15.3797 5.42003 15.0616C5.554 14.7434 5.92243 14.5927 6.24062 14.7266C7.12819 15.1034 8.05764 15.296 8.99545 15.296C11.7 15.296 14.2874 13.6716 16.0961 10.833C16.7241 9.85333 16.7241 8.14517 16.0961 7.16548C15.8365 6.75519 15.5518 6.36164 15.2503 5.99321C15.0326 5.72527 15.0745 5.33172 15.3425 5.10564C15.6104 4.88793 16.0039 4.92142 16.23 5.19775C16.5566 5.59967 16.8748 6.03508 17.1595 6.48724C18.047 7.86885 18.047 10.1213 17.1595 11.5113C15.1164 14.7099 12.1438 16.552 9.00382 16.552Z"
                                                fill="#1C274C"/>
                                          <path d="M9.58061 12.5747C9.28754 12.5747 9.01959 12.3654 8.96098 12.0639C8.89399 11.7206 9.12007 11.3941 9.46338 11.3355C10.3845 11.168 11.1548 10.3976 11.3223 9.47657C11.3893 9.13327 11.7158 8.91556 12.0591 8.97417C12.4024 9.04116 12.6285 9.36772 12.5615 9.71103C12.2936 11.1596 11.1381 12.3068 9.69783 12.5747C9.65597 12.5663 9.62247 12.5747 9.58061 12.5747Z"
                                                fill="#1C274C"/>
                                          <path d="M0.625908 18.0007C0.466815 18.0007 0.307721 17.9421 0.18212 17.8165C-0.0607068 17.5736 -0.0607068 17.1717 0.18212 16.9289L6.43702 10.674C6.67984 10.4312 7.08177 10.4312 7.32459 10.674C7.56742 10.9168 7.56742 11.3188 7.32459 11.5616L1.0697 17.8165C0.944096 17.9421 0.785002 18.0007 0.625908 18.0007Z"
                                                fill="#1C274C"/>
                                          <path d="M11.122 7.50881C10.9629 7.50881 10.8038 7.45019 10.6782 7.32459C10.4354 7.08177 10.4354 6.67984 10.6782 6.43702L16.9331 0.182121C17.1759 -0.0607068 17.5779 -0.0607068 17.8207 0.182121C18.0635 0.424948 18.0635 0.826869 17.8207 1.0697L11.5658 7.32459C11.4402 7.45019 11.2811 7.50881 11.122 7.50881Z"
                                                fill="#1C274C"/>
                                       </svg>
                                    </span>
                                        </div>
                                        <div class="tp-login-input-title">
                                            <label for="password">Password</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="my-3 d-flex align-items-center gap-1 d-none" id="error-msg">
                                    <svg height="25" style="overflow:visible;enable-background:new 0 0 32 32" viewBox="0 0 32 32" width="32" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><g><g id="Error_1_"><g id="Error"><circle cx="16" cy="16" id="BG" r="16" style="fill:#D72828;"/><path d="M14.5,25h3v-3h-3V25z M14.5,6v13h3V6H14.5z" id="Exclamatory_x5F_Sign" style="fill:#E6E6E6;"/></g></g></g></svg>
                                    <span class="text-danger fs-6">Please enter your first name</span>
                                </div>
                                <div class="tp-login-bottom">
                                    <button class="tp-login-btn w-100" onclick="signUp()">Sign Up</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- login area end -->
    </layout:put>

    <layout:put block="scripts" type="PREPEND">
        <script src="https://accounts.google.com/gsi/client" async></script>
    </layout:put>
</layout:extends>
