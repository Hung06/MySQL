SELECT 
    MONTH(s.SaleDate) AS SaleMonth,
    SUM(sd.Quantity * sd.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN SalesDetails sd ON s.SalesID = sd.SalesID
WHERE YEAR(s.SaleDate) YEAR(CURDATE()) -1
GROUP BY SaleMonth
Order BY SaleMonth;