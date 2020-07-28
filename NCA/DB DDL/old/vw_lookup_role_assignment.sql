Use [EPAS_DEV];
GO
Create view [dbo].[vw_lookup_role_assignment]
	(
	   [Id]
      ,[Person_Id]
	  ,[Person_Name]
      ,[Project_Id]
	  ,[Project_Name]
      ,[Role_Id]
	  ,[Role_Name]
      ,[Manager_Id]
	  ,[Manager_Name]
      ,[State_Id]
	  , [State_value]
      ,[DateFrom]
      ,[DateTo]
      ,[EmploymentLevel]
      ,[Execution]
      ,[ContractPosition_Id]
	  ,[ContractPosition_Name]
      ,[Workplace_Id]
	  ,[Workplace_Name]
      ,[Sp_Id]	
	  )
as  select 
	   Assignment.[Id]
      ,Assignment.[Person_Id]
	  ,Assignment_Person.[Name] as [Person_Name]
      ,Assignment.[Project_Id]
	  ,Project.[Name] as [Project_Name]
      ,Assignment.[Role_Id]
	  ,Role.[Name] as Role_Name
      ,Assignment.[Manager_Id]
	  ,Assignment_Manager.[Name] as Manager_Name
      ,Assignment.[State_Id]
	  ,state.[Value] as [State_Value]
      ,Assignment.[DateFrom]
      ,Assignment.[DateTo]
      ,Assignment.[EmploymentLevel]
      ,Assignment.[Execution]
      ,Assignment.[ContractPosition_Id]
	  ,ContractPosition.[Name] as [ContractPosition_Name]
      ,[Workplace_Id]
	  ,Location.Name as [Workplace_Name]
      ,[Sp_Id]	
	from 
		ESD.SP.Assignment as Assignment
		left join [ESD].[SP].[ContractPosition] as ContractPosition
			ON ContractPosition.[Id] = Assignment.[ContractPosition_Id]
			
		left join [ESD].[SP].[Location] as Location
			on  Location.[Id] = Assignment.[Workplace_ID]
			
		left join [ESD].[SP].[Person]  as Assignment_Manager
			on  Assignment_Manager.[Id] = Assignment.[Manager_Id]

		left join [ESD].[SP].[Person]  as Assignment_Person
			on  Assignment_Person.[Id] = Assignment.[Person_Id]
		
		left join [ESD].[SP].[Role] as Role
			on  Role.[Id] = Assignment.[role_Id]

		left join [ESD].[SP].[Project] as Project
			on  Project.[Id] = Assignment.[Project_Id]
		
		left join [ESD].[SP].[State] as State
			on  State.[Id] = Assignment.[State_Id]
GO
		

		

			
