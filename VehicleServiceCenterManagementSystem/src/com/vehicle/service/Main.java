package com.vehicle.service;

import java.util.Scanner;

public class Main {

    public static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {

        int choice;

        do {
            System.out.println("\n===== VEHICLE SERVICE CENTER =====");
            System.out.println("1. Add Customer");
            System.out.println("2. View All Customers");
            System.out.println("3. Add Vehicle");
            System.out.println("4. View All Vehicles");
            System.out.println("5. Book Vehicle Service");
            System.out.println("6. View Service Records");
            System.out.println("7. Update Service Status");
            System.out.println("0. Exit");

            System.out.print("Enter your choice: ");

            while (!sc.hasNextInt()) {
                System.out.println("Invalid input! Enter a number.");
                sc.nextLine();
                System.out.print("Enter your choice: ");
            }

            choice = sc.nextInt();
            sc.nextLine();

            switch (choice) {

                case 1:
                    CustomerManagement.addCustomer();
                    break;

                case 2:
                    CustomerManagement.viewCustomers();
                    break;

                case 3:
                    VehicleManagement.addVehicle();
                    break;

                case 4:
                    VehicleManagement.viewVehicles();
                    break;

                case 5:
                    ServiceManagement.addService();
                    break;

                case 6:
                    ServiceManagement.viewServices();
                    break;

                case 7:
                    ServiceManagement.updateServiceStatus();
                    break;

                case 0:
                    System.out.println(
                        "Thank you for using Vehicle Service Center!"
                    );
                    break;

                default:
                    System.out.println(
                        "Invalid choice! Please try again."
                    );
            }

        } while (choice != 0);

        sc.close();
    }
}
