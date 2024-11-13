
create database if not exists Loja;

use Loja;

create table Estado( 
ID int primary key auto_increment,
nome varchar(100) not null,
UF varchar(2) not null);

create table Municipio(
ID int primary key auto_increment,
FK_EstadoID int not null,
nome varchar(100) not null,
codIBGE int not null, 
foreign key (FK_EstadoID) references Estado(ID)
);

create table Cliente (
ID int primary key auto_increment,
nome varchar(80) not null,
CPF varchar (11) not null,
Celular varchar(11) not null, 
EndLogradouro varchar(100) not null,
EndNumero varchar(10) not null,
EndMunicipio int not null,
EndCEP char(8) not null,
FK_Municipio_ID int not null,
foreign key (FK_Municipio_ID ) references Municipio(ID)
);

create table ContaReceber (
ID int primary key auto_increment,
FK_Cliente_ID Int not null,
FaturaVendaID Int not null,
DataConta date not null,
DataVencimento Date not null,
Valor decimal (18,2)not null,
Situacao enum ("1" , "2","3") not null,
foreign key (FK_Cliente_ID) references Cliente (ID) 
);

INSERT INTO Estado(Nome, UF) values
('São Paulo' ,'SP'),
('Rio de Janeiro','RJ'),
('Minas Gerais', 'MG');
select * from Estado;


INSERT INTO Municipio(FK_EstadoID, Nome, CodIBGE) values
(1,'São Luiz' ,'3550308'),
(2,'São João','3304557'),
(3,'Santo Antonio', '3106200');
select * from Municipio;

INSERT INTO Cliente(Nome,CPF,Celular,EndLogradouro ,
EndNumero, EndMunicipio,FK_Municipio_ID,EndCEP) values
('Neymar','98765432110' ,'98765432110','rua a','123',1,1,'98765432'),
(' Antonio','1234567890','1234567890','rua b','456',2,2,'12345678'),
('João','0123456789','0123456789','rua c','789',3,3,'0123456');
select * from Cliente;
 
 INSERT INTO ContaReceber(FK_Cliente_ID, FaturaVendaID, DataConta ,DataVencimento,Valor,situacao) values
(1,105 ,'2024-08-06','2025-05-15',100.00,'1'),
(2,106 ,'2024-08-06','2025-03-28',200.00,'2'),
(3,107 ,'2024-08-06','2025-04-20',300.00,'3');

select * from Cliente;


 create view ContasNaoPagas as
 select CR.ID as 'ID da Conta a receber',
 C.Nome as 'Nome do Cliente',
 CR.DataVencimento as 'Data de Vencimento',
 C.CPF as 'CPF do Cliente',
 CR.Valor as 'Valor da conta'
 
 From ContaReceber CR
 join Cliente C on CR.FK_Cliente_ID = C.ID
 Where CR.Situacao = '1';
 
select* from ContasNaoPagas ;
select* from ContaReceber ;
