
package com.leave.management;

import java.sql.*;

public class ViewLeaveRequests {

    public static void viewLeaveRequests() {

        String sql = "SELECT lr.leave_id, e.employee_id, e.employee_name, " +
                     "lr.from_date, lr.to_date, lr.reason, lr.status " +
                     "FROM leave_requests lr " +
                     "JOIN employees e " +
                     "ON lr.employee_id = e.employee_id " +
                     "ORDER BY lr.leave_id";

        try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/employee_leave_db",
                    "root",
                    "root");
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("\n--- Leave Requests ---");

            boolean found = false;

            while (rs.next()) {
                found = true;

                System.out.println("Leave ID: " +
                                   rs.getInt("leave_id"));
                System.out.println("Employee ID: " +
                                   rs.getInt("employee_id"));
                System.out.println("Employee Name: " +
                                   rs.getString("employee_name"));
                System.out.println("From Date: " +
                                   rs.getDate("from_date"));
                System.out.println("To Date: " +
                                   rs.getDate("to_date"));
                System.out.println("Reason: " +
                                   rs.getString("reason"));
                System.out.println("Status: " +
                                   rs.getString("status"));
                System.out.println("--------------------");
            }

            if (!found) {
                System.out.println("No leave requests found.");
            }

        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        viewLeaveRequests();
    }
}
