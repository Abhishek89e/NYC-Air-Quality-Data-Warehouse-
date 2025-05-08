SELECT
    p.Name AS Product,
    pc.Name AS Category
FROM
    Product p
JOIN 
    ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN 
    ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE
    p.Name IS NOT NULL AND pc.Name IS NOT NULL
LIMIT 5;



SELECT
    p.Name AS ProductName,
    p.SellStartDate,
    p.SellEndDate,
    ps.Name AS SubcategoryName
FROM
    Product p
JOIN 
    ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LIMIT 5;



SELECT
    p.Name AS Product,
    ps.Name AS Subcategory
FROM
    Product p
JOIN
    ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LIMIT 5;


SELECT
    ps.Name AS SubcategoryName,
    pc.Name AS CategoryName
FROM
    ProductSubcategory ps
JOIN
    ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
LIMIT 5;


SELECT
    v.Name AS Vendor,
    p.Name AS Product,
    pv.StandardPrice AS Price
FROM
    Vendor v
JOIN
    ProductVendor pv ON v.BusinessEntityID = pv.BusinessEntityID
JOIN
    Product p ON pv.ProductID = p.ProductID
WHERE
    pv.StandardPrice IS NOT NULL

LIMIT 5;


SELECT
    v.Name AS VendorName,
    p.Name AS ProductName,
    pv.StandardPrice AS Price,
    s.Name AS SubCategory_Name
FROM
    Vendor v
JOIN
    ProductVendor pv ON v.BusinessEntityID = pv.BusinessEntityID
JOIN
    Product p ON pv.ProductID = p.ProductID
JOIN
    ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID
LIMIT 7;


SELECT
    p.Name AS Product,
    v.Name AS Vendor,
    pv.AverageLeadTime AS LeadTime
FROM
    Product p
JOIN
    ProductVendor pv ON p.ProductID = pv.ProductID
JOIN
    Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE
    pv.AverageLeadTime IS NOT NULL

LIMIT 5;


