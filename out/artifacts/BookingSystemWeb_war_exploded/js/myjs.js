/**
 * Created by mee on 2017/5/10.
 */
function submitMyInfo() {
    var name = document.getElementsByName("cName")[0].value;
    var phone = document.getElementsByName("cPhoneNumber")[0].value;
    if (name == "" || phone == "") {
        alert("请填写完整的信息!");
        return false;
    } else {
        return true;
    }
}
