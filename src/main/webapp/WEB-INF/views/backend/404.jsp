<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>

<layout:extends name="admin-base">

    <layout:put block="title" type="REPLACE">
        <title>404 Page Not Found - Shofy</title>
    </layout:put>


    <layout:put block="main-content">
            <!-- Error -->
            <div class="container-xxl container-p-y d-flex justify-content-center vh-100 align-items-center">
                <div class="misc-wrapper">
                    <h2 class="mb-2 mx-2">Page Not Found :(</h2>
                    <p class="mb-4 mx-2">Oops! The requested URL was not found on this server.</p>
                    <a href="${BASE_URL}admin" class="btn btn-primary">Back to home</a>
                    <div class="mt-3">
                        <img
                                src="${BASE_URL}assets/admin/img/illustrations/page-misc-error-light.png"
                                alt="page-misc-error-light"
                                width="500"
                                class="img-fluid"
                                data-app-dark-img="illustrations/page-misc-error-dark.png"
                                data-app-light-img="illustrations/page-misc-error-light.png"
                        />
                    </div>
                </div>
            </div>
            <!-- /Error -->
    </layout:put>
</layout:extends>