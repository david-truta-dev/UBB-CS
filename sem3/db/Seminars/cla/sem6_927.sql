use sem6_927

if OBJECT_ID('RoutesStations', 'U') is not null
	drop table RoutesStations

if OBJECT_ID('Stations', 'U') is not null
	drop table Stations

if OBJECT_ID('Routes', 'U') is not null
	drop table Routes

if OBJECT_ID('Trains', 'U') is not null
	drop table Trains

if OBJECT_ID('TrainTypes', 'U') is not null
	drop table TrainTypes



create table TrainTypes(
	idType INT PRIMARY KEY identity(1,1),
	name varchar(50),
	description varchar(150)
	)

create table Trains (
	idTrain INT PRIMARY KEY identity(1,1),
	name varchar(50),
	idType int references TrainTypes(idType)
	
	)

create table Stations (
	idStation INT PRIMARY KEY identity(1,1),
	name varchar(50) unique)

create table Routes (
	idRoute INT PRIMARY KEY identity(1,1),
	name varchar(50) unique,
	idTrain int references Trains(idTrain)
	)

create table RoutesStations (
	idRoute INT references Routes(idRoute),
	idStation INT references Stations(idStation),
	arrival TIME,
	departure TIME,
	primary key (idRoute, idStation)
)
---optional: check if arrival < departure 


insert TrainTypes (name, description) VALUES ('r', 'desc r'), ('ir', 'desc ir')

insert Trains (name, idType) values ('t1', 1), ('t2', 1), ('t3', 1)

insert Routes (name, idTrain) values ('r1', 1), ('r2', 2), ('r3', 3)

insert Stations (name) values ('s1'), ('s2'), ('s3') 

insert into RoutesStations (idRoute, idStation, arrival, departure) values 
(1, 1, '9:00am', '9:10am'),
(1, 2, '10:00am', '10:10am'),
(1, 3, '11:00am', '11:10am'),
(2, 1, '9:10am', '9:20am'),
(2, 3, '11:00am', '11:10am'),
(3, 2, '4:00am', '4:10am')


select * from Trains
select * from TrainTypes
select * from Routes
select * from Stations
select * from RoutesStations

go
create proc uspUpdateStationOnRoute @RouteName varchar(50), @StationName varchar(50), @arrivalTime TIMe, @departureTime TIME
as
BEGIn
	declare @idStation int = (SELECT idStation from Stations where name = @StationName)
	declare @idRoute int = (SELECT idRoute from Routes where name=@RouteName)
	-- optionally: add a check to verify if @idStation and @idRoute is not null 
	IF NOT EXISTS (SELECT * from RoutesStations where idRoute=@idRoute and idStation = @idStation) 
		insert RoutesStations (idRoute, idStation, arrival, departure)
		values
		(@idRoute, @idStation, @arrivalTime, @departureTime)
	else
		update RoutesStations
		set arrival = @arrivalTime, departure = @departureTime
		where idRoute = @idRoute and idStation = @idStation
end
go


select * from RoutesStations
exec uspUpdateStationOnRoute @RouteName = 'r3', @StationName = 's3', @arrivalTime = '5:37am', @departureTime = '5:47am'

go
create view viewRoutesWithAllStations
AS
	select name
	from Routes
	where idRoute in (
		select idRoute
		from RoutesStations
		group by idRoute
		having count(*) = (
			select count(*)
			from Stations
		)
	)

select * from viewRoutesWithAllStations


select count(*)
from Stations

select name
from Routes
where idRoute in (
	select idRoute
	from RoutesStations
	group by idRoute
	having count(*) = (
		select count(*)
		from Stations
	)
)

select R.name
from Routes R
where not exists (
	select S.idStation
	from Stations S
	except
	select RS.idStation
	from RoutesStations RS
	where RS.idRoute = R.idRoute
)




--- Implement a function that lists the names of the stations with more than R routes, where R is a function 
--- parameter.

create function fListStationsNamesWithRroutes (@R INT)
returns table
as
return
	select name
	from Stations
	where idStation in (
		select idStation
		from RoutesStations
		group by idStation
		having count(*) > @R
	)
go

select * from fListStationsNamesWithRroutes(1)


select name
from Stations
where idStation in (
	select idStation
	from RoutesStations
	group by idStation
	having count(*) > 2
)

select name
from  (
	select idStation
	from RoutesStations
	group by idStation
	having count(*) > 2
) R inner join Stations S on R.idStation = S.idStation