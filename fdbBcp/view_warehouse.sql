CREATE VIEW APPLIANCES_HPWAREHOUSE_V 
AS 
SELECT
  A.AHPW_ID,
  A.AHPW_CODE,
  A.AHPW_NAME,
  A.AHPW_LOCATION,
  A.AHPW_ADDRESS,
  A.AHPW_PHONE,
  A.AHPW_FAX,
  A.AHPW_MAIL,
  A.AHPW_DEPARTMENT,
  B.L_CODE AS ZIP_CODE,
  B.L_NAME AS LOCATION_NAME,
  C.D_CODE AS DEPARTMENT_CODE,
  C.D_NAME AS DEPARTMENT_NAME
FROM
  APPLIANCES_HPWAREHOUSE A,
  LOCATION B,
  DEPARTMENT C
WHERE
  B.L_ID = A.AHPW_LOCATION
  AND
  C.D_ID = A.AHPW_DEPARTMENT
ORDER BY
  A.AHPW_ID
