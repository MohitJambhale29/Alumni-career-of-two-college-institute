-- 1. Create new schema as ecommerce

create schema ecommerce;
use ecommerce;

-- 2.Import .csv file users_data into MySQL
-- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)

use ecommerce;
SELECT 
    *
FROM
    users_data;
SELECT 
    COUNT(*)
FROM
    users_data;

-- 3.Run SQL command to see the structure of table

desc users_data;

-- 4.Run SQL command to select first 100 rows of the database.

SELECT 
    *
FROM
    users_data
LIMIT 100;

-- 5.How many distinct values exist in table for field country and language.

SELECT 
    COUNT(DISTINCT country) Country,
    COUNT(DISTINCT language) Language
FROM
    users_data;

-- 6.Check whether male users are having maximum followers or female users.

SELECT 
    gender, SUM(socialNBFollowers)
FROM
    users_data
GROUP BY gender;

-- 7.Calculate the total users those:
-- a.Uses Profile Picture in their Profile

SELECT 
    COUNT(hasProfilePicture) User_with_Profile_Picture
FROM
    users_data
WHERE
    hasProfilePicture = 'true';

-- b.Uses Application for Ecommerce platform
SELECT 
    COUNT(hasAnyApp) User_with_Anyapp
FROM
    users_data
WHERE
    hasAnyApp = 'true';

-- c.Uses Android app
SELECT 
    COUNT(hasAndroidApp) User_with_Androidapp
FROM
    users_data
WHERE
    hasAndroidApp = 'true';

-- d.Uses ios app
SELECT 
    COUNT(hasIosApp) User_with_Iosapp
FROM
    users_data
WHERE
    hasIosApp = 'true';

-- 8.Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.)

SELECT 
    country, COUNT(productsBought) Buyers
FROM
    users_data
GROUP BY country
ORDER BY Buyers DESC;

-- 9.Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.)

SELECT 
    country, COUNT(productsSold) Sellers
FROM
    users_data
GROUP BY country
ORDER BY Sellers ASC;

-- 10.Display name of top 10 countries having maximum products pass rate.

SELECT 
    country
FROM
    users_data
GROUP BY country
HAVING MAX(productsPassRate)
LIMIT 10;

-- 11.Calculate the number of users on an ecommerce platform for different language choices

SELECT 
    language, COUNT(language)
FROM
    users_data
GROUP BY language;

-- 12.Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. (Hint: use UNION to answer this question.)

select * from users_data;
SELECT 'Wishlist', 
    count(productsWished) Question_12
FROM
    users_data
WHERE
    gender = 'F' and  productsWished > 0
UNION SELECT 'Social_Ecommerce',
    count(socialProductsLiked)
FROM
    users_data
WHERE
    gender = 'F' and socialProductsLiked > 0 ;
-- choice of female users about putting the product in a wishlist or to like socially om an ecommerce platform is not same. 


-- 13.Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)

SELECT 
    COUNT(productsBought) Question_13
FROM
    users_data
WHERE
    gender = 'M' 
UNION SELECT 
    COUNT(productsSold) Seller
FROM
    users_data
WHERE
    gender = 'M';
-- choice of male users about being seller or buyer is same.


-- 14.Which country is having maximum number of buyers?
select * from users_data;
SELECT 
    country, MAX(productsBought) Max_no_of_buyers
FROM
    users_data
GROUP BY country
ORDER BY MAX(productsBought) DESC
LIMIT 1;
-- Belfique country is having maximum number of buyers.


-- 15.List the name of 10 countries having zero number of sellers.

SELECT 
    country, count(productsSold)
FROM
    users_data
WHERE
    productsSold = 0
group by country
order by count(productsSold) desc
LIMIT 10;

-- 16.Display record of top 110 users who have used ecommerce platform recently.

SELECT 
    *
FROM
    users_data
    
ORDER BY daysSinceLastLogin ASC
LIMIT 110;

-- 17.Calculate the number of female users those who have not logged in since last 100 days.

SELECT 
    COUNT(type)
FROM
    users_data
WHERE
    gender = 'F'
        AND daysSinceLastLogin >= 100;

-- 18.Display the number of female users of each country at ecommerce platform.

SELECT 
    country, COUNT(gender) Female_users
FROM
    users_data
WHERE
    gender = 'F'
GROUP BY country;

-- 19.Display the number of male users of each country at ecommerce platform.

SELECT 
    country, COUNT(gender) Male_users
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;

-- 20.Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

SELECT 
    country,
    AVG(productsSold) Products_sold,
    AVG(productsBought) Products_bought
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;