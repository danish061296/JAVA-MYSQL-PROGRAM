package com.danish;

import java.util.Scanner;

public class OwnerMenu {
    public void menuOptions() {
        System.out.println("Owner Menu");
        System.out.println("1. Search");
        System.out.println("2. Insert");
        System.out.println("3. Update");
        System.out.println("4. Delete");
        System.out.println("5. Exit");
        System.out.print("Select one option from menu: ");
    }

    Search search = new Search();

    public void displayMenu() {
        int option;
        Scanner input = new Scanner(System.in);

        do {
            menuOptions();
            option = input.nextInt();

            switch (option) {
                case 1:
                    search.searchOwner();
                    break;
                case 2:
                    search.insertIntoOwnerTables();
                    break;
                case 3:
                    search.updateOwnerTable();
                    break;
                case 4:
                    search.deleteOwnerTable();
                    break;
                case 5:
                    System.out.println("-----------------------------------------------------");
                    break;
                default:
                    System.out.println("Invalid option! Please select the correct option from the menu above.");
                    System.out.println("");
            }

        } while (option != 5);

        System.out.println("Thank you for interacting with us.");
        System.out.println("See you next time!");
    }


}
