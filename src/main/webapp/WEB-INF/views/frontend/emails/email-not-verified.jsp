<%--
  Created by IntelliJ IDEA.
  User: poojithairosha
  Date: 9/10/23
  Time: 4:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Not Verified</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-content: center;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 600px;
            max-height: 300px;
            margin: 0 0;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .error-icon {
            display: block;
            margin: 0 auto;
            font-size: 60px;
            color: #FF5733;
            text-align: center;
        }

        p {
            text-align: center;
            font-size: 18px;
            color: #777;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #FF5733;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #FF4D26;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Email Not Verified</h1>
    <span class="error-icon">&#9940;</span>
    <p>${it}</p>
    <div class="btn-container">
        <a href="${BASE_URL}" class="btn">Back to Home</a>
    </div>
</div>

</body>
</html>
