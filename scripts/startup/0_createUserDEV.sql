alter session set "_ORACLE_SCRIPT" = true;
create user DEV identified by d3v quota unlimited on USERS;
grant connect, resource to DEV;