use master
go

if exists (select name from sys.databases where name = 'EmpresaSQL' )
begin
    alter database EmpresaSQL set single_user with rollback immediate
    drop database EmpresaSQL
end
go

create database EmpresaSQL
go

use EmpresaSQL
go

