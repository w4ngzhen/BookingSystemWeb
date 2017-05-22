<%@ page import="entity.Booking" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: mee
  Date: 2017/5/18
  Time: 09:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="entity.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%
    int tno = (int) request.getAttribute("tno");
    int places = (int) request.getAttribute("places");
    String currentStatus = (String) request.getAttribute("currentStatus");
    List<Booking> relatedBookings = (List<Booking>) request.getAttribute("relatedBookings");
%>
<html>
<head>
    <title><%= tno %>  号桌 [ <%= currentStatus %> ]</title>
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
            var time2 = document.getElementsByName("endTime")[0];
            if (year == "" || month == "" || day == "" || hour == "" || minute == "") {
                alert("请选择一个完整时间");
                time2.disabled = true;
                timeLocal.value = "";
            } else if (parseInt(hour) < startTimeSetting || parseInt(hour) >= endTimeSelectSetting) {
                alert("请选择" + startTimeSetting + ":00到" + endTimeSelectSetting + ":00的时间");
                time2.disabled = true;
                timeLocal.value = "";
            } else if (year != cY || month != cM || day != cD) {
                alert("请选择今日时间！");
                time2.disabled = true;
            } else {
                time2.disabled = false;
            }
        }
        function timeConfirm2(timeLocal2) {
            timeConfirm(timeLocal2);
            var st = document.getElementsByName("startTime")[0].value;
            var et = timeLocal2.value;
            if (et <= st) {
                alert("请选择晚于开始时间的正确时间");
                timeLocal2.value = "";
            }
        }
        var relatedBookings = new Array();
        <%
            for (int i = 0, count = relatedBookings.size(); i < count; i++) {
                out.print("var booking" + i + " = new Object();");
                out.print("booking" + i + ".bid = '" + relatedBookings.get(i).getBid() + "';");
                out.print("booking" + i + ".startTime = '" + relatedBookings.get(i).getStartTime() + "';");
                out.print("booking" + i + ".endTime = '" + relatedBookings.get(i).getEndTime() + "';");
                out.print("booking" + i + ".cName = '" + relatedBookings.get(i).getcName() + "';");
                out.print("booking" + i + ".cPhoneNumber = '" + relatedBookings.get(i).getcPhoneNumber() + "';");
                out.print("booking" + i + ".status = '" + relatedBookings.get(i).getStatus() + "';");
                out.print("relatedBookings[" + i + "]= booking" + i + ";");
            }
        %>
        function getPoint(booking) {
            var sh = booking.startTime.substring(11, 13);
            var smin = booking.startTime.substring(14, 16);
            var eh = booking.endTime.substring(11, 13);
            var emin = booking.endTime.substring(14, 16);
            var point = new Object();
            point.startPos = (sh - startTimeSetting) * 60 + parseInt(smin);
            point.endPos = (eh - startTimeSetting) * 60 + parseInt(emin);
            return point;
        }
        function getLittleTime(time) {
            return time.substring(11, 13) + " : " + time.substring(14, 16) + " : " + time.substring(17, 19);
        }
        function fillCanvas() {
            var c = document.getElementById("timebar");
            var ctx = c.getContext("2d");
            ctx.fillStyle = "#99FF00";
            ctx.fillRect(0, 0, 600, 20);
            ctx.lineWidth = 1;
            var points = new Array();
            for (var i = 0; i < relatedBookings.length; i++) {
                points[i] = getPoint(relatedBookings[i]);
            }
            for (var i = 0; i < points.length; i++) {
                if (relatedBookings[i].status == "ing") {
                    ctx.fillStyle = "#FF0000";
                } else {
                    ctx.fillStyle = "#FFCC00";
                }
                var sp = points[i].startPos * 2;
                var ep = points[i].endPos * 2;
                ctx.fillRect(sp, 0, ep - sp, 20);
                ctx.strokeRect(sp, 0, ep - sp, 20);
                ctx.lineWidth = 1;
            }
            function getMousePos(canvas, evt) {
                var rect = canvas.getBoundingClientRect();
                return {
                    x: evt.clientX - rect.left,
                    y: evt.clientY - rect.top
                };
            }

            function getTheTimeSlot(xPos) {
                for (var i = 0; i < points.length; i++) {
                    if ((points[i].startPos * 2 < xPos) && (xPos < points[i].endPos * 2)) {
                        return i;
                    }
                }
                return -1;
            }

            c.addEventListener("mouseover", function (evt) {
                var mousePos = getMousePos(c, evt);
                var bookingIndex = getTheTimeSlot(mousePos.x);
                if (bookingIndex == -1) {
                    document.getElementsByName("showTimeInfo")[0].innerHTML = "时间段空闲";
                } else {
                    var content = "时间段: " + getLittleTime(relatedBookings[bookingIndex].startTime)
                        + " 到 " + getLittleTime(relatedBookings[bookingIndex].endTime);
                    document.getElementsByName("showTimeInfo")[0].innerHTML = content;
                }
            }, false);
            c.addEventListener("mousemove", function (evt) {
                var mousePos = getMousePos(c, evt);
                var bookingIndex = getTheTimeSlot(mousePos.x);
                if (bookingIndex == -1) {
                    document.getElementsByName("showTimeInfo")[0].innerHTML = "时间段空闲";
                } else {
                    var content = "时间段: " + getLittleTime(relatedBookings[bookingIndex].startTime)
                        + " 到 " + getLittleTime(relatedBookings[bookingIndex].endTime);
                    document.getElementsByName("showTimeInfo")[0].innerHTML = content;
                }
            }, false);

            c.addEventListener("mouseout", function () {
                document.getElementsByName("showTimeInfo")[0].innerHTML = "鼠标移动到上方时间段显示具体时间";
            }, false);

        }
        function setTimeNote() {
            var c = document.getElementById("timeNote");
            var ctx = c.getContext("2d");
            ctx.moveTo(0, 20);
            ctx.lineTo(600, 20);
            ctx.stroke();
            for (var i = 0; i < 10; i++) {
                ctx.moveTo(i * 60, 20);
                if (i % 2 == 0) {
                    ctx.lineTo(i * 60, 10);
                    ctx.fillText((i / 2 + 18) + ":00", i * 60, 10);
                } else {
                    ctx.lineTo(i * 60, 25);
                    ctx.fillText(":30", i * 60, 35);
                }
                ctx.stroke();
            }
            ctx.moveTo(600, 20);
            ctx.lineTo(600, 10);
            ctx.stroke();
            ctx.fillText("23:00", 565, 10)
        }
        window.onload = function () {
            fillCanvas();
            setTimeNote();
        };
        function convertIntoTimestamp(time, status) {
            if (time != null) {
                var year = time.substring(0, 4);
                var month = time.substring(5, 7);
                var day = time.substring(8, 10);
                var hour = time.substring(11, 13);
                var minute = time.substring(14, 16);
                if ("start" == status) {
                    return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":30";
                } else if ("end" == status) {
                    return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":00";
                }
            }
            return null;
        }
        function overlap() {
            var myst = convertIntoTimestamp(document.getElementsByName("startTime")[0].value, "start");
            var myet = convertIntoTimestamp(document.getElementsByName("endTime")[0].value, "end");
            for (var i = 0; i < relatedBookings.length; i++) {
                if (myst > relatedBookings[i].endTime || myet < relatedBookings[i].startTime) {
                    continue;
                } else {
                    return true;
                }
            }
            return false;
        }

        function infoComplete() {
            var st = document.getElementsByName("startTime")[0].value;
            var et = document.getElementsByName("endTime")[0].value;
            var name = document.getElementsByName("cName")[0].value;
            var phone = document.getElementsByName("cPhoneNumber")[0].value;
            if (st == "" || et == "" || name == "" || phone == "") {
                return false;
            } else {
                return true;
            }
        }
        function checkInfo() {
            if (!infoComplete()) {
                alert("所填信息不够完整！");
                return false;
            } else if (overlap()) {
                alert("所选时间与其他预定有重复");
                return false;
            } else {
                return true;
            }
        }
    </script>
</head>
<body>
<div id="timeDiv">
    <%
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH) + 1;
        int day = now.get(Calendar.DAY_OF_MONTH);
    %>
    <p class="MyTitle">当前日期:<%= " " + year + " 年 " + month + " 月 " + day + "日"%>
    </p>
    <table class="setCenter">
        <tr>
            <td>
                <canvas id="timeNote" width="600" height="40"></canvas>
            </td>
        </tr>
        <tr>
            <td>
                <canvas id="timebar" width="600" height="20"
                        style="border: solid black"></canvas>
            </td>
        </tr>
        <tr>
            <td name="showTimeInfo" style="border: solid black; height: 30px; text-align: center">
                鼠标移动到上方时间段显示具体时间
            </td>
        </tr>
    </table>
</div>
<div id="buttonDiv">
    <form method="post" action="checkout">
        <%= "<input hidden name='checkouttable' value='onGoingTable_" + tno + "'>" %>
        <table>
            <tr>
                <%
                    if ("正就餐".equals(currentStatus)) {
                        out.print("<input type='submit' class='button2 red' value='当前就餐餐桌结账'>");
                    }
                %>
            </tr>
        </table>
    </form>
</div>
<div id="add_booking">
    <form method="post" action="submit" onsubmit="return checkInfo()">
        <p class="MyTitle3">预约时间<br/>（请根据上方时间轴选择合适可用的时间）</p>
        <table class="setCenter">
            <tr>
                <td><input type="datetime-local" name="startTime" onblur="timeConfirm(this)"></td>
                <td><p>到</p></td>
                <td><input type="datetime-local" name="endTime" onblur="timeConfirm2(this)"></td>
            </tr>
        </table>
        <p class="MyTitle1"><%= tno %>号桌（可容纳<%= places %>人左右）</p>
        <%= "<input hidden name='tableSelect' value='" + tno + "'>" %>
        <p class="MyTitle3">预定人</p>
        <table class="setCenter yellow">
            <tr>
                <th>姓名</th>
                <th>电话</th>
                <th></th>
                <th></th>
            </tr>
            <tr>
                <td><input type="text" name="cName"></td>
                <td><input type='text' name="cPhoneNumber">
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
