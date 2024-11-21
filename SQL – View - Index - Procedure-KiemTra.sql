use sqlvip;

-- Ex2
ALTER TABLE products
ADD FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE products
ADD FOREIGN KEY (storeId) REFERENCES stores(storeId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE images
ADD FOREIGN KEY (productId) REFERENCES products(productId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE reviews
ADD FOREIGN KEY (userId) REFERENCES users(userId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE reviews
ADD FOREIGN KEY (productId) REFERENCES products(productId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE carts
ADD FOREIGN KEY (productId) REFERENCES products(productId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE carts
ADD FOREIGN KEY (userId) REFERENCES users(userId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE order_details
ADD FOREIGN KEY (productId) REFERENCES products(productId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE order_details
ADD FOREIGN KEY (orderId) REFERENCES orders(orderId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE stores
ADD FOREIGN KEY (userId) REFERENCES users(userId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE orders
ADD FOREIGN KEY (userId) REFERENCES users(userId)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE orders
ADD FOREIGN KEY (storeId) REFERENCES stores(storeId)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Ex3

-- Liệt kê tất cả các thông tin về sản phẩm (products).
SELECT * From products;
-- Tìm tất cả các đơn hàng (orders) có tổng giá trị (totalPrice) lớn hơn 500,000.
SELECT * FROM orders
WHERE totalPrice >500000;
-- Liệt kê tên và địa chỉ của tất cả các cửa hàng (stores).
SELECT storeName,addressStore
FROM stores
ORDER BY storeName;
-- Tìm tất cả người dùng (users) có địa chỉ email kết thúc bằng '@gmail.com'.
SELECT * From users
WHERE email like '%@gmail.com';
-- Hiển thị tất cả các đánh giá (reviews) với mức đánh giá (rate) bằng 5.
SELECT * From reviews
WHERE rate =5;
-- Liệt kê tất cả các sản phẩm có số lượng (quantity) dưới 10.
SELECT * From products
WHERE quantity<10;
-- Tìm tất cả các sản phẩm thuộc danh mục categoryId = 1.
SELECT * From products
WHERE categoryId=1;
-- Đếm số lượng người dùng (users) có trong hệ thống.
SELECT count(*) AS SLU FROM users;

-- Tính tổng giá trị của tất cả các đơn hàng (orders).
SELECT SUM(totalPrice) AS TongGT From orders;
-- Tìm sản phẩm có giá cao nhất (price).
SELECT * From products
WHERE price = (SELECT MAX(price) From products);
-- Liệt kê tất cả các cửa hàng đang hoạt động (statusStore = 1).
SELECT * From stores
WHERE statusstore =1;
-- Đếm số lượng sản phẩm theo từng danh mục (categories).
SELECT categoryId, COUNT(*) AS SL
FROM products 
GROUP BY categoryId
ORDER BY categoryId;

-- Tìm tất cả các sản phẩm mà chưa từng có đánh giá.
SELECT *
FROM products 
WHERE productId <> ALL (SELECT productId From reviews);
-- Hiển thị tổng số lượng hàng đã bán (quantityOrder) của từng sản phẩm.
SELECT p.productId ,SUM(os.quantityOrder) AS SL
FROM products p 
JOIN order_details os 
ON p.productId = os.productId 
GROUP BY p.productId;
-- Tìm các người dùng (users) chưa đặt bất kỳ đơn hàng nào.
SELECT * FROM users
WHERE userId <> ALL (SELECT userId FROM orders);

-- Hiển thị tên cửa hàng và tổng số đơn hàng được thực hiện tại từng cửa hàng.
SELECT  s.storeName,count(o.orderId) AS SLDH
FROM stores s
Join orders o
ON  o.storeId=s.storeId
GROUP BY s.storeId;
-- Hiển thị thông tin của sản phẩm, kèm số lượng hình ảnh liên quan.
SELECT p.*, count(i.productId) AS SLHA 
From products p
JOIN images i
ON i.productId=p.productId
GROUP BY p.productId;

-- Hiển thị các sản phẩm kèm số lượng đánh giá và đánh giá trung bình.
SELECT p.* , round(avg(rate)) AS AVGRATE, count(*) AS SLDG
FROM products p
JOIN reviews r
On r.productId=p.productId
GROUP BY p.productId;
-- Tìm người dùng có số lượng đánh giá nhiều nhất.
SELECT u.*, COUNT(*) AS SLDG
FROM users u
JOIN reviews r ON r.userId = u.userId
GROUP BY u.userId
HAVING COUNT(*) = (
    SELECT MAX(SLDG)
    FROM (
        SELECT COUNT(*) AS SLDG
        FROM reviews
        GROUP BY userId
    ) AS subquery
);

-- Hiển thị top 3 sản phẩm bán chạy nhất (dựa trên số lượng đã bán).
SELECT * From products
ORDER BY quantitySold DESC
LIMIT 3;
-- Tìm sản phẩm bán chạy nhất tại cửa hàng có storeId = 'S001'.
SELECT p.*, SUM(od.quantityOrder) AS total_sold
FROM products p
JOIN order_details od ON p.productId = od.productId
JOIN stores s ON s.storeId = p.storeId
WHERE s.storeId = 'S001'
GROUP BY p.productId
ORDER BY total_sold DESC
LIMIT 1;


-- Hiển thị danh sách tất cả các sản phẩm có giá trị tồn kho lớn hơn 1 triệu (giá * số lượng).
SELECT * 
FROM products
WHERE price*quantity > 1000000;
-- Tìm cửa hàng có tổng doanh thu cao nhất.
SELECT s.* , SUM(o.totalPrice) AS DT
From stores s
JOIN orders o
ON o.storeId = s.storeId
GROUP BY s.storeId
ORDER BY DT DESC
LIMIT 1;


-- Hiển thị danh sách người dùng và tổng số tiền họ đã chi tiêu.
SELECT u.*, SUm(o.totalPrice) AS Tongtien
FROM users u
JOIN orders o
ON o.userId=u.userId
GROUP BY u.userId;
-- Tìm đơn hàng có tổng giá trị cao nhất và liệt kê thông tin chi tiết.
SELECT * From orders 
WHERE totalPrice =(SELECT MAX(totalPrice) From orders);
-- Tính số lượng sản phẩm trung bình được bán ra trong mỗi đơn hàng.
SELECT * , round(AVG(quantityOrder)) AS SLTB
FROM order_details os
GROUP BY orderDetailId;
-- Hiển thị tên sản phẩm và số lần sản phẩm đó được thêm vào giỏ hàng.
SELECT p.productName,Count(*) AS SL
FROM products p
JOIN carts c
ON c.productId=p.productId
GROUP BY p.productId;
-- Tìm tất cả các sản phẩm đã bán nhưng không còn tồn kho trong kho hàng.
SELECT * From products p
JOIN order_details os
ON os.productId= p.productId
WHERE p.quantity=0;
-- Tìm các đơn hàng được thực hiện bởi người dùng có email là duong@gmail.com'.
SELECT o.*,u.email
From orders o
JOIN users u
ON u.userId=o.userId
WHERE u.email='duong@gmail.com';
-- Hiển thị danh sách các cửa hàng kèm theo tổng số lượng sản phẩm mà họ sở hữu.
SELECT s.*,COUNT(p.productId) AS SLSP
FROM stores s
JOIN products p
ON p.storeId=s.storeId
GROUP BY s.storeId;

-- Exercise 04
-- Tạo view (Bảng ảo) để hiển thị dữ liệu theo các yêu cầu sau
-- View hiển thị tên sản phẩm (productName) và giá (price) từ bảng products với giá trị giá (price) lớn hơn 500,000 có tên là expensive_products
CREATE VIEW expensive_products AS
	SELECT p.productName,p.price
    From products p
	WHERE p.price>500000;
-- Truy vấn dữ liệu từ view vừa tạo expensive_products
SELECT * From expensive_products;

-- Làm thế nào để cập nhật giá trị của view? Ví dụ, cập nhật giá (price) thành 600,000 cho sản phẩm có tên Product A trong view expensive_products.
UPDATE products
SET price = 600000
WHERE productName = 'Product A';

-- Làm thế nào để xóa view expensive_products?
DROP VIEW expensive_products;
--  Tạo một view hiển thị tên sản phẩm (productName), tên danh mục (categoryName) bằng cách kết hợp bảng products và categories.
CREATE View Shows AS
SELECT p.productName,c.categoryName
FROM products p
JOIN categories c
ON c.categoryId=p.categoryId;
-- Exercise 05
-- Làm thế nào để tạo một index trên cột productName của bảng products?
CREATE INDEX productName_index ON products(productName);
-- Hiển thị danh sách các index trong cơ sở dữ liệu?
SELECT 
    TABLE_NAME AS table_name,
    INDEX_NAME AS index_name
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'sqlvip'
GROUP BY TABLE_NAME, INDEX_NAME;

-- Trình bày cách xóa index idx_productName đã tạo trước đó?
SHOW INDEX FROM products;

DROP INDEX productName_index ON products;
-- Tạo một procedure tên getProductByPrice để lấy danh sách sản phẩm với giá lớn hơn một giá trị đầu vào (priceInput)?
DELIMITER $$

CREATE PROCEDURE getProductByPrice(IN priceInput DECIMAL(10, 2))
BEGIN
    SELECT productId, productName, price
    FROM products
    WHERE price > priceInput;
END $$

DELIMITER ;

	
-- Làm thế nào để gọi procedure getProductByPrice với đầu vào là 500000?
CAll getProductByPrice(500000);
-- Tạo một procedure getOrderDetails trả về thông tin chi tiết đơn hàng với đầu vào là orderId?
DELIMITER $$

CREATE PROCEDURE getOrderDetails(IN orderIdInput VARCHAR(100))
BEGIN
    SELECT 
        o.orderId,
        o.orderDate,
        o.customerId,
        od.productId,
        od.quantity,
        od.price
    FROM orders o
    JOIN order_details od ON o.orderId = od.orderId
    WHERE o.orderId = orderIdInput;
END $$

DELIMITER ;

-- Làm thế nào để xóa procedure getOrderDetails?
DROP PROCEDURE getOrderDetails;
-- Tạo một procedure tên addNewProduct để thêm mới một sản phẩm vào bảng products. Các tham số gồm productName, price, description, và quantity.
DELIMITER $$

CREATE PROCEDURE addNewProduct (IN productNamei VARCHAR(100),In pricei DECIMAL(10,2),IN descriptioni VARCHAR(200),IN quantityi INT )
BEGIN
	INSERT INTO products (productName, price, description, quantity)
    VALUES (productNamei,pricei,descriptioni,quantityi);
END $$
DELIMITER ;

-- Tạo một procedure tên deleteProductById để xóa sản phẩm khỏi bảng products dựa trên tham số productId.
DELIMITER $$

CREATE PROCEDURE deleteProductById(IN productIdi VARCHAR(100))
BEGIN
	DELETE FROM products
    WHERE productId=productIdi;
END $$
DELIMITER ;
-- Tạo một procedure tên searchProductByName để tìm kiếm sản phẩm theo tên (tìm kiếm gần đúng) từ bảng products.
DELIMITER $$

CREATE PROCEDURE searchProductByName(IN namei VARCHAR(50))
BEGIN
	SELECT * From products
    WHERE productName like namei;
END $$
DELIMITER ;
-- Tạo một procedure tên filterProductsByPriceRange để lấy danh sách sản phẩm có giá trong khoảng từ minPrice đến maxPrice.
DELIMITER $$

CREATE PROCEDURE filterProductsByPriceRange(IN minPrice DECIMAL(10,2),IN maxPrice DECIMAL(10,2))
BEGIN
	SELECT * From products
    WHERE price BETWEEN minPrice and maxPrice;
END $$
DELIMITER ;
-- Tạo một procedure tên paginateProducts để phân trang danh sách sản phẩm, với hai tham số pageNumber và pageSize.
DELIMITER $$

CREATE PROCEDURE paginateProducts(IN pageNumber INT, IN pageSize INT)
BEGIN
    DECLARE offsetValue INT;
    SET offsetValue = (pageNumber - 1) * pageSize;

    SELECT productId, productName, price, description
    FROM products
    LIMIT offsetValue, pageSize;
END $$
DELIMITER ;
CALL paginateProducts(1,20);

 