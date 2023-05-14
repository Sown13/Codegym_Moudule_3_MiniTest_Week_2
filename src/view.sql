USE minitest_week_2;

-- ex1
CREATE OR REPLACE VIEW vw_Rec_Detail AS
SELECT recID, matlID, quantity_in, price_in, quantity_in * price_in AS total_price
FROM rec_detail;

SELECT*
FROM vw_Rec_Detail;

-- ex2
CREATE OR REPLACE VIEW vw_Rec_Detail_material AS
SELECT recID, matlID, material_name, quantity_in, price_in, quantity_in * price_in AS total_price
FROM rec_detail
         INNER JOIN materials USING (matlID)
ORDER BY recID;

SELECT*
FROM vw_Rec_Detail_material;

-- ex3
CREATE OR REPLACE VIEW vw_Rec_Detail_material_rn AS
SELECT rn.recID,
       rn.recDate,
       rn.poID,
       m.matlID,
       m.material_name,
       rd.quantity_in,
       rd.price_in,
       rd.quantity_in * rd.price_in as total_price
FROM received_notes rn
         INNER JOIN rec_detail rd USING (recID)
         INNER JOIN materials m USING (matlID);

SELECT*
FROM vw_Rec_Detail_material_rn;

-- ex4
CREATE OR REPLACE VIEW vw_Rec_Detail_material_rn_po AS
SELECT rn.recID,
       rn.recDate,
       rn.poID,
       supID,
       m.matlID,
       m.material_name,
       rd.quantity_in,
       rd.price_in,
       rd.quantity_in * rd.price_in as total_price
FROM received_notes rn
         INNER JOIN rec_detail rd USING (recID)
         INNER JOIN materials m USING (matlID)
         INNER JOIN purchase_orders USING (poID)
         INNER JOIN suppliers USING (supID);

SELECT *
FROM vw_Rec_Detail_material_rn_po;

-- ex5
CREATE OR REPLACE VIEW vw_Rec_Detail_Filtered AS
SELECT recID, matlID, quantity_in, price_in, quantity_in * price_in AS total_price
FROM rec_detail
WHERE quantity_in > 50;

SELECT *
FROM vw_Rec_Detail_Filtered;

-- ex6
CREATE OR REPLACE VIEW vw_Rec_Detail_material_Filtered AS
SELECT recID, matlID, material_name, quantity_in, price_in, quantity_in * price_in AS total_price
FROM rec_detail
         INNER JOIN materials USING (matlID)
WHERE unit = 'met';

SELECT*
FROM vw_Rec_Detail_material_Filtered;

-- ex7
CREATE OR REPLACE VIEW vw_Del_Detail AS
SELECT delID, matlID, quantity_out, price_out, quantity_out * price_out AS total_price
FROM del_detail;

SELECT *
FROM vw_Del_Detail;

-- ex8
CREATE OR REPLACE VIEW vw_Del_Detail_material AS
SELECT delID, dd.matlID, material_name, quantity_out, price_out, quantity_out * price_out AS total_price
FROM del_detail dd
         INNER JOIN materials USING (matlID);

SELECT *
FROM vw_Rec_Detail_material;

-- ex9
CREATE OR REPLACE VIEW vw_Del_Detail_material_dd AS
SELECT delID, cusName, matlID, material_name, quantity_out, price_out, quantity_out * price_out AS total_price
FROM del_detail dd
         INNER JOIN materials m USING (matlID)
         INNER JOIN delivery_notes dn USING (delID);

SELECT *
FROM vw_Del_Detail_material_dd;