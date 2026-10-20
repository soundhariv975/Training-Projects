package com.leave.management;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Scanner;

public class ApproveRejectLeave {

    public static void approveRejectLeave(Scanner sc) {

        try {
            System.out.print("Enter Leave ID: ");
            int leaveId = Integer.parseInt(sc.nextLine().trim());

            System.out.print("Enter decision (Approve/Reject): ");
            String decision = sc.nextLine().trim();

            if (!decision.equalsIgnoreCase("Approve")
                    && !decision.equalsIgnoreCase("Reject")) {
                System.out.println("Invalid decision! Enter Approve or Reject.");
                return;
            }

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/employee_leave_db",
                    "root",
                    "root")) {

                con.setAutoCommit(false);

                try {
                    int employeeId;
                    LocalDate fromDate;
                    LocalDate toDate;
                    String currentStatus;

                    String query =
                            "SELECT employee_id, from_date, to_date, status "
                            + "FROM leave_requests "
                            + "WHERE leave_id = ? FOR UPDATE";

                    try (PreparedStatement ps = con.prepareStatement(query)) {
                        ps.setInt(1, leaveId);

                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next()) {
                                System.out.println("Leave request not found.");
                                con.rollback();
                                return;
                            }

                            employeeId = rs.getInt("employee_id");
                            fromDate = rs.getDate("from_date").toLocalDate();
                            toDate = rs.getDate("to_date").toLocalDate();
                            currentStatus = rs.getString("status");
                        }
                    }

                    if (!"Pending".equalsIgnoreCase(currentStatus)) {
                        System.out.println(
                                "This request has already been processed.");
                        con.rollback();
                        return;
                    }

                    if (toDate.isBefore(fromDate)) {
                        System.out.println("Invalid leave dates in the request.");
                        con.rollback();
                        return;
                    }

                    if (decision.equalsIgnoreCase("Approve")) {

                        long leaveDays =
                                ChronoUnit.DAYS.between(fromDate, toDate) + 1;

                        String balanceQuery =
                                "SELECT total_leaves, leaves_taken "
                                + "FROM leave_balance "
                                + "WHERE employee_id = ? FOR UPDATE";

                        int totalLeaves;
                        int leavesTaken;

                        try (PreparedStatement ps =
                                con.prepareStatement(balanceQuery)) {
                            ps.setInt(1, employeeId);

                            try (ResultSet rs = ps.executeQuery()) {
                                if (!rs.next()) {
                                    System.out.println("Leave balance not found.");
                                    con.rollback();
                                    return;
                                }

                                totalLeaves = rs.getInt("total_leaves");
                                leavesTaken = rs.getInt("leaves_taken");
                            }
                        }

                        if (leaveDays > totalLeaves - leavesTaken) {
                            System.out.println("Insufficient leave balance.");
                            con.rollback();
                            return;
                        }

                        String updateBalance =
                                "UPDATE leave_balance "
                                + "SET leaves_taken = leaves_taken + ? "
                                + "WHERE employee_id = ?";

                        try (PreparedStatement ps =
                                con.prepareStatement(updateBalance)) {
                            ps.setLong(1, leaveDays);
                            ps.setInt(2, employeeId);
                            ps.executeUpdate();
                        }
                    }

                    String updateStatus =
                            "UPDATE leave_requests "
                            + "SET status = ? "
                            + "WHERE leave_id = ? AND status = 'Pending'";

                    try (PreparedStatement ps =
                            con.prepareStatement(updateStatus)) {
                        ps.setString(1,
                                decision.equalsIgnoreCase("Approve")
                                        ? "Approved" : "Rejected");
                        ps.setInt(2, leaveId);

                        if (ps.executeUpdate() != 1) {
                            throw new SQLException(
                                    "Could not update the leave request.");
                        }
                    }

                    con.commit();

                    System.out.println("Leave request "
                            + (decision.equalsIgnoreCase("Approve")
                                    ? "approved" : "rejected")
                            + " successfully!");

                } catch (Exception e) {
                    con.rollback();
                    throw e;
                }
            }

        } catch (NumberFormatException e) {
            System.out.println("Invalid Leave ID. Enter a number.");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            approveRejectLeave(sc);
        }
    }
}

