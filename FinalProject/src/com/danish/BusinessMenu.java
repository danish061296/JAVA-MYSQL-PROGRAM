package com.danish;

import java.util.Scanner;

public class BusinessMenu {

    public void menuOptions() {
        System.out.println("Business Menu");
        System.out.println("1. Search");
        System.out.println("2. Insert ");
        System.out.println("3. Update");
        System.out.println("4. Delete ");
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
                    search.searchBusiness();
                    break;
                case 2:
                    search.insertIntoBusinessTables();
                    break;
                case 3:
                    search.updateBusinessTable();
                    break;
                case 4:
                    search.deleteBusinessTable();
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
