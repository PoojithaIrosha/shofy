<%@taglib prefix="layout" uri="http://callidora.lk/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="admin-base">

    <layout:put block="title" type="REPLACE">
        <title>Add Product - Shofy</title>
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
                                    <span class="text-muted fw-light">Dashboard /</span> Add New Product
                                </h4>
                            </div>

                            <div class="row">
                                <div class="col-xl">
                                    <div class="card mb-4">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h5 class="mb-0">Add Product</h5>
                                                <%--                      <small class="text-muted float-end">l</small>--%>
                                        </div>
                                        <div class="card-body">
                                            <div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="name">Product Name</label>
                                                    <input type="text" class="form-control" name="name" id="name"
                                                           placeholder="Iphone 15 Pro"/>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="price">Price</label>
                                                    <input type="number" class="form-control" name="price" id="price"
                                                           placeholder="$999"/>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="qty">Qty</label>
                                                    <div class="input-group input-group-merge">
                                                        <input
                                                                type="text"
                                                                id="qty"
                                                                name="qty"
                                                                class="form-control"
                                                                placeholder="Qty"
                                                        />
                                                    </div>
                                                        <%--                          <div class="form-text">You can use letters, numbers & periods</div>--%>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="brand">Brand</label>
                                                    <input
                                                            type="text"
                                                            name="brand"
                                                            id="brand"
                                                            class="form-control phone-mask"
                                                            placeholder="Apple"
                                                    />
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="category">Category</label>
                                                    <input
                                                            type="text"
                                                            name="category"
                                                            id="category"
                                                            class="form-control phone-mask"
                                                            placeholder="Smart Phones"
                                                    />
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="description">Description</label>
                                                    <textarea
                                                            id="description"
                                                            name="description"
                                                            class="form-control"
                                                            placeholder="Hi, Do you have a moment to talk Joe?"
                                                    ></textarea>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label" for="description">Product Images</label>
                                                    <input
                                                            type="file"
                                                            name="images"
                                                            id="images"
                                                            class="form-control"
                                                            placeholder="Choose some product images" multiple/>
                                                </div>
                                                <button type="submit" class="btn btn-primary" onclick="addProduct()">Add
                                                    Product
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

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