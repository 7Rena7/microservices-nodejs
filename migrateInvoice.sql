-- POSTGRES (Invoice)
--      BD: db_invoice
--      CAMPOS:
--          id_invoice int primary key
--          amount decimal
--          state int
CREATE TABLE IF NOT EXISTS db_invoice (
    id_invoice serial primary key,
    amount decimal,
    state int
);