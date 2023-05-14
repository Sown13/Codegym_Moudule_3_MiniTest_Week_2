USE minitest_week_2;

-- ex1
DELIMITER //
CREATE PROCEDURE cal_ending_stock(IN material_ID INT)
BEGIN
    SELECT matlID, material_name, opening_stock + inventory.total_in - inventory.total_out AS ending_stock
    FROM inventory
             INNER JOIN materials USING (matlID)
    WHERE matlID = material_ID;
END //
DELIMITER ;

CALL cal_ending_stock(2);

-- ex2
DELIMITER //
CREATE PROCEDURE cal_total_price_out(IN material_ID INT)
BEGIN
    SELECT matlID, material_name, sum(quantity_out * price_out) AS total_price_out
    FROM del_detail
             INNER JOIN materials USING (matlID)
    WHERE matlID = material_ID
    GROUP BY matlID;
end //
DELIMITER ;

CALL cal_total_price_out(8);

-- ex3
DELIMITER //
CREATE PROCEDURE cal_total_by_po(IN purchase_order_ID INT)
BEGIN
    SELECT matlID, material_name, poID, SUM(quantity_in)
    FROM rec_detail
             INNER JOIN materials USING (matlID)
             INNER JOIN received_notes USING (recID)
    WHERE poID = purchase_order_ID
    GROUP BY matlID,poID;
END //
DELIMITER ;

CALL cal_total_by_po(1);

-- ex4
DELIMITER //
CREATE PROCEDURE create_po (IN supplier_ID INT)
BEGIN INSERT INTO purchase_orders(oDate,supID)
    VALUE (default,supplier_ID);
END //
DELIMITER ;

CALL create_po(1);

-- ex5
DELIMITER //
CREATE PROCEDURE create_po_detail (IN po_ID INT, IN materila_ID INT,IN quantity_input INT)
BEGIN INSERT INTO order_detail(poID,matlID,quantity)
    VALUE (po_ID,materila_ID,quantity_input);
END //
DELIMITER ;

CALL create_po_detail(4,3,100);