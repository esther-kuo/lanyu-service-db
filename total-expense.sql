select Year, totalExpense,
  round((scooterExpense / totalExpense) * 100, 2) as scooterExpensePct,
  round((transTicketExpense / totalExpense) * 100, 2) as transTicketExpensePct,
  round((shuttleExpense / totalExpense) * 100, 2) as shuttleExpensePct,
  round((accomExpense / totalExpense) * 100, 2) as accomExpensePct,
  round((serviceExpense / totalExpense) * 100, 2) as serviceExpensePct,
  round((otherExpense / totalExpense) * 100, 2) as otherExpensePct
from
  (select (scooterExpense + transTicketExpense + shuttleExpense + accomExpense + serviceExpense + otherExpense)as totalExpense,
    scooterAnalysis.Year, scooterExpense, transTicketExpense, shuttleExpense,
    accomExpense, serviceExpense, otherExpense
  from 
    (select transportation.Year, 
      sum(scooter.RentalCount * scooter.RentalDays * transportation.UnitPrice) as scooterExpense
    from scooter
	join transportation on scooter.SerialNumber=transportation.SerialNumber
	group by transportation.Year) as scooterAnalysis
	join
    (select transportation.Year, 
       sum(ship_train.PersonCount * transportation.UnitPrice) as transTicketExpense
	from ship_train
	join transportation on ship_train.SerialNumber=transportation.SerialNumber
	group by transportation.Year) as transTicketAnalysis
	on scooterAnalysis.Year=transTicketAnalysis.Year
	join
	(select transportation.Year, sum(transportation.UnitPrice) as shuttleExpense
	from transportation
    join shuttle on transportation.serialNumber=shuttle.serialNumber
	group by transportation.Year) as shuttleAnalysis
	on scooterAnalysis.Year=shuttleAnalysis.Year
	join
	(select stay_record.Year, sum(stay_record.AccomExpense) as accomExpense
	from stay_record
	group by stay_record.Year) as accomAnalysis
	on scooterAnalysis.Year=accomAnalysis.Year
	join
	(select service.Year, sum(service.ServiceExpense) as serviceExpense
	from service
	group by service.Year) as serviceAnalysis
	on scooterAnalysis.Year=serviceAnalysis.Year
	join
	(select other_expense.Year, sum(other_expense.OtherExpenseAmount) as otherExpense
	from other_expense
	group by other_expense.Year) as otherAnalysis
	on scooterAnalysis.Year=otherAnalysis.Year) as totalExpenseAnalysis
order by Year