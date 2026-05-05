use ss10;
CREATE TABLE Pharmacy_Inventory (
Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
Drug_Name VARCHAR(255),
Batch_Number VARCHAR(50),
Expiry_Date DATE,
Quantity INT
);
INSERT INTO Pharmacy_Inventory (Drug_Name, Batch_Number, Expiry_Date, Quantity) VALUES
('Paracetamol 500mg', 'B001', '2026-01-15', 120),
('Paracetamol 500mg', 'B002', '2025-12-20', 80),
('Amoxicillin 250mg', 'B003', '2026-03-10', 60),
('Amoxicillin 500mg', 'B004', '2025-11-05', 75),
('Ibuprofen 200mg', 'B005', '2026-02-28', 90),
('Ibuprofen 400mg', 'B006', '2025-10-15', 50),
('Aspirin 81mg', 'B007', '2026-04-01', 110),
('Aspirin 325mg', 'B008', '2025-09-25', 70),
('Vitamin C 500mg', 'B009', '2026-05-12', 200),
('Vitamin C 1000mg', 'B010', '2025-08-30', 150),
('Metformin 500mg', 'B011', '2026-06-18', 95),
('Metformin 850mg', 'B012', '2025-07-22', 65),
('Atorvastatin 10mg', 'B013', '2026-03-05', 40),
('Atorvastatin 20mg', 'B014', '2025-12-01', 55),
('Omeprazole 20mg', 'B015', '2026-01-25', 85),
('Omeprazole 40mg', 'B016', '2025-11-18', 45),
('Cefixime 200mg', 'B017', '2026-02-10', 30),
('Cefixime 400mg', 'B018', '2025-10-05', 25),
('Losartan 50mg', 'B019', '2026-04-20', 60),
('Losartan 100mg', 'B020', '2025-09-10', 35);
create index idx_Drug_Name on Pharmacy_Inventory(Drug_Name);
create index idx_Expiry_Date on Pharmacy_Inventory(Expiry_Date);

explain analyze select 
   Inventory_ID,
   Drug_Name,
   Batch_Number,
   Expiry_Date,
   Quantity 
from Pharmacy_Inventory
where Drug_Name = 'Paracetamol 500mg' and Expiry_Date < '2026-01-01';

create index idx_drug_expriry on Pharmacy_Inventory(Drug_Name,Expiry_Date);
explain analyze select 
   Inventory_ID,
   Drug_Name,
   Batch_Number,
   Expiry_Date,
   Quantity 
from Pharmacy_Inventory
where Drug_Name = 'Paracetamol 500mg' and Expiry_Date < '2026-01-01';
-- Giải thích hiện tượng Index bị "vô hiệu hóa" khi sử dụng LIKE '%keyword%'
-- Index hoạt động theo tìm kiếm theo chữ cái đầu tiên mà khi ta sử dụng LIKE '%keyword%' nên có % ở đầu nên nó không biết tìm kiếm từ đâu từ đó trở nên lâu hơn và làm vô hiệu hóa nó 
-- Để tối ưu index khi dùng like thì không nên để % ở đầu