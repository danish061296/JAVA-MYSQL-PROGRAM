package com.danish;

import java.util.Scanner;

public class Search {
    MySqlConnection con = new MySqlConnection();
    Scanner input = new Scanner(System.in);


    public void searchUser() {
        printUserTables();
        String[] userTables = new String[]{"user", "family", "address", "hotel", "service", "checkInOut", "breakfastMenu", "lunchMenu", "dinnerMenu", "cuisineCategory", "event", "transportation", "transportationType",
                "carCompany", "concert", "hotelOwner", "billingInfo", "restaurant", "game"};

        con.searchTable(userTables);
    }

    public void searchBusiness() {
        printBusinessTables();
        String[] businessTables = new String[]{"businessPerson", "businessCompany", "transportation", "transportationType"};
        con.searchTable(businessTables);

    }

    public void searchOwner() {
        printUserTables();
        System.out.println("employee\n" + "manager\n" + "businessPerson\n" + "businessCompany\n");
        String[] ownerTables = new String[]{"user", "address", "hotel", "service", "breakfastMenu", "lunchMenu", "dinnerMenu", "cuisineCategory", "event", "transportation", "transportationType",
                "carCompany", "concert", "hotelOwner", "billingInfo", "restaurant", "game", "employee", "businessPerson", "businessCompany", "businessMeeting"};
        con.searchTable(ownerTables);
    }

    public void printUserTables() {
        System.out.println("user\n" + "family\n" + "hotel\n" + "address\n" + "paymentType\n" + "breakfastMenu\n" +
                "lunchMenu\n" + "dinnerMenu\n" + "service\n" + "cuisineCategory\n" + "event\n" + "checkInOut\n" +
                "transportation\n" + "transportationType\n" + "carCompany\n" + "concert\n" +
                "hotelOwner\n" + "billingInfo\n" + "restaurant\n" + "game\n");
    }

    public void printBusinessTables() {
        System.out.println("businessPerson\n" + "businessCompany\n" + "address\n" + "transportation\n" + "transportationType\n");
    }


    public void insertIntoUserTables() {

        String[] userTables = new String[]{"family" + "address", "paymentType"};
        System.out.println("Please pick your room: ");
        System.out.print("Enter 1, 2, 3, 4, or 5 for room number: ");
        int room_number = input.nextInt();
        System.out.print("Enter your user_id: ");
        int user_id = input.nextInt();
        input.nextLine();
        String insertCheckInOut = "INSERT INTO checkInOut (room_id, user_id) VALUES (?,?)";
        con.insertIntoCheckInOut(insertCheckInOut, room_number, user_id);
        System.out.println("Tables: ");
        System.out.println("family\n" + "address\n" + "paymentType\n");
        con.insertIntoTables(userTables);
    }

    public void insertIntoBusinessTables() {
        System.out.println("Tables: ");
        System.out.println("businessPerson\n" + "address\n");

        String[] businessTables = new String[]{"businessPerson", "address"};
        con.insertIntoTables(businessTables);

    }

    public void insertIntoOwnerTables() {
        System.out.println("Tables: ");
        System.out.println("user\n" + "owner\n" + "hotel\n" + "room\n" + "employee\n" + "accountType\n" + "service\n" +
                "event\n" + "cuisine\n" + "cuisineCategory\n" + "restaurant\n" +
                "game\n" + "manager\n");

        String[] ownerTables = new String[]{"user", "hotel", "owner", "room", "employee", "accountType",
                "service", "event", "cuisine", "cuisineCategory", "restaurant",
                "game", "manager"};
        con.insertIntoTables(ownerTables);
    }

    public void updateUserTable() {
        System.out.println("Tables: ");
        System.out.println("family\n" + "checkInOut\n");
        String[] userTables = new String[]{"family", "address", "checkInOut"};
        con.updateTables(userTables);
    }

    public void updateBusinessTable() {
        System.out.println("Tables: ");
        System.out.println("businessPerson\n");
        String[] businessTables = new String[]{"businessPerson", "address"};
        con.updateTables(businessTables);
    }

    public void updateOwnerTable() {
        System.out.println("Tables: ");
        System.out.println("user\n" + "hotel\n" + "owner\n" + "room\n" + "employee\n" + "accountType\n" + "service\n" +
                "event\n" + "cuisine\n" + "cuisineCategory\n" + "restaurant\n" +
                "game\n" + "manager\n");
        String[] ownerTables = new String[]{"user", "hotel", "owner", "room", "employee", "accountType",
                "service", "event", "cuisine", "cuisineCategory", "restaurant",
                "game", "manager"};
        con.updateTables(ownerTables);
    }

    public void deleteUserTable() {
        System.out.println("Tables: ");
        System.out.println("family\n" + "paymentType\n" + "checkInOut\n");
        String[] userTables = new String[]{"family", "paymentType", "checkInOut"};
        con.deleteTables(userTables);
    }

    public void deleteBusinessTable() {
        System.out.println("Tables: ");
        System.out.println("businessPerson\n");
        String[] businessTables = new String[]{"businessPerson"};
        con.deleteTables(businessTables);
    }

    public void deleteOwnerTable() {
        System.out.println("Tables: ");
        System.out.println("user\n" + "hotel\n" + "owner\n" + "room\n" + "employee\n" + "accountType\n" + "service\n" +
                "event\n" + "cuisine\n" + "cuisineCategory\n" + "restaurant\n" +
                "game\n" + "manager\n");
        String[] ownerTables = new String[]{"user", "hotel", "owner", "room", "employee", "accountType",
                "service", "event", "cuisine", "cuisineCategory", "restaurant",
                "game", "manager"};
        con.deleteTables(ownerTables);
    }

}
