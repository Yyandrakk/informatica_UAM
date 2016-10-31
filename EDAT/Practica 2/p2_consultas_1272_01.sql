--AUTORES: OSCAR Y ANGEL

/*a) Teniendo en cuenta	que el campo “fecha” indica la fecha de adquisición de cada libro... 
¿Cuáles son los 10 primeros libros adquiridos por la biblioteca?	
Mostrad únicamente título y año.*/

--SELECT libro, date_part('year',fecha) FROM libro ORDER BY fecha LIMIT 10;

/*

Libro; Año
"A Princess of Mars";1993
"Around the World in 80 Days";1994
"Tess of the d'Urbervilles";1994
"The Secret Garden";1994
"Middlemarch";1994
"Jude the Obscure";1994
"American Hand Book of the Daguerreotype";1994
"The Turn of the Screw";1995
"The Aeneid--English";1995
"Rio Grande's Last Race & Other Verses";1995

10rows
*/

/*b) ¿Cuántos libros NO han sido escritos ni en inglés (‘English’) ni en alemán (‘German’)?*/

--SELECT COUNT (ISBN) FROM libro WHERE  idioma <> 'English' and idioma <> 'German';

-- Numero de libros: 55

/*c) ¿Qué libros tratan sobre África (‘Africa’) de una manera u otra?
 Mostrad el título y género de cada libro, ordenados alfabéticamente por título.*/

--SELECT libro, genero FROM libro  where libro ilike '%Africa%' OR genero ilike '%Africa%' ORDER BY  libro ASC ;

 /*
TITULO;GENERO
"African Camp Fires";"#N/A"
"A Narrative of the Most Remarkable Particulars in the Life of James Albert Ukawsaw Gronniosaw  an African Prince  as Related by Himself";"#N/A"
"A Rip Van Winkle Of The Kalahari--And Other Tales of South-West Africa";"Africa -- Fiction"
"A Yellow God: an Idol of Africa";"Africa -- Fiction"
"BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875";"Africa  Central -- Description and travel"
"Benita  an African romance";"Africa  East -- Fiction"
"Blue Aloes--Stories of South Africa";"South Africa -- Social life and customs -- Fiction"
"Boer Politics";"Transvaal (South Africa) -- Politics and government"
"Campaign Pictures of the War in South Africa (1899-1900)--Letters from the Front";"South African War  1899-1902 -- Personal narratives"
"Charge!--A Story of Briton and Boer";"South African War  1899-1902 -- Fiction"
"Child of Storm";"Zulu (African people) -- Fiction"
"Dream Life and Real Life; a little African story";"Essays"
"First Footsteps in East Africa";"Harari language"
"Great African Travellers--From Mungo Park to Livingstone and Stanley";"Explorers"
"How I Found Livingstone; travels  adventures  and discoveres in Central Africa  including an account of four months' residence with Dr. Livingstone  by Henry M. Stanley";"Africa  Central -- Description and travel"
"In Africa--Hunting Adventures in the Big Game Country";"Hunting -- Africa  East"
"In Search of the Okapi--A Story of Adventure in Central Africa";"Adventure stories"
"In the Heart of Africa";"Sudan -- Description and travel"
"Journal of an African Cruiser";"#N/A"
"Lander's Travels--The Travels of Richard Lander into the Interior of Africa";"#N/A"

rows 51

*/
		
/*d) ¿Qué libros han sido traducidos por ‘AMANDA’? Mostrad el título y autor de cada libro.*/

/*SELECT  
   libro.libro, autor.nombre as autor 
FROM 
   libro  NATURAL JOIN isbnRautor NATURAL JOIN autor 
WHERE 
    id_autor=id AND isbnRautor.isbn IN 
				   (SELECT 
					isbn 
                    FROM 
					isbnRtraductor NATURAL JOIN traductor 
				    WHERE 
					id_traductor=id AND traductor.nombre='AMANDA');

*/

-- libro						autor
--"De Nederlandsche Nationale Kleederdrachten"	;"Molkenboer  Theodoor  1871-1920"
--"La Divina Commedia di Dante"			;"Dante Alighieri  1265-1321"

-- Rows 2

/*e) ¿En qué géneros diferentes se ha clasificado al libro ‘The Kreutzer Sonata and Other Stories”, de Tolstoy?
Mostrad los géneros distintos en los que se ha clasificado.*/

--SELECT DISTINCT genero FROM libro WHERE libro ilike 'The Kreutzer Sonata and Other Stories';

--genero
--'Fiction'

-- rows 1
	
/*f) ¿Cuántos usuarios han emitido un voto respecto al título “Dream Life and Real Life; a little African story”?*/

--SELECT COUNT (uid) FROM critica WHERE  isbn = (SELECT isbn FROM libro WHERE libro ilike 'Dream Life and Real Life; a little African story');

--Numero de usuarios: 6
	
/*g) ¿Cuál es la máxima puntuación obtenida por el libro “Allan Quatermain”?*/

--SELECT puntuacion FROM critica where isbn = ( SELECT isbn FROM libro WHERE libro ilike 'Allan Quatermain') ORDER BY puntuacion DESC limit 1;

--puntuacion
--"8"

-- Rows 1

/*h) ¿Quiénes, qué usuarios, han emitido un voto por “Allan Quatermain”?	
Indicad	uid, nombre, sexo y puntuación.*/

--SELECT uid,nombre,sexo,puntuacion FROM usuario NATURAL JOIN  critica NATURAL JOIN libro WHERE libro ilike 'Allan Quatermain';

--uid;nombre;sexo;puntuacion
--3743;"Roberto";"H";8
--1616;"Rosa";"M";1

-- Rows 2

/*i) ¿Cuántos usuarios,	de los que han emitido	algún voto, son	mujeres?*/

--SELECT COUNT (distinct uid) FROM usuario NATURAL JOIN critica WHERE sexo ilike 'M';

--Numero de mujeres: 7		

/*j) ¿A	qué libros se ha emitido algún voto? Indicad ISBN y título.*/

--SELECT DISTINCT isbn, libro FROM libro NATURAL JOIN critica WHERE libro.isbn=critica.isbn;

/*
ISBN;libro
1458;"Dream Life and Real Life; a little African story"
23638;"Reminiscences of a South African Pioneer"
21490;"The Two Supercargoes--Adventures in Savage Africa"
14451;"African Camp Fires"
8564;"Life and Travels of Mungo Park in Central Africa"
11772;"Naufrage de la frigate la MÃ©duse. English"
2710;"Louise de la Valliere"
21254;"In Africa--Hunting Adventures in the Big Game Country"
215;"The Call of the Wild"
21391;"Great African Travellers--From Mungo Park to Livingstone and Stanley"
17700;"The Suppression of the African Slave Trade to the United States of America--1638-1870"
21899;"A Rip Van Winkle Of The Kalahari--And Other Tales of South-West Africa"
1690;"Marie--An Episode in The Life of the late Allan Quatermain"
14466;"South African Memories--Social  Warlike & Sporting from Diaries Written at the Time"
711;"Allan Quatermain"
2761;"Benita  an African romance"
2841;"The Ivory Child"
17164;"Narrative of a Mission to Central Africa Performed in the Years 1850-51  Volume 1--Under the Orders and at the Expense of Her Majesty's Government"
2225;"Captains Courageous"
15240;"A Journal of a Tour in the Congo Free State"

Rows 48

*/

/*k) ¿A qué libros han votado las mujeres? Idem*/

--SELECT DISTINCT isbn,libro FROM libro NATURAL JOIN critica NATURAL JOIN usuario WHERE sexo ilike 'M';

/*
ISBN;libros
1690;"Marie--An Episode in The Life of the late Allan Quatermain"
15399;"The Interesting Narrative of the Life of Olaudah Equiano  Or Gustavus Vassa  The African--Written By Himself"
5305;"Travels in the Interior of Africa â€” Volume 02"
1711;"Child of Storm"
17599;"Von Tripolis nach Alexandrien - 1. Band"
711;"Allan Quatermain"
2857;"A Yellow God: an Idol of Africa"
589;"Catriona"
2681;"Ten Years Later"
2761;"Benita  an African romance"
1458;"Dream Life and Real Life; a little African story"
7937;"Journal of an African Cruiser"
2841;"The Ivory Child"
2759;"The Man in the Iron Mask"
36791;"The Mormon Puzzle  and How to Solve It"
23638;"Reminiscences of a South African Pioneer"
1441;"The Story of an African Farm  a novel"
5760;"Two Trips to Gorilla Land and the Cataracts of the Congo Volume 1"
2225;"Captains Courageous"
6886;"First Footsteps in East Africa"

Rows 37

*/


/*l) ¿A qué libros han votado las personas menores de 20 años? Idem*/	

--SELECT DISTINCT isbn,libro FROM libro NATURAL JOIN critica NATURAL JOIN usuario WHERE edad < '20';

/*
isbn; libro
1711;"Child of Storm"
11772;"Naufrage de la frigate la MÃ©duse. English"
2710;"Louise de la Valliere"
5157;"How I Found Livingstone; travels  adventures  and discoveres in Central Africa  including an account of four months' residence with Dr. Livingstone  by Henry M. Stanley"
1690;"Marie--An Episode in The Life of the late Allan Quatermain"
15399;"The Interesting Narrative of the Life of Olaudah Equiano  Or Gustavus Vassa  The African--Written By Himself"
5305;"Travels in the Interior of Africa â€” Volume 02"
2761;"Benita  an African romance"
21448;"The African Trader--The Adventures of Harry Bayford"

Rows 9

*/
