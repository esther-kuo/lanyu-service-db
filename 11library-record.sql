select library_maintenance.LocationName, library_maintenance.MaintenanceContent,
	   library.TotalHoldings, library.CatalogingSystem, library.LibraryStaffConut, 
       service_location.LocationContactPersonName, service_location.LocationEmail, service_location.LocationPhoneNum
from service
join library_maintenance on service.SerialNumber = library_maintenance.SerialNumber
join library on library_maintenance.LocationName = library.LocationName
join service_location on library.LocationName = service_location.LocationName
where service.Year = 2024
