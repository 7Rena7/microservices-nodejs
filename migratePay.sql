-- MYSQL (Pay)
--      BD: db_operation
--      CAMPOS:
--          id_operation int primary key
--          id_invoice int
--          amount decimal
--          date datetime
CREATE TABLE IF NOT EXISTS db_operation (
    id_operation int primary key auto_increment,
    id_invoice int,
    amount decimal,
    date datetime
);