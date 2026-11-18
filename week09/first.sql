-- 9주차 첫 실습: Codespace에서 SQL 실행해 보기
-- 실행 방법 1: 터미널에서   sqlite3 -header -column data/seoul_sales.db < week09/first.sql
-- 실행 방법 2: 이 파일에서 오른쪽 클릭 -> Run Query (처음 한 번은 데이터베이스로 data/seoul_sales.db 선택)
-- 표 sales: 서울시 상권분석서비스 추정매출, 한 행 = 한 분기 · 한 상권 · 한 업종의 매출
-- 당월_매출_금액은 분기 매출(개인 + 법인). 기준_년분기_코드 20251 = 2025년 1분기

-- [1] 표의 크기와 기간
SELECT COUNT(*) AS 행수,
       MIN(기준_년분기_코드) AS 처음_분기,
       MAX(기준_년분기_코드) AS 마지막_분기
FROM   sales;

-- [2] 분기별 매출 (조 원)
SELECT 기준_년분기_코드,
       ROUND(SUM(당월_매출_금액) / 1e12, 2) AS 매출_조
FROM   sales
GROUP BY 기준_년분기_코드
ORDER BY 기준_년분기_코드;

-- [3] 월별 매출 (월별 자료를 sales_monthly 표로 불러온 뒤 실행)
-- 현재 sales 표는 분기 자료이므로 아래 쿼리로 정확한 월별 매출을 계산할 수 없음.
-- 월별 표에는 기준_년월_코드(예: 202501)와 당월_매출_금액 열이 있어야 함.
-- 월별 자료를 sales_monthly 표로 준비한 뒤 아래 쿼리의 주석(--)을 제거해 실행.
-- SELECT 기준_년월_코드,
--        ROUND(SUM(당월_매출_금액) / 1e9, 1) AS 매출_십억
-- FROM   sales_monthly
-- GROUP BY 기준_년월_코드
-- ORDER BY 기준_년월_코드;
