<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="admin-base">

    <layout:put block="title" type="REPLACE">
        <title>Product Management - Shofy</title>
    </layout:put>

    <layout:put block="main-content">
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <jsp:include page="includes/side-menu.jsp"/>

                <div class="layout-page">
                    <!-- navbar-->
                    <jsp:include page="includes/navbar.jsp"/>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="d-flex justify-content-between">
                                <h4 class="fw-bold py-3 mb-4">
                                    <span class="text-muted fw-light">Dashboard /</span> Products
                                </h4>
                                <div>
                                    <a href="${BASE_URL}admin/products/add" class="btn btn-primary">Add New</a>
                                </div>
                            </div>
                            <!-- Basic Bootstrap Table -->
                            <div class="card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h5 class="card-header">Product List</h5>
                                    <div class="me-3">
                                        <form>
                                            <input type="hidden" name="page" value="${(it.get("page"))}">
                                            <input type="text" class="form-control" placeholder="Search..."
                                                   name="search" value="${(it.get("search"))}">
                                        </form>
                                    </div>
                                </div>

                                <div class="table-responsive text-nowrap">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Product Name</th>
                                            <th>Category</th>
                                            <th>Price</th>
                                            <th>Qty</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody class="table-border-bottom-0">
                                        <jsp:useBean id="it" scope="request"
                                                     type="java.util.HashMap<java.lang.String, java.lang.Object>"/>
                                        <c:forEach items="${it.get('products')}" var="product">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td><a class="link-secondary"
                                                       href="${BASE_URL}products/${product.id}"><strong>${product.name}</strong></a>
                                                </td>
                                                <td>${product.category.name}</td>

                                                <fmt:formatNumber value="${product.price}" type="currency"
                                                                  var="formattedPrice"/>
                                                <td>${formattedPrice}</td>

                                                <td>${product.quantity}</td>

                                                <c:if test="${product.active}">
                                                    <td><span class="badge bg-label-success me-1">ACTIVE</span></td>
                                                </c:if>
                                                <c:if test="${!product.active}">
                                                    <td><span class="badge bg-label-warning me-1">INACTIVE</span></td>
                                                </c:if>

                                                <td>
                                                    <div class="dropdown">
                                                        <button type="button" class="btn p-0 dropdown-toggle hide-arrow"
                                                                data-bs-toggle="dropdown">
                                                            <i class="bx bx-dots-vertical-rounded"></i>
                                                        </button>
                                                        <div class="dropdown-menu">
                                                            <a class="dropdown-item"
                                                               href="${BASE_URL}admin/products/edit/${product.id}"
                                                            ><i class="bx bx-edit-alt me-1"></i> Edit</a>
                                                            <a class="dropdown-item"
                                                               href="${BASE_URL}products/${product.id}" target="_blank"><i
                                                                    class="bx bxs-log-in-circle me-1"></i> View</a>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                            <%--                                        <tr>--%>
                                            <%--                                            <td><i class="fab fa-react fa-lg text-info me-3"></i> <strong>React Project</strong></td>--%>
                                            <%--                                            <td>Barry Hunter</td>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <ul class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Lilian Fuller"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/5.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Sophia Wilkerson"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/6.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Christina Parker"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/7.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                </ul>--%>
                                            <%--                                            </td>--%>
                                            <%--                                            <td><span class="badge bg-label-success me-1">Completed</span></td>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <div class="dropdown">--%>
                                            <%--                                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">--%>
                                            <%--                                                        <i class="bx bx-dots-vertical-rounded"></i>--%>
                                            <%--                                                    </button>--%>
                                            <%--                                                    <div class="dropdown-menu">--%>
                                            <%--                                                        <a class="dropdown-item" href="javascript:void(0);"--%>
                                            <%--                                                        ><i class="bx bx-edit-alt me-2"></i> Edit</a--%>
                                            <%--                                                        >--%>
                                            <%--                                                        <a class="dropdown-item" href="javascript:void(0);"--%>
                                            <%--                                                        ><i class="bx bx-trash me-2"></i> Delete</a--%>
                                            <%--                                                        >--%>
                                            <%--                                                    </div>--%>
                                            <%--                                                </div>--%>
                                            <%--                                            </td>--%>
                                            <%--                                        </tr>--%>
                                            <%--                                        <tr>--%>
                                            <%--                                            <td><i class="fab fa-vuejs fa-lg text-success me-3"></i> <strong>VueJs Project</strong></td>--%>
                                            <%--                                            <td>Trevor Baker</td>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <ul class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Lilian Fuller"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/5.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Sophia Wilkerson"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/6.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Christina Parker"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/7.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                </ul>--%>
                                            <%--                                            </td>--%>
                                            <%--                                            <td><span class="badge bg-label-info me-1">Scheduled</span></td>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <div class="dropdown">--%>
                                            <%--                                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">--%>
                                            <%--                                                        <i class="bx bx-dots-vertical-rounded"></i>--%>
                                            <%--                                                    </button>--%>
                                            <%--                                                    <div class="dropdown-menu">--%>
                                            <%--                                                        <a class="dropdown-item" href="javascript:void(0);"--%>
                                            <%--                                                        ><i class="bx bx-edit-alt me-2"></i> Edit</a--%>
                                            <%--                                                        >--%>
                                            <%--                                                        <a class="dropdown-item" href="javascript:void(0);"--%>
                                            <%--                                                        ><i class="bx bx-trash me-2"></i> Delete</a--%>
                                            <%--                                                        >--%>
                                            <%--                                                    </div>--%>
                                            <%--                                                </div>--%>
                                            <%--                                            </td>--%>
                                            <%--                                        </tr>--%>
                                            <%--                                        <tr>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <i class="fab fa-bootstrap fa-lg text-primary me-3"></i> <strong>Bootstrap Project</strong>--%>
                                            <%--                                            </td>--%>
                                            <%--                                            <td>Jerry Milton</td>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <ul class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Lilian Fuller"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/5.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Sophia Wilkerson"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/6.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                    <li--%>
                                            <%--                                                            data-bs-toggle="tooltip"--%>
                                            <%--                                                            data-popup="tooltip-custom"--%>
                                            <%--                                                            data-bs-placement="top"--%>
                                            <%--                                                            class="avatar avatar-xs pull-up"--%>
                                            <%--                                                            title="Christina Parker"--%>
                                            <%--                                                    >--%>
                                            <%--                                                        <img src="../assets/img/avatars/7.png" alt="Avatar" class="rounded-circle" />--%>
                                            <%--                                                    </li>--%>
                                            <%--                                                </ul>--%>
                                            <%--                                            </td>--%>
                                            <%--                                            <td><span class="badge bg-label-warning me-1">Pending</span></td>--%>
                                            <%--                                            <td>--%>
                                            <%--                                                <div class="dropdown">--%>
                                            <%--                                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">--%>
                                            <%--                                                        <i class="bx bx-dots-vertical-rounded"></i>--%>
                                            <%--                                                    </button>--%>
                                            <%--                                                    <div class="dropdown-menu">--%>
                                            <%--                                                        <a class="dropdown-item" href="javascript:void(0);"--%>
                                            <%--                                                        ><i class="bx bx-edit-alt me-2"></i> Edit</a--%>
                                            <%--                                                        >--%>
                                            <%--                                                        <a class="dropdown-item" href="javascript:void(0);"--%>
                                            <%--                                                        ><i class="bx bx-trash me-2"></i> Delete</a--%>
                                            <%--                                                        >--%>
                                            <%--                                                    </div>--%>
                                            <%--                                                </div>--%>
                                            <%--                                            </td>--%>
                                            <%--                                        </tr>--%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="mt-3 d-flex justify-content-center">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <c:if test='${(it.get("page") - 1) >= 1}'>
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/products?page=${(it.get("page")-1)}&search=${it.get("search")}">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end='${it.get("count")}' var="num">
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/products?page=${num}&search=${it.get("search")}">${num}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test='${((it.get("page")+1) <= it.get("count"))}'>
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/products?page=${(it.get("page")+1)}&search=${it.get("search")}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>

                            <!--/ Basic Bootstrap Table -->

                        </div>
                        <!-- / Content -->

                        <!-- Footer -->
                        <jsp:include page="includes/footer.jsp"/>
                        <!-- / Footer -->

                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                </div>
            </div>
        </div>
    </layout:put>
</layout:extends>