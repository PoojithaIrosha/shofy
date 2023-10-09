/* ====================
   Secure Fetch
   ==================== */
function secureFetch(url, options) {
    const json = localStorage.getItem("user");

    if (json) {
        const user = JSON.parse(json);
        const expiresIn = new Date(parseInt(user.expiresIn)).getTime();
        const now = new Date().getTime();

        if (now > expiresIn) {
            return refreshToken().then(token => {
                options.headers = {
                    ...options.headers, "Authorization": "Bearer " + token,
                }
                return fetch(url, options);
            });
        } else {
            options.headers = {
                ...options.headers, "Authorization": "Bearer " + user.accessToken,
            };
            return fetch(url, options);
        }

    }
}

/* ====================
   Refresh Token
   ==================== */
function refreshToken() {
    const json = localStorage.getItem("user");

    if (json) {
        const user = JSON.parse(json);
        const refreshToken = user.refreshToken;

        const params = new FormData();
        params.append("refreshToken", refreshToken);

        return fetch(`${BASE_URL}auth/refresh-token`, {
            method: "POST", body: params
        }).then(resp => {
            if (resp.ok) {
                return resp.json();
            } else {
                return Promise.reject(resp.text());
            }
        }).then(data => {
            localStorage.setItem("user", JSON.stringify(data));
            return data.accessToken;
        }).catch(err => {
            window.location.href = `${BASE_URL}auth/login`;
        })
    }
}

/* ====================
   User Sign Up
   ==================== */
function signUp() {
    const fname = document.getElementById("fname");
    const lname = document.getElementById("lname");
    const mobile = document.getElementById("mobile");
    const email = document.getElementById("email");
    const password = document.getElementById("password");

    if (fname.value === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter first name";
        return;
    } else if (lname.value === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter last name";
        return;
    } else if (mobile.value === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter mobile number";
        return;
    } else if (email.value === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter email address";
        return;
    } else if (password.value === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter password";
        return;
    } else {
        const data = {
            "first_name": fname.value,
            "last_name": lname.value,
            "mobile": mobile.value,
            "email": email.value,
            "password": password.value
        };

        const url = `${BASE_URL}auth/register`;

        fetch(url, {
            method: "POST", body: JSON.stringify(data), headers: {
                "Content-Type": "application/json",
            }
        }).then(response => {
            if (response.ok) {
                return response.text();
            } else {
                return Promise.reject(response);
            }
        }).then(data => {
            window.location = `${BASE_URL}auth/register`;
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
            })
        });
    }
}

/* ====================
   User Sign IN
   ==================== */
function signIn() {
    const email = document.getElementById("email");
    const password = document.getElementById("password");

    if (email.value === "") {
        showToast("Please enter email address", "Error");
    } else if (password.value === "") {
        showToast("Please enter password", "Error");
    } else {

        const formData = new FormData();
        formData.append("email", email.value);
        formData.append("password", password.value);

        const url = `${BASE_URL}auth/login`;
        fetch(url, {
            method: "POST", body: formData,
        }).then(response => {
            if (response.ok) {
                return response.json();
            } else {
                return Promise.reject(response);
            }
        }).then(data => {
            localStorage.setItem("user", JSON.stringify(data));

            window.location = `${BASE_URL}`;
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
            })
        });
    }
}

/* ====================
   Show Toast
   ==================== */
function showToast(message, status) {
    new Audio(`${BASE_URL}assets/sounds/notificare.mp3`).play();

    const toastBootstrap = bootstrap.Toast.getOrCreateInstance(document.getElementById("toast"));
    document.getElementById("toast-body").innerHTML = message;
    document.getElementById("toast-status").innerHTML = status;
    toastBootstrap.show();
}

/* ====================
   Google Sign In - Callback Func
   ==================== */
function googleSignIn(response) {
    const encodedJwt = response.credential;

    const xhr = new XMLHttpRequest();
    xhr.open('POST', `${BASE_URL}auth/google`);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {

        if (xhr.status === 200) {
            const data = JSON.parse(xhr.responseText);

            localStorage.setItem("user", JSON.stringify(data));
            window.location = `${BASE_URL}`;
        } else {
            showToast(xhr.responseText, "Error");
        }
    };
    xhr.onerror = function () {
        showToast("Something went wrong. Please try again later.", "Error");
    };
    xhr.send('idtoken=' + encodedJwt);
}

/* ====================
   Forgot Password
   ==================== */
function forgotPassword() {

    const email = document.getElementById("email").value;

    if (email === "") {
        showToast("Please enter email address", "Error");
    } else {
        const form = new FormData();
        form.append("email", email);

        fetch(`${BASE_URL}auth/forgot-password`, {
            method: "POST", body: form,
        }).then(resp => {
            if (resp.ok) {
                return resp.text();
            } else {
                return Promise.reject(resp);
            }
        }).then(data => {
            document.querySelector("#sendBtn").innerHTML = "Resend";
            showToast(data, "Success");
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
            });
        });
    }
}

/* ====================
   Reset Password
   ==================== */
function resetPassword() {
    const code = document.getElementById("code").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirm-password").value;

    if (code === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter verification code";
        return;
    } else if (password === "" || confirmPassword === "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter password and confirm password";
        return;
    } else if (password !== confirmPassword) {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Password and confirm password does not match";
        return;
    }

    fetch(`${BASE_URL}auth/reset-password`, {
        method: "POST", headers: {
            "Content-Type": "application/json",
        }, body: JSON.stringify({
            code: code, password: password,
        }),
    }).then(resp => {
        if (resp.ok) {
            return resp.text()
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        showToast(data, "Success");
        window.location = `${BASE_URL}auth/login`;
    }).catch(error => {
        error.text().then((err) => {
            showToast(err, "Error");
        });
    });
}

/* ====================
   Update Password
   ==================== */
function updatePassword(email) {
    const oldPassword = document.getElementById("old-pass").value;
    const newPassword = document.getElementById("new-pass").value;
    const confirmPassword = document.getElementById("con-new-pass").value;

    if (oldPassword === "" || newPassword === "" || confirmPassword === "") {
        showToast("Please enter all the fields", "Error");
        return;
    }

    if (newPassword !== confirmPassword) {
        showToast("Password and confirm password does not match", "Error");
    } else {
        const data = {
            email: email, oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword,
        };

        fetch(`${BASE_URL}auth/update-password`, {
            method: "POST", headers: {
                "Content-Type": "application/json",
            }, body: JSON.stringify(data),
        }).then(resp => {
            if (resp.ok) {
                return resp.text()
            } else {
                return Promise.reject(resp);
            }
        }).then(data => {
            showToast(data, "Success");
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
            });
        });
    }
}

/* ====================
   Add To Cart
   ==================== */
function addToCartPD(productId) {
    const user = localStorage.getItem("user");
    const qty = document.getElementById(`qty-${productId}`).value;

    var colorId = 0;

    if (user != null) {
        document.querySelectorAll(".tp-color-variation-btn").forEach((btn) => {
            btn.classList.forEach((cls) => {
                if (cls === "active") {
                    colorId = btn.querySelector("#color-id").innerHTML;
                }
            })
        });

        if (colorId === 0) {
            showToast("Please select a color", "Error");
            return Promise.reject();
        }

        const form = new FormData();
        form.append("product_id", productId);
        form.append("quantity", qty);
        form.append("color-id", colorId);

        // TODO: Using secure fetch
        secureFetch(`${BASE_URL}user/cart/add`, {
            method: "POST", body: form,
        }).then(resp => {
            if (resp.ok) {
                return resp.text();
            } else {
                return Promise.reject(resp);
            }
        }).then(data => {
            showToast(data, "Success");
            return Promise.resolve();
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
                return Promise.reject();
            });
        });
    } else {
        showToast("Please login to add products to cart", "Error");
        return Promise.reject();
    }
}

/* ====================
   Buy Now Checkout
   ==================== */
function buyNowCheckout(productId) {
    const user = localStorage.getItem("user");
    const qty = document.getElementById(`qty-${productId}`).value;

    var colorId = 0;

    if (user != null) {
        document.querySelectorAll(".tp-color-variation-btn").forEach((btn) => {
            btn.classList.forEach((cls) => {
                if (cls === "active") {
                    colorId = btn.querySelector("#color-id").innerHTML;
                }
            })
        });

        if (colorId === 0) {
            showToast("Please select a color", "Error");
            return Promise.reject();
        }

        window.location = `${BASE_URL}user/checkout/buy-now?id=${productId}&qty=${qty}&colorId=${colorId}`;

    } else {
        showToast("Please login to add products to cart", "Error");
    }
}

/* ====================
   Add To Cart
   ==================== */
function addToCart(productId, qty) {
    const user = localStorage.getItem("user");

    if (user != null) {

        var colorId = document.querySelector(".tp-color-variation-btn .active #color-id");

        const form = new FormData();
        form.append("product_id", productId);
        form.append("quantity", qty);

        secureFetch(`${BASE_URL}user/cart/add`, {
            method: "POST",
            body: form,
        }).then(resp => {
            if (resp.ok) {
                return resp.text();
            } else {
                return Promise.reject(resp);
            }
        }).then(data => {
            showToast(data, "Success");
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
            });
        });
    } else {
        showToast("Please login to add products to cart", "Error");
    }
}

/* ====================
   Remove product from cart
   ==================== */
function removeFromCart(cartId, cartItemId) {
    secureFetch(`${BASE_URL}user/cart/remove/${cartId}/${cartItemId}`, {
        method: "DELETE"
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        window.location.reload();
    }).catch(error => {
        error.text().then((err) => {
            showToast(err, "Error");
        });
    });
}

/* ====================
   Logout
   ==================== */
function logout() {
    fetch(`${BASE_URL}auth/logout`, {
        method: "GET",
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        localStorage.removeItem("user");
        window.location.reload();
    }).catch(error => {
        error.text().then((err) => {
            showToast(err, "Error");
        });
    })
}

/* ====================
   Update User Profile
   ==================== */
function updateProfile() {
    const user = JSON.parse(localStorage.getItem("user"));

    const data = {
        firstName: document.getElementById("firstName").value,
        lastName: document.getElementById("lastName").value,
        mobileNumber: document.getElementById("mobileNumber").value,
        email: document.getElementById("email").value,
        addressLine1: document.getElementById("addLine1").value,
        addressLine2: document.getElementById("addLine2").value,
        city: document.getElementById("city").value,
        zipCode: document.getElementById("zipCode").value,
    }

    secureFetch(`${BASE_URL}user/profile/update`, {
        method: "PUT", headers: {
            "Content-Type": "application/json"
        }, body: JSON.stringify(data),
    }).then(resp => {
        if (resp.ok) {
            return resp.text()
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        showToast(data, "Success");
    }).catch(error => {
        error.text().then((err) => {
            showToast(err, "Error");
        });
    });
}

/* ====================
   Change Profile Image
   ==================== */
function changeProfileImage(event) {
    const fileInput = document.getElementById("profile-thumb-input");
    const files = fileInput.files;

    const form = new FormData();
    form.append("file", files[0]);

    secureFetch(`${BASE_URL}user/profile/update-picture`, {
        method: "PUT", body: form,
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        showToast(data, "Success");
        setTimeout(() => {
            window.location.reload();
        }, 2000);
    }).catch(error => {
        error.text().then((err) => {
            showToast(err, "Error");
        });
    });
}


/* ====================
   Qty Increment & Decrement
   ==================== */
function incrementQty(id) {
    const qty = document.getElementById(`qty-${id}`);
    qty.value = Number.parseInt(qty.value) + 1;
}

function decrementQty(id) {
    const qty = document.getElementById(`qty-${id}`);
    if (Number.parseInt(qty.value) > 1) {
        qty.value = Number.parseInt(qty.value) - 1;
    } else {
        showToast("Quantity cannot be 0", "Warning");
    }
}


function cartQtyIncrement(productId, cartItemId) {

    const qty = document.getElementById(`qty-${cartItemId}`);

    fetch(`${BASE_URL}products/get/qty/${productId}`, {
        method: "GET", headers: {
            "Content-Type": "application/json",
        }
    }).then(resp => {
        if (resp.ok) {
            return resp.json();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        if ((parseInt(qty.value) + 1) <= data) {
            incrementQty(cartItemId);
            updateQty(cartItemId, qty.value);
        } else {
            showToast("You have come to the maximum quantity", "Warning");
        }
    }).catch(err => {
        err.text().then(error => {
            showToast(error, "Error");
        })
    })

}

function cartQtyDecrement(productId, cartItemId) {

    const qty = document.getElementById(`qty-${cartItemId}`);

    fetch(`${BASE_URL}products/get/qty/${productId}`, {
        method: "GET", headers: {
            "Content-Type": "application/json",
        }
    }).then(resp => {
        if (resp.ok) {
            return resp.json();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        if ((parseInt(qty.value) + 1) >= 1) {
            decrementQty(cartItemId);
            updateQty(cartItemId, qty.value);
        } else {
            showToast("You have come to the maximum quantity", "Warning");
        }
    }).catch(err => {
        err.text().then(error => {
            showToast(error, "Error");
        })
    })

}

/* ====================
   Qty Update - Key UP
   ==================== */
function cartQtyKeyUp(productId, cartItemId) {

    const qty = document.getElementById(`qty-${cartItemId}`);
    const updateBtn = document.getElementById("update-btn");
    updateBtn.classList.remove("d-none");

    fetch(`${BASE_URL}products/get/qty/${productId}`, {
        method: "GET", headers: {
            "Content-Type": "application/json",
        }
    }).then(resp => {
        if (resp.ok) {
            return resp.json();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        if ((parseInt(qty.value)) >= data) {
            showToast(`Maximum quantity is ${data}`, "Warning");
            qty.value = data;
        }
    }).catch(err => {
        err.text().then(error => {
            showToast(error, "Error");
        })
    })

}

/* ====================
   Update Qty Button
   ==================== */
function updateQtyBtn(itemId) {
    const qty = document.getElementById(`qty-${itemId}`);
    const updateBtn = document.getElementById("update-btn");

    new Promise((resolve, reject) => {
        updateQty(itemId, qty.value);
        resolve();
    }).then(() => {
        updateBtn.classList.add("d-none");
    })

}

/* ====================
   Update QTY
   ==================== */
function updateQty(itemId, qty) {
    const form = new FormData();
    form.append("id", itemId);
    form.append("qty", qty);

    fetch(`${BASE_URL}user/cart/update-qty`, {
        method: "PUT", body: form
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        if (data === "success") {
            showToast("Product quantity updated", "Succcess");
            setTimeout(() => {
                window.location.reload();
            }, 2000);
        } else {
            showToast("Something went wrong. Please try again", "Error");
        }
    }).catch(err => {
        err.text().then(e => {
            showToast(e, "Error");
        })
    })
}


/* ====================
   Add product to wishlist
   ==================== */
function addToWishlist(productId) {
    const user = localStorage.getItem("user");

    if (user != null) {
        const form = new FormData();
        form.append("product_id", productId);

        secureFetch(`${BASE_URL}user/wishlist/add`, {
            method: "POST", body: form,
        }).then(resp => {
            if (resp.ok) {
                return resp.text();
            } else {
                return Promise.reject(resp);
            }
        }).then(data => {
            showToast(data, "Success");
        }).catch(error => {
            error.text().then((err) => {
                showToast(err, "Error");
            });
        });
    } else {
        showToast("Please login to add products to wishlist", "Error");
    }
}

/* ====================
   Remove product from wishlist
   ==================== */
function removeFromWishlist(wishlistId, wishlistItemId) {
    secureFetch(`${BASE_URL}user/wishlist/remove/${wishlistId}/${wishlistItemId}`, {
        method: "DELETE"
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        window.location.reload();
    }).catch(error => {
        error.text().then((err) => {
            showToast(err, "Error");
        });
    });
}

/* ====================
   Select Color
   ==================== */
function selectColor(colorId) {

    document.querySelectorAll(".tp-color-variation-btn").forEach((btn) => {
        btn.classList.remove("active");
    });

    document.getElementById(`color-btn-${colorId}`).classList.add("active");
}

/* ====================
   Change Delivery
   ==================== */
function changeDelivery(subTotal, deliveryFee) {
    const total = document.getElementById("total");
    const totalUnformatted = document.getElementById("total-unformatted");

    const formattedTotal = (Number.parseInt(subTotal) + Number.parseInt(deliveryFee)).toLocaleString('en-US', {
        style: 'currency', currency: 'USD'
    });
    totalUnformatted.innerHTML = (Number.parseInt(subTotal) + Number.parseInt(deliveryFee)).toString();
    total.innerHTML = formattedTotal;

    document.querySelectorAll(".delivery-fee-radio").forEach((radio) => {
        if (radio.checked) {
            radio.classList.add("active");
        } else {
            radio.classList.remove("active");
        }
    })
}

/* ====================
   Checkout
   ==================== */
function checkout() {

    const amount = document.getElementById("total-unformatted").innerHTML;
    const firstName = document.getElementById("firstName");
    const lastName = document.getElementById("lastName");
    const mobile = document.getElementById("mobile");
    const email = document.getElementById("email");
    const addressLine1 = document.getElementById("addressLine1");
    const addressLine2 = document.getElementById("addressLine2");
    const city = document.getElementById("city");
    const zipCode = document.getElementById("zipCode");
    let deliveryFee = undefined;

    document.querySelectorAll(".delivery-fee-radio").forEach((radio) => {
        if (radio.checked) {
            deliveryFee = radio;
        }
    });

    secureFetch(`${BASE_URL}user/checkout/hash?amount=${amount}`, {
        method: "GET"
    }).then((resp) => {
        if (resp.ok) {
            return resp.json();
        } else {
            return Promise.reject(resp);
        }
    }).then((data) => {

        // Payment completed. It can be a successful failure.
        payhere.onCompleted = function onCompleted(orderId) {
            var data = {
                total: amount,
                deliveryFee: deliveryFee.value,
                firstName: firstName.value,
                lastName: lastName.value,
                mobile: mobile.value,
                email: email.value,
                addressLine1: addressLine1.value,
                addressLine2: addressLine2.value,
                city: city.value,
                zipCode: zipCode.value,
                orderId: orderId
            }

            secureFetch(`${BASE_URL}user/checkout`, {
                method: "POST", headers: {
                    "Content-Type": "application/json"
                }, body: JSON.stringify(data),
            }).then(resp => {
                if (resp.ok) {
                    return resp.text();
                } else {
                    return Promise.reject(resp);
                }
            }).then(data => {
                window.location = `${BASE_URL}user/order/success/${orderId}`;
            }).catch(error => {
                error.text().then((err) => {
                    showToast(err, "Error");
                    console.log(err);
                });
            })

            // Note: validate the payment and show success or failure page to the customer
        };

        // Payment window closed
        payhere.onDismissed = function onDismissed() {
            // Note: Prompt user to pay again or show an error page
            console.log("Payment dismissed");
        };

        // Error occurred
        payhere.onError = function onError(error) {
            // Note: show an error page
            console.log("Error:" + error);
        };

        // Put the payment variables here
        var payment = {
            "sandbox": true,
            "merchant_id": data.merchantID,    // Replace your Merchant ID
            "return_url": undefined,     // Important
            "cancel_url": undefined,     // Important
            "notify_url": undefined,
            "order_id": data.orderID,
            "items": firstName.value + " - " + data.orderID,
            "amount": data.amount,
            "currency": data.currency,
            "hash": data.hash, // *Replace with generated hash retrieved from backend
            "first_name": firstName.value,
            "last_name": lastName.value,
            "email": email.value,
            "phone": mobile.value,
            "address": addressLine1.value + ", " + addressLine2.value,
            "city": city.value,
            "country": "Sri Lanka",
            "delivery_address": addressLine1.value + ", " + addressLine2.value,
            "delivery_city": city.value,
            "delivery_country": "Sri Lanka",
        };

        // Show the payhere.js popup, when "PayHere Pay" is clicked
        payhere.startPayment(payment);
    }).catch((error) => {
        error.text().then((err) => {
            showToast(err, "Error");
            console.log(err);
        });
    });
}

/* ====================
   Buy Now
   ==================== */
function buyNow(productId, qty, colorId) {
    const amount = document.getElementById("total-unformatted").innerHTML;
    const firstName = document.getElementById("firstName");
    const lastName = document.getElementById("lastName");
    const mobile = document.getElementById("mobile");
    const email = document.getElementById("email");
    const addressLine1 = document.getElementById("addressLine1");
    const addressLine2 = document.getElementById("addressLine2");
    const city = document.getElementById("city");
    const zipCode = document.getElementById("zipCode");
    let deliveryFee = undefined;

    document.querySelectorAll(".delivery-fee-radio").forEach((radio) => {
        if (radio.checked) {
            deliveryFee = radio;
        }
    });

    secureFetch(`${BASE_URL}user/checkout/hash?amount=${amount}`, {
        method: "GET"
    }).then((resp) => {
        if (resp.ok) {
            return resp.json();
        } else {
            return Promise.reject(resp);
        }
    }).then((data) => {

        // Payment completed. It can be a successful failure.
        payhere.onCompleted = function onCompleted(orderId) {
            var data = {
                total: amount,
                deliveryFee: deliveryFee.value,
                firstName: firstName.value,
                lastName: lastName.value,
                mobile: mobile.value,
                email: email.value,
                addressLine1: addressLine1.value,
                addressLine2: addressLine2.value,
                city: city.value,
                zipCode: zipCode.value,
                orderId: orderId,
                productId: productId,
                qty: qty,
                colorId: colorId
            }

            secureFetch(`${BASE_URL}user/checkout/buy-now`, {
                method: "POST", headers: {
                    "Content-Type": "application/json"
                }, body: JSON.stringify(data),
            }).then(resp => {
                if (resp.ok) {
                    return resp.text();
                } else {
                    return Promise.reject(resp);
                }
            }).then(data => {
                window.location = `${BASE_URL}user/order/success/${orderId}`;
            }).catch(error => {
                error.text().then((err) => {
                    showToast(err, "Error");
                    console.log(err);
                });
            })

            // Note: validate the payment and show success or failure page to the customer
        };

        // Payment window closed
        payhere.onDismissed = function onDismissed() {
            // Note: Prompt user to pay again or show an error page
            console.log("Payment dismissed");
        };

        // Error occurred
        payhere.onError = function onError(error) {
            // Note: show an error page
            console.log("Error:" + error);
        };

        // Put the payment variables here
        var payment = {
            "sandbox": true,
            "merchant_id": data.merchantID,    // Replace your Merchant ID
            "return_url": undefined,     // Important
            "cancel_url": undefined,     // Important
            "notify_url": undefined,
            "order_id": data.orderID,
            "items": firstName.value + " - " + data.orderID,
            "amount": data.amount,
            "currency": data.currency,
            "hash": data.hash, // *Replace with generated hash retrieved from backend
            "first_name": firstName.value,
            "last_name": lastName.value,
            "email": email.value,
            "phone": mobile.value,
            "address": addressLine1.value + ", " + addressLine2.value,
            "city": city.value,
            "country": "Sri Lanka",
            "delivery_address": addressLine1.value + ", " + addressLine2.value,
            "delivery_city": city.value,
            "delivery_country": "Sri Lanka",
        };

        // Show the payhere.js popup, when "PayHere Pay" is clicked
        payhere.startPayment(payment);
    }).catch((error) => {
        error.text().then((err) => {
            showToast(err, "Error");
            console.log(err);
        });
    });
}