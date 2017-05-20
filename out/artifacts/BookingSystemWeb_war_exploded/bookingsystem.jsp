<%--
  Created by IntelliJ IDEA.
  User: mee
  Date: 2017/4/24
  Time: 08:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="entity.Booking" %>
<%@ page import="entity.Table" %>
<%@ page import="myutil.TableCheck" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Booking> preBookings = (List<Booking>) request.getAttribute("preBookings");
    List<Table> onGoingTables = (List<Table>) request.getAttribute("onGoingTables");
    List<Table> allTables = (List<Table>) request.getAttribute("allTables");
    String startTime = (String) request.getAttribute("startTime");
    String endTime = (String) request.getAttribute("endTime");
    List<Table> freeTables = (List<Table>) request.getAttribute("freeTables");
%>
<html>
<head>
    <title>餐厅预订系统主页</title>
    <link rel="stylesheet" type="text/css" href="./css/button.css">
    <link rel="stylesheet" type="text/css" href="css/title.css">
    <link rel="stylesheet" type="text/css" href="css/center.css">
    <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script>
        var startTimeSetting = 18;
        var endTimeSelectSetting = 23;
        function timeConfirm(timeLocal) {
            var currentDate = new Date();
            var cY = currentDate.getFullYear();
            var cM = currentDate.getMonth() + 1;
            var cD = currentDate.getDate();
            var x = timeLocal.value;
            var year = x.substring(0, 4);
            var month = x.substring(5, 7);
            var day = x.substring(8, 10);
            var hour = x.substring(11, 13);
            var minute = x.substring(14);
            var time2 = document.getElementsByName("endTimeSelect")[0];
            if (year == "" || month == "" || day == "" || hour == "" || minute == "") {
                alert("请选择一个完整时间");
                time2.disabled = true;
                timeLocal.value = "";
            } else if (parseInt(hour) < startTimeSetting || parseInt(hour) >= endTimeSelectSetting) {
                alert("请选择" + startTimeSetting + ":00到" + endTimeSelectSetting + ":00的时间");
                time2.disabled = true;
                timeLocal.value = "";
            } else if (year != cY || month != cM || day != cD) {
                alert("请选择今日时间:" + cY + "-" + cM + "-" + cD);
                time2.disabled = true;
            } else {
                time2.disabled = false;
            }
        }
        function timeConfirm2(timeLocal2) {
            timeConfirm(timeLocal2);
            var st = document.getElementsByName("startTimeSelect")[0].value;
            var et = timeLocal2.value;
            if (et <= st) {
                alert("请选择晚于开始时间的正确时间");
                timeLocal2.value = "";
            }
        }
        function inputComplete() {
            var st = document.getElementsByName("startTimeSelect")[0].value;
            var et = document.getElementsByName("endTimeSelect")[0].value;
            if (st == "" || et == "") {
                alert("请选择时间");
                return false;
            } else {
                return true;
            }
        }
        function listClick() {
            var selects = document.getElementsByName("select");
            for (var i = 0; i < selects.length; i++) {
                if (selects[i].checked) {
                    var selectValue = selects[i].value;
                    var transferButton = document.getElementsByName("transfer")[0];
                    var recordButton = document.getElementsByName("record")[0];
                    var checkoutButton = document.getElementsByName("checkout")[0];
                    var cancelButton = document.getElementsByName("cancel")[0];
                    if (selectValue.match("preBooking_*")) {
                        transferButton.disabled = false;
                        recordButton.disabled = false;
                        checkoutButton.disabled = true;
                        cancelButton.disabled = false;
                        document.getElementsByName("transfertable")[0].value = selectValue;
                        document.getElementsByName("setRepastBooking")[0].value = selectValue;
                        document.getElementsByName("cancelbookingid")[0].value = selectValue;
                    } else if (selectValue.match("onGoingTable_*")) {
                        transferButton.disabled = true;
                        recordButton.disabled = true;
                        checkoutButton.disabled = false;
                        cancelButton.disabled = true;
                        document.getElementsByName("checkouttable")[0].value = selectValue;
                    }
                }
            }
        }

        function itsTimeToEat() {
            var hour = new Date().getHours();
            if (hour < 10) {
                alert("当前时间(18点以前)不可进行就餐！");
                return false;
            } else {
                return true;
            }
        }
        tnos = new Array();
        <%
            int tableSize = allTables.size();
            for (int i = 0; i < tableSize; i++) {
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

        function addMyNewTable() {
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
        $(document).ready(function () {
            $("#booking_flip").click(function () {
                $("#add_booking_panel").slideToggle("slow");
            });
            $("#add_without_booking_flip").click(function () {
                if (itsTimeToEat() && '<%= freeTables.size() %>' != 0) {
                    $("#add_without_booking_panel").slideToggle("slow");
                } else if ('<%= freeTables.size() %>' == 0) {
                    alert("当前没有可用桌子了！");
                }
            });
            $("#deleteTheTable").click(function () {
                $("#theDeleteBox").slideToggle("slow");
            });
            $("#cancelDeleteTheTable").click(function () {
                $("#theDeleteBox").slideUp("slow");
            });
            $("#addTheTable").click(function () {
                $("#theAddBox").slideToggle("slow");
            });
            $("#cancelAddTheTable").click(function () {
                $("#theAddBox").slideUp("slow");
            });
            var tds = $("#allTables td");
            tds.click(function () {
                var tdSeq = $(this).parent().find("td").index($(this)[0]);
                var trSeq = $(this).parent().parent().find("tr").index($(this).parent()[0]);
                var text = document.getElementById("allTables")
                    .getElementsByTagName("tr")[trSeq]
                    .getElementsByTagName("td")[tdSeq].innerHTML;
                var tableDetailForm = document.getElementById("table_detail_form");
                tableDetailForm.getElementsByTagName("input")[0].value = text;
                document.getElementById("table_detail_form").submit();
            });
        });
    </script>
    <style>
        body {
            text-align: center;
        }

        table.imagetable {
            margin: auto;
            font-family: verdana, arial, sans-serif;
            font-size: 11px;
            color: #333333;
            border-width: 3px;
            border-color: #111111;
            border-collapse: collapse;
        }

        table.imagetable th {
            background: #b5cfd2 url('/images/cell-blue.jpg');
            border-width: 3px;
            padding: 8px;
            border-style: solid;
            border-color: #999999;
        }

        table.imagetable td {
            background: #dcddc0 url('/images/cell-grey.jpg');
            border-width: 3px;
            padding: 8px;
            border-style: solid;
            border-color: #999999;
        }

        div.addDiv {
            text-align: center;
            margin: auto;
            border: solid black;
            width: 600px;
            height: auto;
            display: none;
        }

        div.deleteTableDiv {
            text-align: center;
            margin: auto;
            border: solid black;
            width: 300px;
            height: auto;
            display: none;
        }

        div.addTableDiv {
            text-align: center;
            margin: auto;
            border: solid black;
            width: 300px;
            height: auto;
            display: none;
        }

        input:disabled {
            border: 1px solid #DDD;
            background-color: #F5F5F5;
            color: #ACA899;
        }

        div.bookingDiv {
            width: 600px;
            border: black solid;
            margin: auto;
        }

        div.onGoingDiv {
            width: 600px;
            border: black solid;
            margin: auto;
        }

        div.buttonDiv {
            width: 600px;
            border: black solid;
            margin: auto;
        }

        div.buttonDiv2 {
            width: 600px;
            border: black solid;
            margin: auto;
        }

        table.buttonTable {
            text-align: center;
            margin: auto;
            width: 600px;
            height: 30px;
        }

        table.buttonTable td {
            margin: auto;
            width: inherit;
            height: inherit;
        }

        .frame {
            margin: auto;
            width: 920px;
            height: auto;
        }

        .mainArea {
            float: left;
            width: 600px;
            height: auto;
        }

        .tableArea {
            float: right;
            width: 300px;
            height: auto;
            border: solid black;
        }

        table.notetables {
            float: left;
            width: 300px;
            height: 50px;
        }

        table.notetables td {
            border: solid black;
            font-size: 4px;
        }

        table.buttonArea {
            float: left;
            width: 100px;
            height: 100px;
            border: solid black;
        }

        table.mytables {
            width: 300px;
            border: solid black;
            font-size: 2px;
        }

        table.mytables td {
            width: 60px;
            height: 100px;
            margin-bottom: 0px;
        }

        table.mytables td.free {
            background: url('images/table_free.png') no-repeat;
        }

        table.mytables td.pre {
            background: url('images/table_pre.png') no-repeat;
        }

        table.mytables td.ing {
            background: url('images/table_ing.png') no-repeat;
        }
    </style>
</head>
<body>
<div class="frame">
    <div class="mainArea">
        <div class="bookingDiv">
            <h3 class="MyTitle">当前预订信息</h3>
            <table id="preBookings" class="imagetable">
                <%
                    int preBookingsSize = preBookings.size();
                    if (preBookingsSize > 0) {
                        out.print("<tr>\n" +
                                "            <th></th>\n" +
                                "            <th>订单号码</th>\n" +
                                "            <th>预定时间</th>\n" +
                                "            <th>结束时间</th>\n" +
                                "            <th>桌号</th>\n" +
                                "            <th>预定人</th>\n" +
                                "            <th>手机号码</th>\n" +
                                "        </tr>");
                    } else {
                        out.print("<h5>当前没有预订信息</h5>");
                    }
                    for (int i = 0; i < preBookingsSize; i++) {
                %>
                <tr>
                    <td><%= "<input type='radio' value='preBooking_" + preBookings.get(i).getBid() + "' name='select' onclick='listClick()'>" %>
                    </td>
                    <td><%= preBookings.get(i).getBid() %>
                    </td>
                    <td><%= preBookings.get(i).getStartTime() %>
                    </td>
                    <td><%= preBookings.get(i).getEndTime() %>
                    </td>
                    <td><%= preBookings.get(i).getTno() %>
                    </td>
                    <td><%= preBookings.get(i).getcName() %>
                    </td>
                    <td><%= preBookings.get(i).getcPhoneNumber() %>
                    </td>

                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div class="onGoingDiv">
            <h3 class="MyTitle">就餐中</h3>
            <table id="onGoingTables" class="imagetable">
                <%
                    int onGoingTablesSize = onGoingTables.size();
                    if (onGoingTablesSize > 0) {
                        out.print("<tr>\n" +
                                "            <th></th>\n" +
                                "            <th>就餐桌号</th>\n" +
                                "            <th>容纳人数</th>\n" +
                                "        </tr>");
                    } else {
                        out.print("<h5>当前没有人就餐中</h5>");
                    }
                    for (int i = 0; i < onGoingTablesSize; i++) {
                %>
                <tr>
                    <td><%= "<input type='radio' value='onGoingTable_" + onGoingTables.get(i).getTno() + "' name='select' onclick='listClick()'>" %>
                    </td>
                    <td><%= onGoingTables.get(i).getTno() %>
                    </td>
                    <td><%= onGoingTables.get(i).getPlaces() %>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <div class="buttonDiv">
            <table class="buttonTable">
                <tr>
                    <td>
                        <form method="post" action="/transfer">
                            <input class="button2 pink" name="transfer" type="submit" value="调换座位" disabled>
                            <input name="transfertable" value="" hidden>
                        </form>
                    </td>
                    <td>
                        <form method="post" action="/record">
                            <input class="button2 orange" name="record" type="submit" value="就餐" disabled>
                            <input name="setRepastBooking" value="" hidden>
                        </form>
                    </td>
                    <td>
                        <form method="post" action="/checkout">
                            <input class="button2 yellow" name="checkout" type="submit" value="结账" disabled>
                            <input name="checkouttable" value="" hidden>
                        </form>
                    </td>
                    <td>
                        <form method="post" action="/cancel">
                            <input class="button2 red" name="cancel" type="submit" value="取消订单" disabled>
                            <input name="cancelbookingid" value="" hidden>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        <div id="ButtonDiv2" class="buttonDiv2">
            <table style="width: 600px; text-align: center">
                <tr>
                    <td style="text-align: center">
                        <input id="booking_flip" type="button" class="button2 blue" value="我要预定">
                    </td>
                    <td style="text-align: center">
                        <input id="add_without_booking_flip" type="button" class="button2 green" value="未预定食客就餐">
                    </td>
                </tr>
            </table>
        </div>
        <div id='add_booking_panel' class="addDiv">
            <form method="post" action="/addbooking" onsubmit="return inputComplete()">
                <h3 class="MyTitle2">预定时间(18:00-23:00)</h3>
                <table style="margin: auto">
                    <tr>
                        <td><input type="datetime-local" name="startTimeSelect" onblur="timeConfirm(this)"></td>
                        <td>到</td>
                        <td><input type="datetime-local" name="endTimeSelect" onblur="timeConfirm2(this)" disabled></td>
                    </tr>
                </table>
                <input class="button2 blue" type="submit" value="新增预约">
            </form>
        </div>
        <div id="add_without_booking_panel" class="setCenter setWidth" style="display: none; border: solid black;">
            <form id="submitForm" method="post" action="/submit" onsubmit="return submitMyInfo()">
                <%= "<input hidden name='startTime' value='" + startTime + "' readonly>"%>
                <%= "<input hidden name='endTime' value='" + endTime + "' readonly>"%>
                <p class="MyTitle">桌号选择</p>
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
                <table class="setCenter yellow">
                    <tr>
                        <td><input type="text" name="cName" value="ordinary_guest" hidden></td>
                        <td><input type='text' name="cPhoneNumber" value="000" hidden></td>
                        <td><input type="radio" name="sex" value="male" checked>先生</td>
                        <td><input type="radio" name="sex" value="female">女士</td>
                    </tr>
                </table>
                <table class="setCenter yellow">
                    <tr>
                        <input hidden name="from" value="add_orderwithoutbooking">
                        <td><input class="button2 red" type="submit" value="确认"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <div class="tableArea">
        <table class="notetables">
            <tr>
                <td style="text-align: center">
                    <input style="margin: auto" id="addTheTable" class="button2 green" type="button" value="添加桌子">
                </td>
                <td></td>
                <td style="text-align: center">
                    <input style="margin: auto" r id="deleteTheTable" class="button2 red" type="button" value="移除桌子">
                </td>
            </tr>
        </table>
        <%
            int size = allTables.size();
            int row = (int) Math.ceil(size / 4.0);
            int col = 4;
            if (size <= 0) {
                out.print("<h3>没有桌子</h3>");
            } else {
                out.print("<table id='allTables' class='mytables' >");
                for (int i = 0; i < row; i++) {
                    out.print("<tr>");
                    for (int j = 0; j < col; j++) {
                        if (i * col + j < size) {
                            Table table = allTables.get(i * col + j);
                            String status;
                            String sta;
                            String fontColor;
                            if (TableCheck.hasTheTableInTables(onGoingTables, table.getTno())) {
                                status = "ing";
                                sta = "正就餐";
                                fontColor = "#EB1524";
                            } else if (TableCheck.hasTheTableInBookings(preBookings, table.getTno())) {
                                status = "pre";
                                sta = "有预定";
                                fontColor = "#EBD515";
                            } else {
                                status = "free";
                                sta = "空闲";
                                fontColor = "#AB7127";
                            }
                            out.print("<td valign='bottom' class='" + status + "'>"
                                    + "<strong>&nbsp&nbsp-" + table.getTno() + "号桌-</strong><br/>"
                                    + "<font color='" + fontColor + "'>&nbsp&nbsp&nbsp[" + sta + "]</font><br/>"
                                    + "&nbsp&nbsp&nbsp(" + table.getPlaces() + "人左右)" + "</td>");
                        }
                    }
                    out.print("</tr>");
                }
                out.print("</table>");
            }
        %>
        <div id="theDeleteBox" class="deleteTableDiv">
            <form method="post" action="/deletetable">
                <p class="MyTitle">当前可移除的桌子</p>
                <select name="tableSelect">
                    <%
                        for (int i = 0, allTableCount = allTables.size(); i < allTableCount; i++) {
                            int tno = allTables.get(i).getTno();
                            int places = allTables.get(i).getPlaces();
                            if (!TableCheck.hasTheTableInTables(onGoingTables, tno)
                                    && !TableCheck.hasTheTableInBookings(preBookings, tno)) {
                                if (i == 0) {
                                    out.print("<option  selected='selected' value ='" + tno + "'>"
                                            + tno + "（" + places + "人左右）" + "</option>");
                                } else {
                                    out.print("<option  value ='" + tno + "'>"
                                            + tno + "（" + places + "人左右）" + "</option>");
                                }
                            }
                        }
                    %>
                </select>
                <input type="submit" class="button2 red" value="移除">
                <input id="cancelDeleteTheTable" type="button" class="button2 blue" value="取消">
            </form>
        </div>
        <div id="theAddBox" class="addTableDiv">
            <form method="post" action="/addtable_result" onsubmit="return addMyNewTable()">
                <p class="MyTitle3">新增桌子</p>
                <input hidden type="text" value="" name="tno">
                <input hidden type="text" value="" name="capa">
                <%
                    int tableCount = allTables.size();
                    if (0 == tableCount) {
                        out.print("<p class='setCenter MyTitle'>当前系统中没有任何桌号信息</p>");
                    } else {
                        out.print("<p class='setCenter MyTitle3'>已有桌号信息见上</p>");
                    }
                %>
                <table class="setCenter">
                    <tr>
                        <td class="MyTitle3">新增桌号</td>
                        <td><input type="text" name="tableno"
                                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
                                   onblur="this.v();"></td>
                    </tr>
                    <tr>
                        <td class="MyTitle3">大致容纳人数</td>
                        <td><input type="text" name="capacity"
                                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)"
                                   onblur="this.v();"></td>
                    </tr>
                    <tr>
                        <td><input class="button2 orange" type="submit" value="添加"></td>
                        <td><input id="cancelAddTheTable" class="button2 yellow" type="button" value="取消"></td>
                    </tr>
                </table>
            </form>
        </div>
        <form id="table_detail_form" method="post" action="/tabledetail" hidden>
            <input hidden type="text" value="" name="info">
        </form>
    </div>
</div>
</body>
</html>
