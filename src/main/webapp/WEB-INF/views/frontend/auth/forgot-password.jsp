<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>

<layout:extends name="base">

  <layout:put block="header" type="REPLACE">
    <jsp:include page="../includes/header-2.jsp" />
  </layout:put>

    <layout:put block="main-content" type="REPLACE">

        <!-- breadcrumb area start -->
        <section class="breadcrumb__area include-bg text-center pt-95 pb-50">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-12">
                        <div class="breadcrumb__content p-relative z-index-1">
                            <h3 class="breadcrumb__title">Forgot Password</h3>
                            <div class="breadcrumb__list">
                                <span><a href="#">Home</a></span>
                                <span>Reset Passowrd</span>
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
                                <h3 class="tp-login-title">Reset Passowrd</h3>
                                <p>Enter your email address to request password reset.</p>
                            </div>
                            <div class="tp-login-option">
                                <div class="tp-login-input-wrapper">
                                    <div class="tp-login-input-box">
                                        <div class="tp-login-input">
                                            <input id="email" type="email" placeholder="shofy@mail.com">
                                        </div>
                                        <div class="tp-login-input-title">
                                            <label for="email">Your Email</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="my-3 d-flex align-items-center gap-1 d-none" id="error-msg">
                                    <svg height="25" style="overflow:visible;enable-background:new 0 0 32 32" viewBox="0 0 32 32" width="32" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><g><g id="Error_1_"><g id="Error"><circle cx="16" cy="16" id="BG" r="16" style="fill:#D72828;"/><path d="M14.5,25h3v-3h-3V25z M14.5,6v13h3V6H14.5z" id="Exclamatory_x5F_Sign" style="fill:#E6E6E6;"/></g></g></g></svg>
                                    <span class="text-danger fs-6"></span>
                                </div>
                                <div class="tp-login-bottom mb-15">
                                    <button id="sendBtn" type="submit" class="tp-login-btn w-100" onclick="forgotPassword()">Send Mail</button>
                                </div>
                                <div class="tp-login-suggetions d-sm-flex align-items-center justify-content-center">
                                    <div class="tp-login-forgot">
                                        <span>Remeber Passowrd? <a href="${BASE_URL}auth/login"> Login</a></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- login area end -->

    </layout:put>
</layout:extends>