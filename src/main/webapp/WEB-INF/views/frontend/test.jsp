<%--
  Created by IntelliJ IDEA.
  User: poojithairosha
  Date: 10/2/23
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<input type="number" id="number">
<button onclick="send()">Send</button>

<br/><br/>

<table border="1" style="border-collapse: collapse">
    <thead>
    <tr>
        <th>Odd</th>
        <th>Even</th>
    </tr>
    </thead>
    <tbody id="tbody">

    </tbody>
</table>

<script>
    function send() {
        const number = parseInt(document.getElementById("number").value);

        if(number >= 100 && number <= 1000) {
            const form = new FormData();
            form.append("number", number);

            fetch(`${BASE_URL}test/`, {
                method: "POST",
                body:form
            }).then(resp => resp.json()).then(data => {
                console.log(data);

                const tbody = document.getElementById("tbody");
                var tr = document.createElement("tr");
                var odd = document.createElement("td");
                var even = document.createElement("td");

                if(data.type === "EVEN") {
                    even.innerHTML = data.number;
                    tr.append(odd);
                    tr.append(even);
                }else {
                    odd.innerHTML = data.number;
                    tr.append(odd);
                    tr.append(even);
                }

                tbody.append(tr);
            }).catch(err => {
                alert(err);
            });
        }else {
            alert("Number must be between 100 and 1000");
        }
    }
</script>
</body>
</html>
