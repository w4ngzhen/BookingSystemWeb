package myutil;

import entity.Booking;
import entity.Table;

import java.util.List;

/**
 * Created by mee on 2017/4/27.
 */
public class TableCheck {
    public static boolean hasTheTableInTables(List<Table> tables, int tno) {
        for (Table t : tables) {
            if (t.getTno() == tno)
                return true;
        }
        return false;
    }
    public static boolean hasTheTableInBookings(List<Booking> bookings, int tno) {
        for (Booking booking : bookings) {
            if (booking.getTno() == tno)
                return true;
        }
        return false;
    }
}
