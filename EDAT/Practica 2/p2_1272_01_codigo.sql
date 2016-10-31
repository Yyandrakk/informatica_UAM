--AUTORES: Oscar y Angel

SET datestyle TO postgres, mdy;--Cambiamos el formato de la fecha

CREATE TABLE libro_t (
ISBN int ,
libro text,
fecha date, 
idioma text,
genero text,
autor text,
traductor text
);

CREATE TABLE usuario_t (
uid int ,
nombre text,
sexo char(1),
edad int,
ISBN int, 
puntuacion int 
);

COPY "libro_t" FROM '/home/oscar/libros.txt'with delimiter as '	' csv header;

CREATE TABLE libro (
ISBN int PRIMARY KEY,
libro text NOT NULL,
fecha date NOT NULL, 
idioma text NOT NULL,
genero text NOT NULL
);

CREATE TABLE autor (
id serial PRIMARY KEY,
nombre text NOT NULL
);

CREATE TABLE traductor (
id serial PRIMARY KEY,
nombre text NOT NULL
);

INSERT INTO autor(nombre) SELECT DISTINCT autor FROM libro_t;
INSERT INTO traductor(nombre) SELECT DISTINCT traductor FROM libro_t;

INSERT INTO libro(ISBN,libro,fecha,idioma,genero) SELECT isbn, libro, fecha, idioma, genero FROM libro_t;

CREATE TABLE isbnRautor (
ISBN int REFERENCES libro(isbn),
id_autor int REFERENCES autor(id)
);


CREATE TABLE isbnRtraductor (
ISBN int REFERENCES libro(isbn),
id_traductor int REFERENCES traductor(id)
);

INSERT INTO isbnRautor(isbn, id_autor) SELECT libro_t.isbn, autor.id FROM libro_t JOIN autor ON libro_t.autor=autor.nombre;

INSERT INTO isbnRtraductor(isbn, id_traductor) SELECT libro_t.isbn, traductor.id FROM libro_t JOIN traductor ON libro_t.traductor=traductor.nombre;

COPY "usuario_t" FROM '/home/oscar/usuarios.txt'with delimiter as ',' csv header;

CREATE TABLE usuario (
uid int PRIMARY KEY,
nombre text NOT NULL,
sexo char(1) NOT NULL,
edad int NOT NULL
);

INSERT INTO usuario(uid,nombre,sexo,edad)SELECT DISTINCT uid,nombre,sexo,edad FROM usuario_t;

CREATE TABLE critica (
uid int REFERENCES usuario(uid),
ISBN int REFERENCES libro(ISBN), 
puntuacion int NOT NULL
);

INSERT INTO critica(uid,ISBN,puntuacion)SELECT uid, ISBN, puntuacion FROM usuario_t;

DROP TABLE usuario_t;
DROP TABLE libro_t;
