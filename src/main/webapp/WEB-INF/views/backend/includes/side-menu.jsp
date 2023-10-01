<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
    <div class="app-brand demo">
        <a href="index.html" class="app-brand-link">
              <span class="app-brand-logo demo">
                <img src="${BASE_URL}assets/img/logo/logo.svg" alt="">
              </span>
        </a>

        <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
            <i class="bx bx-chevron-left bx-sm align-middle"></i>
        </a>
    </div>

    <div class="menu-inner-shadow"></div>

    <ul class="menu-inner py-1">
        <!-- Dashboard -->
        <li class="menu-item active">
            <a href="${BASE_URL}admin/dashboard" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">Dashboard</div>
            </a>
        </li>

        <!-- Layouts -->
        <li class="menu-item">
            <a href="${BASE_URL}admin/products" class="menu-link">
                <i class="menu-icon tf-icons bx bx-layout"></i>
                <div data-i18n="Layouts">Products</div>
            </a>
        </li>

        <li class="menu-item">
            <a href="${BASE_URL}admin/users" class="menu-link">
                <i class="menu-icon tf-icons bx bx-user"></i>
                <div data-i18n="Layouts">Users</div>
            </a>
        </li>

        <li class="menu-item">
            <a href="${BASE_URL}admin/order-history" class="menu-link">
                <i class="menu-icon tf-icons bx bx-history"></i>
                <div data-i18n="Analytics">Order History</div>
            </a>
        </li>
    </ul>
</aside>

<script>
    document.querySelectorAll(".menu-item").forEach(
        (item) => {
            if (window.location.href.startsWith(item.querySelector("a").href)) {
                item.classList.add("active");
            }else {
                item.classList.remove("active");
            }
        }
    )
</script>