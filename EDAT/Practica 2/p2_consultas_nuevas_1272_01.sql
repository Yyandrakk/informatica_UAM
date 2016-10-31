-- Autores: Oscar y Angel

-- a) ¿Qué libros escritos en aleman, han sido votados por hombres y su puntuacion? Indicad ISBN, titulo, uid, nombre y puntuacion.

--SELECT isbn, libro, uid, nombre, puntuacion FROM libro NATURAL JOIN critica NATURAL JOIN usuario WHERE idioma ilike 'german' AND sexo='H';

/*

isbn; libro; uid; nombre; puntuacion
17599;"Von Tripolis nach Alexandrien - 1. Band";1720;"Nacho";10
17599;"Von Tripolis nach Alexandrien - 1. Band";3738;"Gabriel";10
16280;"BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875";1720;"Nacho";10
16280;"BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875";3738;"Gabriel";9
17599;"Von Tripolis nach Alexandrien - 1. Band";4728;"Thomas";0
16280;"BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875";4728;"Thomas";10

Rows 6

*/

-- B) ¿Mostrar la puntuacion media de cada libro votado de mayor a menor? Mostrar isbn, libro, media.

--SELECT isbn, libro, avg(puntuacion) as media FROM libro NATURAL JOIN critica GROUP BY isbn ORDER BY avg(puntuacion) DESC;

/* ISBN; libro; media
17164;"Narrative of a Mission to Central Africa Performed in the Years 1850-51  Volume 1--Under the Orders and at the Expense of Her Majesty's Government";9.0000000000000000;10
18544;"Narrative of a Mission to Central Africa Performed in the Years 1850-51  Volume 2--Under the Orders and at the Expense of Her Majesty's Government";7.6666666666666667;10
6886;"First Footsteps in East Africa";7.2500000000000000;10
15042;"A Narrative of the Most Remarkable Particulars in the Life of James Albert Ukawsaw Gronniosaw  an African Prince  as Related by Himself";7.0000000000000000;10
16280;"BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875";6.6000000000000000;10
1441;"The Story of an African Farm  a novel";6.3333333333333333;10
3810;"The Man-Eaters of Tsavo and Other East African Adventures";6.2500000000000000;9
1711;"Child of Storm";6.0000000000000000;9
23638;"Reminiscences of a South African Pioneer";6.0000000000000000;8
11617;"Punch  or the London Charivari  Volume 156  April 2  1919";5.7500000000000000;10
14451;"African Camp Fires";5.5000000000000000;7
3657;"Wild Beasts and Their Ways  Reminiscences of Europe  Asia  Africa and America â€” Volume 1";5.5000000000000000;7
5305;"Travels in the Interior of Africa â€” Volume 02";5.5000000000000000;8
8564;"Life and Travels of Mungo Park in Central Africa";5.5000000000000000;9
12428;"The History of the Rise  Progress and Accomplishment of the Abolition of the African Slave Trade by the British Parliament (1808)  Volume I";5.5000000000000000;10
21254;"In Africa--Hunting Adventures in the Big Game Country";5.5000000000000000;10
2857;"A Yellow God: an Idol of Africa";5.3333333333333333;7
14466;"South African Memories--Social  Warlike & Sporting from Diaries Written at the Time";5.3333333333333333;10
21060;"The Congo Rovers--A Story of the Slave Squadron";5.2500000000000000;9
1690;"Marie--An Episode in The Life of the late Allan Quatermain";5.1250000000000000;10

Rows 48

 */