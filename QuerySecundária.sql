SELECT
	TRIM(LEADING '0' FROM A."OBJECT_ID") OBJECT_ID,
	TO_CHAR(A."GUID") AS GUID_OPP,
	TO_CHAR(B."GUID_ITEM") AS GUID_ITEM,
	count(B."NUMBER_INT") ITENS,
	sum(case when B."ITEM_PROCESS_TYP" = 'MATL' THEN 1 END) Bens,
	sum(case when B."ITEM_PROCESS_TYP" = 'SERVICE' THEN 1 END) Servicos
 
FROM ( 	SELECT
			"GUID",
			"OBJECT_ID"
		FROM "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_DADOS_OPORTUNIDADE"
 
		UNION
 
		SELECT
			"GUID",
			"OBJECT_ID"
 
		FROM "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_DADOS_LEILAO") AS A
 
 
LEFT JOIN (	SELECT
				"GUID" AS GUID_ITEM,
				"HEADER",
		 		"NUMBER_INT",
		 		"ITEM_PROCESS_TYP",
		 		"DEL_IND"
			FROM "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_DADOS_ITEM_OPORTUNIDADE"
 
			UNION
 
			SELECT
				"GUID_ITEM",
				"HEADER",
		 		"NUMBER_INT",
		 		"ITEM_PROCESS_TYP",
		 		"DEL_IND"
 
			FROM "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_DADOS_ITEM_LEILAO") AS B
 
		ON A."GUID" = B."HEADER"
 
WHERE B."ITEM_PROCESS_TYP" != 'OUTL' 
AND A."OBJECT_ID" IN ('X')
 
GROUP BY 
	A."OBJECT_ID",
	A."GUID",
	B."GUID_ITEM",
	B."NUMBER_INT"
