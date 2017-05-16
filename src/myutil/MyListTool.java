package myutil;

import entity.Table;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mee on 2017/5/2.
 */
public class MyListTool {
    private static boolean hasSame(List<Table> tl1, Table t) {
        int len1 = tl1.size();
        for (int i = 0; i < len1; i++) {
            if (tl1.get(i).getTno() == t.getTno())
                return true;
        }
        return false;
    }
    public static List<Table> getUnionTableList(List<Table> tl1, List<Table> tl2) {
        int len1 = tl1.size();
        int len2 = tl2.size();
        List<Table> temp = new ArrayList<Table>();
        for (int i = 0; i < len1; i++) {
            if (!hasSame(temp, tl1.get(i))) {
                Table t = new Table();
                t.setTno(tl1.get(i).getTno());
                t.setPlaces(tl1.get(i).getPlaces());
                temp.add(t);
            }
        }
        for (int i = 0; i < len2; i++) {
            if (!hasSame(temp, tl2.get(i))) {
                Table t = new Table();
                t.setTno(tl2.get(i).getTno());
                t.setPlaces(tl2.get(i).getPlaces());
                temp.add(t);
            }
        }
        return temp;
    }
    public static void printTableList(List<Table> tl) {
        for (Table t : tl) {
            System.out.println("tno = " + t.getTno());
        }
        System.out.println();
    }
}
