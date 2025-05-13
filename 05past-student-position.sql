select student.StudentID, student.StudentName, participation.Position
from student
join participation on student.StudentID = participation.StudentID
where participation.Year = 2024
order by participation.Position