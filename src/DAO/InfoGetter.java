package DAO;

import entity.Booking;
import entity.Table;
import myutil.MyListTool;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


/**
 * Created by mee on 2017/4/24.
 */
public class InfoGetter {
    public static Booking getBookingByBid(int bid) {
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bsbooking WHERE bid = ?";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setString(1, "" + bid);
            rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBid(rs.getInt("bid"));
                booking.setStartTime(rs.getTimestamp("startTime"));
                booking.setEndTime(rs.getTimestamp("endtime"));
                booking.setTno(rs.getInt("tno"));
                booking.setcName(rs.getString("cName"));
                booking.setcPhoneNumber(rs.getString("cPhoneNumber"));
                booking.setStatus(rs.getString("status"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                if (rs != null)
                    rs.close();
                dbc.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public static List<Table> getFreeTableByTime(Timestamp st, Timestamp et) {
        List<Table> temp = new ArrayList<Table>();
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT tno, places " +
                "FROM bstable " +
                "WHERE tno " +
                "NOT IN " +
                "(SELECT tno FROM bsbooking WHERE NOT (? > endTime OR ? < startTime))";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setString(1, st.toString());
            ps.setString(2, et.toString());
            rs = ps.executeQuery();
            while (rs.next()) {
                Table t = new Table();
                t.setTno(rs.getInt("tno"));
                t.setPlaces(rs.getInt("places"));
                temp.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                if (rs != null)
                    rs.close();
                dbc.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return temp;
    }

    public static List<Table> getTablesByStatus(String tableStatus) {
        List<Table> temp = new ArrayList<Table>();
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = null;
        if ("onGoing".equals(tableStatus)) {
            sql = "SELECT tno, places " +
                    "FROM bstable " +
                    "WHERE tno IN " +
                    "(SELECT tno FROM bsbooking WHERE bsbooking.status = 'ing')";
        } else if ("free".equals(tableStatus)) {
            sql = "SELECT tno, places " +
                    "FROM bstable " +
                    "WHERE tno NOT IN " +
                    "(SELECT tno FROM bsbooking WHERE bsbooking.status = 'ing' OR bsbooking.status = 'pre')";
        }
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Table t = new Table();
                t.setTno(rs.getInt("tno"));
                t.setPlaces(rs.getInt("places"));
                temp.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                if (rs != null)
                    rs.close();
                dbc.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return temp;
    }

    public static List<Booking> getBookingsByStatus(String bookingStatus) {
        List<Booking> temp = new ArrayList<Booking>();
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bsbooking WHERE bsbooking.status = ?";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            ps.setString(1, bookingStatus);
            rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBid(rs.getInt("bid"));
                booking.setStartTime(rs.getTimestamp("startTime"));
                booking.setEndTime(rs.getTimestamp("endTime"));
                booking.setTno(rs.getInt("tno"));
                booking.setcName(rs.getString("cName"));
                booking.setcPhoneNumber(rs.getString("cPhoneNumber"));
                booking.setStatus(rs.getString("status"));
                temp.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                if (rs != null)
                    rs.close();
                dbc.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return temp;
    }

    public static List<Table> getAllTable() {
        List<Table> allTables = new ArrayList<Table>();
        DatabaseConnection dbc = new DatabaseConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM bstable";
        try {
            ps = dbc.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Table table = new Table();
                table.setTno(rs.getInt("tno"));
                table.setPlaces(rs.getInt("places"));
                allTables.add(table);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null)
                    ps.close();
                if (rs != null)
                    rs.close();
                dbc.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return allTables;
    }
}
