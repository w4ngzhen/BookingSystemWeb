package entity;

import java.sql.Timestamp;

/**
 * Created by mee on 2017/4/24.
 */
public class Booking {
    private int bid;
    private Timestamp startTime;
    private Timestamp endTime;
    private int tno;
    private String cName;
    private String cPhoneNumber;
    private String status;

    public Object clone() throws CloneNotSupportedException{
        Booking bk = (Booking)super.clone();
        bk.setStartTime((Timestamp)startTime.clone());
        return bk;
    }

    public int getBid() { return bid; }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public int getTno() {
        return tno;
    }

    public void setTno(int tno) {
        this.tno = tno;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public String getcPhoneNumber() {
        return cPhoneNumber;
    }

    public void setcPhoneNumber(String cPhoneNumber) {
        this.cPhoneNumber = cPhoneNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "订单: " + bid
                + " [ " + startTime + " ~ " + endTime +" ] 桌号:" + tno
                + " 客人: " + cName
                + " 电话: " + cPhoneNumber;
    }
}
