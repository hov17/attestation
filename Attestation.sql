-- 1.Найти самый дорогой товар. Вывести имя товара и его цену
SELECT g.name AS ИМЯ_ТОВАРА, p.value AS ЦЕНА_ТОВАРА FROM goods g  
LEFT JOIN prices p ON p.goods_id = g.id
LEFT JOIN quantity q ON q.goods_id = g.id
RIGHT JOIN suppliers s ON g.supplier_id = s.id
RIGHT JOIN manufacturer m ON s.manufacturer_id = m.id
WHERE p.value = (SELECT MAX(p.value) FROM prices p)


--2.Найти товары с нулевым остатком. Вывести имя товара и его цену
SELECT g.name AS ИМЯ_ТОВАРА, p.value AS ЦЕНА FROM goods g 
LEFT JOIN prices p ON p.goods_id = g.id
LEFT JOIN quantity q ON q.goods_id = g.id
RIGHT JOIN suppliers s ON g.supplier_id = s.id
RIGHT JOIN manufacturer m ON s.manufacturer_id = m.id
WHERE q.value = 0


--3.Найти производителя с самой большой средней ценой за товары. Вывести имя производителя и среднюю стоимость
SELECT m.name AS ИМЯ_ПРОИЗВОДИТЕЛЯ, ROUND(AVG(p.value), 2) AS СРЕДНЯЯ_ЦЕНА_ТОВАРА FROM goods g  
LEFT JOIN prices p ON p.goods_id = g.id
LEFT JOIN quantity q ON q.goods_id = g.id
RIGHT JOIN suppliers s ON g.supplier_id = s.id
RIGHT JOIN manufacturer m ON s.manufacturer_id = m.id
GROUP BY m.name
HAVING ROUND(AVG(p.value), 2) > 0
ORDER BY AVG(p.value)
DESC
LIMIT 1


-- 4.Найти все товары производителей из Москвы. Вывести имена товаров, их цены и имена производителей
SELECT g.name AS ИМЯ_ТОВАРА, p.value AS ЦЕНА, m.name AS ИМЯ_ПРОИЗВОДИТЕЛЯ FROM goods g 
LEFT JOIN prices p ON p.goods_id = g.id
LEFT JOIN quantity q ON q.goods_id = g.id
RIGHT JOIN suppliers s ON g.supplier_id = s.id
RIGHT JOIN manufacturer m ON s.manufacturer_id = m.id
WHERE m.location = 'Moscow'
ORDER by p.value