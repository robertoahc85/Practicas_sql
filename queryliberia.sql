-- Active: 1725418236768@@127.0.0.1@5434@libreria
update 
    libros 
  set 
    isbn = 888
WHERE
  id=2    

  update categoria 
  set 
  "descripcion" = 'Imaginativas'
  WHERE
  id =2

Select * from libros
ORDER BY titulo ASC

DELETE  from libros
 where  id =2 

select min(publicacion)
from  libros

select max(publicacion)
from  libros

select count(publicacion)
from  libros


select AVG(publicacion)
from  libros

select SUM(publicacion)
from  libros

select titulo, autores.nombre
from  libros INNER JOIN autores ON libros.id_autor = autores.id;

select titulo,categoria.nombre
from libros INNER JOIN categoria ON libros.id_categoria = categoria.id
where libros.id =1 

