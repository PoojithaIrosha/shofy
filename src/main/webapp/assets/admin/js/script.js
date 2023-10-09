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
   Admin Login
   ==================== */
function login() {

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    if (email === "") {
        showToast("Email is required", "Error");
    } else if (password === "") {
        showToast("Password is required", "Error");
    } else {

        const form = new FormData();
        form.append("email", email);
        form.append("password", password);

        fetch(`${BASE_URL}admin/login`, {
            method: "POST",
            body: form
        }).then(resp => {
            if (resp.ok) {
                return resp.json();
            } else {
                return Promise.reject(resp);
            }
        }).then(json => {
            localStorage.setItem("user", JSON.stringify(json));
            window.location = `${BASE_URL}admin`;
        }).catch(err => {
            err.text().then(txt => {
                showToast(txt, "Error");
            })
        })
    }
}

/* ====================
   Add Product
   ==================== */
function addProduct() {
    const name = document.getElementById("name");
    const price = document.getElementById("price");
    const qty = document.getElementById("qty");
    const brand = document.getElementById("brand");
    const category = document.getElementById("category");
    const description = document.getElementById("description");
    const images = document.getElementById("images");

    if (name.value === "") {
        showToast("Name is required", "Error");
    } else if (price.value === "") {
        showToast("Price is required", "Error");
    } else if (qty.value === "") {
        showToast("Quantity is required", "Error");
    } else if (brand.value === "") {
        showToast("Brand is required", "Error");
    } else if (category.value === "") {
        showToast("Category is required", "Error");
    } else if (description.value === "") {
        showToast("Description is required", "Error");
    } else if (images.files.length == 0) {
        showToast("Images are required", "Error");
    } else {

        const form = new FormData();
        form.append("name", name.value);
        form.append("price", price.value);
        form.append("quantity", qty.value);
        form.append("brand", brand.value);
        form.append("category", category.value);
        form.append("description", description.value);

        for (let i = 0; i < images.files.length; i++) {
            form.append("images", images.files[i]);
        }

        secureFetch(`${BASE_URL}admin/products/add`, {
            method: "POST",
            body: form
        }).then(resp => {
            if (resp.ok) {
                return resp.text();
            } else {
                return Promise.reject(resp);
            }
        }).then(data => {
            showToast(data, "Success");
            setTimeout(() => {
                window.location = `${BASE_URL}admin/products`;
            }, 2000);
        }).catch(err => {
            err.text().then(txt => {
                showToast(txt, "Error");
            })
        });

    }
}

/* ====================
   Update Product
   ==================== */
function updateProduct(id) {
    const name = document.getElementById("name");
    const price = document.getElementById("price");
    const qty = document.getElementById("qty");
    const brand = document.getElementById("brand");
    const category = document.getElementById("category");
    const description = document.getElementById("description");
    const images = document.getElementById("images");
    const active = document.getElementById("active-status");

    const form = new FormData();
    form.append("name", name.value);
    form.append("price", price.value);
    form.append("quantity", qty.value);
    form.append("brand", brand.value);
    form.append("category", category.value);
    form.append("description", description.value);
    form.append("active", active.value);

    for (let i = 0; i < images.files.length; i++) {
        form.append("images", images.files[i]);
    }

    secureFetch(`${BASE_URL}admin/products/edit/${id}`, {
        method: "PUT",
        body: form
    }).then(resp => {
        if (resp.ok) {
            return resp.text();
        } else {
            return Promise.reject(resp);
        }
    }).then(data => {
        showToast(data, "Success");
        setTimeout(() => {
            window.location = `${BASE_URL}admin/products`;
        }, 2000);
    }).catch(err => {
        err.text().then(txt => {
            console.log(txt);
            showToast(txt, "Error");
        })
    });
}

/* ====================
   Change User Status
   ==================== */
function changeUserStatus(userId) {

    const form = new FormData();
    form.append("userId", userId);

    secureFetch(`${BASE_URL}admin/users/update-status`, {
        method: "PATCH",
        body: form
    }).then(resp => resp.text()).then(data => {
        showToast(data, "Success");
        setTimeout(() => {
            window.location.reload();
        }, 2000);
    }).catch(err => {
        showToast(err, "Error");
    })

}