select DonationAnalysis.DonorName, DonationAnalysis.AvgDonationAmount,
  donor.DonorContactPerson, donor.DonorEmail, donor.DonorPhoneNum
from(select DonorName, round(avg(DonationAmount), 0) as AvgDonationAmount,
     count(distinct year) as DonationTimes
     from donation 
     group by DonorName) DonationAnalysis
join donor on DonationAnalysis.DonorName=donor.DonorName
where DonationAnalysis.AvgDonationAmount > 10000 and DonationAnalysis.DonationTimes > 1