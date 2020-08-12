package com.danish;

//import com.mysql.cj.MysqlConnection;

import java.io.File;
import java.util.Scanner;

public class Account {
    String name;
    String email;
    String password;
    String last_name;
    int age;
    String gender;
    String phone;

    MySqlConnection con = new MySqlConnection();

    Scanner input = new Scanner(System.in);

    public void createAccount() {
        System.out.println("Please provide the following information.");
        System.out.print("name: ");
        name = input.nextLine();
        System.out.print("last name: ");
        last_name = input.nextLine();
        System.out.print("email: ");
        email = input.nextLine();
        System.out.print("password: ");
        password = input.nextLine();
        System.out.print("age: ");
        age = input.nextInt();
        input.nextLine();
        System.out.print("gender(M/F): ");
        gender = input.nextLine();
        System.out.print("Phone Number: ");
        phone = input.nextLine();

        String query = "INSERT INTO user (name, last_name, email, password, age, gender, phone)" +
                " VALUES (?, ?, ?, ?, ?, ?, ?)";
        con.insertCreateAccount(query, name, last_name, email, password, age, gender, phone);
    }

    public void userLogin() {
        System.out.println("Please provide the login information.");
        System.out.print("email: ");
        email = input.nextLine();
        System.out.print("password: ");
        password = input.nextLine();

        String query = "Select * FROM user WHERE email = ?";
        con.userLoginVerification(query, email, password);

    }
}


