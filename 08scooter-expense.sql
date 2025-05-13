select scooter.RentalShopName,
          transportation.UnitPrice,
          round((transportation.UnitPrice - UnitPriceAnalysis.AvgUnitPrice), 0) as 
            PriceDifference
from transportation
join scooter 
on transportation.SerialNumber = scooter.SerialNumber,
     (select avg(UnitPrice) as AvgUnitPrice 
      from transportation 
      where transportation.TransportationType = 'SCOOTER' ) as UnitPriceAnalysis
where transportation.Year = 2024
