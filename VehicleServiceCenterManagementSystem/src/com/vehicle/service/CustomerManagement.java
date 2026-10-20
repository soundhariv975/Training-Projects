package com.vehicle.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerManagement {

    public static void addCustomer() {

        System.out.print("Enter Customer Name: ");
        String customerName = Main.sc.nextLine();

        System.out.print("Enter Phone Number: ");
        String phone = Main.sc.nextLine();

        System.out.print("Enter Email: ");
        String email = Main.sc.nextLine();

        System.out.print("Enter Address: ");
        String address = Main.sc.nextLine();

        String sql = "INSERT INTO customers "
                   + "(customer_name, phone, email, address) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, customerName);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Customer registered successfully!");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void viewCustomers() {

        String sql = "SELECT * FROM customers";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            boolean found = false;

            while (rs.next()) {
                found = true;

                System.out.println("\nCustomer ID: "
                        + rs.getInt("customer_id"));
                System.out.println("Customer Name: "
                        + rs.getString("customer_name"));
                System.out.println("Phone Number: "
                        + rs.getString("phone"));
                System.out.println("Email: "
                        + rs.getString("email"));
                System.out.println("Address: "
                        + rs.getString("address"));
                System.out.println("-------------------------");
            }

            if (!found) {
                System.out.println("No customers found.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
