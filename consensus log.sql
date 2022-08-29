use compito_db;


drop table if exists c_consensus_log;
/* form submission logs */
create table c_consensus_log(
					-- Section 0
						  s0_submission_timestamp timestamp unique not null,
                          s0_submitters_ldap varchar(25) not null,
                    -- Section 1      
                          s1_form_submission_date date not null,
                          s1_country_code varchar(2) not null,
                          s1_metro_region varchar(25) not null,
						  s1_issue_id varchar(16) primary key,
                          s1_24_metro_condition bool not null,
                          s1_op_process varchar(25) not null,
                    -- Section 2
						  s2_mandate_found varchar(25) not null,
                          s2_authorative_site text(250) not null,
                    -- Section 3
						  s3_how_wide_spread_is_the_mandate varchar(25),
                          s3_mandate_status varchar(50),
					-- Section 4
						  s4_reopen_request_status bool,
					-- Section 5
                          s5_reopen_impacted_gcid_list text(5000),
                          s5_reopen_gcid_count int,
                          s5_reopen_ss text(1000),
                          s5_reopen_website_update_date date,
                          s5_reopen_mandate_start_date date,
                          s5_reopen_mandate_end_date date,
                          s5_reopen_follow_up_required_status bool,
					-- Section 6
						  s6_closure_request_status bool,
					-- Section 7
                          s7_closure_impacted_gcid_list text(5000),
                          s7_closure_gcid_count int,
                          s7_closure_ss text(1000),
                          s7_closure_website_update_date date,
                          s7_closure_mandate_start_date date,
                          s7_closure_mandate_end_date date,
                          s7_closure_follow_up_required_status bool,
					-- Section 8
						  s8_sa_request_status bool,
					-- Section 9
                          s9_sa_impacted_gcid_list text(5000),
                          s9_sa_gcid_count int,
                          s9_sa_request_type varchar(50),
                          s9_sa_ss text(1000),
                          s9_sa_website_update_date date,
                          s9_sa_mandate_start_date date,
                          s9_sa_mandate_end_date date,
                          s9_sa_follow_up_required_status bool,
					-- Section 10
						  s10_ch_request_status bool,
					-- Section 11
                          s11_ch_impacted_gcid_list text(5000),
                          s11_ch_gcid_count int,
                          s11_ch_request_type varchar(50),
                          s11_ch_ss text(1000),
                          s11_ch_website_update_date date,
                          s11_ch_mandate_start_date date,
                          s11_ch_mandate_end_date date,
                          s11_ch_follow_up_required_status bool,
					-- Section 12
						  s12_mandate_already_executed_date date,
                          s12_mandate_already_executed_ss text(2000),
					-- Section 13
						  s13_mandate_non_executable_date date,
                          s13_mandate_not_executable_reason text(1000),
                          s13_mandate_not_executable_ss text(1000),
					-- Section 14
						  s14_observation_comments text(5000),
                          completed_on date
                          
                          -- PRIMARY KEY (s1_issue_id, s0_submitters_ldap) -- composite primary key to identify 2 submissions per issue_id by the research opeartors
);

insert into c_consensus_log values(current_timestamp(),"nikhilgup","2022-08-25","NP","Kathmandu","M-12345678912345",true,"Labeling","Mandate Found", "https://", "Country wide","Mandate Not Executable",
null,
null,null,null,null,null,null,null,
null,
null,null,null,null,null,null,null,
null,
null,null,null,null,null,null,null,null,
null,
null,null,null,null,null,null,null,null,
null,null,
"2022-08-21","Out of Scope","https://ss",
"No Comments", current_date
);

Select * from c_consensus_log;
-- describe c_consensus_log;




