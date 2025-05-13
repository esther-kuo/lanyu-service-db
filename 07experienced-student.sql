select StudentParticipation.StudentID, 
       StudentParticipation.StudentName, 
       StudentParticipation.ParticipationCount, 
       StudentParticipation.Positions
from (
    select student.StudentID, 
		   student.StudentName,
           count(distinct participation.year) as ParticipationCount, 
           group_concat(distinct concat(participation.year, ' - ', participation.position) order by participation.year separator ' ,  ') as Positions
    from student
    join participation on student.StudentID = participation.StudentID
    group by student.StudentID, student.StudentName
) as StudentParticipation
where StudentParticipation.ParticipationCount > 1
order by StudentParticipation.StudentID