<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<layout:extends name="admin-base">

    <layout:put block="title" type="REPLACE">
        <title>Invoice - ${it.id} - Shofy</title>
    </layout:put>

    <layout:put block="main-content">
        <jsp:useBean id="it" scope="request" type="com.poojithairosha.shofy.model.order.Order"/>

        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">

                <jsp:include page="includes/side-menu.jsp"/>

                <div class="layout-page">
                    <!-- navbar-->
                    <jsp:include page="includes/navbar.jsp"/>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->

                        <div class="container-xxl container-p-y">
                            <div class="d-flex justify-content-between">
                                <h4 class="fw-bold py-3 mb-4">
                                    <span class="text-muted fw-light">Dashboard / Order History / </span> Invoice - ${it.orderId}
                                </h4>
                            </div>

                            <div class="col-xxl">
                                <div class="card mb-4">
                                    <div class="card-header d-flex align-items-center justify-content-between">
                                        <h5 class="mb-0">INVOICE</h5>
                                        <span class="badge bg-label-success me-1 float-end fs-6">${it.orderStatus}</span>
                                    </div>
                                    <div class="card-body">
                                        <form>
                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label"
                                                       for="basic-default-name">ORDER ID</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="basic-default-name"
                                                           value="${it.orderId}" disabled>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label"
                                                       for="basic-default-name">Customer</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="basic-default-name"
                                                           value="${it.user.firstName} ${it.user.lastName}" disabled>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label" for="basic-default-company">Order
                                                    Date</label>
                                                <div class="col-sm-10">
                                                    <fmt:parseDate value="${it.orderDate}" pattern="yyyy-MM-dd"
                                                                   var="orderDate" type="both"/>

                                                    <input type="text" class="form-control" id="basic-default-company"
                                                           value="<fmt:formatDate pattern="dd-MM-yyyy"
                                                                   value="${ orderDate }"/>" disabled/>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label" for="basic-default-company">Expected
                                                    Delivery Date</label>
                                                <div class="col-sm-10">
                                                    <fmt:parseDate value="${it.orderDate.plusDays(7)}"
                                                                   pattern="yyyy-MM-dd"
                                                                   var="expectedDate" type="both"/>

                                                    <input type="text" class="form-control" id="basic-default-company"
                                                           value="<fmt:formatDate pattern="dd-MM-yyyy"
                                                                   value="${ expectedDate }"/>" disabled/>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label" for="basic-default-company">Sub
                                                    Total</label>
                                                <div class="col-sm-10">
                                                    <fmt:formatNumber value="${it.total - it.deliveryFee.fee}"
                                                                      type="currency" var="subTotal"/>
                                                    <input type="text" class="form-control" id="basic-default-company"
                                                           value="${subTotal}" disabled/>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label" for="basic-default-company">Delivery
                                                    Fee</label>
                                                <div class="col-sm-10">
                                                    <fmt:formatNumber value="${it.deliveryFee.fee}" type="currency"
                                                                      var="deliveryFee"/>
                                                    <input type="text" class="form-control" id="basic-default-company"
                                                           value="${deliveryFee}" disabled/>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label"
                                                       for="basic-default-company">Total</label>
                                                <div class="col-sm-10">
                                                    <fmt:formatNumber value="${it.total}" type="currency" var="total"/>
                                                    <input type="text" class="form-control" id="basic-default-company"
                                                           value="${total}" disabled/>
                                                </div>
                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label mb-3" for="basic-default-company">Products</label>
                                                <div class="table-responsive text-nowrap">
                                                    <table class="table">
                                                        <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Product Name</th>
                                                            <th>Quantity</th>
                                                            <th>Price</th>
                                                            <th>Total</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody class="table-border-bottom-0">
                                                        <c:forEach items="${it.orderItems}" var="item" varStatus="loop">
                                                            <tr>
                                                                <td>${loop.index + 1}</td>
                                                                <td>${item.product.name}</td>
                                                                <td>${item.quantity}</td>
                                                                <td><fmt:formatNumber value="${item.product.price}"
                                                                                      type="currency" var="price"/>
                                                                        ${price}
                                                                </td>
                                                                <td><fmt:formatNumber value="${item.price * item.quantity}"
                                                                                      type="currency" var="ptotal"/>
                                                                        ${ptotal}
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            </div>

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
