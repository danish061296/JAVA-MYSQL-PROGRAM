package com.danish;


import javax.swing.plaf.metal.MetalBorders;
import java.awt.*;
import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConnection {

    //SQL Operations
    int DROP_DATABASE;
    int DROP_TABLE;
    int CREATE_DATABASE;
    String CREATE_TABLE = "CREATE TABLE ";
    String INSERT = "INSERT INTO ";
    String SELECT = "SELECT ";
    String UPDATE = "UPDATE";
    String DELETE = "DELETE";
    int RUN_SCRIPT;

    //Get each property value
    public static String DB_URL;
    public static String DB_TIME;
    public static String DB_USERNAME;
    public static String DB_PASSWORD;
    public static String DATABASE;
    String TRANSACTIONS = "";

    private static Connection connection = null;
    private static Statement st = null;
    private static PreparedStatement ps = null;
    //Most common default queries
    String DROP_DATABASE_QUERY = "DROP DATABASE IF EXISTS ";
    String DROP_TABLE_QUERY = "DROP TABLE IF EXISTS ";
    String CREATE_DATABASE_QUERY = "CREATE DATABASE IF NOT EXISTS ";

    Scanner input = new Scanner(System.in);

    //No argument constructor
    public MySqlConnection() {
    }

    public MySqlConnection(String url, String username, String password, String database, String configFile) throws FileNotFoundException {
        this.DB_URL = url;
        this.DB_USERNAME = username;
        this.DB_PASSWORD = password;
        this.DATABASE = database;
        this.TRANSACTIONS = null;

        if (configFile != null) {
            getMysqlCredentials(configFile);
        }
    }

    //reads mysql credentials from properties file
    public void getMysqlCredentials(String configFile) {
        try {
            Properties props = new Properties();
            InputStream is = new FileInputStream(configFile);
            props.load(is);

            //Get each property value
            DB_URL = props.getProperty("db.url");
            DB_TIME = props.getProperty("db.time");
            DB_USERNAME = props.getProperty("db.username");
            DB_PASSWORD = props.getProperty("db.password");
            DATABASE = props.getProperty("database");
            TRANSACTIONS = props.getProperty("transactions");
        } catch (IOException e) {
//            e.printStackTrace();
            System.out.println("Config file couldn't be read correctly...");
        }
    }

    //makes a connection
    public Connection connect(String database) {
        try {
            if (database != null) {
                this.DATABASE = database;
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(DB_URL + database + DB_TIME, DB_USERNAME, DB_PASSWORD);
                return connection;
            }

        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
            System.out.println("Couldn't connect to mysql server.\n");
        }
        return null;
    }

    //function to write transactions to transaction file
    public static void writeTransaction(String query) throws IOException {

        FileWriter fw = null;
        BufferedWriter bw = null;
        PrintWriter writer = null;

        try {
            fw = new FileWriter("transactions.sql", true);
            bw = new BufferedWriter(fw);
            writer = new PrintWriter(bw);
            writer.println(query);
            System.out.println("Transaction saved Successfully..");
            writer.flush();

        } finally {
            try {
                writer.close();
                bw.close();
                fw.close();
            } catch (IOException e) {
//                e.printStackTrace();
                System.out.println(e);
            }
        }
    }

    //Helper function with base implementation for drop database and drop table functions
    public static void drop(Connection connection, String query) {
        try {
            Statement st = connection.createStatement();
            st.executeUpdate(query);
            System.out.println("Database deleted successfully");

        } catch (SQLException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
        }
    }

    //drops an existing databases
    public void dropDatabase(String database) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(DB_URL + database + DB_TIME, DB_USERNAME, DB_PASSWORD);
        if (database != null) {
            this.DATABASE = database;
            String query = DROP_DATABASE_QUERY + database;
            drop(connection, query);
        }
    }

    //drops a table
    public void dropTable(String table) {
        connection = connect(DATABASE);
        String query = DROP_TABLE_QUERY + table;
        drop(connection, query);
    }

    public boolean createDatabase(String database, boolean dropDatabaseFirst) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL + DB_TIME, DB_USERNAME, DB_PASSWORD);
            if (database == null) {
                database = this.DATABASE;
            }
            if (dropDatabaseFirst == true) {
                dropDatabase(database);
            }
            String query = CREATE_DATABASE_QUERY + database;
            st = connection.createStatement();
            st.executeUpdate(query);
            System.out.println("Database created successfully!");
            return true;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e);
            System.out.println("Please install mysql and run mysql server before" +
                    " executing this program...\n" + "Thank you!");
        }
//        connection.close();
        return false;
    }

    //Helper method executes queries with values to avoid SQL injections
    public ResultSet executeSqlQuery(String query, String values, String action) {
        connection = connect(DATABASE);
        try {
            st = connection.createStatement();
            if (values == null) {
                st.executeQuery(query);
            } else {
                st.executeUpdate(query);
            }
            if (action == SELECT) {
                ResultSet rs = st.executeQuery(query);
                return rs;
            }
            st.close();
        } catch (SQLException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
        }
        return null;
    }

    //gets the queries from sql files
    public void runSqlFile(String sqlFile) {
        String s = new String();
        StringBuffer sb = new StringBuffer();
        try {
            FileReader fr = new FileReader(new File(sqlFile));
            BufferedReader br = new BufferedReader(fr);

            while ((s = br.readLine()) != null) {
                sb.append(s);
            }
            br.close();

            String[] queries = sb.toString().split(";");
            connection = connect(DATABASE);
            if (connection != null) {
                st = connection.createStatement();
                for (int i = 0; i < queries.length; i++) {
                    if (!queries[i].trim().equals("")) {
                        st.executeUpdate(queries[i]);
//                    System.out.println(queries[i]);
                    }
                }
            } else {
                System.out.println("Connection is null.");
            }
            if (sqlFile == "databasemodel.sql") {
                System.out.println("databasemodel.sql executed successfully!");
            } else if (sqlFile == "inserts.sql") {
                System.out.println("inserts.sql executed successfully!");
            } else if (sqlFile == "transactions.sql") {
                System.out.println("transactions.sql executed successfully!");
            } else {
                System.out.println("Some file/s couldn't run.");
            }

        } catch (FileNotFoundException e) {
//            e.printStackTrace();
            System.out.println(e);
        } catch (IOException e) {
//            e.printStackTrace();
            System.out.println(e);
        } catch (SQLException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
        }
    }

    public void createTable(String query, String values) {
        executeSqlQuery(query, values, CREATE_TABLE);
        System.out.println("Created table");
    }

    //Function to create user account
    public void insertCreateAccount(String query, String name, String last_name, String email, String password, int age, String gender, String phone) {

       String hashPassword = hashPassword(password);

        try {
            connection = connect(DATABASE);
            ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, last_name);
            ps.setString(3, email);
            ps.setString(4, hashPassword);
            ps.setInt(5, age);
            ps.setString(6, gender);
            ps.setString(7, phone);
            int affectedRows = ps.executeUpdate();

            String accountQuery = "INSERT INTO user (name, last_name, email, password, age, gender, phone)" +
                    " VALUES " + "(" + "'" + name + "'" + "," + "'" + last_name + "'" + "," + "'" + email + "'" + "," + "'" + hashPassword + "'" + "," + age + "," +
                    "'" + gender + "'" + "," + "'" + phone + "'" + ");";
            if (affectedRows > 0) {
                System.out.println("Account created successfully!");
                System.out.println("");
                writeTransaction(accountQuery);
                ps.close();
            } else {
                System.out.println("Couldn't create an account.\n");

            }

            String selectUserid = "SELECT * FROM user WHERE email = ?";
            PreparedStatement ps1 = connection.prepareStatement(selectUserid);
            ps1.setString(1, email);
            ResultSet rs = ps1.executeQuery();
            int userid = 0;
            if (rs.next()) {
                userid = rs.getInt(1);
                rs.close();
            }
            String selectAccountType = "SELECT * FROM accountType";
            Statement st = connection.createStatement();
            ResultSet rsAccType = st.executeQuery(selectAccountType);
            int accountid = 0;
            if (rsAccType.next()) {
                accountid = rsAccType.getInt(1);
                rsAccType.close();
            }

            String selectRegion = "SELECT * FROM region";
            Statement st1 = connection.createStatement();
            ResultSet rsRegion = st1.executeQuery(selectRegion);
            int regionid = 0;
            if (rsRegion.next()) {
                regionid = rsRegion.getInt(1);
                rsRegion.close();
            }

            String selectPaymentType = "SELECT * FROM paymentType";
            Statement st2 = connection.createStatement();
            ResultSet rsPayment = st2.executeQuery(selectPaymentType);
            int paymentid = 0;
            if (rsPayment.next()) {
                paymentid = rsPayment.getInt(1);
                rsPayment.close();
            }

            Random r = new Random();
            int amount = r.nextInt((700 - 400) + 1) + 400;

            String insertIntoBilling = "INSERT INTO billingInfo (user_id, paymentType_id, amount) VALUES (?,?,?)";
            PreparedStatement ps3 = connection.prepareStatement(insertIntoBilling);
            ps3.setInt(1, userid);
            ps3.setInt(2, paymentid);
            ps3.setInt(3, amount);
            int affrectedRowsBill = ps3.executeUpdate();
            String insertPayment = "INSERT INTO billingInfo (user_id, paymentType_id, amount) VALUES (" + userid + "," + paymentid + "," + amount + ");";
            if (affrectedRowsBill > 0) {
                writeTransaction(insertPayment);
            } else {
                System.out.println("Couldn't insert into payment table.");
            }

            String insertIntoAccount = "INSERT INTO account (user_id, type_id, region_id) VALUES (?,?,?)";
            PreparedStatement ps2 = connection.prepareStatement(insertIntoAccount);
            ps2.setInt(1, userid);
            ps2.setInt(2, accountid);
            ps2.setInt(3, regionid);
            int affrectedRowsAcc = ps2.executeUpdate();
            String insertAccount = "INSERT INTO account (user_id, type_id, region_id) VALUES (" + userid + "," + accountid + "," + regionid + ");";

            if (affrectedRowsAcc > 0) {
                writeTransaction(insertAccount);
            } else {
                System.out.println("Couldn't insert into account table.");
            }


        } catch (SQLException | IOException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
            System.out.println("Email already exists.\n" + "Please create account again with a different email.");
        }
    }

    public String hashPassword(String password) {
        StringBuffer sb = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] b = md.digest();
            sb = new StringBuffer();
            for (byte b1 : b) {
                sb.append(Integer.toHexString(b1 & 0xff).toString());
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }


    //function to get user login info and verify it
    public void userLoginVerification(String query, String email, String password) {
        try {
            connection = connect(DATABASE);
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("You are logged in as " + rs.getString(2));
                System.out.println("Your user id is " + rs.getInt(1) + ".");
                System.out.println("Please remember your id number for future usage of our services.\n" + "Such as searching from family and billingInfo tables\n" + "Thank You..");
                System.out.println("");
            } else {
                System.out.println("Invalid email and/or password..\n");
                System.out.println("");
            }
        } catch (SQLException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
        }
    }

    //function to search values in tables
    public void searchTable(String[] tables) {

        System.out.print("Select a table to search: ");
        String tableName = input.nextLine();

        List<String> tableList = Arrays.asList(tables);
        List<String> columnList = new ArrayList<>();

        System.out.print("Search by (i.e name, user_id)? ");
        String column = input.nextLine();
        System.out.print("Enter value: ");
        String value = input.nextLine();

        if (tableList.contains(tableName) || tableName.equals("family") || tableName.equals("manager")
                || tableName.equals("billingInfo") || tableName.equals("checkInOut")) {
            String selectQuery = "SELECT * FROM " + tableName;

            try {
                connection = connect(DATABASE);
                ps = connection.prepareStatement(selectQuery);
                ResultSet rs = ps.executeQuery();
                ResultSetMetaData rsmd = rs.getMetaData();
                int columnCount = rsmd.getColumnCount();
                for (int i = 1; i <= columnCount; i++) {
                    columnList.add(rsmd.getColumnName(i));
                }

                if (tableName.equals("family") && columnList.contains(column)) {
                    String query = "SELECT user.name , user.email , family.number_of_kids , family.number_of_adults FROM family" +
                            " JOIN user ON user.user_id = family.user_id " +
                            "WHERE family." + column + " = ?";
                    executeSearch(query, tableName, column, value);
                } else if (tableName.equals("manager") && columnList.contains(column)) {
                    String query = "SELECT manager.ssn,  employee.name , employee.role , employee.salary FROM manager" +
                            " JOIN employee ON employee.ssn = manager.ssn " +
                            "WHERE manager." + column + " = ?";
                    executeSearch(query, tableName, column, value);
                } else if (tableName.equals("billingInfo") && columnList.contains(column)) {
                    String query = "SELECT user.name, user.email, paymentType.street, paymentType.city, billingInfo.amount" +
                            " FROM billingInfo" +
                            " JOIN user ON user.user_id = billingInfo.user_id" +
                            " JOIN paymentType on paymentType.paymentType_id = billingInfo.paymentType_id" +
                            " WHERE billingInfo." + column + "= ?";
                    executeSearch(query, tableName, column, value);
                } else if (tableName.equals("checkInOut") && columnList.contains(column)) {
                    String query = "SELECT user.name, user.email, room.room_number, room.price, checkInOut.from" +
                            " FROM checkInOut" +
                            " JOIN user ON user.user_id = checkInOut.user_id" +
                            " JOIN room on room.room_id = checkInOut.room_id" +
                            " WHERE checkInOut." + column + "= ?";
                    System.out.println("Results from table: " + tableName);
                    executeSearch(query, tableName, column, value);
                } else if (!tableName.equals("family") && columnList.contains(column)) {
                    String query = "SELECT * FROM " + tableName + " WHERE " + column + "=?";
                    executeSearch(query, tableName, column, value);
                } else {
                    System.out.println("Unknown column name/s.");
                }
            } catch (SQLException throwables) {
//                throwables.printStackTrace();
                System.out.println(throwables);
            }
        } else {
            System.out.println("Table with this name doesn't exist..\n" + "Please choose the correct table from the menu above.\n" +
                    "Thank you!\n");
        }

    }

    //function to execute search
    public void executeSearch(String query, String tableName, String column, String value) {

        try {
            connection = connect(DATABASE);
            ps = connection.prepareStatement(query);
            ps.setString(1, value);
            ResultSet rs = ps.executeQuery();

            if (tableName.equals("family")) {
                if (rs.next()) {
                    System.out.println("Username: " + rs.getString("name"));
                    System.out.println("Email: " + rs.getString("email"));
                    System.out.println("Kids: " + rs.getString("number_of_kids"));
                    System.out.println("Adults: " + rs.getString("number_of_adults"));
                    System.out.println("");
                } else {
                    System.out.println("No result was found!");
                }
            } else if (tableName.equals("manager")) {
                if (rs.next()) {
                    System.out.println("Manager's name: " + rs.getString("name"));
                    System.out.println("ssn: " + rs.getString("ssn"));
                    System.out.println("role: " + rs.getString("role"));
                    System.out.println("salary: " + rs.getString("salary"));
                    System.out.println("");
                } else {
                    System.out.println("No result was found!");
                }

            } else if (tableName.equals("billingInfo")) {
                if (rs.next()) {
                    System.out.println("Name: " + rs.getString("name"));
                    System.out.println("Email: " + rs.getString("email"));
                    System.out.println("Street: " + rs.getString("street"));
                    System.out.println("City: " + rs.getString("city"));
                    System.out.println("Total Amount: " + rs.getInt("amount"));
                    System.out.println("");
                } else {
                    System.out.println("No result was found!");
                }
            } else if (tableName.equals("checkInOut")) {
                if (rs.next()) {
                    System.out.println("Name: " + rs.getString("name"));
                    System.out.println("Email: " + rs.getString("email"));
                    System.out.println("Room Number: " + rs.getString("room_number"));
                    System.out.println("Room Price: " + rs.getInt("price"));
                    System.out.println("Checkin Time: " + rs.getTimestamp("from"));

                    System.out.println("");
                } else {
                    System.out.println("No result was found for this user!");
                }
            } else {
                if (rs.next()) {
                    System.out.println("id: " + rs.getInt(1));
                    System.out.println(column + ": " + rs.getString(column));
                    System.out.println("");
                }
            }
        } catch (SQLException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
            System.out.println("Couldn't search for values. Please try again!\n");
        }
    }

    //function to insert values into tables
    public void insertIntoTables(String[] tables) {
        System.out.print("Enter a table to insert data: ");
        String tableName = input.nextLine();

        List<String> tableList = Arrays.asList(tables);
        List<String> columnNames = new ArrayList<>();
        List<String> attributeList = new ArrayList<>();

        List<String> columns = new ArrayList<>();
        List<String> valueList = new ArrayList<>();

        String[] attributes;
        String[] values;
        String attribute_str = "";
        String value_str = "";
        try {
            if (tableList.contains(tableName) || tableName.equals("family")) {
                if (tableName.equals("family")) {
                    System.out.print("Enter your user_id: ");
                    int user_id = input.nextInt();
                    System.out.print("Enter number of kids: ");
                    int kids = input.nextInt();
                    System.out.print("Enter number of adults: ");
                    int adults = input.nextInt();
                    input.nextLine();
                    String query = "INSERT INTO family (user_id, number_of_kids, number_of_adults) VALUES (?,?,?)";
                    connection = connect(DATABASE);
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, user_id);
                    ps.setInt(2, kids);
                    ps.setInt(3, adults);
                    int affectedRows = ps.executeUpdate();
                    String insertFamily = "INSERT INTO family (user_id, number_of_kids, number_of_adults) VALUES (" +
                            user_id + "," + kids + "," + adults + ");";
                    if (affectedRows > 0) {
                        System.out.println("Data inserted successfully into " + tableName);
                        System.out.println("");
                        writeTransaction(insertFamily);
                    } else {
                        System.out.println("Data couldn't be inserted");

                    }
                } else {
                    System.out.print("Enter tha name attribute/s separated by comma? ");
                    attribute_str = input.nextLine();
                    System.out.print("Enter the values separated by comma? ");
                    value_str = input.nextLine();

                    if (attribute_str.contains(",")) {
                        attributes = attribute_str.split("[ ,]+");
                        values = value_str.split("[ ,]+");
                        columns = Arrays.asList(attributes);
                        valueList = Arrays.asList(values);
                    } else {
                        columns.add(attribute_str);
                        valueList.add(value_str);
                    }

                    if (valueList.size() != columns.size()) {

                        System.out.println("Please enter equal number of values.");

                    } else {
                        String selectQuery = "SELECT * FROM " + tableName;

                        try {
                            connection = connect(DATABASE);
                            ps = connection.prepareStatement(selectQuery);
                            ResultSet rs = ps.executeQuery();
                            ResultSetMetaData rsmd = rs.getMetaData();
                            int columnCount = rsmd.getColumnCount();
                            for (int i = 1; i <= columnCount; i++) {
                                columnNames.add(rsmd.getColumnName(i));
                            }
                        } catch (SQLException throwables) {
//                            throwables.printStackTrace();
                            System.out.println(throwables);
                        }

                        StringBuilder sbString = new StringBuilder("");

                        for (int i = 0; i < columns.size(); i++) {
                            if (columnNames.contains(columns.get(i))) {
                                attributeList.add(columns.get(i));
                            } else {
                                System.out.println("Incorrect attribute name/s.");
                            }
                        }

                        for (int i = 0; i < columns.size(); i++) {
                            sbString.append("?").append(",");
                        }


                        String wildcards = sbString.toString();

                        if (wildcards.length() > 0) {
                            wildcards = wildcards.substring(0, wildcards.length() - 1);
                        }

                        StringBuilder sb = new StringBuilder("");
                        for (String str : attributeList) {
                            sb.append(str).append(",");
                        }

                        String oneAttribute = sb.toString();

                        if (oneAttribute.length() > 0) {
                            oneAttribute = oneAttribute.substring(0, oneAttribute.length() - 1);
                        }

                        executeInsert(tableName, oneAttribute, valueList, wildcards);

                    }
                }
            } else {
                System.out.println("Table doesn't exist\n" + "Please enter correct table name.\n");
            }


        } catch (Exception e) {
//            e.printStackTrace();
            System.out.println("Table doesn't exist\n" + "Please enter correct table name.");
        }

    }

    //function to execute insert
    public void executeInsert(String tableName, String column, List<String> values, String wildcards) {

        try {
            String insertQuery = String.format("INSERT INTO %1$s (%2$s) VALUES (%3$s)", tableName, column, wildcards);

            System.out.println(values);
            connection = connect(DATABASE);
            ps = connection.prepareStatement(insertQuery);
            int count = 1;

            for (int i = 0; i < values.size(); i++) {
                ps.setString(count++, values.get(i));
//                System.out.println("values: " + count++ + values.get(i));

            }

            StringBuilder sb = new StringBuilder("");
            for (String str : values) {
                sb.append("'").append(str).append("'").append(",");
            }

            String value = sb.toString();

            if (value.length() > 0) {
                value = value.substring(0, value.length() - 1);
            }


            int affectedRows = ps.executeUpdate();
            String insertTable = "INSERT INTO " + tableName + " (" + column + ") VALUES (" + value + ");";
            if (affectedRows > 0) {
                System.out.println("Data inserted successfully into " + tableName);
                System.out.println("");
                writeTransaction(insertTable);
            } else {
                System.out.println("Data couldn't be inserted");

            }
        } catch (SQLException | IOException throwables) {
//            throwables.printStackTrace();
            System.out.println(throwables);
        }
    }

    //function to let the user check in to room
    public void insertIntoCheckInOut(String query, int roomid, int userid) {
        try {
            connection = connect(DATABASE);
            ps = connection.prepareStatement(query);
            ps.setInt(1, roomid);
            ps.setInt(2, userid);
            int affectedRows = ps.executeUpdate();
            String insertFamily = "INSERT INTO checkInOut (room_id, user_id) VALUES (" +
                    roomid + "," + userid + ");";
            if (affectedRows > 0) {
                System.out.println("A room has been checkedIn under your name.");
                System.out.println("To see your room details please go back to search option and search for" +
                        "table CheckInOut using your user_id.\n" + "Otherwise continue inserting into tables.");
                System.out.println("");
                writeTransaction(insertFamily);
            } else {
                System.out.println("Data couldn't be inserted");
            }
        } catch (SQLException throwables) {
//       throwables.printStackTrace();
            System.out.println(throwables);
        } catch (IOException e) {
//       e.printStackTrace();
            System.out.println(e);
        }
    }

    //function to update values in tables
    public void updateTables(String[] tables) {
        System.out.print("Table to update: ");
        String tableName = input.nextLine();

        List<String> tableList = Arrays.asList(tables);
        List<String> columnNames = new ArrayList<>();
        ArrayList<String> attributes = new ArrayList<>();

        try {
            if (tableList.contains(tableName)) {
                System.out.print("SET attribute: ");
                String setAttribute = input.nextLine();
                System.out.print("New value: ");
                String newValue = input.nextLine();
                System.out.print("WHERE attribute: ");
                String whereAttribute = input.nextLine();
                System.out.print("Old value: ");
                String oldValue = input.nextLine();

                String selectQuery = "SELECT * FROM " + tableName;
                try {
                    connection = connect(DATABASE);
                    ps = connection.prepareStatement(selectQuery);
                    ResultSet rs = ps.executeQuery();
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int columnCount = rsmd.getColumnCount();
                    for (int i = 1; i <= columnCount; i++) {
                        columnNames.add(rsmd.getColumnName(i));
                    }

                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                    System.out.println(throwables);
                }

                for (int i = 0; i < columnNames.size(); i++) {
                    if (columnNames.contains(setAttribute) && columnNames.contains(whereAttribute)) {
                        attributes.add(setAttribute);
                        attributes.add(whereAttribute);
                    } else {
                        System.out.println("Incorrect attribute name/s.");
                    }
                }

                if (attributes.contains(setAttribute) && attributes.contains(whereAttribute)) {
                    executeUpdate(tableName, attributes, newValue, oldValue);
                } else {
                    System.out.println("Unknown attributes. Please enter correct attribute name/s.\n");
                }

            } else {
                System.out.println("Table doesn't exist Please enter correct table name.\n");
            }

        } catch (Exception e) {
//            e.printStackTrace();
            System.out.println(e);
            System.out.println("Table doesn't exist. Please enter correct attribute name/s.");
        }

    }

    //function to execute update
    public void executeUpdate(String tableName, ArrayList<String> attributes, String newValue, String oldValue) {
        System.out.println("TableName " + tableName);

        String setAttribute = attributes.get(0);
        String whereAttribute = attributes.get(1);



        if (setAttribute == null || whereAttribute == null) {
            System.out.println("Please write correct attribute name/s");
        } else {
            try {
                String updateQuery = String.format("UPDATE %1$s SET %2$s = ? WHERE %3$s = ?", tableName, setAttribute, whereAttribute);
                connection = connect(DATABASE);
                ps = connection.prepareStatement(updateQuery);
                ps.setString(1, newValue);
                ps.setString(2, oldValue);

                int affectedRows = ps.executeUpdate();
                String updateTable = "UPDATE " + tableName + " SET " + setAttribute + " = " + "'" + newValue + "'" + " WHERE " + whereAttribute + " = " + "'" + oldValue + "'" + ";";
                if (affectedRows > 0) {
                    System.out.println("Data updated successfully in " + tableName);
                    System.out.println("");
                    writeTransaction(updateTable);
                } else {
                    System.out.println("Data couldn't be updated");
                }

            } catch (SQLException | IOException throwables) {
//                throwables.printStackTrace();
                System.out.println(throwables);
            }

        }
    }

    //function to delete values in tables
    public void deleteTables(String[] tables) {
        System.out.print("Table to delete from: ");
        String tableName = input.nextLine();

        List<String> tableList = Arrays.asList(tables);
        List<String> columnNames = new ArrayList<>();
        ArrayList<String> attributes = new ArrayList<>();

        try {
            if (tableList.contains(tableName)) {
                System.out.print("WHERE attribute: ");
                String whereAttribute = input.nextLine();
                System.out.print("Existing Value: ");
                String value = input.nextLine();

                String selectQuery = "SELECT * FROM " + tableName;
                try {
                    connection = connect(DATABASE);
                    ps = connection.prepareStatement(selectQuery);
                    ResultSet rs = ps.executeQuery();
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int columnCount = rsmd.getColumnCount();
                    for (int i = 1; i <= columnCount; i++) {
                        columnNames.add(rsmd.getColumnName(i));
                    }

                } catch (SQLException throwables) {
//                    throwables.printStackTrace();
                    System.out.println(throwables);
                }

                for (int i = 0; i < columnNames.size(); i++) {
                    if (columnNames.contains(whereAttribute)) {
                        attributes.add(whereAttribute);
                    } else {
                        System.out.println("Incorrect attribute name/s.");
                    }
                }

                if (attributes.contains(whereAttribute)) {
                    executeDelete(tableName, attributes, value);
                } else {
                    System.out.println("Unknown attributes. Please enter correct attribute name/s.\n");
                }

            } else {
                System.out.println("Table doesn't exist Please enter correct table name.\n");
            }

        } catch (Exception e) {
//            e.printStackTrace();
            System.out.println(e);
            System.out.println("Table doesn't exist. Please enter correct attribute name/s.");
        }

    }

    //function to execute delete
    public void executeDelete(String tableName, ArrayList<String> attributes, String value) {

        String whereAttribute = attributes.get(0);


        if (whereAttribute == null) {
            System.out.println("Please write correct attribute name/s");
        } else {
            try {
                String deleteQuery = String.format("DELETE FROM %1$s WHERE %2$s = ?", tableName, whereAttribute);
                connection = connect(DATABASE);
                ps = connection.prepareStatement(deleteQuery);
                ps.setString(1, value);

                int affectedRows = ps.executeUpdate();
                String deleteTable = "DELETE FROM " + tableName + " WHERE " + whereAttribute + " = " + "'" + value + "'" + ";";
                if (affectedRows > 0) {
                    System.out.println("Data deleted successfully from " + tableName);
                    System.out.println("");
                    writeTransaction(deleteTable);
                } else {
                    System.out.println("Data couldn't be deleted");

                }

            } catch (SQLException | IOException throwables) {
//                throwables.printStackTrace();
                System.out.println(throwables);
            }

        }
    }

    public void select(String query, String values) throws SQLException {

        connection = connect(DATABASE);
        st = connection.createStatement();
        ResultSet rs = st.executeQuery(query);
        while (rs.next()) {
            //Retrieve by column name
            String email = rs.getString("email");
            String name = rs.getString("name");
            String last = rs.getString("last_name");
            String password = rs.getString("password");
//            int age = rs.getInt("age");
//            String gender = rs.getString("gender");
//            String phone = rs.getString("phone");

//            System.out.format("%s, %s, %s, %s, %s, %s\n", email, name, last, age, gender, phone);
//
//            System.out.println("userid:  " + rs.getInt("user_id"));
//            System.out.println("typeid:  " + rs.getInt("type_id"));
//            System.out.println("regionid: " + rs.getInt("region_id"));


//            System.out.println("roomnumber:  " + rs.getString("room_number"));
//            System.out.println("price :  " + rs.getInt("price"));
//            System.out.println("phone:  " + rs.getString("phone"));


            //Display values
            System.out.println("Email: " + email);
            System.out.println(", First Name: " + name);
            System.out.println(", Last Name: " + last);
            System.out.println(", Password: " + password);
//            System.out.print(", age: " + age);
//            System.out.print(", gender: " + gender);
//            System.out.println(", phone: " + phone);

        }
//        ResultSet rs = executeQuery(query,values, SELECT);
//        return rs;
    }
}

