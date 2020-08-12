INSERT INTO user (name, last_name, email, password, age, gender, phone) VALUES ('Danish', 'Siddiqui', 'Danish@gmail.com', '1234', 20, 'M', '123-456-7890'), ('Micheal', 'Jackson', 'Michael@gmail.com', '14321', 50, 'M', '123-456-7891'), ('Selena', 'Gomez', 'Selena@gmail.com', 'h134j2', 22, 'F', '123-4567-892'), ('John', 'Roberts', 'John@gmail.com', '34h2j3', 35, 'M', '123-4567-835'), ('Lauren', 'Lopez', 'Lauren@yahoo.com', '9k3hd2', 28, 'F', '345-726-3892');

INSERT INTO family (user_id, number_of_kids, number_of_adults) VALUES (2, 3, 2), (1, 0, 2), (3, 2, 3), (4, 0, 1);

INSERT INTO hotelOwner (name, last_name, phone) VALUES ('Justin', 'Bieber', '3456789012'), ('Ariana', 'Grande', '3456789013'), ('Zain', 'Malik', '3456789014');

INSERT INTO hotel (name, phone, owner_id) VALUES ('Hilton Hotel', '413-537-5894', 2), ('Holiday Inn', '628-894-3952', 1), ('Days Inn', '415-238-4859', 3);

INSERT INTO address (street, city, state, zipcode, country, hotel_id) VALUES ('910 Stockten', 'San Francisco', 'CA', '91009', 'United States', 2), ('111 WaterCress', 'Houston', 'TX', '76021', 'United States', 1), ('525 Douglas', 'Sacramento', 'CA', '87659', 'United States', 3), ('112 California', 'San Leandro', 'CA', '73679', 'United States', null), ('879 Spruce', 'New York', 'NY', '45284', 'United States', null), ('716 Mason', 'Richmond', 'CA', '84425', 'United States', null);

INSERT INTO room (room_number, price) VALUES ('C128', 50), ('B136', 30), ('A68', 45), ('A22', 45), ('C76', 50);

INSERT INTO employee (ssn, name, last_name, role, phone, salary) VALUES (413283942, 'John', 'Cena', 'cheff', '2345678901', 2300), (314283412,'Mark', 'Henry', 'receptionist', '2345678902', 3000), (134412452,'Tom', 'Cruise', 'decorator', '2345678904', 5000);

INSERT INTO region (description) VALUES ('United States'), ('South Africa'), ('New Zealand'), ('Canada'), ('England');

INSERT INTO accountType (description) VALUES ('guest'), ('visitor'), ('staff');

INSERT INTO service (description) VALUES ('room reservation'), ('concert'), ('holiday'), ('birthday party'),
('breakfast'), ('lunch'), ('dinner'), ('gaming'), ('fitness'), ('pool');

INSERT INTO businessPerson (name, last_name, phone) VALUES ('Jack', 'Ryder', '4567890123'), ('Moson', 'Doe', '4567890145'), ('Sara', 'Lee', '4586790124'), ('Mike', 'Hawkins', '8293739203');

INSERT INTO businessCompany (name, established) VALUES ('Apple', 1997), ('Google', 1998), ('Samsung', 1938), ('Amazon', 1994);

INSERT INTO businessMeeting (place, title, businessPerson_id, businessCompany_id) VALUES ('Business Room', 'Tech and Future',4,3), ('Company Room', 'Be a Entreprenuer',2,1), ('Business Room', 'Welcome Graguates',3,3);

INSERT INTO paymentType (street, city, state, zipcode, country) VALUES ('910 Stockten', 'San Francisco', 'CA', '91009', 'United States'), ('111 WaterCress', 'Houston', 'TX', '76021', 'United States'), ('525 Douglas', 'Sacramento', 'CA', '87659', 'United States'), ('879 Spruce', 'New York', 'NY', '45284', 'United States'), ('716 Mason', 'Richmond', 'CA', '84425', 'United States');

INSERT INTO event (description) VALUES ('concert'), ('birthday party'), ('holiday celebration');

INSERT INTO artist (name, last_name) VALUES ('Kanye', 'West'), ('Shawn', 'Mandes'), ('Jannett', 'Jackson');

INSERT INTO holidayType (description) VALUES ('Christmas'), ('Halloween'), ('New Year');

INSERT INTO cuisine (description) VALUES ('breakfast'), ('lunch'), ('dinner');

INSERT INTO cuisineCategory (description) VALUES ('Chinese'), ('American'), ('Italian');

INSERT INTO breakfastMenu (calories, dishName, drink) VALUES ('450cal', 'pancakes', 'coffee'), ('740cal', 'eggs', 'water'), ('862cal', 'shrimps', 'tea');

INSERT INTO lunchMenu (calories, dishName, drink) VALUES ('800cal', 'hamburger', 'sprite'), ('645cal', 'chicken pizza', 'orange juice'), ('320cal', 'shawarma', 'sprite');

INSERT INTO dinnerMenu (calories, dishName, drink) VALUES ('700cal', 'chicken bbq', 'red wine'), ('625cal', 'fish combo', 'coke'), ('290cal', 'pasta', 'dr.pepper');

INSERT INTO restaurant (name) VALUES ('M.Y. China'), ('McDonalds'), ('Napoli Pizza'),('Golden Kim Tar'), ('New Asia Restaurant'),('Pinecrest Diner');

INSERT INTO sectionArea (description) VALUES ('Game for fun'), ('Fitness for all'), ('Jump in the pool');

INSERT INTO section (description, sectionArea_id) VALUES ('games', 1), ('fitness',2), ('pool',3);

INSERT INTO game (description) VALUES ('arcade'), ('shooting'), ('action'), ('sports'),('Gambling');

INSERT INTO fitnessType (title) VALUES ('Training'), ('CrossFit'), ('Training and Crossfit');

INSERT INTO transportation (description) VALUES ('Lower level'),('Middle level'),('Higher level');

INSERT INTO transportationType (vehicle_name, capacity, model_year) VALUES ('Mercedes Benzz', 6, '2014'), ('Chevrolet', 10, '2018'), ('Ford', 15, '2012');
INSERT INTO transportationType (vehicle_name, capacity, model_year) VALUES ('BMW High Roof', 12, '2019');

INSERT INTO carCompany (name, country) VALUES ('Mercedez', 'Germany'), ('Chevrolet', 'United States'), ('Ford', 'United States'),('BMW','Germany');

INSERT INTO carManufacture (transportType_id, carCompany_id, number_of_vehicle) VALUES (2,2,8), (1,1,6), (3,4,4);

INSERT INTO account (user_id, type_id, region_id) VALUES (2, 1, 1), (1, 1, 3), (4, 1, 2), (3, 2, 2);
INSERT INTO account (user_id, type_id, region_id) VALUES (5, 2, 1);

INSERT INTO session (user_id) VALUES (2), (1), (4), (5);
INSERT INTO session (user_id) VALUES (1), (4), (2);

INSERT INTO userAddress (address_id, user_id) VALUES (2,1), (1,3), (3,4),(2,4);

INSERT INTO manager (ssn) VALUES (134412452),( 413283942);

INSERT INTO work (hotel_id, ssn) VALUES (1, 314283412), (1, 134412452), (2, 134412452), (3, 314283412);

INSERT INTO reserveRoom (reserve_id, user_id, room_id) VALUES (1, 2, 2), (2, 1, 1), (3, 4, 3), (4, 4, 1), (5, 1, 5);

INSERT INTO checkInOut (room_id, user_id) VALUES (3, 4), (2, 2), (1, 1), (1, 4);
INSERT INTO checkInOut (room_id, user_id) VALUES (5, 1);

INSERT INTO employeeAddress (ssn, address_id) VALUES (314283412, 1), (413283942, 3), (134412452, 3);

INSERT INTO ownerAddress (owner_id, address_id) VALUES (2, 3), (1, 1), (3, 2);

INSERT INTO creditCard (card_number, paymentType_id, cvv, bank) VALUES ('1234567890123456', 2, 521, 'Bank of America'), ('1234567890128213', 3, 581, 'Wells Fargo'), ('1234567890123492', 1, 651, 'Chase');

INSERT INTO bankAccount (acc_number, paymentType_id, bank, routing_number) VALUES ('231436478593', 2, 'Chase', '124672847'), ('724852674823', 1, 'Bank of America', '892482084'), ('702649853751', 3, 'Bank of America', '693562093');

INSERT INTO billingInfo (user_id, paymentType_id, amount) VALUES (2, 2, 450), (1, 1, 650), (2, 3, 340);

INSERT INTO concert (eventType_id, description) VALUES (1, 'Solo Performance'), (1, 'Orchestra night'), (1, 'Weekdend songs');

INSERT INTO attendEvent (user_id, event_id, length) VALUES (2, 3, 3), (4, 2, 2), (1, 1, 2);
INSERT INTO attendEvent (user_id, event_id, length) VALUES (3, 3, 3), (5, 1, 4);

INSERT INTO holidayCelebration (eventType_id, holidayType_id, place) VALUES (3, 3, 'Community Hall'), (3, 2, 'Party House'), (3, 1, 'Special Hall');

INSERT INTO eatCuisine (user_id, cuisine_id) VALUES (3,1), (4, 2), (3,2), (1,2), (1,3), (5,1);

INSERT INTO foodCategory (cuisine_id, cuisineCategory_id) VALUES (2, 1), (3,2), (3, 1);

INSERT INTO supportedService (acctType_id, service_id) VALUES ( 1, 2), ( 2, 1), (2, 3), (2, 9), (1, 7), (1,10);

INSERT INTO birthdayParty (eventType_id, description) VALUES (2, 'Birthday bash'), (2, 'Birthday farewell'), (2, 'Happy 50th Birthday');

INSERT INTO artistPerformance (concert_id, artist_id) VALUES (2, 1), (3,2), (1,3);

INSERT INTO breakfast (cuisineType_id, description) VALUES (1, 'Bread and Fish'), (1, 'Egg and Pan Cakes'), (1, 'Macronis');

INSERT INTO lunch (cuisineType_id, description) VALUES (2, 'Pizza and drink'), (2, 'Chow Mein'), (2, 'Hamburgers');

INSERT INTO dinner (cuisineType_id, description) VALUES (3, 'Steaks'), (3, 'Chinese Rice'), (3, 'Lasagna');

INSERT INTO restaurantProvide (restaurant_id, cuisine_id) VALUES (3,2), (4,1), (2,2), (4,2);

INSERT INTO gamingSection (section_id, name) VALUES (1, 'Adults Games'), (1, 'Hotel Casino'), (1, 'Kids Games');

INSERT INTO visitSection (user_id,section_id) VALUES (3,1), (2,2), (2,1), (5,2),(1,3),(3,2);

INSERT INTO fitnessSection (section_id, description, fitnessType_id) VALUES (2, 'Lets get trained', 1), (2, 'Lift heavy', 2), (2, 'Be a bodybuilder', 3), (2, 'Train like athlete', 1);

INSERT INTO gamingCategory (gamingSection_id, game_id) VALUES (2, 5), (1,3), (3,1);

INSERT INTO poolSection (section_id, pool_number) VALUES (3, '5C'), (3, '1B'), (3, '1A'),(3, '2A');

INSERT INTO crossFit (fitnessType_id, capacity) VALUES (2, 25), (2, 40), (2, 45), (2, 50);

INSERT INTO trainingGym (fitnessType_id, capacity) VALUES (3, 48), (3,45), (3,20), (3,30);

INSERT INTO takeTransportation (user_id, transportation_id, number_plate) VALUES (2,1,'M704U3'), (3,1,'O74H34'), (4,2,'I3UH42'),(2,2,'O74H34');

INSERT INTO transportationInfo (transport_id, transportType_id, pickup, dropoff) VALUES (2,1,'Hilton Hotel', 'null'), (1,2,'Days Inn', 'SFO Airport'), (1,3,'Days Inn', 'Sarcamento Station'), (3, 3, 'Holiday Inn', 'null');

INSERT INTO hasMenu (breakfastMenu_id, breakfast_id, lunchMenu_id, lunch_id, dinnerMenu_id, dinner_id) VALUES (2,1,2,3,2,3), (3,1,3,2,2,1), (1,3,3,1,2,2);

INSERT INTO hotelHas (room_id, hotel_id, businessMeeting_id, event_id, cuisine_id, section_id, transportation_id)
 VALUES (2,1,1,3,2,3,1), (3,2,3,1,2,1,2), (4,3,2,3,2,2,1);
