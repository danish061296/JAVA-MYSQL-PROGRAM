package com.danish;


import java.util.Scanner;

public class UserMenu {
    public void menuOptions() {
        System.out.println("User Menu");
        System.out.println("1. Create Account ");
        System.out.println("2. Login ");
        System.out.println("3. Search");
        System.out.println("4. Insert ");
        System.out.println("5. Update");
        System.out.println("6. Delete ");
        System.out.println("7. Exit");
        System.out.print("Select one option from the menu: ");
    }

    Account account = new Account();
    Search search = new Search();

    public void displayMenu() {
        int option;
        Scanner input = new Scanner(System.in);

        do {
            menuOptions();
            option = input.nextInt();

            switch (option) {
                case 1:
                    account.createAccount();
                    break;
                case 2:
                    account.userLogin();
                    break;
                case 3:
                    search.searchUser();
                    break;
                case 4:
                    search.insertIntoUserTables();
                    break;
                case 5:
                    search.updateUserTable();
                    break;
                case 6:
                    search.deleteUserTable();
                    break;
                case 7:
                    System.out.println("-----------------------------------------------------");
                    break;
                default:
                    System.out.println("Invalid option! Please select the correct option from the menu above.");
                    System.out.println("");
            }

        } while (option != 7);

        System.out.println("Thank you for interacting with us.");
        System.out.println("See you next time!");
    }

}
