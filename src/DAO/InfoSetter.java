package DAO;

import entity.Booking;
import entity.Table;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by mee on 2017/4/25.
 */
public class InfoSetter {
    public static boolean addTable(Table table) {
        String sql = "INSERT INTO bstable (tno, places) VALUES (?, ?)";
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setInt(1, table.getTno());
            ps.setInt(2, table.getPlaces());
            if (ps.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                dbc.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean deleteBookingByBid(int bid) {
        String sql = "DELETE FROM bsbooking WHERE bid = ?";
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setInt(1, bid);
            if (ps.executeUpdate() > 0)
                return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                dbc.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean setRepastByBid(int bid) {
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        String sql = "UPDATE bsbooking SET bsbooking.status = 'ing' WHERE bid = ? AND bsbooking.status = 'pre' ";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setInt(1, bid);
            if (ps.executeUpdate() > 0)
                return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                dbc.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean checkoutByTno(int tno) {
        boolean flag = false, flag2 = false;
        Booking booking = null;
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bsbooking WHERE tno = ? AND bsbooking.status = 'ing'";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setInt(1, tno);
            rs = ps.executeQuery();
            while (rs.next()) {
                booking = new Booking();
                booking.setBid(rs.getInt("bid"));
                booking.setStartTime(rs.getTimestamp("startTime"));
                booking.setEndTime(rs.getTimestamp("endTime"));
                booking.setTno(rs.getInt("tno"));
                booking.setcName(rs.getString("cName"));
                booking.setcPhoneNumber(rs.getString("cPhoneNumber"));
                booking.setStatus("ed");
            }

            if (booking == null || booking.getBid() <= 0) {
                System.out.println("记录未找到");
                return false;
            } else {
                System.out.println("记录找到: " + booking);
            }

            if (ps != null)
                ps.close();
            if (rs != null)
                rs.close();
            String sql2 = "DELETE FROM bsbooking WHERE bid = ?";
            ps = dbc.getConnection().prepareStatement(sql2);
            ps.setInt(1, booking.getBid());
            int i = ps.executeUpdate();

            if (i > 0) {
                flag = true;
                System.out.println("删除成功");
            } else {
                System.out.println("删除失败");
            }

            if (ps != null)
                ps.close();
            String sql3 = "INSERT INTO bookingrecord (bid, startTime, endTime, tno, cName, cPhoneNumber)" +
                    " VALUES (?, ?, ?, ?, ?, ?)";
            ps = dbc.getConnection().prepareStatement(sql3);
            ps.setInt(1, booking.getBid());
            ps.setString(2, booking.getStartTime().toString());
            ps.setString(3, booking.getEndTime().toString());
            ps.setInt(4, booking.getTno());
            ps.setString(5, booking.getcName());
            ps.setString(6, booking.getcPhoneNumber());
            int j = ps.executeUpdate();
            if (j > 0) {
                flag2 = true;
                System.out.println("历史记录添加成功");
            } else {
                System.out.println("历史记录添加失败");
            }
            if (ps != null)
                ps.close();
            return flag && flag2;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                if (rs != null)
                    rs.close();
                dbc.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean transferTableSuccess(int bid, int tno) {
        boolean flag = false;
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        String sql = "UPDATE bsbooking SET tno = ? WHERE bid = ? ";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setInt(1, tno);
            ps.setInt(2, bid);
            if (ps.executeUpdate() > 0)
                return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                dbc.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return flag;
    }

    public static boolean addBookingSuccess(Booking booking) {
        DatabaseConnection dbc = new DatabaseConnection();
        String sql = "INSERT INTO bsbooking " +
                "(bid, startTime, endTime,tno, cName, cPhoneNumber, bsbooking.status) " +
                "VALUES " +
                "(NULL, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = null;
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setString(1, booking.getStartTime().toString());
            ps.setString(2, booking.getEndTime().toString());
            ps.setInt(3, booking.getTno());
            ps.setString(4, booking.getcName());
            ps.setString(5, booking.getcPhoneNumber());
            ps.setString(6, booking.getStatus());
            if (ps.executeUpdate() != 0)
                return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                dbc.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
