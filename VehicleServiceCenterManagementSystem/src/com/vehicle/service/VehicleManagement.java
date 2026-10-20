package com.vehicle.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VehicleManagement {

    public static void addVehicle() {

        System.out.print("Enter Customer ID: ");
        int customerId = Main.sc.nextInt();
        Main.sc.nextLine();

        System.out.print("Enter Vehicle Number: ");
        String vehicleNumber = Main.sc.nextLine();

        System.out.print("Enter Vehicle Model: ");
        String vehicleModel = Main.sc.nextLine();

        System.out.print("Enter Vehicle Type: ");
        String vehicleType = Main.sc.nextLine();

        String sql = "INSERT INTO vehicles "
                   + "(customer_id, vehicle_number, vehicle_model, vehicle_type) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ps.setString(2, vehicleNumber);
            ps.setString(3, vehicleModel);
            ps.setString(4, vehicleType);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Vehicle registered successfully!");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void viewVehicles() {

        String sql = "SELECT v.vehicle_id, c.customer_name, "
                   + "v.vehicle_number, v.vehicle_model, v.vehicle_type "
                   + "FROM vehicles v "
                   + "JOIN customers c ON v.customer_id = c.customer_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            boolean found = false;

            while (rs.next()) {
                found = true;

                System.out.println("\nVehicle ID: "
                        + rs.getInt("vehicle_id"));
                System.out.println("Customer Name: "
                        + rs.getString("customer_name"));
                System.out.println("Vehicle Number: "
                        + rs.getString("vehicle_number"));
                System.out.println("Vehicle Model: "
                        + rs.getString("vehicle_model"));
                System.out.println("Vehicle Type: "
                        + rs.getString("vehicle_type"));
                System.out.println("-------------------------");
            }

            if (!found) {
                System.out.println("No vehicles found.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
