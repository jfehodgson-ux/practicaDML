--Parte I. Creación de Base de Datos y Tablas (DDL)--

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

create table TDepartamento(
nDepartamentoID int identity (1,1) constraint PK_nDepartamentoID primary key,
cNombreDepartamento NVARCHAR (50) constraint UQ_cNombreDepartamento unique not null
);

create table TCargo(
nCargoID int identity (1,1) constraint PK_nCargoID primary key,
cNombreCargo NVARCHAR (50) constraint UQ_cNombreCargo unique not null
);

create table TEmpleado(
nEmpleadoID int identity (1,1) constraint PK_nEmpleadoID primary key,
cNIF int constraint UQ_cNIF unique not null,
cNombre NVARCHAR (50) not null,
cApellido NVARCHAR (50) not null, 
nDepartamentoID int constraint FK_nDepartamentoID foreign key references TDepartamento(nDepartamentoID) not null,
nCargoID int constraint FK_nCargoID foreign key references TCargo(nCargoID) not null,
dFechaContratacion date constraint DF_dFechaContratacion default (getdate()) not null,
nSalario decimal(10,2) constraint CK_nSalario check(nSalario>300) not null
);

create table TProyecto(
nIdProyecto int identity (1,1) constraint PK_nIdProyecto primary key,
cNombreProyecto NVARCHAR (100) not null,
nFechaInicio datetime not null,
nFechaFinal datetime null
);

create table TEmpleadoProyecto(
nEmpleadoID int constraint FK_nEmpleadoID foreign key references TEmpleado(nEmpleadoID),
nIdProyecto int constraint FK_nnIdProyecto foreign key references TProyecto(nIdProyecto)
);

--Parte II. Modificación de Estructuras (ALTER)--
alter table TEmpleado add cEmail NVARCHAR (100);

alter table TEmpleado add cTelefono NVARCHAR (50);

alter table TEmpleado alter column cNombre NVARCHAR (100) not null;

alter table TEmpleado alter column cApellido NVARCHAR (100) not null;

alter table TEmpleado add cDireccion NVARCHAR (255);

alter table TEmpleado add nEdad int;

alter table TEmpleado add constraint CK_nEdad check (nEdad >= 18 and nEdad <= 65);

alter table TEmpleado add constraint UQ_cEmail unique (cEmail);

alter table TEmpleado add bActivo bit constraint DF_bActivo default 1;

alter table TEmpleado drop column cDireccion;

alter table TEmpleado alter column cTelefono VARCHAR (20);

alter table TEmpleado add cGenero CHAR (1);

alter table TEmpleado add constraint CK_cGenero check (cGenero = 'M' or cGenero = 'F');

alter table TEmpleado add dFechaNacimiento date;

create table TSucursal(nSucursalID int identity (1,1) constraint PK_nSucursalID primary key, cNombreSucursal NVARCHAR (100) not null);

--Parte III. Inserción de Datos (INSERT)--
insert into TDepartamento (cNombreDepartamento) values
('Recursos Humanos'),
('Tecnologia'),
('Finanzas'),
('Marketing'),
('Operaciones');

insert into TCargo (cNombreCargo) values
('Gerente'),
('Desarrollador'),
('Analista'),
('Diseñador'),
('Soporte Tecnico');

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero, cEmail) values
(1001, 'Juan', 'Perez', 1, 1, 1500.00, 35, 'M', 'juan@gmail.com'),
(1002, 'Maria', 'Gomez', 2, 2, 1200.00, 28, 'F', 'maria@gmail.com'),
(1003, 'Pedro', 'Lopez', 3, 3, 1100.00, 40, 'M', 'pedro@gmail.com'),
(1004, 'Lucia', 'Martinez', 4, 4, 1050.00, 32, 'F', 'lucia@gmail.com'),
(1005, 'Carlos', 'Sanchez', 5, 5, 900.00, 25, 'M', 'carlos@gmail.com'),
(1006, 'Ana', 'Rodriguez', 2, 2, 1250.00, 29, 'F', 'ana@gmail.com'),
(1007, 'Luis', 'Fernandez', 2, 3, 1150.00, 45, 'M', 'luis@gmail.com'),
(1008, 'Carmen', 'Ruiz', 3, 3, 1300.00, 38, 'F', 'carmen@gmail.com'),
(1009, 'Jorge', 'Diaz', 4, 1, 1600.00, 50, 'M', 'jorge@gmail.com'),
(1010, 'Elena', 'Torres', 1, 5, 850.00, 22, 'F', 'elena@gmail.com');

insert into TProyecto (cNombreProyecto, nFechaInicio, nFechaFinal) values
('Sistema ERP', '2026-01-10', '2026-12-31'),
('Campaña Verano', '2026-05-01', '2026-08-31'),
('Auditoria Interna', '2026-06-01', '2026-07-15');

insert into TEmpleadoProyecto (nEmpleadoID, nIdProyecto) values
(1, 1),
(2, 1),
(4, 2),
(9, 2),
(3, 3);

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero, cEmail) 
values (1011, 'Roberto', 'Morales', 2, 2, 1400.00, 30, 'M', 'roberto@gmail.com');

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero, cEmail) 
values (1012, 'Sofia', 'Castro', 4, 4, 1100.00, 27, 'F', 'sofia.personal@gmail.com');

insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero, cEmail) 
values (1013, 'Fernando', 'Vargas', 5, 5, 950.00, 33, 'M', 'fernando@gmail.com');

insert into TCargo (cNombreCargo) values('Asesor'),('Supervisor Directivo'),('Coordinador');

begin try 
insert into TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, nEdad, cGenero, cEmail) 
values (1014, 'Mario', 'Ortiz', 1, 3, -500.00, 28, 'M', 'mario@gmail.com');
end try 
begin catch 
print 'Error porque es negativo consecuentemente menor a 300';
    print ERROR_MESSAGE();
end catch


--Parte IV. Actualización de Datos (UPDATE)--

update TEmpleado set nSalario = nSalario * 1.10;

update TEmpleado set nSalario = nSalario * 1.20 where (nDepartamentoID = 1);

update TEmpleado set cEmail = 'juan.nuevo@gmail.com' where (cNIF = 1001);

update TEmpleado set nCargoID = 2 where (cNIF = 1001);

update TEmpleado set nDepartamentoID = 4 where cNIF in (1002, 1003);

update TEmpleado set bActivo = 0 where (nSalario < 500);

update TProyecto set nFechaFinal = '2027-01-15' where (nIdProyecto = 1);

insert into TEmpleadoProyecto (nEmpleadoID, nIdProyecto) values (1, 3);


--Parte V. Eliminación de Datos (DELETE)--

delete from TEmpleadoProyecto where nEmpleadoID = (select nEmpleadoID from TEmpleado where cNIF = 1004);
delete from TEmpleado where cNIF = 1004;

delete from TEmpleado where bActivo = 0;

delete from TEmpleadoProyecto where nIdProyecto = 2;
delete from TProyecto where nIdProyecto = 2;

delete from TEmpleadoProyecto where nEmpleadoID = 1;

delete from TDepartamento where nDepartamentoID not in (select nDepartamentoID from TEmpleado);

--Desafíos Adicionales (lo pongo aqui antes de hacer drop table)--

create table TCliente(
nClienteID int identity (1,1) constraint PK_nClienteID primary key,
cIdentificacion varchar (20) constraint UQ_cIdentificacion unique not null,
cNombre nvarchar (100) not null,
cApellido nvarchar (100) not null,
cEmail nvarchar (100) constraint UQ_cEmailCliente unique,
cTelefono varchar (20),
cDireccion nvarchar (255),
dFechaRegistro date constraint DF_dFechaRegistro default getdate() not null
);

create table TVenta(
nVentaID int identity (1,1) constraint PK_nVentaID primary key,
nClienteID int constraint FK_TVenta_Cliente foreign key references TCliente(nClienteID) not null,
nEmpleadoID int constraint FK_TVenta_Empleado foreign key references TEmpleado(nEmpleadoID) not null,
nMontoTotal decimal(10,2) constraint CK_nMontoTotal check(nMontoTotal > 0) not null,
dFechaVenta date constraint DF_dFechaVenta default getdate() not null
);

insert into TCliente (cIdentificacion, cNombre, cApellido, cEmail, cTelefono, cDireccion, dFechaRegistro) values
('001-200000-0000A', 'Roberto', 'Carlos', 'roberto@gmail.com', '8888-0001', 'Managua', '2026-01-05'),
('001-200000-0001B', 'Andrea', 'Mejia', 'andrea@gmail.com', '8888-0002', 'Masaya', '2026-01-10'),
('001-200000-0002C', 'Julio', 'Iglesias', 'julio@gmail.com', '8888-0003', 'Leon', '2026-01-15'),
('001-200000-0003D', 'Marta', 'Sanchez', 'marta@gmail.com', '8888-0004', 'Granada', '2026-02-01'),
('001-200000-0004E', 'Diego', 'Luna', 'diego@gmail.com', '8888-0005', 'Rivas', '2026-02-12'),
('001-200000-0005F', 'Laura', 'Pausini', 'laura@gmail.com', '8888-0006', 'Esteli', '2026-02-20'),
('001-200000-0006G', 'Carlos', 'Vives', 'carlos.v@gmail.com', '8888-0007', 'Matagalpa', '2026-03-05'),
('001-200000-0007H', 'Shakira', 'Mebarak', 'shakira@gmail.com', '8888-0008', 'Managua', '2026-03-15'),
('001-200000-0008I', 'Alejandro', 'Sanz', 'alejandro@gmail.com', '8888-0009', 'Jinotepe', '2026-03-25'),
('001-200000-0009J', 'Thalia', 'Sodi', 'thalia@gmail.com', '8888-0010', 'Managua', '2026-04-02'),
('001-200000-0010K', 'Luis', 'Miguel', 'luis.m@gmail.com', '8888-0011', 'Leon', '2026-04-10'),
('001-200000-0011L', 'Gloria', 'Trevi', 'gloria@gmail.com', '8888-0012', 'Masaya', '2026-04-20'),
('001-200000-0012M', 'Ricky', 'Martin', 'ricky@gmail.com', '8888-0013', 'Granada', '2026-05-01'),
('001-200000-0013N', 'Enrique', 'Iglesias', 'enrique@gmail.com', '8888-0014', 'Rivas', '2026-05-05'),
('001-200000-0014O', 'Paulina', 'Rubio', 'paulina@gmail.com', '8888-0015', 'Managua', '2026-05-15'),
('001-200000-0015P', 'Chayanne', 'Figueroa', 'chayanne@gmail.com', '8888-0016', 'Esteli', '2026-05-25'),
('001-200000-0016Q', 'Ricardo', 'Arjona', 'ricardo.a@gmail.com', '8888-0017', 'Matagalpa', '2026-06-01'),
('001-200000-0017R', 'Julieta', 'Venegas', 'julieta@gmail.com', '8888-0018', 'Managua', '2026-06-03'),
('001-200000-0018S', 'Miguel', 'Bose', 'miguel.b@gmail.com', '8888-0019', 'Jinotepe', '2026-06-05'),
('001-200000-0019T', 'Cliente', 'SinVentas', 'sinventas@gmail.com', '8888-0020', 'Managua', '2026-06-08');

insert into TVenta (nClienteID, nEmpleadoID, nMontoTotal, dFechaVenta) values
(1, 1, 150.50, '2026-01-10'), (1, 2, 300.00, '2026-01-15'), (2, 3, 450.25, '2026-01-20'), 
(3, 5, 1200.00, '2026-01-25'), (4, 5, 80.00, '2026-02-05'), (5, 6, 95.50, '2026-02-15'),
(6, 7, 210.00, '2026-02-22'), (7, 8, 340.75, '2026-03-08'), (8, 9, 500.00, '2026-03-18'), 
(9, 10, 75.20, '2026-03-28'), (10, 11, 1500.00, '2026-04-05'), (11, 12, 250.00, '2026-04-12'),
(12, 13, 310.50, '2026-04-22'), (13, 1, 420.00, '2026-05-02'), (14, 2, 850.00, '2026-05-08'), 
(15, 3, 95.00, '2026-05-18'), (16, 5, 110.25, '2026-05-28'), (17, 5, 600.00, '2026-06-02'),
(18, 6, 720.00, '2026-06-04'), (19, 7, 890.50, '2026-06-06'), (1, 8, 100.00, '2026-01-12'), 
(2, 9, 200.00, '2026-01-22'), (3, 10, 300.00, '2026-02-02'), (4, 11, 400.00, '2026-02-12'),
(5, 12, 500.00, '2026-02-22'), (6, 13, 600.00, '2026-03-04'), (7, 1, 700.00, '2026-03-14'), 
(8, 2, 800.00, '2026-03-24'), (9, 3, 900.00, '2026-04-03'), (10, 5, 1000.00, '2026-04-13'),
(11, 5, 1100.00, '2026-04-23'), (12, 6, 1200.00, '2026-05-03'), (13, 7, 130.00, '2026-05-13'), 
(14, 8, 140.00, '2026-05-23'), (15, 9, 150.00, '2026-06-02'), (16, 10, 160.00, '2026-06-04'),
(17, 11, 170.00, '2026-06-05'), (18, 12, 180.00, '2026-06-06'), (19, 13, 190.00, '2026-06-07'), 
(1, 1, 200.00, '2026-01-18'), (2, 2, 210.00, '2026-01-28'), (3, 3, 220.00, '2026-02-08'),
(4, 5, 230.00, '2026-02-18'), (5, 5, 240.00, '2026-02-28'), (6, 6, 250.00, '2026-03-10'), 
(7, 7, 260.00, '2026-03-20'), (8, 8, 270.00, '2026-03-30'), (9, 9, 280.00, '2026-04-09'),
(10, 10, 290.00, '2026-04-19'), (11, 11, 300.00, '2026-04-29');

update TVenta set nMontoTotal = nMontoTotal * 0.90 where nMontoTotal > 1000;

delete from TCliente where nClienteID not in (select distinct nClienteID from TVenta);

select top 5 concat(c.cNombre, ' ', c.cApellido) as nombre_cliente, sum(v.nMontoTotal) as total_comprado 
from TCliente c 
inner join TVenta v on c.nClienteID = v.nClienteID 
group by c.nClienteID, c.cNombre, c.cApellido 
order by total_comprado desc;

select month(dFechaVenta) as mes, year(dFechaVenta) as anio, sum(nMontoTotal) as total_ventas 
from TVenta 
group by year(dFechaVenta), month(dFechaVenta) 
order by anio, mes;

select concat(c.cNombre, ' ', c.cApellido) as nombre_cliente, avg(v.nMontoTotal) as promedio_ventas 
from TCliente c 
inner join TVenta v on c.nClienteID = v.nClienteID 
group by c.nClienteID, c.cNombre, c.cApellido;

select v.nVentaID, concat(c.cNombre, ' ', c.cApellido) as cliente_completo, concat(e.cNombre, ' ', e.cApellido) as empleado_completo, v.nMontoTotal, v.dFechaVenta 
from TVenta v 
inner join TCliente c on v.nClienteID = c.nClienteID 
inner join TEmpleado e on v.nEmpleadoID = e.nEmpleadoID;


--Parte VI. Consultas de Verificación--

select * from TEmpleado order by cApellido;

select * from TEmpleado where nSalario > 1000;

select * from TEmpleado where bActivo = 1;

select * from TEmpleado where year(dFechaContratacion) = year(getdate());

select e.cNombre, e.cApellido, d.cNombreDepartamento from TEmpleado e inner join TDepartamento d on e.nDepartamentoID = d.nDepartamentoID;

select e.cNombre, e.cApellido, c.cNombreCargo from TEmpleado e inner join TCargo c on e.nCargoID = c.nCargoID;

select distinct e.cNombre, e.cApellido from TEmpleado e inner join TEmpleadoProyecto ep on e.nEmpleadoID = ep.nEmpleadoID;

select d.cNombreDepartamento, count(e.nEmpleadoID) as cantidad_empleados from TDepartamento d left join TEmpleado e on d.nDepartamentoID = e.nDepartamentoID group by d.cNombreDepartamento;

select d.cNombreDepartamento, avg(e.nSalario) as promedio_salario from TDepartamento d inner join TEmpleado e on d.nDepartamentoID = e.nDepartamentoID group by d.cNombreDepartamento;

select d.cNombreDepartamento, max(e.nSalario) as salario_maximo, min(e.nSalario) as salario_minimo from TDepartamento d inner join TEmpleado e on d.nDepartamentoID = e.nDepartamentoID group by d.cNombreDepartamento;

select p.cNombreProyecto from TProyecto p inner join TEmpleadoProyecto ep on p.nIdProyecto = ep.nIdProyecto group by p.cNombreProyecto having count(ep.nEmpleadoID) > 2;

select * from TEmpleado where cApellido like 'G%';

select * from TEmpleado order by nSalario desc;

select top 3 * from TEmpleado order by nSalario desc;

select * from TEmpleado where nEdad between 25 and 40;

select count(*) as total_empleados_activos from TEmpleado where bActivo = 1;

select count(*) as total_proyectos from TProyecto;

--Parte VII. Administración de Objetos--

alter table TEmpleado drop constraint CK_nEdad;
alter table TEmpleado drop constraint UQ_cEmail;
alter table TEmpleado add constraint CK_nEdad check (nEdad >= 18 and nEdad <= 65);
alter table TEmpleado add constraint UQ_cEmail unique (cEmail);

drop table TVenta;
drop table TEmpleadoProyecto;
drop table TCliente;
drop table TProyecto;
drop table TEmpleado;
drop table TCargo;
drop table TDepartamento;
drop table TSucursal;

--necesito poner master antes de hacer el dropdatabase--
use master
go

alter database EmpresaSQL set single_user with rollback immediate
drop database EmpresaSQL

go