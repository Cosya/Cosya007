

select count(*) from EPAS_DEV.[SP].[Person]
union all 
select count(*) from EPAS_DEV.[PA].[Context]
union all 
select count(*) from EPAS_DEV.[PA].[EPFeedback]
union all 
select count(*) from EPAS_DEV.[PA].[EvaluationPeer];



select count(*) from EP.[SP].[Person]
union all 
select count(*) from EP.[PA].[Context]
union all 
select count(*) from EP.[PA].[EPFeedback]
union all 
select count(*) from EP.[PA].[EvaluationPeer];