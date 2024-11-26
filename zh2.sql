-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zh2
-- -----------------------------------------------------
drop table furgon;
drop table motor;
drop table futar;
-- -----------------------------------------------------
-- Schema zh2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zh2` DEFAULT CHARACTER SET utf8 ;
USE `zh2` ;

-- -----------------------------------------------------
-- Table `zh2`.`furgon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zh2`.`furgon` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rendszam` VARCHAR(7) NULL,
  `teherbiras` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zh2`.`motor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zh2`.`motor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rendszam` VARCHAR(7) NULL,
  `sebesseg` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zh2`.`futar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zh2`.`futar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(45) NULL,
  `fizetes` INT NULL,
  `furgon_id` INT NULL,
  `motor_id` INT NOT NULL,
  PRIMARY KEY (`id`, `motor_id`),
  INDEX `fk_futar_furgon1_idx` (`furgon_id`),
  INDEX `fk_futar_motor1_idx` (`motor_id`),
  CONSTRAINT `fk_futar_furgon1`
    FOREIGN KEY (`furgon_id`)
    REFERENCES `zh2`.`furgon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_futar_motor1`
    FOREIGN KEY (`motor_id`)
    REFERENCES `zh2`.`motor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into motor (rendszam, sebesseg) values ('AABB123',140);
insert into motor (rendszam, sebesseg) values ('BBCC123',120);

insert into furgon (rendszam, teherbiras) values ('DDEE123', 750.5);
insert into furgon (rendszam, teherbiras) values ('CCDD123', 808.6);
insert into furgon (rendszam, teherbiras) values ('EEFF123', 900);

insert into futar (nev, fizetes, motor_id, furgon_id) values ('Kiss Anna', 425000, 
(select id from motor where rendszam = 'AABB123' LIMIT 1), (select id from furgon where rendszam = 'DDEE123' LIMIT 1));
insert into futar (nev, fizetes, motor_id, furgon_id) values ('Közepes Béla', 400000, 
(select id from motor where rendszam = 'BBCC123' LIMIT 1), (select id from furgon where rendszam = 'CCDD123' LIMIT 1));
insert into futar (nev, fizetes, motor_id, furgon_id) values ('Közepes Cecil', 445000, 
(select id from motor where rendszam = 'AABB123' LIMIT 1), (select id from furgon where rendszam = 'DDEE123' LIMIT 1));
insert into futar (nev, fizetes, motor_id, furgon_id) values ('Nagy Dénes', 360000, 
(select id from motor where rendszam = 'BBCC123' LIMIT 1), NULL);
insert into futar (nev, fizetes, motor_id, furgon_id) values ('Nagy Erika', 420000, 
(select id from motor where rendszam = 'BBCC123' LIMIT 1), (select id from furgon where rendszam = 'CCDD123' LIMIT 1));

select * from futar;
select * from motor;
select * from furgon;

select furgon.rendszam as rendszam, ifnull(sum(futar.fizetes),0) as osszfizetes , ifnull(min(futar.fizetes),0) as minfizetes from
futar right outer join furgon on furgon.id = futar.furgon_id where teherbiras > 800 group by furgon.rendszam



