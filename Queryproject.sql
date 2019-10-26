
create table FlightStatus_FMS
(
Id int primary key Identity(1000,1),
Description varchar(50) unique
)

create table FlightOperators_FMS
(
Id int primary key Identity(2000,1),
Name varchar(50) unique,
HeadOffice varchar(50) not null,
ContactNo varchar(50) not null
)

create table AirportTerminal_FMS
(
Id int primary key Identity(3000,1),
TerminalName varchar(50) unique,
AirportName varchar(50) not null,
ContactNo varchar(50) not null
)

create table FlightDeparture_FMS
(
Id int primary key Identity(4000,1),
Scheduled datetime not null,
Estimated Datetime not null,
Actual datetime not null
)

Create table Flight_FMS
(
ID int  Identity(6000,1) ,
Flightno  AS ('FL-'+ RIGHT(CAST(ID AS VARCHAR(4)), 4)) PERSISTED primary key,
Name varchar(50) references FlightOperators_FMS(Name),
Destination varchar(50) not null,
DepartureId int references FlightDeparture_FMS(Id),
TerminalId int references AirportTerminal_FMS(Id),
GateNo varchar(10) not null,
StatusId int references FlightStatus_FMS(Id)
)

create proc Insert_Flightinfo4
@ScheduledTime Datetime,
@TerminalName varchar(50),
@AirportName varchar(50) ,
@ContactNo int,
@Name varchar(50),
@Destination varchar(50),
@GateNo varchar(10),
@StatusId int

as
begin
insert into FlightDeparture_FMS (Scheduled,Estimated ,Actual) values (@ScheduledTime,@ScheduledTime,@ScheduledTime)
Declare @DepartureId int = @@identity
insert into AirportTerminal_FMS (TerminalName,AirportName,ContactNo) values (@TerminalName,@AirportName,@ContactNo)
Declare @TerminalId int = @@identity
insert into Flight_FMS (Name,Destination,DepartureId,TerminalId,GateNo,StatusId) values(@Name,@Destination, @DepartureId,@TerminalId,@GateNo ,@StatusId)

End

Execute Insert_Flightinfo1 @Name='Ashraf',@Destination='Pune', @DepartureId=4000,@TerminalId=3000,@GateNo='1A' ,@StatusId=1000
