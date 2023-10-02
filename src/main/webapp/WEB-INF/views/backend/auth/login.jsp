<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>

<layout:extends name="admin-base">

    <layout:put block="title" type="REPLACE">
        <title>Admin Login - Shofy</title>
    </layout:put>


    <layout:put block="main-content" type="REPLACE">
        <div class="container-xxl">
            <div class="authentication-wrapper authentication-basic container-p-y">
                <div class="authentication-inner">
                    <!-- Register -->
                    <div class="card">
                        <div class="card-body">
                            <!-- Logo -->
                            <div class="app-brand justify-content-center">
                                <a href="${BASE_URL}admin" class="app-brand-link gap-2">
                                  <span class="app-brand-logo demo">
                                       <img src="${BASE_URL}/assets/img/logo/logo.svg" alt="Brand Logo" class="img-fluid" style="height: 50px">
                                  </span>
                                </a>
                            </div>
                            <!-- /Logo -->
                            <h4 class="mb-2">Welcome</h4>
                            <p class="mb-4">Please sign-in to your admin account and start the adventure</p>

                            <div id="formAuthentication" class="mb-3">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email address</label>
                                    <input
                                            type="text"
                                            class="form-control"
                                            id="email"
                                            name="email-username"
                                            placeholder="Enter your email or username"
                                            autofocus
                                    />
                                </div>
                                <div class="mb-3 form-password-toggle">
                                    <div class="d-flex justify-content-between">
                                        <label class="form-label" for="password">Password</label>
                                        <a href="auth-forgot-password-basic.html">
                                            <small>Forgot Password?</small>
                                        </a>
                                    </div>
                                    <div class="input-group input-group-merge">
                                        <input
                                                type="password"
                                                id="password"
                                                class="form-control"
                                                name="password"
                                                placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                                                aria-describedby="password"
                                        />
                                        <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="remember-me"/>
                                        <label class="form-check-label" for="remember-me"> Remember Me </label>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <button class="btn btn-primary d-grid w-100" type="submit" onclick="login();">Sign
                                        in
                                    </button>
                                </div>
                            </div>

                            <p class="text-center">
                                <span>New on our platform?</span>
                                <a href="auth-register-basic.html">
                                    <span>Create an account</span>
                                </a>
                            </p>
                        </div>
                    </div>
                    <!-- /Register -->
                </div>
            </div>
        </div>
    </layout:put>
</layout:extends>