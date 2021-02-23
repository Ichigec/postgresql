CREATE TABLE T_CONTRACTOR_SHERULER
(NAME varchar, SHEDULE varchar, DATE_BEGIN timestamp, DATE_END timestamp,
constraint ID_NAME primary key(NAME, DATE_BEGIN),
constraint date_check CHECK(DATE_BEGIN < DATE_END));

COPY T_CONTRACTOR_SHERULER(name, shedule, date_begin, date_end) FROM 'E:\\Vakansy\\magnit\\shedulers.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE T_CONTRACTOR_WORK_DAY
(ID int, NAME varchar, DATE_BEGIN timestamp, DATE_END timestamp);
