package com.vehicle.service;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/vehicle_service_db",
            "root",
            "root"
        );
    }

    public static void main(String[] args) {

        try {
            Connection con = getConnection();
            System.out.println("Connected...");
            con.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
