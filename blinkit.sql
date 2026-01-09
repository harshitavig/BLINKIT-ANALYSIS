CREATE DATABASE blinkit_grocery_sales
USE blinkit_grocery_sales

ALTER TABLE blinkit_data
CHANGE COLUMN `ï»¿Item Fat Content` Item_Fat_Content VARCHAR(50) 

SELECT DISTINCT(Item_Fat_Content)
FROM blinkit_data


#SAFE MOD QUERY
SET sql_safe_updates=0

#UPDATING THE DATA
UPDATE blinkit_data 
SET Item_Fat_Content=
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content='reg' THEN 'Regular'
ELSE Item_Fat_Content
END

SELECT * FROM blinkit_data

#TOTAL SALES
SELECT concat(round(sum(Sales)/1000),'k') as Total_sales 
FROM blinkit_data


#AVERAGE SALES
SELECT cast(avg(Sales) as decimal(10,1)) as Avg_sales 
FROM blinkit_data

#TOTAL NO OF ITEMS
SELECT count(*) as No_of_Items 
FROM blinkit_data

#AVERAGE RATING
SELECT cast(avg(Rating) as decimal (10,2))
FROM blinkit_data 

#TOTAL SALES BY FAT CONTENT
SELECT Item_Fat_Content,
       concat(round(sum(Sales)),'k')as total_sales,
       cast(avg(Sales) as decimal(10,1)) as Avg_sales,
       cast(avg(Rating) as decimal (10,2)),
       count(*) as No_of_Items 
FROM blinkit_data
WHERE `Outlet Establishment Year`=2022
GROUP BY Item_Fat_Content
ORDER BY total_sales desc

#SALES BY ITEM TYPE
SELECT `Item Type`,
       concat(round(sum(Sales)),'k')as total_sales,
       cast(avg(Sales) as decimal(10,1)) as Avg_sales,
       cast(avg(Rating) as decimal (10,2)),
       count(*) as No_of_Items 
      
FROM blinkit_data
WHERE `Outlet Establishment Year`=2022
GROUP BY `Item Type`
ORDER BY total_sales desc 

#FAT CONTENT BY OUTLET FOR TOTAL SALES
SELECT `Outlet Location Type`,
        round(sum(case 
        when Item_Fat_Content= 'Low Fat' then Sales
        else 0
        end)/1000,2) as low_fat_k,
        round(sum(case
        when Item_Fat_Content='Regular' then Sales
        else 0
        end)/1000,2) as regular_k
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type` 

#TOTAL SALES BY OUTLET ESTABLISHMENT
SELECT `Outlet Establishment Year`,
        cast(sum(Sales) as decimal(10,2)) as total_sales
FROM blinkit_data
GROUP BY `Outlet Establishment Year`   
ORDER BY total_sales desc      


#PERCENTAGE OF SALES BY OUTLET SIZE
SELECT `Outlet Size`,
        cast(sum(Sales) as decimal (10,2)) as total_sales,
        cast(sum(Sales)*100.0/sum(sum(Sales)) over() as decimal(10,2)) as sales_percentage
FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY total_sales desc;   

#SALES BY OUTLET LOCATION TYPE
SELECT `Outlet Location Type`,
       cast(sum(Sales) as decimal (10,2)) as total_sales
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY total_sales desc    

#SALES BY OUTLET TYPE
SELECT `Outlet Type`,
       cast(sum(Sales) as decimal (10,2)) as total_sales
FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY total_sales desc    

