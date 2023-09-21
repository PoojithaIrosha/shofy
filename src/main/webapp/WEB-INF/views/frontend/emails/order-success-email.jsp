<!DOCTYPE html>
<html>
<head>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous"
  />
  <style>
    .tp-order-details {
      padding: 70px 100px 55px;
    }
    @media only screen and (min-width: 1200px) and (max-width: 1399px) {
      .tp-order-details {
        padding: 70px 70px 55px;
      }
    }
    @media only screen and (min-width: 992px) and (max-width: 1199px) {
      .tp-order-details {
        padding: 70px 30px 55px;
      }
    }
    @media only screen and (min-width: 576px) and (max-width: 767px) {
      .tp-order-details {
        padding: 70px 50px 55px;
      }
    }
    @media (max-width: 575px) {
      .tp-order-details {
        padding: 40px 30px 45px;
      }
    }
    .tp-order-details-icon {
      margin-bottom: 22px;
    }
    .tp-order-details-icon span {
      display: inline-block;
      width: 120px;
      height: 120px;
      line-height: 118px;
      text-align: center;
      font-size: 55px;
      color: #ffffff;
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 50%;
    }
    .tp-order-details-title {
      font-size: 30px;
      font-weight: 600;
      color: #ffffff;
      margin-bottom: 7px;
    }
    .tp-order-details-content p {
      font-size: 16px;
      color: #ffffff;
      line-height: 1.38;
    }
    .tp-order-details-item {
      margin-bottom: 38px;
    }
    .tp-order-details-item-wrapper
    .row
    [class*="col-"]:nth-child(2n)
    .tp-order-details-item {
      padding-left: 40px;
    }
    @media (max-width: 575px) {
      .tp-order-details-item-wrapper
      .row
      [class*="col-"]:nth-child(2n)
      .tp-order-details-item {
        padding-left: 0;
      }
    }
    .tp-order-details-item h4 {
      font-size: 18px;
      color: #ffffff;
      margin-bottom: 0;
      font-weight: 400;
    }
    .tp-order-details-item p {
      font-weight: 700;
      font-size: 18px;
      color: #ffffff;
      margin-bottom: 0;
    }
    .tp-order-info-wrapper {
      padding: 42px 50px;
    }
    @media only screen and (min-width: 992px) and (max-width: 1199px) {
      .tp-order-info-wrapper {
        padding: 42px 40px;
      }
    }
    @media (max-width: 575px) {
      .tp-order-info-wrapper {
        padding: 42px 30px;
      }
    }
    .tp-order-info-title {
      font-size: 26px;
      font-weight: 600;
      margin-bottom: 40px;
    }
    .tp-order-info-list ul li {
      list-style: none;
      padding: 15px 0;
      display: -webkit-box;
      display: -moz-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .tp-order-info-list ul li:not(:last-child) {
      border-bottom: 1px solid #e0e2e3;
    }
    .tp-order-info-list ul li span {
      font-size: 15px;
      color: #010f1c;
    }
    .tp-order-info-list ul li.tp-order-info-list-header {
      padding-top: 0;
      padding-bottom: 12px;
    }
    .tp-order-info-list ul li.tp-order-info-list-header h4 {
      font-size: 16px;
      font-weight: 500;
      margin-bottom: 0;
    }
    .tp-order-info-list ul li.tp-order-info-list-desc p {
      font-size: 15px;
      margin-bottom: 0;
    }
    .tp-order-info-list ul li.tp-order-info-list-desc p span {
      font-size: 15px;
      font-weight: 500;
    }
    .tp-order-info-list ul li.tp-order-info-list-subtotal span:last-child {
      color: #0989ff;
    }
    .tp-order-info-list ul li.tp-order-info-list-shipping span input {
      display: none;
    }
    .tp-order-info-list
    ul
    li.tp-order-info-list-shipping
    span
    input:checked
    ~ label::after {
      border-color: #0989ff;
    }
    .tp-order-info-list
    ul
    li.tp-order-info-list-shipping
    span
    input:checked
    ~ label::before {
      opacity: 1;
      visibility: visible;
    }
    .tp-order-info-list ul li.tp-order-info-list-shipping span label {
      font-size: 14px;
      position: relative;
      padding-right: 27px;
    }
    .tp-order-info-list ul li.tp-order-info-list-shipping span label span {
      color: #0989ff;
    }
    .tp-order-info-list ul li.tp-order-info-list-shipping span label:hover {
      cursor: pointer;
    }
    .tp-order-info-list ul li.tp-order-info-list-shipping span label::after {
      position: absolute;
      content: "";
      right: 0;
      top: 5px;
      width: 16px;
      height: 16px;
      border-radius: 50%;
      border: 1px solid #bcbcbc;
      -webkit-transition: all 0.2s 0s ease-out;
      -moz-transition: all 0.2s 0s ease-out;
      -ms-transition: all 0.2s 0s ease-out;
      -o-transition: all 0.2s 0s ease-out;
      transition: all 0.2s 0s ease-out;
    }
    .tp-order-info-list ul li.tp-order-info-list-shipping span label::before {
      position: absolute;
      content: "";
      right: 4px;
      top: 9px;
      width: 8px;
      height: 8px;
      border-radius: 50%;
      background-color: #0989ff;
      visibility: hidden;
      opacity: 0;
      -webkit-transition: all 0.2s 0s ease-out;
      -moz-transition: all 0.2s 0s ease-out;
      -ms-transition: all 0.2s 0s ease-out;
      -o-transition: all 0.2s 0s ease-out;
      transition: all 0.2s 0s ease-out;
    }
    .tp-order-info-list ul li.tp-order-info-list-total {
      padding: 14px 0;
    }
    .tp-order-info-list ul li.tp-order-info-list-total span {
      font-size: 16px;
      font-weight: 500;
    }
    .tp-order-inner {
      background-color: #ffffff;
      box-shadow: 0px 30px 70px rgba(1, 15, 28, 0.1);
    }
  </style>
</head>
<body style="height: 100vh; display: flex; align-items: center; justify-content: center;">
<section
        class="tp-order-area pb-160">
  <div class="container">
    <div class="tp-order-inner">
      <div class="row gx-0">
        <div class="col-lg-6" style="background-color: #4f3d97">
          <div class="tp-order-details" data-bg-color="#4F3D97">
            <div class="tp-order-details-top text-center mb-70">
              <div
                      class="tp-order-details-icon d-flex justify-content-center"
              >
                    <span
                            class="d-flex align-items-center justify-content-center"
                    >
                      <svg
                              width="52"
                              height="52"
                              viewBox="0 0 52 52"
                              fill="none"
                              xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                                d="M46 26V51H6V26"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                        />
                        <path
                                d="M51 13.5H1V26H51V13.5Z"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                        />
                        <path
                                d="M26 51V13.5"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                        />
                        <path
                                d="M26 13.5H14.75C13.0924 13.5 11.5027 12.8415 10.3306 11.6694C9.15848 10.4973 8.5 8.9076 8.5 7.25C8.5 5.5924 9.15848 4.00269 10.3306 2.83058C11.5027 1.65848 13.0924 1 14.75 1C23.5 1 26 13.5 26 13.5Z"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                        />
                        <path
                                d="M26 13.5H37.25C38.9076 13.5 40.4973 12.8415 41.6694 11.6694C42.8415 10.4973 43.5 8.9076 43.5 7.25C43.5 5.5924 42.8415 4.00269 41.6694 2.83058C40.4973 1.65848 38.9076 1 37.25 1C28.5 1 26 13.5 26 13.5Z"
                                stroke="currentColor"
                                stroke-width="2"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                        />
                      </svg>
                    </span>
              </div>
              <div class="tp-order-details-content">
                <h3 class="tp-order-details-title">Your Order Confirmed</h3>
                <p>
                  We will send you a shipping confirmation email as soon
                  <br />
                  as your order ships
                </p>
              </div>
            </div>
            <div class="tp-order-details-item-wrapper">
              <div class="row">
                <div class="col-sm-6">
                  <div class="tp-order-details-item">
                    <h4>Order Date:</h4>
                    <p>April 10, 2023</p>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="tp-order-details-item">
                    <h4>Expected Delivery:</h4>
                    <p>April 16, 2023</p>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="tp-order-details-item">
                    <h4>Order Number:</h4>
                    <p>#9641</p>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="tp-order-details-item">
                    <h4>Payment Method:</h4>
                    <p>Credit Card</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="tp-order-info-wrapper">
            <h4 class="tp-order-info-title">Order Details</h4>

            <div class="tp-order-info-list">
              <ul>
                <!-- header -->
                <li class="tp-order-info-list-header">
                  <h4>Product</h4>
                  <h4>Total</h4>
                </li>

                <!-- item list -->
                <li class="tp-order-info-list-desc">
                  <p>Xiaomi Redmi Note 9 Global V. <span> x 2</span></p>
                  <span>$274:00</span>
                </li>
                <li class="tp-order-info-list-desc">
                  <p>Office Chair Multifun <span> x 1</span></p>
                  <span>$74:00</span>
                </li>
                <li class="tp-order-info-list-desc">
                  <p>Apple Watch Series 6 Stainless <span> x 3</span></p>
                  <span>$362:00</span>
                </li>
                <li class="tp-order-info-list-desc">
                  <p>Body Works Mens Collection <span> x 1</span></p>
                  <span>$145:00</span>
                </li>

                <!-- subtotal -->
                <li class="tp-order-info-list-subtotal">
                  <span>Subtotal</span>
                  <span>$507.00</span>
                </li>

                <!-- shipping -->
                <!-- shipping -->
                <li class="tp-order-info-list-shipping">
                  <span>Shipping</span>
                  <div
                          class="tp-order-info-list-shipping-item d-flex flex-column align-items-end"
                  >
                        <span>
                          <input id="shipping_info" type="checkbox" />
                          <label for="shipping_info"
                          >Flat rate: <span>$20.00</span></label
                          >
                        </span>
                  </div>
                </li>

                <!-- total -->
                <li class="tp-order-info-list-total">
                  <span>Total</span>
                  <span>$1,476.00</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
</html>
