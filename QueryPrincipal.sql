SELECT 
    DISTINCT A."OBJECT_ID", 
    TO_CHAR(A."GUID") GUID, 
    OC."PROC_ORG", 
    C."BID_TYPE" 

FROM ( 
    SELECT 
        "GUID", 
        TRIM(LEADING '0' FROM "OBJECT_ID") OBJECT_ID, 
        "DESCRIPTION", 
        "PROCESS_TYPE", 
        "QUOT_DEAD", 
        "OPEN_TIME", 
        "QUOT_DEAD_TIME", 
        "CREATED_AT" 
    FROM "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_DADOS_OPORTUNIDADE" 

    UNION ALL 

    SELECT 
        "GUID", 
        TRIM(LEADING '0' FROM "OBJECT_ID") OBJECT_ID, 
        "DESCRIPTION", 
        "PROCESS_TYPE", 
        "QUOT_DEAD", 
        "OPEN_TIME", 
        "QUOT_DEAD_TIME", 
        "CREATED_AT" 
    FROM "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_DADOS_LEILAO"
) AS A 

LEFT JOIN "_SYS_BIC"."Petronect.Analytics.SRM.CalculationView/CV_ORGANIZACAO_COMPRAS" AS OC 
    ON A."GUID" = OC."GUID_HI" 
LEFT JOIN "LT_SCP_JNP"."BBP_PDHSC" AS B 
    ON A."GUID" = B."GUID" 
LEFT JOIN "LT_SCP_JNP"."BBP_PDHSB" AS C 
    ON A."GUID" = C."GUID" 

WHERE 
    A."QUOT_DEAD" >= ADD_MONTHS(FIRST_DAY(CURRENT_DATE), -1)
    AND A."QUOT_DEAD" < FIRST_DAY(CURRENT_DATE) 
