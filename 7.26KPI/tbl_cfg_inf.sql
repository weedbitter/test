drop table tbl_cfg_inf;
create table tbl_cfg_inf (
    pid    integer  not null,
    ppid   integer  not null,
    name   char(128)  not null
) in tbs_dat index in tbs_idx;
