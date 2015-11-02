CREATE VIEW DOC_ALL_V
AS
  SELECT DOC_ID, DOC_CODE, DOC_NAME FROM
    (SELECT
       A.DB_ID AS DOC_ID,
       A.DB_CODE AS DOC_CODE,
       A.DB_NAME AS DOC_NAME
     FROM
       DOC_BUYING A
  
  UNION
    SELECT
      B.DC_ID AS DOC_ID,
      B.DC_CODE AS DOC_CODE,
      B.DC_NAME AS DOC_NAME
    FROM
      DOC_CONTRACT B
  
  UNION
    SELECT
      C.DF_ID AS DOC_ID,
      C.DF_CODE AS DOC_CODE,
      C.DF_NAME AS DOC_NAME
    FROM
      DOC_FINANCE C
      
  UNION
    SELECT
      D.DL_ID AS DOC_ID,
      D.DL_CODE AS DOC_CODE,
      D.DL_NAME AS DOC_NAME
    FROM
      DOC_LAB D
      
  UNION
    SELECT
      E.DMI_ID AS DOC_ID,
      E.DMI_CODE AS DOC_CODE,
      E.DMI_NAME AS DOC_NAME
    FROM
      DOC_MEDICAL_INPUT E
      
  UNION
    SELECT
      F.DMO_ID AS DOC_ID,
      F.DMO_CODE AS DOC_CODE,
      F.DMO_NAME AS DOC_NAME
    FROM
      DOC_MEDICAL_ORDERS F
      
  UNION
    SELECT
      G.DMO_ID AS DOC_ID,
      G.DMO_CODE AS DOC_CODE,
      G.DMO_NAME AS DOC_NAME
    FROM
      DOC_MEDICAL_OUTPUT G
      
  UNION
    SELECT
      H.DO_ID AS DOC_ID,
      H.DO_CODE AS DOC_CODE,
      H.DO_NAME AS DOC_NAME
    FROM
      DOC_OUTGOINGS H
      
  UNION
    SELECT
      I.DP_ID AS DOC_ID,
      I.DP_CODE AS DOC_CODE,
      I.DP_NAME AS DOC_NAME
    FROM
      DOC_PAYMENT I
      
  UNION
    SELECT
      J.DR_ID AS DOC_ID,
      J.DR_CODE AS DOC_CODE,
      J.DR_NAME AS DOC_NAME
    FROM
      DOC_REQUISITION J
      
  UNION
    SELECT
      K.DR_ID AS DOC_ID,
      K.DR_CODE AS DOC_CODE,
      K.DR_NAME AS DOC_NAME
    FROM
      DOC_RESERVATION K
      
  UNION
    SELECT
      L.DS_ID AS DOC_ID,
      L.DS_CODE AS DOC_CODE,
      L.DS_NAME AS DOC_NAME
    FROM
      DOC_SELL L
      
  UNION
    SELECT
      M.DSI_ID AS DOC_ID,
      M.DSI_CODE AS DOC_CODE,
      M.DSI_NAME AS DOC_NAME
    FROM
      DOC_STORAGEORDER_INPUT M
      
  UNION
    SELECT
      N.DSO_ID AS DOC_ID,
      N.DSO_CODE AS DOC_CODE,
      N.DSO_NAME AS DOC_NAME
    FROM
      DOC_STORAGEORDER_OUTPUT N
      
  UNION
    SELECT
      O.DWI_ID AS DOC_ID,
      O.DWI_CODE AS DOC_CODE,
      O.DWI_NAME AS DOC_NAME
    FROM
      DOC_WAREHOUSE_IN O
      
  UNION
    SELECT
      P.DWO_ID AS DOC_ID,
      P.DWO_CODE AS DOC_CODE,
      P.DWO_NAME AS DOC_NAME
    FROM
      DOC_WAREHOUSE_OUT P
      
  UNION
    SELECT
      R.DWO_ID AS DOC_ID,
      R.DWO_CODE AS DOC_CODE,
      R.DWO_NAME AS DOC_NAME
    FROM
      DOC_WORK_ORDERS R
    )
  ORDER BY
    DOC_NAME
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    