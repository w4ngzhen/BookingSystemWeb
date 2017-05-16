/**
 * Created by mee on 2017/5/8.
 */
function timeConfirm(timeLocal) {
    var x = timeLocal.value;
    var year = x.substring(0,4);
    var month = x.substring(5,7);
    var day = x.substring(8,10);
    var hour = x.substring(11,13);
    var minute = x.substring(14);
    var time2 = document.getElementsByName("endTimeSelect")[0];
    if (year == "" || month == "" || day == "" || hour == "" || minute == "") {
        alert("请选择一个完整时间");
        time2.disabled = true;
        timeLocal.value = "    -  -T  :  ";
    } else if (parseInt(hour) < 18 || parseInt(hour) >= 23) {
        alert("请选择18:00到23:00的时间");
        time2.disabled = true;
        timeLocal.value = "    -  -T  :  ";
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
        timeLocal2.value = "    -  -T  :  ";
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
    for (var i = 0; i< selects.length; i++) {
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
