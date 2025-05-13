select ROUND(avg(AverageDonationPerPerson), 0) as TotalAverageDonationPerStudent
from
 (select StudentsAnalysis.Year, ROUND(DonationAnalysis.TotalDonation / StudentsAnalysis.TotalStudents, 0) as AverageDonationPerStudent
  from 
   (select participation.Year, count(*) as TotalStudents
    from participation
    group by participation.Year) as StudentsAnalysis
  join 
   (select donation.Year, SUM(donation.DonationAmount) as TotalDonation
	from donation
	group by donation.Year) as DonationAnalysis
  on StudentsAnalysis.Year = DonationAnalysis.Year) as YearlyDonation
