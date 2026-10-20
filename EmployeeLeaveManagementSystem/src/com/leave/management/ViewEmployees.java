package com.leave.management;

import java.sql.*;

public class ViewEmployees {

    public static void viewEmployees() {

        String sql = "SELECT employee_id, employee_name, email, department, phone " +
                     "FROM employees";

        try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/employee_leave_db",
                    "root",
                    "root");
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("\n--- Employee List ---");

            boolean found = false;

            while (rs.next()) {
                found = true;

                System.out.println("Employee ID: " +
                                   rs.getInt("employee_id"));
                System.out.println("Name: " +
                                   rs.getString("employee_name"));
                System.out.println("Email: " +
                                   rs.getString("email"));
                System.out.println("Department: " +
                                   rs.getString("department"));
                System.out.println("Phone: " +
                                   rs.getString("phone"));
                System.out.println("--------------------");
            }

            if (!found) {
                System.out.println("No employees found.");
            }

        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        viewEmployees();
    }
}
