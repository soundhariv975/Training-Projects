package com.leave.management;

import java.sql.*;
import java.util.Scanner;

public class CheckLeaveBalance {

    public static void checkLeaveBalance(Scanner sc) {
        try {
            System.out.print("Enter Employee ID: ");
            int employeeId = Integer.parseInt(sc.nextLine().trim());

            String sql = "SELECT e.employee_id, e.employee_name, " +
                         "lb.total_leaves, lb.leaves_taken, " +
                         "(lb.total_leaves - lb.leaves_taken) AS remaining_leaves " +
                         "FROM employees e " +
                         "JOIN leave_balance lb " +
                         "ON e.employee_id = lb.employee_id " +
                         "WHERE e.employee_id = ?";

            try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/employee_leave_db",
                        "root",
                        "root");
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, employeeId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        System.out.println("\n--- Leave Balance ---");
                        System.out.println("Employee ID: " +
                                           rs.getInt("employee_id"));
                        System.out.println("Employee Name: " +
                                           rs.getString("employee_name"));
                        System.out.println("Total Leaves: " +
                                           rs.getInt("total_leaves"));
                        System.out.println("Leaves Taken: " +
                                           rs.getInt("leaves_taken"));
                        System.out.println("Remaining Leaves: " +
                                           rs.getInt("remaining_leaves"));
                    } else {
                        System.out.println(
                            "Employee not found or leave balance is unavailable."
                        );
                    }
                }
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid Employee ID. Enter a number.");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            checkLeaveBalance(sc);
        }
    }
}
