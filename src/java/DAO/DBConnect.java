/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author PC
 */
public class DBConnect {

    private static final String URL = "jdbc:mysql://localhost:3307/cuahangden";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Kết nối MySQL thành công!");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy Driver MySQL: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối CSDL: " + e.getMessage());
        }
        return conn;
    }
}
