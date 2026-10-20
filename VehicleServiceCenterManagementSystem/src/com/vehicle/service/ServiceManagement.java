
package com.vehicle.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

public class ServiceManagement {

    public static void addService() {

        System.out.print("Enter Vehicle ID: ");
        int vehicleId = Main.sc.nextInt();
        Main.sc.nextLine();

        System.out.print("Enter Service Date (YYYY-MM-DD): ");
        String serviceDate = Main.sc.nextLine();

        System.out.print("Enter Service Type: ");
        String serviceType = Main.sc.nextLine();

        System.out.print("Enter Service Cost: ");
        double serviceCost = Main.sc.nextDouble();
        Main.sc.nextLine();

        String sql = "INSERT INTO service_records "
                   + "(vehicle_id, service_date, service_type, service_cost) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, vehicleId);
            ps.setDate(2, Date.valueOf(serviceDate));
            ps.setString(3, serviceType);
            ps.setDouble(4, serviceCost);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Service booked successfully!");
                System.out.println("Service Status: Pending");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void viewServices() {

        String sql = "SELECT s.service_id, v.vehicle_number, "
                   + "v.vehicle_model, s.service_date, "
                   + "s.service_type, s.service_cost, s.service_status "
                   + "FROM service_records s "
                   + "JOIN vehicles v ON s.vehicle_id = v.vehicle_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            boolean found = false;

            while (rs.next()) {
                found = true;

                System.out.println("\nService ID: "
                        + rs.getInt("service_id"));
                System.out.println("Vehicle Number: "
                        + rs.getString("vehicle_number"));
                System.out.println("Vehicle Model: "
                        + rs.getString("vehicle_model"));
                System.out.println("Service Date: "
                        + rs.getDate("service_date"));
                System.out.println("Service Type: "
                        + rs.getString("service_type"));
                System.out.println("Service Cost: "
                        + rs.getDouble("service_cost"));
                System.out.println("Status: "
                        + rs.getString("service_status"));
                System.out.println("-------------------------");
            }

            if (!found) {
                System.out.println("No service records found.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void updateServiceStatus() {

        System.out.print("Enter Service ID: ");
        int serviceId = Main.sc.nextInt();
        Main.sc.nextLine();

        System.out.println("\nSelect New Service Status:");
        System.out.println("1. Pending");
        System.out.println("2. In Progress");
        System.out.println("3. Completed");

        System.out.print("Enter your choice: ");
        int choice = Main.sc.nextInt();
        Main.sc.nextLine();

        String status;

        switch (choice) {
            case 1:
                status = "Pending";
                break;

            case 2:
                status = "In Progress";
                break;

            case 3:
                status = "Completed";
                break;

            default:
                System.out.println("Invalid status choice!");
                return;
        }

        String sql = "UPDATE service_records "
                   + "SET service_status = ? "
                   + "WHERE service_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, serviceId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println(
                    "Service status updated successfully!"
                );
                System.out.println("New Status: " + status);
            } else {
                System.out.println(
                    "Service ID not found. Please check the ID."
                );
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
