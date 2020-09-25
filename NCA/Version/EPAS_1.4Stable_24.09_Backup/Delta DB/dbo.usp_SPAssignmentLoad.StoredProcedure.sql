USE [EPAS_DEV]
GO
/****** Object:  StoredProcedure [dbo].[usp_PAContextLoad]    Script Date: 15.09.2020 11:03:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[usp_SPAssignmentLoad]
AS
BEGIN

	DECLARE @DefaultInt INT = 0;
	DECLARE @DefaultString nvarchar(255) = 'merging';
	DECLARE @EmptyGuid UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';
	DECLARE @DateMax DATE = CAST('9999-12-31' AS DATE);
	
	WITH Source AS (
					Select
						a.Id,
						Person_id, 
						Per.name as Person,
						Project_Id ,
						pr.Name as Project,
						role_id,
						r.Name as role,
						A.Manager_Id,
						p_m.Name as Manager,
						DateFrom,
						DateTo,
						ContractPosition_Id,
						cp.Name as ContractPosition,
						A.State_Id 
					from 
						[ESD].[SP].[Assignment] A
						join[ESD].[SP].[Person] Per 
							on Per.Id = A.Person_Id
							and per.Department_Id in (
															SELECT
																[Id]
															FROM 
																[EP].[SP].[Department]
															WHERE 
																Name = 'Deloitte BU' 
															)
								and per.Seniority_Id not in		
														(SELECT 
															[Id]
														  FROM 
															[EP].[SP].[Seniority]
														  WHERE
															Name in ('Level 4', 'Level 3', 'Level 2', 'Level 1')
								
															)	
					join [ESD].[SP].Role R
						on R.Id = A.Role_Id
					join [ESD].[SP].Project Pr
						on pr.id = a.Project_Id
					join [ESD].[SP].Person p_m
						on p_m.id = A.Manager_Id
					join [ESD].[SP].ContractPosition cp
						on cp.id = a.ContractPosition_Id

				  where 
					A.State_Id   = (select ID from [ESD].[SP].State
									where value = 1))

		
	
	MERGE INTO [SP].[Assignment] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
			 ISNULL(target.[Person_id],@EmptyGuid) 					<> ISNULL(source.[Person_id],@EmptyGuid) 
			 OR target.[Person] 									<> source.[Person] 				
			 OR  ISNULL(target.[Project_Id],@EmptyGuid)  			<> isnull(source.[Project_Id], @EmptyGuid) 				
			 OR target.[Project]									<> source.[Project]			
			 OR isnull(target.[role_id], @EmptyGuid)				<> isnull(source.[role_id], @EmptyGuid)		
			 OR target.[role] 										<> source.[role] 	
			 OR isnull(target.[Manager_Id], @EmptyGuid) 			<> isnull(source.[Manager_Id], @EmptyGuid) 
			 OR target.[Manager] 									<> source.[Manager]
			 OR ISNULL(target.[DateFrom],@DateMax) 					<> ISNULL(source.[DateFrom],@DateMax) 
			 OR ISNULL(target.[DateTo],@DateMax) 					<> ISNULL(source.[DateTo],@DateMax)
			 OR isnull(target.[ContractPosition_Id], @EmptyGuid)	<> isnull(source.[ContractPosition_Id], @EmptyGuid)	
			 OR target.[ContractPosition]							<> source.[ContractPosition]	
			 OR isnull(target.[State_Id] , @EmptyGuid)				<> isnull(source.[State_Id], @EmptyGuid) 				
		
	) THEN
		UPDATE SET
			  target.[Person_id]			= source.[Person_id],
			  target.[Person] 				= source.[Person] ,				
			  target.[Project_Id] 			= source.[Project_Id], 				
			  target.[Project]				= source.[Project],			
			  target.[role_id]				= source.[role_id],			
			  target.[role] 				= source.[role], 	
			  target.[Manager_Id] 			= source.[Manager_Id], 
			  target.[Manager] 				= source.[Manager],
			  target.[DateFrom] 			= source.[DateFrom], 
			  target.[DateTo] 				= source.[DateTo], 
			  target.[ContractPosition_Id]	= source.[ContractPosition_Id],	
			  target.[ContractPosition]		= source.[ContractPosition],	
			  target.[State_Id] 			= source.[State_Id] 	

	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Person_id], [Person], [Project_Id], [Project],[role_id],[role],[Manager_Id],[Manager],[DateFrom],[DateTo],[ContractPosition_Id],[ContractPosition],[State_Id]) 
		VALUES(Id, [Person_id], [Person], [Project_Id], [Project],[role_id],[role],[Manager_Id],[Manager],[DateFrom],[DateTo],[ContractPosition_Id],[ContractPosition],[State_Id])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO
	PRINT 'Import was successful from PA.[Assignment]'
END