CREATE TABLE userinfo (
  id INT NOT NULL AUTO_INCREMENT,
  name varchar(64) NOT NULL DEFAULT '',
  email varchar(64) NOT NULL ,
  password varchar(64) NOT NULL DEFAULT '',
  dob date DEFAULT NULL,
  address varchar(255) NOT NULL DEFAULT '',
  city varchar(64) NOT NULL DEFAULT '',
  state_id INT  NOT NULL DEFAULT '0',
  zip  varchar(8) NOT NULL DEFAULT '',
  country_id INT  NOT NULL DEFAULT '0',
  account_type varchar(32) NOT NULL DEFAULT '',
  closest_airport varchar(3) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
)
ENGINE=InnoDB;

-- insert data using procedure

DELIMITER $$
CREATE PROCEDURE InsertUserInfo(IN max_count INT)
BEGIN
    DECLARE x INT DEFAULT 0;
    DECLARE state_id INT DEFAULT 0;

    WHILE x < max_count DO
        SET state_id = state_id + 1;

INSERT INTO userinfo (`name`, `email`, `password`, `dob`, `address`, `city`, `state_id`, `zip`, `country_id`, `account_type`, `closest_airport`)
VALUES (
           CONCAT('John', x),
           CONCAT('johnsmith',x,'@email.com'),
           '1234',
           '1986-02-14',
           '1795 Santiago de Compostela Way',
           'Austin',
           state_id,
           '18743',
           1,
           'customer account',
           'aut'
       );

SET x = x + 1;
END WHILE;
END $$

DELIMITER ;
