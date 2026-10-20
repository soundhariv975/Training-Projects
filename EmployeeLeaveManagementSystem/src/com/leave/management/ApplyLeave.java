package com.leave.management;

import java.sql.*;
import java.time.LocalDate;
import java.util.Scanner;

public class ApplyLeave {

    public static void applyLeave(Scanner sc) {

        try {
            System.out.print("Enter Employee ID: ");
            int employeeId = Integer.parseInt(sc.nextLine().trim());

            System.out.print("Enter From Date (YYYY-MM-DD): ");
            LocalDate fromDate = LocalDate.parse(sc.nextLine().trim());

            System.out.print("Enter To Date (YYYY-MM-DD): ");
            LocalDate toDate = LocalDate.parse(sc.nextLine().trim());

            if (toDate.isBefore(fromDate)) {
                System.out.println(
                        "Invalid dates! To Date cannot be before From Date.");
                return;
            }

            System.out.print("Enter Reason for Leave: ");
            String reason = sc.nextLine().trim();

            String query =
                    "INSERT INTO leave_requests "
                    + "(employee_id, from_date, to_date, reason) "
                    + "SELECT ?, ?, ?, ? "
                    + "WHERE EXISTS "
                    + "(SELECT 1 FROM employees WHERE employee_id = ?)";

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/employee_leave_db",
                    "root",
                    "root");
                 PreparedStatement ps = con.prepareStatement(query)) {

                ps.setInt(1, employeeId);
                ps.setDate(2, Date.valueOf(fromDate));
                ps.setDate(3, Date.valueOf(toDate));
                ps.setString(4, reason);
                ps.setInt(5, employeeId);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    System.out.println(
                            "Leave request submitted successfully!");
                    System.out.println("Status: Pending");
                } else {
                    System.out.println(
                            "Employee not found! Please check the Employee ID.");
                }
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid Employee ID. Enter a number.");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            applyLeave(sc);
        }
    }
}

