SELECT sa.TotalAmount, st.StoreName
From Sales AS sa
INNER JOIN Stores AS st
ON sa.StoreID = st.StoreID
ORDER BY sa.TotalAmount DESC
Having LIMIT 3;


SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(s.SaleID) AS NumberOfOrders,
    SUM(s.TotalAmount) AS TotalSpending
FROM Customers AS c
INNER JOIN Sales AS s ON c.CustomerID = s.CustomerID
WHERE YEAR(s.SaleDate) = 2024
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(s.TotalAmount) > 10000
ORDER BY TotalSpending DESC;

