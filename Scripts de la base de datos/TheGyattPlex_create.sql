-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema The Gyatt Plex
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema The Gyatt Plex
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `The Gyatt Plex` DEFAULT CHARACTER SET utf8 ;
USE `The Gyatt Plex` ;

-- -----------------------------------------------------
-- Table `The Gyatt Plex`.`Film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `The Gyatt Plex`.`Film` (
  `FilmID` INT NOT NULL,
  `Title` VARCHAR(255) NULL,
  `Director` VARCHAR(150) NULL,
  `Genre` VARCHAR(50) NULL,
  `Rating` VARCHAR(10) NULL,
  `Duration` INT NULL,
  `Synopsis` LONGTEXT NULL,
  `IsActive` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`FilmID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `The Gyatt Plex`.`Theater`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `The Gyatt Plex`.`Theater` (
  `TheaterID` INT NOT NULL,
  `TheaterNumber` INT NULL,
  `Capacity` INT NULL,
  PRIMARY KEY (`TheaterID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `The Gyatt Plex`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `The Gyatt Plex`.`Customer` (
  `CustomerID` INT NOT NULL,
  `FirstName` VARCHAR(100) NULL,
  `LastName` VARCHAR(150) NULL,
  `Email` VARCHAR(255) NULL,
  `DateOfBirth` DATE NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `The Gyatt Plex`.`Showing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `The Gyatt Plex`.`Showing` (
  `ShowingID` INT NOT NULL,
  `StartTime` TIME NULL,
  `Date` DATE NULL,
  `FilmID` INT NOT NULL,
  `TheaterID` INT NOT NULL,
  PRIMARY KEY (`ShowingID`),
  INDEX `fk_Showing_Film_idx` (`FilmID` ASC) VISIBLE,
  INDEX `fk_Showing_Theater1_idx` (`TheaterID` ASC) VISIBLE,
  CONSTRAINT `fk_Showing_Film`
    FOREIGN KEY (`FilmID`)
    REFERENCES `The Gyatt Plex`.`Film` (`FilmID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Showing_Theater1`
    FOREIGN KEY (`TheaterID`)
    REFERENCES `The Gyatt Plex`.`Theater` (`TheaterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `The Gyatt Plex`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `The Gyatt Plex`.`Ticket` (
  `TicketID` INT NOT NULL,
  `SeatNumber` VARCHAR(5) NULL,
  `Price` DECIMAL(10,2) NULL,
  `PurchaseDate` DATETIME NULL,
  `ShowingID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`TicketID`),
  INDEX `fk_Ticket_Showing1_idx` (`ShowingID` ASC) VISIBLE,
  INDEX `fk_Ticket_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_Showing1`
    FOREIGN KEY (`ShowingID`)
    REFERENCES `The Gyatt Plex`.`Showing` (`ShowingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `The Gyatt Plex`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
