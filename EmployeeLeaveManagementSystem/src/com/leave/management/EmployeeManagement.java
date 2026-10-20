package com.leave.management;

import java.sql.*;
import java.util.Scanner;

public class EmployeeManagement {

    public static void registerEmployee(Scanner sc) {

        String name;
        String department;
        String email;
        String phone;

        System.out.print("Enter Employee Name: ");
        name = sc.nextLine().trim();

        System.out.print("Enter Department: ");
        department = sc.nextLine().trim();

        System.out.print("Enter Email: ");
        email = sc.nextLine().trim();

        System.out.print("Enter Phone: ");
        phone = sc.nextLine().trim();

        String employeeQuery =
                "INSERT INTO employees "
                + "(employee_name, department, email, phone) "
                + "VALUES (?, ?, ?, ?)";

        String balanceQuery =
                "INSERT INTO leave_balance (employee_id) VALUES (?)";

        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/employee_leave_db",
                "root",
                "root")) {

            con.setAutoCommit(false);

            try {
                int employeeId;

                try (PreparedStatement ps = con.prepareStatement(
                        employeeQuery,
                        Statement.RETURN_GENERATED_KEYS)) {

                    ps.setString(1, name);
                    ps.setString(2, department);
                    ps.setString(3, email);
                    ps.setString(4, phone);

                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) {
                            throw new SQLException(
                                    "Employee ID could not be generated.");
                        }

                        employeeId = rs.getInt(1);
                    }
                }

                try (PreparedStatement ps2 =
                        con.prepareStatement(balanceQuery)) {

                    ps2.setInt(1, employeeId);
                    ps2.executeUpdate();
                }

                con.commit();

                System.out.println(
                        "Employee registered successfully!");
                System.out.println("Employee ID: " + employeeId);

            } catch (Exception e) {
                con.rollback();
                throw e;
            }

        } catch (Exception e) {
            System.out.println(
                    "Registration failed: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            registerEmployee(sc);
        }
    }
}

