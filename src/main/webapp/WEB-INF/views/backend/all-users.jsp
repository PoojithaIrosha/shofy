<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="admin-base">
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
                                    <span class="text-muted fw-light">Dashboard /</span> Users
                                </h4>
                            </div>
                            <!-- Basic Bootstrap Table -->
                            <div class="card">
                                <h5 class="card-header">User Management</h5>
                                <div class="table-responsive text-nowrap">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Profile</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody class="table-border-bottom-0">
                                        <jsp:useBean id="it" scope="request"
                                                     type="java.util.HashMap<java.lang.String, java.lang.Object>"/>
                                        <c:forEach items="${it.get('users')}" var="user">
                                            <tr>
                                                <td>${user.id}</td>
                                                <td><strong>${user.firstName} ${user.lastName}</strong></td>
                                                <td>${user.email}</td>
                                                <td>${user.mobileNumber}</td>

                                                <td>
                                                    <ul class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">
                                                        <li
                                                                data-bs-toggle="tooltip"
                                                                data-popup="tooltip-custom"
                                                                data-bs-placement="top"
                                                                class="avatar avatar-xs pull-up"
                                                                title="${user.firstName}"
                                                        >
                                                            <c:if test="${user.picture != null}">
                                                                <img src="${user.picture}" alt="Avatar"
                                                                     class="rounded-circle"/>
                                                            </c:if>
                                                            <c:if test="${user.picture == null}">
                                                                <img src="${BASE_URL}assets/img/users/user.png" alt="Avatar"
                                                                     class="rounded-circle"/>
                                                            </c:if>

                                                        </li>
                                                    </ul>
                                                </td>

                                                <td>${user.userType}</td>
                                                <c:if test="${user.active}">
                                                    <td><span class="badge bg-label-success me-1">ACTIVE</span></td>
                                                </c:if>
                                                <c:if test="${!user.active}">
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
                                                               href="javascript:changeUserStatus('${user.id}')"
                                                            ><i class="bx bx-station me-1"></i>${user.active ? "Inactive" : "Active"}
                                                            </a>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="mt-3 d-flex justify-content-center">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <c:if test='${(it.get("page") - 1) >= 1}'>
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/users?page=${(it.get("page")-1)}&search=${it.get("search")}">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end='${it.get("count")}' var="num">
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/users?page=${num}&search=${it.get("search")}">${num}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test='${((it.get("page")+1) <= it.get("count"))}'>
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/users?page=${(it.get("page")+1)}&search=${it.get("search")}">Next</a>
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