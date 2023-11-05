CREATE TABLE userinfo (
                          id int unsigned NOT NULL AUTO_INCREMENT,
                          name varchar(64) NOT NULL DEFAULT '',
                          email varchar(64) NOT NULL DEFAULT '',
                          password varchar(64) NOT NULL DEFAULT '',
                          dob date DEFAULT NULL,
                          address varchar(255) NOT NULL DEFAULT '',
                          city varchar(64) NOT NULL DEFAULT '',
                          state_id smallint unsigned NOT NULL DEFAULT '0',
                          zip  varchar(8) NOT NULL DEFAULT '',
                          country_id smallint unsigned NOT NULL DEFAULT '0',
                          account_type varchar(32) NOT NULL DEFAULT '',
                          closest_airport varchar(3) NOT NULL DEFAULT '',
                          PRIMARY KEY (id),
                          UNIQUE KEY email (email)
)ENGINE=InnoDB;