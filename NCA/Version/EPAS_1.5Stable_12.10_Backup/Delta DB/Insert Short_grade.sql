
Insert into [dbo].[t_short_grades] ([Long_Grade],[Short_Grade],[Grade],[Specialization],[Grade_Type] )
     



Select 'Expert Software Engineer (ServiceNow)'						 , 'ServiceNow Exp Dev'		,'Expert'	,'ServiceNow',			'Developer' 
 Union all 
select 'Junior Consultant (SAP)'									 , 'Sap Jr'					,'Junior'	,'SAP',					'Developer'
 Union all 
select 'Junior Software Engineer (Data Science)'					 ,	'Data Jr'				,'Junior'	,'Data Science',		'Developer'
 Union all 
select 'Middle Consultant (SAP)'									 ,	'Mid Sap'				,'Middle'	,'SAP',					'Developer'
 Union all 
select 'Middle Designer (Mobile Solutions)'							 ,	'Mid Designer'			,'Middle'	,'Mobile Solutions',	'Developer'
 Union all 																
select 'Middle Software Engineer (SharePoint)'						 ,	'Mid SharePoint Dev'	,'Middle'	,'SharePoint',			'Developer'
 Union all 																
select 'Senior Analyst (ServiceNow)'								 ,	'Sr analyst'			,'Senior'	,'ServiceNow',			'Developer'
 Union all 																
select 'Senior Financial Controller (No specialization)'			 ,	'Sr Fin'				,'Senior'	,'No specializatio',	'Developer'
 Union all 																
select 'Senior IT Engineer (MS Windows Server)'					    ,	'Sr IT'					,'Senior'	,'MS Windows Server',	'Developer'
 Union all 																
select 'Trainee Quality Control Engineer (Software testing)'		 ,	'QA Tr Dev'				,'Trainee'	,'Software testing',	'Developer'
 Union all 																
select 'Trainee Software Engineer (.NET)'							 ,	'.NET Tr Dev'			,'Trainee'	,'.NET',				'Developer'