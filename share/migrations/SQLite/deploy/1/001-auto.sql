-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sat Jan 26 16:29:56 2013
-- 

;
BEGIN TRANSACTION;
--
-- Table: todolist
--
CREATE TABLE todolist (
  todolist_id INTEGER PRIMARY KEY NOT NULL,
  entry text NOT NULL,
  status enum NOT NULL
);
COMMIT;
