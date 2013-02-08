//selects suggested speakers for US10337
select first_name, last_name from speaker where suggested_by is not null;