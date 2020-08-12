package com.danish;


import java.util.Scanner;

public class UserType {
    int option;
    Scanner input = new Scanner(System.in);
    UserMenu user = new UserMenu();
    BusinessMenu business = new BusinessMenu();
    OwnerMenu owner = new OwnerMenu();

    public void userType() {

        do {
            System.out.println("Usertype is required for security purposes.");
            System.out.println("All strong tables will have primary ids such as user -> user_id");
            System.out.println("Please chose an option number from below according to your user type. \n" + "Thank you!");
            System.out.println("User Type: ");
            System.out.println("1. Owner");
            System.out.println("2. Regular User");
            System.out.println("3. Business Person");
            System.out.println("4. End Program");
            System.out.print("Option (1,2,3): ");
            option = input.nextInt();
            input.nextLine();
            System.out.println("");
            switch (option) {
                case 1:
                    owner.displayMenu();
                    break;
                case 2:
                    user.displayMenu();
                    break;
                case 3:
                    business.displayMenu();
                    break;
                case 4:
                    System.out.println("-----------------------------------------------------");
                    break;
                default:
                    System.out.println("Error: Please select the correct option number.\n");
            }
        } while (option != 4);
        System.out.println("Thank you for interacting with us.");
    }
}
