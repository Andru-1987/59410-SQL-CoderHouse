-- CLASS INFO: 
-- https://dev.mysql.com/doc/refman/8.4/en/commit.html

-- CREATE STRUCTURE
DROP DATABASE IF EXISTS transaction_sample;
CREATE DATABASE transaction_sample;
USE transaction_sample;

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT  PRIMARY KEY ,
    account_holder VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);


CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL') NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);


-- POPULATE DATABASE
INSERT INTO
  accounts (account_holder, balance)
  VALUES
  ('John Doe', 1500.00),
  ('Jane Smith', 2500.50),
  ('Alice Johnson', 3200.75),
  ('Bob Brown', 1800.00),
  ('Charlie Black', 500.25),
  ('Diana White', 750.00),
  ('Eve Green', 1200.00),
  ('Frank Blue', 2200.00),
  ('Grace Red', 3000.00),
  ('Hank Yellow', 400.00),
  ('Ivy Purple', 600.00),
  ('Jack Orange', 800.00),
  ('Kara Pink', 900.00),
  ('Leo Gray', 1100.00),
  ('Mona Cyan', 1300.00),
  ('Nina Magenta', 1400.00),
  ('Oscar Lime', 1600.00),
  ('Paul Teal', 1700.00),
  ('Quinn Indigo', 1900.00),
  ('Rita Violet', 2000.00);


-- CREATE SP

DELIMITER //

CREATE PROCEDURE transfer(
    IN sender_id INT,
    IN receiver_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE rollback_message VARCHAR(255) DEFAULT 'Transaction rolled back: Insufficient funds';
    DECLARE commit_message VARCHAR(255) DEFAULT 'Transaction committed successfully';

    -- Start the transaction
    START TRANSACTION;

    -- Attempt to debit money from account 1
    UPDATE accounts SET balance = balance - amount WHERE account_id = sender_id;

    -- Attempt to credit money to account 2
    UPDATE accounts SET balance = balance + amount WHERE account_id = receiver_id;

    -- Check if there are sufficient funds in account 1
    -- Simulate a condition where there are insufficient funds
    IF (SELECT balance FROM accounts WHERE account_id = sender_id) < 0 THEN
        -- Roll back the transaction if there are insufficient funds
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = rollback_message;
    ELSE
        -- Log the transactions if there are sufficient funds
        INSERT INTO transactions (account_id, amount, transaction_type) VALUES (sender_id, -amount, 'WITHDRAWAL');
        INSERT INTO transactions (account_id, amount, transaction_type) VALUES (receiver_id, amount, 'DEPOSIT');
        
        -- Commit the transaction
        COMMIT;
        SELECT commit_message AS 'Result';
    END IF;
END //

DELIMITER ;

-- TEST SAMPLE\

CALL transfer(1,2,2000);