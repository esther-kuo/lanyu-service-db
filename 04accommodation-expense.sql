select DaysAnalysis.Year, DaysAnalysis.TotalDays, StudentsAnalysis.TotalStudents, 
	   round(ExpenseAnalysis.TotalExpense / (StudentsAnalysis.TotalStudents * DaysAnalysis.TotalDays), 0) as CostPerStudentPerDay,
       ExpenseAnalysis.TotalExpense,
       round((ExpenseAnalysis.TotalExpense / DonationAnalysis.TotalDonation)*100, 2) as AccomPercentage
from
 (select edition.Year, DATEDIFF(EditionEndDate, EditionStartDate) + 1 as TotalDays
  from edition) as DaysAnalysis
join
 (select participation.Year, count(*) as TotalStudents
  from participation
  group by participation.Year) as StudentsAnalysis
on DaysAnalysis.Year = StudentsAnalysis.Year
join 
 (select stay_record.Year, sum(stay_record.AccomExpense) as TotalExpense
  from stay_record
  group by stay_record.Year) as ExpenseAnalysis
on StudentsAnalysis.Year = ExpenseAnalysis.Year
join
 (select donation.Year, sum(donation.DonationAmount) as TotalDonation
  from donation
  group by donation.Year) as DonationAnalysis
on ExpenseAnalysis.Year = DonationAnalysis.Year
order by DaysAnalysis.Year