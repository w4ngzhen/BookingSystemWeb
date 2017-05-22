<%--
  Created by IntelliJ IDEA.
  User: mee
  Date: 2017/4/25
  Time: 22:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>抱歉</title>
</head>
<body>
<h3>抱歉，所选时间段没有适合的桌子了</h3>
<script>
    window.onload = function () {
        alert("抱歉，当前已经没有可用的桌子了！");
        window.location.href = "bookingsystem";
    };
</script>
</body>
</html>
