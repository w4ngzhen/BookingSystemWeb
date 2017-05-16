package DAO;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by mee on 2017/4/24.
 */
public class DatabaseConnection {
    private String driver;
    private String url;
    private String userName;
    private String passwd;
    private Connection connection = null;

    public DatabaseConnection() {
        FileInputStream fin = null;
        Properties pro;
        try {
            String propertiesPath = getClass().getProtectionDomain().getCodeSource().getLocation().getFile()
                    + "/config/database_config.properties";
            fin = new FileInputStream(propertiesPath);
            pro = new Properties();
            pro.load(fin);

            driver = pro.getProperty("driver");
            url = pro.getProperty("url");
            userName = pro.getProperty("userName");
            passwd = pro.getProperty("passwd");

            Class.forName(driver);
            connection = DriverManager.getConnection(url, userName, passwd);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (fin != null)
                    fin.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public void close() {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
