SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `family` ;

CREATE TABLE IF NOT EXISTS `family` (
  `family_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NOT NULL,
  `number_of_kids` INT NULL,
  `number_of_adults` INT NULL,
  PRIMARY KEY (`family_id`),
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_family_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `hotelOwner` ;

CREATE TABLE IF NOT EXISTS `hotelOwner` (
  `owner_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(15) NULL,
  PRIMARY KEY (`owner_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `hotel` ;

CREATE TABLE IF NOT EXISTS `hotel` (
  `hotel_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `owner_id` TINYINT NOT NULL,
  PRIMARY KEY (`hotel_id`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  INDEX `fk_hotel_owner_idx` (`owner_id` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_owner`
    FOREIGN KEY (`owner_id`)
    REFERENCES `hotelOwner` (`owner_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `address_id` TINYINT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zipcode` CHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `hotel_id` TINYINT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_hotel_idx` (`hotel_id` ASC) VISIBLE,
  UNIQUE INDEX `hotel_id_UNIQUE` (`hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_hotel`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`hotel_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `userAddress` ;

CREATE TABLE IF NOT EXISTS `userAddress` (
  `address_id` TINYINT NOT NULL,
  `user_id` TINYINT NOT NULL,
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  INDEX `address_idx` (`address_id` ASC) VISIBLE,
  PRIMARY KEY (`address_id`, `user_id`),
  CONSTRAINT `pk_userAddress_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_userAddress_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `region_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `accountType` ;

CREATE TABLE IF NOT EXISTS `accountType` (
  `accountType_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`accountType_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
  `account_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NOT NULL,
  `type_id` TINYINT NOT NULL,
  `region_id` TINYINT NOT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `renewal` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`, `user_id`, `type_id`),
  INDEX `region_idx` (`region_id` ASC) VISIBLE,
  INDEX `type_idx` (`type_id` ASC) VISIBLE,
  UNIQUE INDEX `user_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `pk_account_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `accountType` (`accountType_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_account_region`
    FOREIGN KEY (`region_id`)
    REFERENCES `region` (`region_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `paymentType` ;

CREATE TABLE IF NOT EXISTS `paymentType` (
  `paymentType_id` TINYINT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zipcode` CHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paymentType_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `billingInfo` ;

CREATE TABLE IF NOT EXISTS `billingInfo` (
  `user_id` TINYINT NOT NULL,
  `paymentType_id` TINYINT NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `paymentType_id`),
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  INDEX `payment_type_idx` (`paymentType_id` ASC) VISIBLE,
  CONSTRAINT `pk_billingInfo_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_billingInfo_type`
    FOREIGN KEY (`paymentType_id`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `bankAccount` ;

CREATE TABLE IF NOT EXISTS `bankAccount` (
  `acc_number` VARCHAR(45) NOT NULL,
  `paymentType_id` TINYINT NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `routing_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`acc_number`, `paymentType_id`),
  INDEX `type_idx` (`paymentType_id` ASC) VISIBLE,
  CONSTRAINT `pk_bankAccount_type`
    FOREIGN KEY (`paymentType_id`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `creditCard` ;

CREATE TABLE IF NOT EXISTS `creditCard` (
  `card_number` VARCHAR(45) NOT NULL,
  `paymentType_id` TINYINT NOT NULL,
  `cvv` CHAR(3) NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `exp_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`card_number`, `paymentType_id`),
  INDEX `payment_type_idx` (`paymentType_id` ASC) VISIBLE,
  CONSTRAINT `pk_creditCard_type`
    FOREIGN KEY (`paymentType_id`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `session` ;

CREATE TABLE IF NOT EXISTS `session` (
  `session_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NOT NULL,
  `expires` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`session_id`),
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_session_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `service` ;

CREATE TABLE IF NOT EXISTS `service` (
  `service_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`service_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `supportedService` ;

CREATE TABLE IF NOT EXISTS `supportedService` (
  `supported_id` TINYINT NOT NULL AUTO_INCREMENT,
  `acctType_id` TINYINT NOT NULL,
  `service_id` TINYINT NOT NULL,
  PRIMARY KEY (`supported_id`),
  INDEX `account_type_idx` (`acctType_id` ASC) VISIBLE,
  INDEX `service_idx` (`service_id` ASC) VISIBLE,
  CONSTRAINT `fk_supportedService_accType`
    FOREIGN KEY (`acctType_id`)
    REFERENCES `accountType` (`accountType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedService_service`
    FOREIGN KEY (`service_id`)
    REFERENCES `service` (`service_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `employee` ;

CREATE TABLE IF NOT EXISTS `employee` (
  `ssn` CHAR(9) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(15) NULL,
  `salary` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`ssn`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `employeeAddress` ;

CREATE TABLE IF NOT EXISTS `employeeAddress` (
  `ssn` CHAR(9) NOT NULL,
  `address_id` TINYINT NOT NULL,
  PRIMARY KEY (`ssn`, `address_id`),
  INDEX `employee_idx` (`ssn` ASC) VISIBLE,
  INDEX `address_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `pk_empAddress_employee`
    FOREIGN KEY (`ssn`)
    REFERENCES `employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_empAddress_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `work` ;

CREATE TABLE IF NOT EXISTS `work` (
  `hotel_id` TINYINT NOT NULL,
  `ssn` CHAR(9) NOT NULL,
  PRIMARY KEY (`hotel_id`, `ssn`),
  INDEX `hotel_idx` (`hotel_id` ASC) VISIBLE,
  INDEX `employee_idx` (`ssn` ASC) VISIBLE,
  CONSTRAINT `pk_work_hotel`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`hotel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_work_employee`
    FOREIGN KEY (`ssn`)
    REFERENCES `employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `ownerAddress` ;

CREATE TABLE IF NOT EXISTS `ownerAddress` (
  `owner_id` TINYINT NOT NULL,
  `address_id` TINYINT NOT NULL,
  PRIMARY KEY (`owner_id`, `address_id`),
  INDEX `owner_idx` (`owner_id` ASC) VISIBLE,
  INDEX `address_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `pk_ownerAddress_owner`
    FOREIGN KEY (`owner_id`)
    REFERENCES `hotelOwner` (`owner_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_ownerAddress_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `room` ;

CREATE TABLE IF NOT EXISTS `room` (
  `room_id` TINYINT NOT NULL AUTO_INCREMENT,
  `room_number` VARCHAR(20) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`room_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `businessPerson` ;

CREATE TABLE IF NOT EXISTS `businessPerson` (
  `businessPerson_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(20) NULL,
  PRIMARY KEY (`businessPerson_id`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `businessCompany` ;

CREATE TABLE IF NOT EXISTS `businessCompany` (
  `businessCompany_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `established` INT NOT NULL,
  PRIMARY KEY (`businessCompany_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `businessMeeting` ;

CREATE TABLE IF NOT EXISTS `businessMeeting` (
  `businessMeeting_id` TINYINT NOT NULL AUTO_INCREMENT,
  `place` VARCHAR(60) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `businessPerson_id` TINYINT NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `businessCompany_id` TINYINT NOT NULL,
  PRIMARY KEY (`businessMeeting_id`),
  INDEX `fk_businessMeeting_person_idx` (`businessPerson_id` ASC) VISIBLE,
  INDEX `fk_businessMeeting_company_idx` (`businessCompany_id` ASC) VISIBLE,
  CONSTRAINT `fk_businessMeeting_person`
    FOREIGN KEY (`businessPerson_id`)
    REFERENCES `businessPerson` (`businessPerson_id`)
    ON DELETE NO ACTION
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_businessMeeting_company`
    FOREIGN KEY (`businessCompany_id`)
    REFERENCES `businessCompany` (`businessCompany_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `event` ;

CREATE TABLE IF NOT EXISTS `event` (
  `event_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `cuisine` ;

CREATE TABLE IF NOT EXISTS `cuisine` (
  `cuisine_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`cuisine_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `sectionArea` ;

CREATE TABLE IF NOT EXISTS `sectionArea` (
  `sectionArea_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`sectionArea_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `section` ;

CREATE TABLE IF NOT EXISTS `section` (
  `section_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(60) NOT NULL,
  `sectionArea_id` TINYINT NOT NULL,
  PRIMARY KEY (`section_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE,
  INDEX `fk_section_sectionArea_idx` (`sectionArea_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_sectionArea`
    FOREIGN KEY (`sectionArea_id`)
    REFERENCES `sectionArea` (`sectionArea_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `transportation` ;

CREATE TABLE IF NOT EXISTS `transportation` (
  `transportation_id` TINYINT NOT NULL AUTO_INCREMENT,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transportation_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `hotelHas` ;

CREATE TABLE IF NOT EXISTS `hotelHas` (
  `room_id` TINYINT NOT NULL,
  `hotel_id` TINYINT NOT NULL,
  `businessMeeting_id` TINYINT NOT NULL,
  `event_id` TINYINT NOT NULL,
  `cuisine_id` TINYINT NOT NULL,
  `section_id` TINYINT NOT NULL,
  `transportation_id` TINYINT NOT NULL,
  PRIMARY KEY (`room_id`, `hotel_id`, `businessMeeting_id`, `event_id`, `cuisine_id`, `section_id`, `transportation_id`),
  INDEX `room_idx` (`room_id` ASC) VISIBLE,
  INDEX `hotel_idx` (`hotel_id` ASC) VISIBLE,
  INDEX `business_meeting_idx` (`businessMeeting_id` ASC) VISIBLE,
  INDEX `event_idx` (`event_id` ASC) VISIBLE,
  INDEX `cuisine_idx` (`cuisine_id` ASC) VISIBLE,
  INDEX `fk_hotelHas_section_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_hotelHas_transport_idx` (`transportation_id` ASC) VISIBLE,
  CONSTRAINT `pk_hotelHas_room`
    FOREIGN KEY (`room_id`)
    REFERENCES `room` (`room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hotelHas_hotel`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`hotel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hotelHas_meeting`
    FOREIGN KEY (`businessMeeting_id`)
    REFERENCES `businessMeeting` (`businessMeeting_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hotelHas_event`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hotelHas_cuisine`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hotelHas_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `section` (`section_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hotelHas_transport`
    FOREIGN KEY (`transportation_id`)
    REFERENCES `transportation` (`transportation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `checkInOut` ;

CREATE TABLE IF NOT EXISTS `checkInOut` (
  `room_id` TINYINT NOT NULL,
  `user_id` TINYINT NOT NULL,
  `from` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `to` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`room_id`, `user_id`, `from`),
  INDEX `room_idx` (`room_id` ASC) VISIBLE,
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `pk_check_room`
    FOREIGN KEY (`room_id`)
    REFERENCES `room` (`room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_check_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `reserveRoom` ;

CREATE TABLE IF NOT EXISTS `reserveRoom` (
  `reserve_id` TINYINT NOT NULL,
  `user_id` TINYINT NOT NULL,
  `room_id` TINYINT NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reserve_id`, `user_id`, `room_id`),
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  INDEX `room_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `pk_reserveRoom_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_reserveRoom_room`
    FOREIGN KEY (`room_id`)
    REFERENCES `room` (`room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `attendEvent` ;

CREATE TABLE IF NOT EXISTS `attendEvent` (
  `attentEvent_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NOT NULL,
  `event_id` TINYINT NOT NULL,
  `length` INT NOT NULL,
  PRIMARY KEY (`attentEvent_id`),
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  INDEX `event_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_attendEvent_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendEvent_event`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `concert` ;

CREATE TABLE IF NOT EXISTS `concert` (
  `concert_id` TINYINT NOT NULL AUTO_INCREMENT,
  `eventType_id` TINYINT NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`concert_id`, `eventType_id`),
  INDEX `event_type_idx` (`eventType_id` ASC) VISIBLE,
  CONSTRAINT `pk_concert_event`
    FOREIGN KEY (`eventType_id`)
    REFERENCES `event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `birthdayParty` ;

CREATE TABLE IF NOT EXISTS `birthdayParty` (
  `birthday_id` TINYINT NOT NULL AUTO_INCREMENT,
  `eventType_id` TINYINT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`birthday_id`, `eventType_id`),
  INDEX `event_idx` (`eventType_id` ASC) VISIBLE,
  CONSTRAINT `pk_birthday_event`
    FOREIGN KEY (`eventType_id`)
    REFERENCES `event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `holidayType` ;

CREATE TABLE IF NOT EXISTS `holidayType` (
  `holidayType_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`holidayType_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `holidayCelebration` ;

CREATE TABLE IF NOT EXISTS `holidayCelebration` (
  `holiday_id` TINYINT NOT NULL AUTO_INCREMENT,
  `eventType_id` TINYINT NOT NULL,
  `holidayType_id` TINYINT NULL,
  `place` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`holiday_id`, `eventType_id`),
  INDEX `event_type_idx` (`eventType_id` ASC) VISIBLE,
  INDEX `holiday_type_idx` (`holidayType_id` ASC) VISIBLE,
  CONSTRAINT `pk_holiday_event`
    FOREIGN KEY (`eventType_id`)
    REFERENCES `event` (`event_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_holiday_type`
    FOREIGN KEY (`holidayType_id`)
    REFERENCES `holidayType` (`holidayType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `artist` ;

CREATE TABLE IF NOT EXISTS `artist` (
  `artist_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `artistPerformance` ;

CREATE TABLE IF NOT EXISTS `artistPerformance` (
  `concert_id` TINYINT NOT NULL,
  `artist_id` TINYINT NOT NULL,
  `time_id` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`concert_id`, `artist_id`, `time_id`),
  INDEX `concert_idx` (`concert_id` ASC) VISIBLE,
  INDEX `artist_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `pk_performance_concert`
    FOREIGN KEY (`concert_id`)
    REFERENCES `concert` (`concert_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_performance_artist`
    FOREIGN KEY (`artist_id`)
    REFERENCES `artist` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `breakfast` ;

CREATE TABLE IF NOT EXISTS `breakfast` (
  `breakfast_id` TINYINT NOT NULL AUTO_INCREMENT,
  `cuisineType_id` TINYINT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`breakfast_id`, `cuisineType_id`),
  INDEX `cuisine_type_idx` (`cuisineType_id` ASC) VISIBLE,
  CONSTRAINT `pk_breakfast_cuisine`
    FOREIGN KEY (`cuisineType_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `lunch` ;

CREATE TABLE IF NOT EXISTS `lunch` (
  `lunch_id` TINYINT NOT NULL AUTO_INCREMENT,
  `cuisineType_id` TINYINT NOT NULL,
  `description` VARCHAR(65) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`lunch_id`, `cuisineType_id`),
  INDEX `cuisine_idx` (`cuisineType_id` ASC) VISIBLE,
  CONSTRAINT `pk_lunch_cuisine`
    FOREIGN KEY (`cuisineType_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `dinner` ;

CREATE TABLE IF NOT EXISTS `dinner` (
  `dinner_id` TINYINT NOT NULL AUTO_INCREMENT,
  `cuisineType_id` TINYINT NOT NULL,
  `description` VARCHAR(60) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dinner_id`, `cuisineType_id`),
  INDEX `cuisine_type_idx` (`cuisineType_id` ASC) VISIBLE,
  CONSTRAINT `pk_dinner_cuisine`
    FOREIGN KEY (`cuisineType_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `eatCuisine` ;

CREATE TABLE IF NOT EXISTS `eatCuisine` (
  `user_id` TINYINT NOT NULL,
  `cuisine_id` TINYINT NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cuisine_id`, `user_id`, `time`),
  INDEX `user_idx` (`user_id` ASC) VISIBLE,
  INDEX `cuisine_idx` (`cuisine_id` ASC) VISIBLE,
  CONSTRAINT `fk_eatCuisine_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_eatCuisine_cuisine`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `restaurant` ;

CREATE TABLE IF NOT EXISTS `restaurant` (
  `restaurant_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `restaurantProvide` ;

CREATE TABLE IF NOT EXISTS `restaurantProvide` (
  `restaurant_id` TINYINT NOT NULL,
  `cuisine_id` TINYINT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `cuisine_id`),
  INDEX `restaurant_idx` (`restaurant_id` ASC) VISIBLE,
  INDEX `cuisine_idx` (`cuisine_id` ASC) VISIBLE,
  CONSTRAINT `pk_provide_restuarant`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_provide_cuisine`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `cuisineCategory` ;

CREATE TABLE IF NOT EXISTS `cuisineCategory` (
  `cuisineCategory_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cuisineCategory_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `foodCategory` ;

CREATE TABLE IF NOT EXISTS `foodCategory` (
  `cuisine_id` TINYINT NOT NULL,
  `cuisineCategory_id` TINYINT NOT NULL,
  PRIMARY KEY (`cuisineCategory_id`, `cuisine_id`),
  INDEX `cuisine_idx` (`cuisine_id` ASC) VISIBLE,
  INDEX `cuisineCategory_idx` (`cuisineCategory_id` ASC) VISIBLE,
  CONSTRAINT `pk_food_cuisine`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `cuisine` (`cuisine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_food_cuisineCategory`
    FOREIGN KEY (`cuisineCategory_id`)
    REFERENCES `cuisineCategory` (`cuisineCategory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `breakfastMenu` ;

CREATE TABLE IF NOT EXISTS `breakfastMenu` (
  `breakfastMenu_id` TINYINT NOT NULL AUTO_INCREMENT,
  `calories` VARCHAR(15) NOT NULL,
  `dishName` VARCHAR(45) NOT NULL,
  `drink` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`breakfastMenu_id`),
  UNIQUE INDEX `dish_UNIQUE` (`dishName` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `lunchMenu` ;

CREATE TABLE IF NOT EXISTS `lunchMenu` (
  `lunchMenu_id` TINYINT NOT NULL AUTO_INCREMENT,
  `calories` VARCHAR(15) NOT NULL,
  `dishName` VARCHAR(45) NOT NULL,
  `drink` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lunchMenu_id`),
  UNIQUE INDEX `dishName_UNIQUE` (`dishName` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `dinnerMenu` ;

CREATE TABLE IF NOT EXISTS `dinnerMenu` (
  `dinnerMenu_id` TINYINT NOT NULL AUTO_INCREMENT,
  `calories` VARCHAR(15) NOT NULL,
  `dishName` VARCHAR(45) NOT NULL,
  `drink` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dinnerMenu_id`),
  UNIQUE INDEX `dishName_UNIQUE` (`dishName` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `hasMenu` ;

CREATE TABLE IF NOT EXISTS `hasMenu` (
  `breakfastMenu_id` TINYINT NOT NULL,
  `breakfast_id` TINYINT NOT NULL,
  `lunchMenu_id` TINYINT NOT NULL,
  `lunch_id` TINYINT NOT NULL,
  `dinnerMenu_id` TINYINT NOT NULL,
  `dinner_id` TINYINT NOT NULL,
  PRIMARY KEY (`breakfastMenu_id`, `breakfast_id`, `lunchMenu_id`, `lunch_id`, `dinnerMenu_id`, `dinner_id`),
  INDEX `breakfastMenu_idx` (`breakfastMenu_id` ASC) VISIBLE,
  INDEX `breakfast_idx` (`breakfast_id` ASC) VISIBLE,
  INDEX `lunchMenu_idx` (`lunchMenu_id` ASC) VISIBLE,
  INDEX `lunch_idx` (`lunch_id` ASC) VISIBLE,
  INDEX `dinnerMenu_idx` (`dinnerMenu_id` ASC) VISIBLE,
  INDEX `dinner_idx` (`dinner_id` ASC) VISIBLE,
  CONSTRAINT `pk_hasMenu_breakMenu`
    FOREIGN KEY (`breakfastMenu_id`)
    REFERENCES `breakfastMenu` (`breakfastMenu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hasMenu_breakfast`
    FOREIGN KEY (`breakfast_id`)
    REFERENCES `breakfast` (`breakfast_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hasMenu_lunchMenu`
    FOREIGN KEY (`lunchMenu_id`)
    REFERENCES `lunchMenu` (`lunchMenu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hasMenu_lunch`
    FOREIGN KEY (`lunch_id`)
    REFERENCES `lunch` (`lunch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hasMenu_dinnerMenu`
    FOREIGN KEY (`dinnerMenu_id`)
    REFERENCES `dinnerMenu` (`dinnerMenu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_hasMenu_dinner`
    FOREIGN KEY (`dinner_id`)
    REFERENCES `dinner` (`dinner_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `visitSection` ;

CREATE TABLE IF NOT EXISTS `visitSection` (
  `user_id` TINYINT NOT NULL,
  `section_id` TINYINT NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk__idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_visit_section_idx` (`section_id` ASC) VISIBLE,
  PRIMARY KEY (`user_id`, `section_id`, `time`),
  CONSTRAINT `pk_visit_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_visit_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `section` (`section_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `gamingSection` ;

CREATE TABLE IF NOT EXISTS `gamingSection` (
  `gamingSection_id` TINYINT NOT NULL AUTO_INCREMENT,
  `section_id` TINYINT NOT NULL,
  `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`gamingSection_id`, `section_id`),
  INDEX `pk_gaming_section_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `pk_gaming_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `section` (`section_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `fitnessType` ;

CREATE TABLE IF NOT EXISTS `fitnessType` (
  `fitnessType_id` TINYINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fitnessType_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `fitnessSection` ;

CREATE TABLE IF NOT EXISTS `fitnessSection` (
  `fitness_id` TINYINT NOT NULL AUTO_INCREMENT,
  `section_id` TINYINT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `fitnessType_id` TINYINT(1) NOT NULL,
  PRIMARY KEY (`fitness_id`, `section_id`, `fitnessType_id`),
  INDEX `pk_fitness_section_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_fitness_type_idx` (`fitnessType_id` ASC) VISIBLE,
  CONSTRAINT `pk_fitness_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `section` (`section_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_fitness_type`
    FOREIGN KEY (`fitnessType_id`)
    REFERENCES `fitnessType` (`fitnessType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `poolSection` ;

CREATE TABLE IF NOT EXISTS `poolSection` (
  `pool_id` TINYINT NOT NULL AUTO_INCREMENT,
  `section_id` TINYINT NOT NULL,
  `pool_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pool_id`, `section_id`),
  INDEX `pk_pool_section_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `pk_pool_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `section` (`section_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `game` ;

CREATE TABLE IF NOT EXISTS `game` (
  `game_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `gamingCategory` ;

CREATE TABLE IF NOT EXISTS `gamingCategory` (
  `gameCategory_id` TINYINT NOT NULL AUTO_INCREMENT,
  `gamingSection_id` TINYINT NOT NULL,
  `game_id` TINYINT NOT NULL,
  PRIMARY KEY (`gameCategory_id`, `gamingSection_id`, `game_id`),
  INDEX `fk_gamingCategory_gaming_idx` (`gamingSection_id` ASC) VISIBLE,
  INDEX `fk_gamingCategory_game_idx` (`game_id` ASC) VISIBLE,
  CONSTRAINT `pk_gamingCategory_gaming`
    FOREIGN KEY (`gamingSection_id`)
    REFERENCES `gamingSection` (`gamingSection_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_gamingCategory_game`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`game_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `crossFit` ;

CREATE TABLE IF NOT EXISTS `crossFit` (
  `crossFit_id` TINYINT NOT NULL AUTO_INCREMENT,
  `fitnessType_id` TINYINT NOT NULL,
  `start` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `capacity` TINYINT(3) NOT NULL,
  PRIMARY KEY (`crossFit_id`, `fitnessType_id`),
  INDEX `pk_crossFit_type_idx` (`fitnessType_id` ASC) VISIBLE,
  CONSTRAINT `pk_crossFit_type`
    FOREIGN KEY (`fitnessType_id`)
    REFERENCES `fitnessType` (`fitnessType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `trainingGym` ;

CREATE TABLE IF NOT EXISTS `trainingGym` (
  `trainingGym_id` INT NOT NULL AUTO_INCREMENT,
  `fitnessType_id` TINYINT NOT NULL,
  `start` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `capacity` TINYINT(3) NOT NULL,
  PRIMARY KEY (`trainingGym_id`, `fitnessType_id`),
  INDEX `pk_trainingGym_type_idx` (`fitnessType_id` ASC) VISIBLE,
  CONSTRAINT `pk_trainingGym_type`
    FOREIGN KEY (`fitnessType_id`)
    REFERENCES `fitnessType` (`fitnessType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `takeTransportation` ;

CREATE TABLE IF NOT EXISTS `takeTransportation` (
  `user_id` TINYINT NOT NULL,
  `transportation_id` TINYINT NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `number_plate` VARCHAR(45) NOT NULL,
  INDEX `fk_takeTransport_transport_idx` (`transportation_id` ASC) VISIBLE,
  INDEX `fk_takeTransport_user_idx` (`user_id` ASC) VISIBLE,
  PRIMARY KEY (`user_id`, `transportation_id`),
  CONSTRAINT `pk_takeTransport_transport`
    FOREIGN KEY (`transportation_id`)
    REFERENCES `transportation` (`transportation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_takeTransport_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `transportationType` ;

CREATE TABLE IF NOT EXISTS `transportationType` (
  `transportType_id` TINYINT NOT NULL AUTO_INCREMENT,
  `vehicle_name` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  `model_year` VARCHAR(20) NULL,
  PRIMARY KEY (`transportType_id`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `transportationInfo` ;

CREATE TABLE IF NOT EXISTS `transportationInfo` (
  `transportInfo_id` TINYINT NOT NULL AUTO_INCREMENT,
  `transport_id` TINYINT NOT NULL,
  `transportType_id` TINYINT NOT NULL,
  `pickup` VARCHAR(45) NULL,
  `dropoff` VARCHAR(45) NULL,
  PRIMARY KEY (`transportInfo_id`),
  INDEX `fk_trabsportInfo_transport_idx` (`transport_id` ASC) VISIBLE,
  INDEX `fk_transportInfo_type_idx` (`transportType_id` ASC) VISIBLE,
  CONSTRAINT `fk_transportInfo_transport`
    FOREIGN KEY (`transport_id`)
    REFERENCES `transportation` (`transportation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_transportInfo_type`
    FOREIGN KEY (`transportType_id`)
    REFERENCES `transportationType` (`transportType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `carCompany` ;

CREATE TABLE IF NOT EXISTS `carCompany` (
  `carCompany_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`carCompany_id`, `name`, `country`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `carManufacture` ;

CREATE TABLE IF NOT EXISTS `carManufacture` (
  `carManufacture_id` TINYINT NOT NULL AUTO_INCREMENT,
  `transportType_id` TINYINT NOT NULL,
  `carCompany_id` TINYINT NOT NULL,
  `number_of_vehicle` INT NOT NULL,
  PRIMARY KEY (`carManufacture_id`, `transportType_id`, `carCompany_id`),
  INDEX `fk_carManufacture_type_idx` (`transportType_id` ASC) VISIBLE,
  INDEX `fk_carManufacture_car_idx` (`carCompany_id` ASC) VISIBLE,
  CONSTRAINT `pk_carManufacture_type`
    FOREIGN KEY (`transportType_id`)
    REFERENCES `transportationType` (`transportType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `pk_carManufacture_car`
    FOREIGN KEY (`carCompany_id`)
    REFERENCES `carCompany` (`carCompany_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `manager` ;

CREATE TABLE IF NOT EXISTS `manager` (
  `manager_id` TINYINT NOT NULL AUTO_INCREMENT,
  `ssn` CHAR(9) NOT NULL,
  PRIMARY KEY (`manager_id`, `ssn`),
  INDEX `pk_manager_employee_idx` (`ssn` ASC) VISIBLE,
  CONSTRAINT `pk_manager_employee`
    FOREIGN KEY (`ssn`)
    REFERENCES `employee` (`ssn`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
