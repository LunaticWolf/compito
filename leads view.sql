-- create database compito_db;
use compito_db;



-- Leads Assigned View
drop table if exists c_leads_log;
/* create table customer type */
create table c_leads_log( issue_id varchar(16) primary key,
						  inflow_date timestamp unique not null,
						  country_iso varchar(2) not null,
						  metro varchar(25) not null,
                          geo_vertical varchar(25) not null,
                          24_metro_condition boolean not null,
                          pipeline varchar(25) not null,
                          marked_as_duplicate boolean not null
                          
);

describe c_leads_log;
insert into c_leads_log values("M-12345678912345", current_timestamp , "NP", "Kathmandu", "SHOPPING",true,"Inferred Mandate",false); 
update c_leads_log set marked_as_duplicate=false where issue_id="M-12345678912345";
Select * from c_leads_log;



-- LV1 Assign View
drop table if exists c_research_assign_log1;
create table c_research_assign_log1( issue_id varchar(16) primary key, assigned_lv1_timestamp timestamp not null, ldap_lv1 varchar(20) not null);
insert into c_research_assign_log1 values("M-12345678912345",current_timestamp ,"nikhilgup");
Select * from c_research_assign_log1;


-- LV2 Assign View
drop table if exists c_research_assign_log2;
create table c_research_assign_log2( issue_id varchar(16) primary key, assigned_lv2_timestamp timestamp not null, ldap_lv2 varchar(20) not null);
insert into c_research_assign_log2 values("M-12345678912345",current_timestamp ,"burra");
Select * from c_research_assign_log2;



-- Final Assign View
drop table if exists c_research_assign_log;
create table c_research_assign_log ( Select 
										LV1.issue_id as issue_id,
										LV1.ldap_lv1 as lv1_op, 
                                        LV2.ldap_lv2 as lv2_op 
									from c_research_assign_log1 as LV1 
									join c_research_assign_log2 as LV2 
									on LV1.issue_id=LV2.issue_id 
									);
Select * from c_research_assign_log;                     

drop table if exists leads_all_view;
create table leads_all_view
(
Select 
    leads_log.*, 
    c_log.s2_mandate_found as final_Mandate,
    c_log.s3_mandate_status as final_Mandate_Status,
	assign_log.LV1_op as LV1_op1,
    r_log_op1.s2_mandate_found as lv1_Mandate_decision,
    r_log_op1.s3_mandate_status as lv1_Mandate_status,
    assign_log.LV2_op as LV2_op2,
    r_log_op2.s2_mandate_found as lv2_Mandate_decision,
    r_log_op2.s3_mandate_status as lv2_Mandate_status,
    meta_log.meta_ldap,
    c_log.s0_submitters_ldap as final_submission_credits,
    c_log.completed_on as research_completed_on
from c_leads_log as leads_log 
join c_research_assign_log as assign_log -- assigned log
on leads_log.issue_id=assign_log.issue_id
join c_consensus_log as c_log -- consensus log//final response log
on c_log.s1_issue_id=leads_log.issue_id
join c_research_log as r_log_op1 -- LV1 log in research log response
on r_log_op1.s1_issue_id=leads_log.issue_id and r_log_op1.s0_submitters_ldap=assign_log.LV1_op 
join c_research_log as r_log_op2 -- LV2 log in research log response
on r_log_op2.s1_issue_id=leads_log.issue_id and r_log_op2.s0_submitters_ldap=assign_log.LV2_op
join meta_approvals as meta_log on meta_log.issue_id=leads_log.issue_id and meta_log.meta_decision=true and not meta_log.response_status="LGTM"
);

Select * from leads_all_view;