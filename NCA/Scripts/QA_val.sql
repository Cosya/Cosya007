--������ ����� ������ ����� ��������� � ������
DELETE FROM EPAS.[dbo].[stg_t_s_report_excel]
WHERE DatasetID = '467CA11F-AF76-490A-B2F8-6770AE217777';

DELETE FROM EPAS.[dbo].[t_s_report_excel]
where EffectiveMonthDate is null;

--��������� �������, ��� ����� SSIS 
INSERT INTO EPAS.[dbo].[stg_t_s_report_excel]
	  ( [Full_Name_UA]
      ,[Full_Name]
      ,[Relationship_IP]
      ,[Relationship_Partner]
      ,[Partner_Company]
      ,[Department]
      ,[Group_Leader]
      ,[Project]
      ,[Direct_Manager]
      ,[Hourly_Pay_Type]
      ,[Grade]
      ,[Maternity_Leave]
      ,[Compensation_Package_Group]
      ,[Location]
      ,[Staff_Type]
      ,[Start_Date]
      ,[Base]
      ,[Currency]
      ,[Addon]
      ,[Type_addon]
      ,[Variable]
      ,[Created_by]
      ,[Created_on]
      ,[Status_id]
      ,[DatasetID])

SELECT [Full_Name_UA]
      ,[Full_Name]
      ,[Relationship_IP]
      ,[Relationship_Partner]
      ,[Partner_Company]
      ,[Department]
      ,[Group_Leader]
      ,[Project]
      ,[Direct_Manager]
      ,[Hourly_Pay_Type]
      ,[Grade]
      ,[Maternity_Leave]
      ,[Compensation_Package_Group]
      ,[Location]
      ,[Staff_Type]
      ,[Start_Date]
      ,[Base]
      ,[Currency]
      ,[Addon]
      ,[Type_addon]
      ,[Variable]
      ,[Created_by]
      ,[Created_on]
      ,[Status_id]
	  ,'467CA11F-AF76-490A-B2F8-6770AE217777'  --���� �������� �������
  FROM [EPAS].[dbo].[stg_t_s_report_excel]
  WHERE DatasetID = '467CA11F-AF76-490A-B2F8-6770AE217EEE'
  
  ;

  ---������  ������� ������ �� ����� �������� (����� ����������)

  Update [EPAS].[dbo].[stg_t_s_report_excel]
  set [Addon] = 'fail' -- �������� ��������� �� ������ ����� ������ ������
  where 
	Full_Name = 'Tucker Perry' 
	and DatasetID = '467CA11F-AF76-490A-B2F8-6770AE217777'	;



  --����� ��������� -  ���������  ��������� ��������� � ������� ������ �����


GO

DECLARE @RC int

EXECUTE  EPAS.[dbo].[usp_val_ExcelImport]
 '467CA11F-AF76-490A-B2F8-6770AE217777'
GO

--���� ������ ��� �� ������� ��� ������ ������ � ������ - ��� ����� ��� �������� , �� � ������ ����� EffectiveMonthDate - ��� ����������� ����� �� ��������

SELECT * 
  FROM [EPAS].[dbo].[t_s_report_excel]
  where EffectiveMonthDate is null;


  --���� ������ ���� �� ��� ������� � [t_Excell_load_errors]

  SELECT*
  FROM [EPAS_DEV].[dbo].[t_Excell_load_errors]
  where  DatasetID = '467CA11F-AF76-490A-B2F8-6770AE217777'

