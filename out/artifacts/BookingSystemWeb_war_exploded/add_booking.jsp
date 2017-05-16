<%--
  Created by IntelliJ IDEA.
  User: mee
  Date: 2017/4/24
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="entity.Table" %>
<%
    String startTime = (String) request.getAttribute("startTime");
    String endTime = (String) request.getAttribute("endTime");
    List<Table> freeTables = (List<Table>) request.getAttribute("freeTables");
%>
<html>
<head>
    <title>新增预约</title>
    <link rel="stylesheet" type="text/css" href="./css/button.css">
    <link rel="stylesheet" type="text/css" href="css/center.css">
    <link rel="stylesheet" type="text/css" href="css/title.css">
    <script type="text/javascript" src="js/myjs.js"></script>
</head>
<body>
<div class="setCenter red setWidth">
    <form id="submitForm" method="post" action="/submit" onsubmit="return submitMyInfo()">
        <p class="MyTitle">预定时间段</p>
        <%= "<input type='text' name='startTime' value='" + startTime + "' readonly>"%>
        <label>到</label>
        <%= "<input type='text' name='endTime' value='" + endTime + "' readonly>"%>
        <p class="MyTitle">预定桌号</p>
        <select name="tableSelect">
        <%
            int freeTablesSize = freeTables.size();
            for (int i = 0; i < freeTablesSize; i++) {
                int tno = freeTables.get(i).getTno();
                int places = freeTables.get(i).getPlaces();
                if (i == 0) {
                    out.print("<option  selected='selected' value ='" + tno + "'>" + tno + "（" + places + "人左右）" + "</option>");
                } else {
                    out.print("<option  value ='" + tno + "'>" + tno + "（" + places + "人左右）" + "</option>");
                }
            }
        %>
        </select>
        <p class="MyTitle">预定人</p>
        <table class="setCenter yellow">
            <tr>
                <th>姓名</th>
                <th>电话</th>
                <th></th>
                <th></th>
            </tr>
            <tr>
                <td><input type="text" name="cName" ></td>
                <td><input type='text' name="cPhoneNumber" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();" />
                </td>
                <td><input type="radio" name="sex" value="male" checked>先生</td>
                <td><input type="radio" name="sex" value="female">女士</td>
            </tr>
        </table>
        <table class="setCenter yellow">
            <tr>
                <input hidden name="from" value="add_booking">
                <td><input class="button2 yellow" type="submit" value="确认"></td>
                <td><input class="button2 red" type="reset" value="重新填写"></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
