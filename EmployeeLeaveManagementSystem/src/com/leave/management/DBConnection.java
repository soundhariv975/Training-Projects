package com.leave.management;
import java.sql.*;

public class DBConnection {

    public static void main(String[] args) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/employee_leave_db",
                "root",
                "root"
            );

            System.out.println("Connected...");

            con.close();
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }

}


