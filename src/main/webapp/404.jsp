<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>

<layout:extends name="base">

    <layout:put block="header" type="REPLACE">
        <jsp:include page="WEB-INF/views/frontend/includes/header-2.jsp" />
    </layout:put>

    <layout:put block="main-content" type="REPLACE">
        <!-- error area start -->
        <section class="tp-error-area pt-110 pb-110">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-8 col-md-10">
                        <div class="tp-error-content text-center">
                            <div class="tp-error-thumb">
                                <img src="${BASE_URL}assets/img/error/error.png" alt="">
                            </div>

                            <h3 class="tp-error-title">Oops! Page not found</h3>
                            <p>Whoops, this is embarassing. Looks like the page you were looking for wasn't found.</p>

                            <a href="${BASE_URL}" class="tp-error-btn">Back to Home</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- error area end -->
    </layout:put>


</layout:extends>Ï