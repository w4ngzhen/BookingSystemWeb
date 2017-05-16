<%--
  Created by IntelliJ IDEA.
  User: mee
  Date: 2017/5/9
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String content = (String) request.getAttribute("content");
    String result = (String) request.getAttribute("result");
%>
<html>
<head>
    <title><%= content + result %>
    </title>
    <script>
        window.onload = function () {
            var content = document.getElementsByName("content")[0].value;
            var result = document.getElementsByName("result")[0].value;
            alert(content + ": " + result);
            window.location.href = "/bookingsystem";
        };
    </script>
</head>
<body>
<%= "<input hidden type='text' name='content' value='" + content + "' >" %>
<%= "<input hidden type='text' name='result' value='" + result + "' >" %>
</body>
</html>
