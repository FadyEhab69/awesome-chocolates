select * from products;
-- Scenario: Optimizing Sales and Operations for Awesome Chocolates
-- The owner of Awesome Chocolates wants to improve the company’s sales strategy and operational efficiency.
-- They’ve tasked me, the data analyst, with analyzing the data to uncover trends, identify top performers, and recommend strategies for growth. we’ll use the awesome chocolates database to answer key questions that will help the owner make data-driven decisions
-- 1/Sales Performance by Region
-- ما هي المناطق التي تحقق أعلى إيرادات مبيعات، وكيف يختلف هذا مع مرور الوقت؟
-- الهدف: تحديد المناطق ذات الأداء العالي لتخصيص المزيد من الموارد، والمناطق ذات الأداء المنخفض للتسويق المُستهدف.
SELECT g.Region, g.Geo, SUM(s.Amount) as total_revenue, COUNT(s.SaleDate) as total_transactions
FROM sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region, g.Geo
ORDER BY total_revenue DESC;

-- هنقوم بتقسيم الإيرادات شهريًا لتحديد علشان نعرف مبيعات كل موسم
SELECT g.Region, g.Geo, DATE_FORMAT(s.SaleDate, '%Y-%m') as sale_month, SUM(s.Amount) as monthly_revenue
FROM sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region, g.Geo, sale_month
ORDER BY sale_month, monthly_revenue DESC;

-- التوقعات: قد تتصدر الأمريكتان (الولايات المتحدة الأمريكية وكندا) المبيعات 
-- اكثر المبيعات في موسم (يناير ٢٠٢١) إلى مبيعات 

-- 2/ عاوزين نشوف شعبية المنتج و مدي الربح بتاعتة
-- السؤال: ما هي المنتجات الأكثر انتشار من حيث عدد الصناديق اللي اتباعت ؟
-- الهدف: تحسين المخزون بالتركيز على المنتجات عالية الطلب وعالية الربحية
SELECT g.Region, p.Product, SUM(s.Boxes) as total_boxes_sold
FROM sales s
JOIN products p ON s.PID = p.PID
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region, p.Product
ORDER BY total_boxes_sold DESC;
-- التوقعات ك: منتج Orange Choco هو الاكثر مبيعا 

-- 3/ أداء مندوبي المبيعات والفرق
-- السؤال: من هم مندوبي المبيعات والفرق الأفضل أداءً من حيث الإيرادات وعدد العملاء الذين تمت خدمتهم؟
-- الهدف: مكافأة أصحاب الأداء المتميز وتحديد الفرق أو الأفراد الذين يحتاجون إلى الدعم
SELECT p.Salesperson, p.Team, p.Location, SUM(s.Amount) as total_revenue, 
       SUM(s.Customers) as total_customers, SUM(s.Boxes) as total_boxes
FROM sales s
JOIN people p ON s.SPID = p.SPID
GROUP BY p.Salesperson, p.Team, p.Location
ORDER BY total_revenue DESC
LIMIT 5;
 
 select * from people
 where Team in ( 'delish', 'yummies ');
 
-- كدا افضل تيمين هما delish, yummies

-- 4/Cost vs. Revenue
-- السؤال: ما هي المنتجات التي تحقق أفضل نسبة إيرادات إلى تكلفة، وهل هناك منتجات أخرى ذات أداء ضعيف؟
-- الهدف: تحسين محفظة المنتجات بالتركيز على المنتجات ذات هامش الربح المرتفع
SELECT p.Product, p.Cost_per_box, SUM(s.Amount) as total_revenue, SUM(s.Boxes) as total_boxes,
       (SUM(s.Amount) / (SUM(s.Boxes) * p.Cost_per_box)) as revenue_to_cost_ratio
FROM sales s
JOIN products p ON s.PID = p.PID
GROUP BY p.Product, p.Cost_per_box
ORDER BY revenue_to_cost_ratio DESC;
-- تحقق منتجات مثل "الشوكولاتةفضة التكلفة للعلبة (0.16 دولار أمريكي) نسبة إيرادات إلى تكلفة عالية

select SPID , PID , Amount , Boxes, Amount / Boxes'amount_of_boxes'from sales ;

-- 5/ عاوزين نعرف اجمالي الايرادات في كل المناطق 
-- الهدف : نعرف ب نبيع ب اجمالي كام لحد الوقت الحالي
SELECT SUM(s.Boxes * p.Cost_per_box) as total_revenue
FROM sales s
JOIN products p ON s.PID = p.PID;

-- 6/أفضل 5 منتجات مبيعًا حسب المنطقة
-- علشان نعرف المنحني الخاص ب منتاجات و البيع شكلة ازاي
SELECT g.Region, p.Product, SUM(s.Boxes) as total_boxes
FROM sales s
JOIN products p ON s.PID = p.PID
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Region, p.Product
ORDER BY g.Region, total_boxes DESC
LIMIT 5;
-- كدا امريكا حتل كل مناطق و اشهر المماجات مبيعا هما 
--  'Organic Choco Syrup','White Choc' 'Orange Choco 'Manuka Honey Choco' 'Eclairs', 

-- ملخص الرؤى والتوصيات
-- تجاهات الإيرادات: إذا حققت منطقة آسيا والمحيط الهادئ إيرادات مرتفعة، فكّر في توسيع الإنتاج هناك.
-- التركيز على المنتج: الترويج للمنتجات عالية الإيرادات مثل "ألواح الحليب" (P01) أو تعديل المخزون للمنتجات منخفضة المبيعات.
-- تحسين أداء الفريق: مكافأة الفرق المتميزة (مثل "ياميز") ومعالجة الثغرات في مندوبي المبيعات غير المتعاونين.
-- استراتيجية الموقع: تعزيز الموارد في المواقع عالية الأداء مثل حيدر أباد. 
-- الكفاءة التشغيلية: تصحيح التباينات في الكمية مقابل الصناديق في  التكلفة الصندوق الواحد لضمان دقة التقارير.

-- عاوزين نجيب القيم اللي اكبر من 10000 و السنة 2022
select SaleDate, Amount from sales
where amount > 10000 and SaleDate >='2022-01-01'
order by amount desc;

-- عدد العمليات اللي حصلت في اخر الاسبوع
select  PID,GeoID ,SaleDate,Amount,Boxes , weekday(SaleDate)
as 'day of week' from sales
where weekday(SaleDate) = 4;

