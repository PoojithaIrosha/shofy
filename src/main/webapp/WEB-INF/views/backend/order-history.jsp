<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="admin-base">

    <layout:put block="title" type="REPLACE">
        <title>Order History - Shofy</title>
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
                                    <span class="text-muted fw-light">Dashboard /</span> Order History
                                </h4>
                            </div>
                            <!-- Basic Bootstrap Table -->
                            <div class="card">
                                <h5 class="card-header">Order History</h5>
                                <div class="table-responsive text-nowrap">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Customer</th>
                                            <th>No. Items</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Order Date</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody class="table-border-bottom-0">
                                        <jsp:useBean id="it" scope="request"
                                                     type="java.util.HashMap<java.lang.String, java.lang.Object>"/>
                                        <c:forEach items="${it.get('orders')}" var="order">
                                            <tr>
                                                <td>${order.id}</td>
                                                <td>${order.user.firstName} ${order.user.lastName}</td>
                                                <td>${order.orderItems.size()}</td>

                                                <fmt:formatNumber value="${order.total}" type="currency"
                                                                  var="total"/>
                                                <td>${total}</td>
                                                <td><span class="badge bg-label-success me-1">${order.orderStatus}</span></td>
                                                <fmt:parseDate value="${order.orderDate}" pattern="yyyy-MM-dd"
                                                               var="orderDate" type="both"/>
                                                <td><fmt:formatDate pattern="dd-MM-yyyy"
                                                                    value="${ orderDate }"/> </td>
                                                <td>
                                                    <a href="${BASE_URL}admin/order-history/invoice/${order.orderId}" class="btn btn-danger btn-sm">INVOICE</a>
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
                                                                     href="${BASE_URL}admin/order-history?page=${(it.get("page")-1)}">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end='${it.get("count")}' var="num">
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/order-history?page=${num}">${num}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test='${((it.get("page")+1) <= it.get("count"))}'>
                                            <li class="page-item"><a class="page-link"
                                                                     href="${BASE_URL}admin/order-history?page=${(it.get("page")+1)}">Next</a>
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