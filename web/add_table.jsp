<%--
  Created by IntelliJ IDEA.
  User: mee
  Date: 2017/5/14
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.Table" %>
<%@ page import="java.util.List" %>
<%
    List<Table> allTables = (List<Table>) request.getAttribute("allTables");
%>
<html>
<head>
    <title>新增桌子</title>
    <link rel="stylesheet" type="text/css" href="./css/center.css">
    <link rel="stylesheet" type="text/css" href="./css/button.css">
    <link rel="stylesheet" type="text/css" href="css/title.css">
    <script>
        tnos = new Array();
        <%
            int size = allTables.size();
            for (int i = 0; i < size; i++) {
                out.print("tnos[" + i + "]='" + allTables.get(i).getTno() + "';");
            }
        %>

        function hasTheTable(tno) {
            for (var i = 0; i < tnos.length; i++) {
                if (tnos[i] == tno)
                    return true;
            }
            return false;
        }

        function onAddMyTable() {
            var tno = document.getElementsByName("tableno")[0].value;
            var cap = document.getElementsByName("capacity")[0].value;
            if (tno == "" || cap == "") {
                alert("请填写完整信息!");
                return false;
            } else if (hasTheTable(tno)) {
                alert("所选桌号已经存在!");
                return false;
            } else if (cap <= 0) {
                alert("容纳人数不能为负数!");
                return false;
            } else {
                document.getElementsByName("tno")[0].value = tno;
                document.getElementsByName("capa")[0].value = cap;
                return true;
            }
            return false;
        }
    </script>
</head>
<body>
<form method="post" action="addtable_result" onsubmit="return onAddMyTable()">
    <p class="MyTitle">新增桌子</p>
    <input hidden type="text" value="" name="tno">
    <input hidden type="text" value="" name="capa">
    <%
        int tableCount = allTables.size();
        if (0 == tableCount) {
            out.print("<p class='setCenter MyTitle'>当前系统中没有任何桌号信息</p>");
        } else {
            out.print("<p class='setCenter MyTitle'>已有桌号信息</p>");
        }
    %>
    <%
        int row = (int) Math.ceil(tableCount/4.0);
        int col = 4;
        out.print("<table class='setCenter'>");

        for (int i = 0; i < row; i++) {
            out.print("<tr>");
            for (int j = 0; j < col; j++) {
                if ((i * col + j) < tableCount) {
                    out.print("<td>&nbsp&nbsp桌号: " + allTables.get(i * col + j).getTno()
                            + "(" + allTables.get(i * col + j).getPlaces() + "人左右)" + "</td>");
                }
            }
            out.print("</tr>");
        }
        out.print("</table>");
    %>
    <table class="setCenter">

    </table>
    <table class="setCenter">
        <tr>
            <td class="MyTitle">桌号</td>
            <td><input type="text" name="tableno" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"></td>
        </tr>
        <tr>
            <td class="MyTitle">大致容纳人数</td>
            <td><input type="text" name="capacity" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"></td>
        </tr>
        <tr>
            <td><input class="button2 orange" type="submit" value="添加"></td>
            <td><input class="button2 yellow" type="reset" value="重写"></td>
        </tr>
    </table>
</form>
</body>
</html>
