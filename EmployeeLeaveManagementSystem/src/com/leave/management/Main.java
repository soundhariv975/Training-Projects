package com.leave.management;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        try (Scanner sc = new Scanner(System.in)) {

            boolean running = true;

            while (running) {

                System.out.println("\n===== Employee Leave Management System =====");
                System.out.println("1. Register Employee");
                System.out.println("2. View Employees");
                System.out.println("3. Apply for Leave");
                System.out.println("4. View Leave Requests");
                System.out.println("5. Approve or Reject Leave");
                System.out.println("6. Check Leave Balance");
                System.out.println("7. Exit");

                System.out.print("Enter your choice: ");

                String input = sc.nextLine().trim();
                int choice;

                try {
                    choice = Integer.parseInt(input);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid choice. Please enter a number from 1 to 7.");
                    continue;
                }

                switch (choice) {

                    case 1:
                        EmployeeManagement.registerEmployee(sc);
                        break;

                    case 2:
                        ViewEmployees.viewEmployees();
                        break;

                    case 3:
                        ApplyLeave.applyLeave(sc);
                        break;

                    case 4:
                        ViewLeaveRequests.viewLeaveRequests();
                        break;

                    case 5:
                        ApproveRejectLeave.approveRejectLeave(sc);
                        break;

                    case 6:
                        CheckLeaveBalance.checkLeaveBalance(sc);
                        break;

                    case 7:
                        System.out.println("Thank you for using the system!");
                        running = false;
                        break;

                    default:
                        System.out.println("Invalid choice. Please select 1 to 7.");
                }
            }

        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
        }
    }
}
