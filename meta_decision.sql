use compito_db;


drop table if exists meta_approvals;

create table meta_approvals(
								issue_id varchar(16) not null,
								op_ldap varchar(25) not null,
								response_status varchar(25),
								response_description text(500),
                                meta_ldap varchar(25) not null,
                                meta_decision boolean not null,
                                meta_decision_timestamp timestamp not null,
                                meta_observation text,
								primary key(issue_id, op_ldap)
							);
                            
                            
insert into meta_approvals values("M-12345678912345","nikhilgup","LGTM","","koppulum",true,current_timestamp,"");
insert into meta_approvals values("M-12345678912345","burra","LGTM'ed","","koppulum",true,current_timestamp,"");  

insert into meta_approvals values("F-12345678912346","nikhilgup","Flagged","Section 3 - 'Mandate Status'","koppulum",true,current_timestamp,"");
insert into meta_approvals values("F-12345678912346","burra","Flagged","Section 3 - 'Mandate Status'","koppulum",false,current_timestamp,"");


Select * from meta_approvals;

Select issue_id, op_ldap from meta_approvals where meta_decision=false;
Select issue_id, op_ldap from meta_approvals where meta_decision=true and response_status="Flagged";  -- moves to consensus
Select issue_id, op_ldap from meta_approvals where meta_decision=true and response_status="LGTM'ed"; -- moves to consensus