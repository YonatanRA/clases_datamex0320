# caso select everything
select * from publishers;



# caso where
select * from publishers where city='Boston' or city='Chicago';
select * from publishers where country='USA';


# misma query con IN
select * from publishers where city in ('Boston', 'Chicago');



# ejemplo join
select * from titles as t
left join titleauthor as a
on t.title_id=a.title_id;


# lo mismo
select * from titles 
left join titleauthor 
on titles.title_id=titleauthor.title_id;




# concat y doble join
select t.title, t.title_id, a.au_id, concat(au.au_fname, ' ', au.au_lname) as completename
from titles as t
left join titleauthor as a
on t.title_id=a.title_id
left join authors as au
on a.au_id=au.au_id;




# libros con autores y año
select title, year(max(pubdate)) as 'year', count(titleauthor.title_id) as numauthors,
group_concat(concat(authors.au_fname, ' ', authors.au_lname)) as allauthors
from titles
left join titleauthor
on titles.title_id=titleauthor.title_id
left join authors
on authors.au_id=titleauthor.au_id
group by titles.title
order by numauthors desc;




# otro ejemplo 
select *
from publications.employee emp
right join publications.jobs job
on emp.job_id=job.job_id
union
select *
from publications.employee emp
left join publications.jobs job
on emp.job_id=job.job_id;




# Single JOIN example
SELECT 
    title, title_id
FROM
    titles AS title
        LEFT JOIN
    titleauthor AS author ON title_id = title_id;
    




# Books with author but title is duplicated due to JOIN
SELECT 
    t.title, t.title_id, a.au_id, CONCAT(au.au_fname, ' ', au.au_lname) as completename
FROM
    titles AS t
	LEFT JOIN titleauthor AS a
		ON t.title_id = a.title_id
    LEFT JOIN authors AS au
		ON a.au_id = au.au_id;
    




# Books with complete author names and year, title duplication is removed with GROUP BY
SELECT 
		title, 
        year(max(pubdate)) as "year",
        count(titleauthor.title_id) as numautores,
        group_concat(concat(authors.au_fname,' ', authors.au_lname))
	FROM titles
	LEFT JOIN titleauthor
		ON titles.title_id = titleauthor.title_id
	LEFT JOIN authors
		ON authors.au_id = titleauthor.au_id
    GROUP BY titles.title
    ORDER BY numautores DESC;





# Alias
SELECT q.title FROM publis.titles as  q;




# Mutliple JOINs
SELECT titleauthor.au_id, titles.title FROM titleauthor 
	LEFT JOIN titles ON titleauthor.title_id = titles.title_id
	RIGHT JOIN titles ON titleauthor.title_id = titles.title_id;
    




# Concatenate string columns
SELECT CONCAT(au_lname, " ", au_fname) AS FullName FROM authors;





# Multiple joins grouped by title with concatenated authors
SELECT title, GROUP_CONCAT(CONCAT(au_lname, " ", au_fname) SEPARATOR ", "), count(*)
FROM titles as t 
	INNER JOIN titleauthor as ta ON t.title_id = ta.title_id
    INNER JOIN authors as au ON ta.au_id = au.au_id
    GROUP BY t.title;
    



# Union
SELECT  au_id, city as m FROM authors WHERE state="IN"
UNION
SELECT au_id, royaltyper as m FROM  titleauthor;





# Subquery
SELECT stor_id, m.title, m.title_id, payterms  FROM sales 
INNER JOIN titles as m ON sales.title_id = m.title_id
WHERE payterms != "Net 30" 
	AND  m.title_id IN (
		SELECT titles.title_id FROM sales 
		INNER JOIN titles ON sales.title_id = titles.title_id
		WHERE payterms = "Net 30"
	);
