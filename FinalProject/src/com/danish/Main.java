package com.danish;

/*
This is the user interface where the program interacts with the user.
       USAGE:
       1. Go to sqlconfig.properties file and change the username and password
       values to the ones from you are using in your mysql instance
       2. Please make sure you have mysql installed and mysql server is up and running
        before running this program
       3. Make sure to have java version 14 installed and mysql jdbc driver connecter/j should also be connected
       3. Open a terminal, cd into FinalProject folder (the name of the cloned directory):
       cd FinalProject
       4. When you are in FinalProject folder, run the following command:

          java --enable-preview -jar out/artifacts/FinalProject_jar/Final\ Project.jar

 */


import java.io.IOException;
import java.sql.SQLException;


public class Main {
    public static void main(String[] args) throws IOException, SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {

        MySqlConnection con = new MySqlConnection();
        con.getMysqlCredentials("sqlconfig.properties");

//        con.connect("HotelManagementDB");

        String database = "HotelManagementDB";
        if (con.createDatabase(database, true)) {
            System.out.println(database + " database created");

            con.TRANSACTIONS = "0";
        } else {
            con.TRANSACTIONS = "1";
            System.out.println("No connection to MYSQL");
        }

        if (con.TRANSACTIONS.equals("1") && con.createDatabase(database, true)) {
            con.runSqlFile("databasemodel.sql");
            con.runSqlFile("inserts.sql");
            con.runSqlFile("transactions.sql");
            System.out.println("hahaha");
            UserType userType = new UserType();
            userType.userType();
        }
        if(con.TRANSACTIONS.equals("0")) {
            con.runSqlFile("databasemodel.sql");
            con.runSqlFile("inserts.sql");
            con.runSqlFile("transactions.sql");
            System.out.println("");
            UserType userType = new UserType();
            userType.userType();
        }


//
//        String selectQuery = "SELECT * FROM user ";
//       con.select(selectQuery, null);

    }
}
