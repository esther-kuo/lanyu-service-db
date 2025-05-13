select accommodation.AccomName, accommodation.AccomAddress,
	   stay_record.AccomStartDate, stay_record.AccomEndDate, stay_record.AccomExpense,
	   accommodation.AccomContactPerson,
	   accommodation.AccomPhoneNum, accommodation.WebsiteLink
from accommodation
join stay_record on accommodation.AccomName = stay_record.AccomName
where stay_record.Year = 2024
order by stay_record.AccomStartDate