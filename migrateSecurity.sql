-- MYSQL (Security)
--      BD: db_security
--      CAMPOS:
--          id_user int primary key
--          username varchar 100
--          password varchar 100
CREATE TABLE IF NOT EXISTS db_security (
    id_user int primary key auto_increment,
    username varchar(100),
    password varchar(100)
);