/* ====================
   User Sign Up
   ==================== */
function signUp() {
    const fname = document.getElementById("fname");
    const lname = document.getElementById("lname");
    const mobile = document.getElementById("mobile");
    const email = document.getElementById("email");
    const password = document.getElementById("password");

    if (fname.value == "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter first name";
        return;
    } else if (lname.value == "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter last name";
        return;
    } else if (mobile.value == "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter mobile number";
        return;
    } else if (email.value == "") {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Please enter email address";
        return;
    } else if (password.value == "") {
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
            method: "POST",
            body: JSON.stringify(data),
            headers: {
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

    const formData = new FormData();
    formData.append("email", email.value);
    formData.append("password", password.value);

    const url = `${BASE_URL}auth/login`;
    fetch(url, {
        method: "POST",
        body: formData,
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
    })
}

/* ====================
   Show Toast
   ==================== */
function showToast(message, status) {
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
        const data = JSON.parse(xhr.responseText);
        console.log(xhr.responseText);

        localStorage.setItem("user", JSON.stringify(data));
        window.location = `${BASE_URL}`;
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
    const form = new FormData();
    form.append("email", document.getElementById("email").value);

    fetch(`${BASE_URL}auth/forgot-password`, {
        method: "POST",
        body: form,
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

/* ====================
   Reset Password
   ==================== */
function resetPassword() {
    const code = document.getElementById("code").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirm-password").value;

    if (password !== confirmPassword) {
        document.querySelector("#error-msg").classList.remove("d-none");
        document.querySelector("#error-msg span").innerHTML = "Password and confirm password does not match";
        return;
    }

    fetch(`${BASE_URL}auth/reset-password`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            code: code,
            password: password,
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

    if (newPassword !== confirmPassword) {
        showToast("Password and confirm password does not match", "Error");
    } else {
        const data = {
            email: email,
            oldPassword: oldPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword,
        };

        fetch(`${BASE_URL}auth/update-password`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
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

    if (user != null) {
        const form = new FormData();
        form.append("product_id", productId);
        form.append("quantity", qty);

        fetch(`${BASE_URL}user/cart/add`, {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${JSON.parse(user).accessToken}`,
            },
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
   Add To Cart
   ==================== */
function addToCart(productId, qty) {
    const user = localStorage.getItem("user");

    if (user != null) {
        const form = new FormData();
        form.append("product_id", productId);
        form.append("quantity", qty);

        fetch(`${BASE_URL}user/cart/add`, {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${JSON.parse(user).accessToken}`,
            },
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
    fetch(`${BASE_URL}user/cart/remove/${cartId}/${cartItemId}`, {
        method: "DELETE",
        headers: {
            "Authorization": `Bearer ${JSON.parse(localStorage.getItem("user")).accessToken}`,
        }
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

    fetch(`${BASE_URL}user/profile/update`, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${user.accessToken}`,
        },
        body: JSON.stringify(data),
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
        method: "GET",
        headers: {
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
        method: "GET",
        headers: {
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

function cartQtyKeyUp(productId, cartItemId) {

    const qty = document.getElementById(`qty-${cartItemId}`);
    const updateBtn = document.getElementById("update-btn");
    updateBtn.classList.remove("d-none");

    fetch(`${BASE_URL}products/get/qty/${productId}`, {
        method: "GET",
        headers: {
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

function updateQty(itemId, qty) {
    const form = new FormData();
    form.append("id", itemId);
    form.append("qty", qty);

    fetch(`${BASE_URL}user/cart/update-qty`, {
        method: "PUT",
        body: form
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        if(data === "success") {
            showToast("Product quantity updated", "Succcess");
            setTimeout(() => {
                window.location.reload();
            }, 2000);
        }else {
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

        fetch(`${BASE_URL}user/wishlist/add`, {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${JSON.parse(user).accessToken}`,
            },
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
        showToast("Please login to add products to wishlist", "Error");
    }
}

/* ====================
   Remove product from wishlist
   ==================== */
function removeFromWishlist(wishlistId, wishlistItemId) {
    fetch(`${BASE_URL}user/wishlist/remove/${wishlistId}/${wishlistItemId}`, {
        method: "DELETE",
        headers: {
            "Authorization": `Bearer ${JSON.parse(localStorage.getItem("user")).accessToken}`,
        }
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
