<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>

<!DOCTYPE html>

<html lang="en" class="light-style customizer-hide" dir="ltr" data-theme="theme-default" data-assets-path="../assets/">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>

    <layout:block name="title">
        <title>Admin | Shofy</title>
    </layout:block>

    <meta name="description" content=""/>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="${BASE_URL}assets/img/logo/favicon.png">

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${BASE_URL}assets/admin/vendor/fonts/boxicons.css"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="${BASE_URL}assets/admin/vendor/css/core.css" class="template-customizer-core-css"/>
    <link rel="stylesheet" href="${BASE_URL}assets/admin/vendor/css/theme-default.css"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="${BASE_URL}assets/admin/css/demo.css"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${BASE_URL}assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <link rel="stylesheet" href="${BASE_URL}assets/admin/vendor/libs/apex-charts/apex-charts.css"/>
    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="${BASE_URL}assets/admin/vendor/css/pages/page-auth.css"/>
    <!-- Helpers -->
    <script src="${BASE_URL}assets/admin/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${BASE_URL}assets/admin/js/config.js"></script>
    <script src="${BASE_URL}assets/js/profile-image.js"></script>
</head>

<body>
<!-- Content -->
<layout:block name="main-content">

</layout:block>
<!-- / Content -->

<%--<div class="toast-container position-fixed bottom-0 end-0 p-3">
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
</div>--%>

<div class="toast-container position-fixed bottom-0 end-0 p-3 zindex-5">
    <div id="toast" class="bs-toast toast fade bg-dark" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <i class="bx bx-bell me-2"></i>
            <div class="me-auto fw-semibold">Shofy</div>
            <small id="toast-status"></small>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toast-body">
            Fruitcake chocolate bar tootsie roll gummies gummies jelly beans cake.
        </div>
    </div>
</div>

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->
<script src="${BASE_URL}assets/admin/vendor/libs/jquery/jquery.js"></script>
<script src="${BASE_URL}assets/admin/vendor/libs/popper/popper.js"></script>
<script src="${BASE_URL}assets/admin/vendor/js/bootstrap.js"></script>
<%--<script src="${BASE_URL}assets/js/bootstrap.min.js"></script>--%>
<script src="${BASE_URL}assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="${BASE_URL}assets/admin/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->
<script src="${BASE_URL}assets/admin/vendor/libs/apex-charts/apexcharts.js"></script>

<!-- Main JS -->
<script src="${BASE_URL}assets/admin/js/main.js"></script>

<!-- Page JS -->
<script src="${BASE_URL}assets/admin/js/dashboards-analytics.js"></script>
<script src="${BASE_URL}assets/admin/js/script.js"></script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<script type="text/javascript">
    const BASE_URL = '${BASE_URL}';
</script>
</body>
</html>
