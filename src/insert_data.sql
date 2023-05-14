USE minitest_week_2;

-- vật tư
INSERT INTO materials VALUES (default,'Sắt ngang size 10','met',100),
                             (default,'Sắt ngang size 20','met',200),
                             (default,'Cọc sắt','met',300),
                             (default,'Cọc tre','met',250),
                             (default,'Đinh vit','kg',100),
                             (default,'Xi măng','kg',20),
                             (default,'Cát','m3',50),
                             (default,'Sơn xanh loại 1','bin',700),
                             (default,'Sơn đỏ loại 1','bin',600),
                             (default,'Sơn vàng','bin',550);

INSERT INTO inventory(matlID,opening_stock) VALUES (1,default),
                                                   (2,10),
                                                   (3,default),
                                                   (4,default),
                                                   (5,default),
                                                   (6,20),
                                                   (7,100),
                                                   (8,30),
                                                   (9,20),
                                                   (10,default);

INSERT INTO suppliers VALUES (default,'MVNHN','Metal Vina','Hà Nội', '0913289322'),
                             (default,'XBSH','Xi măng Bút Sơn','Hà Nam','0123456789'),
                             (default,'CVNHCM','Color Vina','Hồ Chí Minh','987654321');

INSERT INTO purchase_orders VALUES (default,'po1',default,1),
                                   (default,'po2',default,2),
                                   (default,'po3',default,3);

INSERT INTO received_notes VALUES (default,'rc1',default,1),
                                  (default,'rc2',default,2),
                                  (default,'rc3',default,3);

INSERT INTO delivery_notes VALUES (default,'dl1',default,'customer 1'),
                                  (default,'dl2',default,'customer 2'),
                                  (default,'dl3',default,'customer 1');

INSERT INTO order_detail VALUES (default,1,1,50),
                                (default,1,2,100),
                                (default,2,6,100),
                                (default,2,7,50),
                                (default,3,8,20),
                                (default,3,9,10),
                                (default,2,1,20),
                                (default,3,2,20);

INSERT INTO rec_detail VALUES (default,1,1,50,50,''),
                              (default,1,2,100,100,''),
                              (default,2,6,100,10,''),
                              (default,2,7,50,25,''),
                              (default,3,8,20,400,''),
                              (default,3,9,10,350,''),
                              (default,2,1,20,60,''),
                              (default,3,2,20,110,'');

INSERT INTO del_detail VALUES (default,1,1,30,100,''),
                              (default,1,2,100,200,''),
                              (default,2,6,50,20,''),
                              (default,2,7,40,50,''),
                              (default,3,8,35,700,''),
                              (default,3,9,20,600,'');


-- Update inventory table after insert rec and del notes
UPDATE inventory
    INNER JOIN
    (SELECT rec_detail.matlID, sum(rec_detail.quantity_in) as total_in
     FROM rec_detail
     GROUP BY matlID) AS rd_sum
    ON inventory.matlID = rd_sum.matlID
SET inventory.total_in = rd_sum.total_in
WHERE inventory.matlID = rd_sum.matlID;


UPDATE inventory
    INNER JOIN
        (SELECT del_detail.matlID, sum(del_detail.quantity_out) as total_out
FROM del_detail
GROUP BY matlID) AS dd_sum
ON inventory.matlID = dd_sum.matlID
SET inventory.total_out = dd_sum.total_out WHERE inventory.matlID = dd_sum.matlID;
