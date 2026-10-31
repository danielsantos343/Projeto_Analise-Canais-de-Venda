-- Visão Geral: Desempenho de canal (Store, Online, Reseller, Catalog
SELECT 
	c.ChannelName AS canal,

-- Período coberto pelos dados de cada canal
	MIN(f.DateKey) AS data_inicio,
	MAX(f.Datekey) AS data_fim,

-- Volume de linhas de venda
	COUNT(*) AS total_registros,

-- Métricas Financeiras
	SUM(f.SalesAmount) AS faturamento_total,
	SUM(f.ReturnAmount) AS Devolução_total,
	SUM(f.SalesAmount) - SUM (f.ReturnAmount) AS faturamento_líquido,

-- % de devolução = devoluções / faturamento
	ROUND(SUM(f.ReturnAmount) 
			/ NULLIF(SUM(f.SalesAmount), 0) * 100,2) AS pct_participação

FROM 
	FactSales AS f
INNER JOIN DimChannel AS c ON c.ChannelKey = f.channelKey
INNER JOIN DimDate AS d ON d.DateKey = f.DateKey

-- WHERE d.calendarYear BETWEEN 2007 AND 2009 

GROUP BY d.CalendarYear, c.ChannelName
ORDER BY d.CalendarYear, faturamento_total DESC;