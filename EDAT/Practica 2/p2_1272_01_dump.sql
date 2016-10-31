-- AUTORES: Oscar y Angel
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.0
-- Dumped by pg_dump version 9.3.0
-- Started on 2013-10-17 11:33:16 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 179 (class 3079 OID 11828)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 179
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 26333)
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE autor (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 26331)
-- Name: autor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE autor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autor_id_seq OWNER TO postgres;

--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 171
-- Name: autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE autor_id_seq OWNED BY autor.id;


--
-- TOC entry 178 (class 1259 OID 26387)
-- Name: critica; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE critica (
    uid integer,
    isbn integer,
    puntuacion integer NOT NULL
);


ALTER TABLE public.critica OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 26353)
-- Name: isbnrautor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isbnrautor (
    isbn integer,
    id_autor integer
);


ALTER TABLE public.isbnrautor OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 26366)
-- Name: isbnrtraductor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isbnrtraductor (
    isbn integer,
    id_traductor integer
);


ALTER TABLE public.isbnrtraductor OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 26323)
-- Name: libro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE libro (
    isbn integer NOT NULL,
    libro text NOT NULL,
    fecha date NOT NULL,
    idioma text NOT NULL,
    genero text NOT NULL
);


ALTER TABLE public.libro OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 26344)
-- Name: traductor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE traductor (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.traductor OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 26342)
-- Name: traductor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE traductor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.traductor_id_seq OWNER TO postgres;

--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 173
-- Name: traductor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE traductor_id_seq OWNED BY traductor.id;


--
-- TOC entry 177 (class 1259 OID 26379)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    uid integer NOT NULL,
    nombre text NOT NULL,
    sexo character(1) NOT NULL,
    edad integer NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 1929 (class 2604 OID 26336)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autor ALTER COLUMN id SET DEFAULT nextval('autor_id_seq'::regclass);


--
-- TOC entry 1930 (class 2604 OID 26347)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY traductor ALTER COLUMN id SET DEFAULT nextval('traductor_id_seq'::regclass);


--
-- TOC entry 2054 (class 0 OID 26333)
-- Dependencies: 172
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autor (id, nombre) FROM stdin;
1	Lawrence  D. H. (David Herbert)  1885-1930
2	Ford  Paul Leicester  1865-1902
3	Stanley  Henry M. (Henry Morton)  1841-1904
4	Sophocles  495   BC-406 BC
5	Shakespeare  William  1564-1616
6	HernÃ¡ndez  JosÃ©  1834-1886
7	Turner  Ethel Sybil  1872-1958
8	Stimson  Dorothy  1890-1988
9	Australia. Dept. of External Affairs
10	Spofford  Ainsworth Rand  1825-1908
11	How  Edith A.
12	Chesterton  G. K. (Gilbert Keith)  1874-1936
13	Warner  William
14	Aristophanes  446   BC-385   BC
15	Equiano  Olaudah  1745-1797
16	Tarbell  Frank Bigelow  1853-1920
17	Payn  James  1830-1898
18	Tolstoi  Ilia Lvovich  Graf  1866-1933
19	Farnol  Jeffery  1878-1952
20	Gulick  Sidney Lewis  1860-1945
21	Chopin  Kate  1850-1904
22	Major  Charles  1856-1913
23	Verne  Jules  1828-1905
24	Little  Frances  1863-1941
25	Jerrold  W. Blanchard  1826-1884
26	Lindsay  Vachel  1879-1931
27	Warren  Henry White  1831-1912
28	Deland  Margaret Wade Campbell  1857-1945
29	Falkner  John Meade  1858-1932
30	Collingwood  Harry  1851-1922
31	Lozano  Pedro  1697-1752
32	Sumner  Charles  1811-1874
33	Michelson  Miriam  1870-1942
34	Rinehart  Mary Roberts  1876-1958
35	Goodrich  Samuel G. (Samuel Griswold)  1793-1860
36	Wilde  Oscar  1854-1900
37	Molkenboer  Theodoor  1871-1920
38	Carboni  Raffaello  1817-1885
39	Anonymous
40	Sterne  Laurence  1713-1768
41	Barco Centenera  MartÃ­n del  1535-
42	Mauclair  Camille  1872-1945
43	BahÃ¡'u'llÃ¡h  1817-1892
44	Nicholson  Meredith  1866-1947
45	Dell  Ethel M. (Ethel May)  1881-1939
46	Holmes  William Henry  1846-1933
47	Brown  William N.
48	Fenn  George Manville  1831-1909
49	Speed  Harold
50	Pridden  W. (William)  1810-
51	Montesquieu  Charles de Secondat  baron de  1689-1755
52	Daudet  Alphonse  1840-1897
53	Kafka  Franz  1883-1924
54	Mackintosh  C. (Charles) H. (Henry)
55	Defoe  Daniel  1661  -1731
56	GrimkÃ©  Archibald Henry  1849-1930
57	James  Juliet Helena Lumbard  1864-
58	Parker  K. Langloh (Katie Langloh)  1856-1940
59	Jacobs  Harriet Ann  1813-1897
60	Fitzpatrick  Percy  Sir  1862-1931
61	Burton  John Hill  1809-1881
62	Virgil  70 BC-19 BC
63	Cornell  Frederick Carruthers  1867-1921
64	Prescott  William Hickling  1796-1859
65	Wentworth  William Charles  1790-1872
66	Dostoyevsky  Fyodor  1821-1881
67	Stratton-Porter  Gene  1863-1924
68	Curtin  D. Thomas
69	Paterson  A. B. (Andrew Barton)  1864-1941
70	Lawson  Henry  1867-1922
71	Twopeny  Richard Ernest Nowell  1857-1915
72	Hough  Emerson  1857-1923
73	Marx  Karl  1818-1883
74	Mindeleff  Victor  1860-1948
75	Quennell  C. H. B. (Charles Henry Bourne)  1872-1935
76	Undiano y Gastelu  Sebastian
77	Allen  James Lane  1849-1925
78	LouÃ¿s  Pierre  1870-1925
79	Glasgow  Ellen Anderson Gholson  1873-1945
80	Clark  Galen  1814-1910
81	Hawthorne  Nathaniel  1804-1864
82	Locke  William John  1863-1930
83	Everett  Edward  1794-1865
84	Scott  Ernest  1867-1939
85	Nicholls  H. G. (Henry George)  1825-1867
86	Ibsen  Henrik  1828-1906
87	Various
88	MassÃ©  H. J. L. J. (Henri Jean Louis Joseph)  1860-
89	Cibber  Theophilus  1703-1758
90	Shelley  Percy Bysshe  1792-1822
91	McCutcheon  George Barr  1866-1928
92	Williamson  Robert Wood  1856-1932
93	Darwin  George
94	Harrison  Henry Sydnor  1880-1930
95	Johnson  Elias
96	Hutchinson  A. S. M. (Arthur Stuart-Menteth)  1879-1971
97	Park  Mungo  1771-1806
98	Hamsun  Knut  1859-1952
99	Balzac  HonorÃ© de  1799-1850
100	Haeckel  Ernst Heinrich Philipp August  1834-1919
101	Parker  Gilbert  1862-1932
102	Hale  Horatio  1817-1896
103	Noad  Joseph  1823-1898
104	Collins  David  1754-1810
105	Bacon  Francis  1561-1626
106	Haverfield  F. (Francis)  1860-1919
107	Motley  John Lothrop  1814-1877
108	Descartes  RenÃ©  1596-1650
109	Ruskin  John  1819-1900
110	Koopman  Harry Lyman  1860-1937
111	Fisher  A. Hugh (Alfred Hugh)  1867-1945
112	Proctor  Richard A. (Richard Anthony)  1837-1888
113	Guyot  Yves  1843-1928
114	Grey  Zane  1872-1939
115	Homer  750   BC-650   BC
116	Hugo  Victor  1802-1885
117	Field  George  1777  -1854
118	Patterson  J. H. (John Henry)  1867-1947
119	Cellini  Benvenuto  1500-1571
120	Holden  Edward Singleton  1846-1914
121	Leichhardt  Ludwig  1813-1848
122	Mill  John Stuart  1806-1873
123	Scully  W. C. (William Charles)  1855-1943
124	Joyce  James  1882-1941
125	Johnston  Mary  1870-1936
126	Caine  Hall  Sir  1853-1931
127	Cole  Fay-Cooper  1881-1961
128	Cholmondeley  Mary  1859-1925
129	Beeston  Joseph Lievesley  1859-1921
130	Williamson  A. M. (Alice Muriel)  1869-1933
131	Poe  Edgar Allan  1809-1849
132	Morillo  Francisco
133	Villarino  Basilio  1741-1785
134	Bode  Wilhelm  1845-1929
135	Serviss  Garrett Putman  1851-1929
136	Le Fanu  Joseph Sheridan  1814-1873
137	Maspero  G. (Gaston)  1846-1916
138	Beaumarchais  Pierre Augustin Caron de  1732-1799
139	Marlowe  Christopher  1564-1593
140	Grey  George  1812-1898
141	Feith  Jan  1874-1944
142	Stowe  Harriet Beecher  1811-1896
143	Bridge  Horatio  1806-1893
144	Shorter  Clement King  1857-1926
145	Wright  Harold Bell  1872-1944
146	Sedgwick  Anne Douglas  1873-1935
147	Fletcher  F. Morley (Frank Morley)  1866-1949
148	Maunder  E. Walter (Edward Walter)  1851-1928
149	Gunn  Jeannie  1870-1961
150	Baker  Samuel White  Sir  1821-1893
151	Becke  Louis  1855-1913
152	Gerland  Georg Karl Cornelius  1833-1921
153	Brownell  W. C. (William Crary)  1851-1928
154	Confucius  551 BC-479 BC
155	Morrison  George Ernest  1862-1920
156	Doyle  Arthur Conan  Sir  1859-1930
157	Flaubert  Gustave  1821-1880
158	Brown  William Wells  1816  -1884
159	Hunter  John  1738-1821
160	Richardson  Henry Handel  1870-1946
161	Lee  Ida  1865-1943
162	Dorman  Marcus Roberts Phipps
163	Lamothe-Langon  Etienne-LÃ©on  baron de  1786-1864
164	Abbott  L. A.  1813-
165	King  Phillip Parker  1793  -1856
166	Boldrewood  Rolf  1826-1915
167	Van Dyke  Henry  1852-1933
168	Swift  Jonathan  1667-1745
169	Lorimer  George Horace  1869-1937
170	Barry  John D. (John Daniel)  1866-1942
171	Thompson  Maurice  1844-1901
172	Rice  Alice Caldwell Hegan  1870-1942
173	Dreiser  Theodore  1871-1945
174	White  Stewart Edward  1873-1946
175	Du Bois  W. E. B. (William Edward Burghardt)  1868-1963
176	Scott  G. Firth
177	Lee  Gerald Stanley  1862-1944
178	Campbell  Robert Granville
179	Bragdon  Claude Fayette  1866-1946
180	StaÃ«l  Madame de (Anne-Louise-Germaine)  1766-1817
181	Bacheller  Irving  1859-1950
182	Kester  Vaughan  1869-1911
183	Gibbs  Philip  1877-1962
184	Franck  Harry Alverson  1881-1962
185	Tolstoy  Leo  graf  1828-1910
186	Hudson  W. H. (William Henry)  1841-1922
187	Jardine  Frank  1841-1919
188	Connor  Ralph  1860-1937
189	Kronheim  Joseph Martin  1810-1896
190	Butler  Samuel  1835-1902
191	Burroughs  Edgar Rice  1875-1950
192	Arnim  Elizabeth von  1866-1941
193	MacGrath  Harold  1871-1932
194	Dampier  William  1652-1715
195	Forbes  George  1849-1936
196	France  Anatole  1844-1924
197	Yeats  W. B. (William Butler)  1865-1939
198	Baudelaire  Charles  1821-1867
199	Johnson  Samuel  1709-1784
200	Streeter  Edward  1891-1976
201	Livingstone  David  1813-1873
202	Apuleius  Lucius  125  -180
203	Wilson  Sarah Isabella Augusta  Lady  1865-1929
204	IsraÃ«ls  Jozef  1824-1911
205	Gregory  Augustus Charles  1819-1905
206	Silva  Joaquim PossidÃ³nio Narciso da  1806-1896
207	Pater  Walter  1839-1894
208	Franklin  Miles  1879-1954
209	Paine  Thomas  1737-1809
210	Emerson  Ralph Waldo  1803-1882
211	Chambers  Robert W. (Robert William)  1865-1933
212	Semple  Ellen Churchill  1863-1932
213	Morgan  Lewis H.  1818-1881
214	Proudhon  P.-J. (Pierre-Joseph)  1809-1865
215	Mitchell  Thomas  1792-1855
216	Baldwin  Gerald
217	Morris  Edward Ellis  1843-1901
218	Rousseau  Jean-Jacques  1712-1778
219	Thayer  William Roscoe  1859-1923
220	Phillips  George S. (George Searle)  1815-1889
221	Bergson  Henri  1859-1941
222	Spearman  Frank H. (Frank Hamilton)  1859-1937
223	Mason  Otis Tufton  1838-1908
224	Stevenson  James  1840-1888
225	Lytton  Edward Bulwer Lytton  Baron  1803-1873
226	Grant  Robert  1852-1940
227	Tarkington  Booth  1869-1946
228	Hendrick  Burton Jesse  1870-1949
229	Conrad  Joseph  1857-1924
230	Favenc  Ernest  1845-1908
231	Mindeleff  Cosmos  1863-
232	Fielding  Henry  1707-1754
233	CorrÃ©ard  Alexandre  1788-1857
234	Kalidasa
235	Allen  Lewis Falley  1800-1890
236	Whitman  Walt  1819-1892
237	Withers  Hartley  1867-1950
238	Vance  Louis Joseph  1879-1933
239	Tischner  August  1819-
240	Heeres  J. E. (Jan Ernst)  1858-1932
241	Malet  Lucas  1852-1931
242	Macmillan  Hugh
243	James  Henry  1843-1916
244	Marett  R. R. (Robert Ranulph)  1866-1943
245	Gibbon  Edward  1737-1794
246	Dawson  Coningsby  1883-1959
247	Stevenson  Robert Louis  1850-1894
248	Bygate  Joseph E.
249	Muskett  Philip E.  -1909
250	Bryant  Walter W. (Walter William)
251	Lewis  M. G. (Matthew Gregory)  1775-1818
252	Dickens  Charles  1812-1870
253	Creswicke  Louis
254	Clarkson  Thomas  1760-1846
255	Dennett  Mary
256	King  Basil  1859-1928
257	Wollstonecraft  Mary  1759-1797
258	Clark  John Willis  1833-1910
259	Chesnutt  Charles W. (Charles Waddell)  1858-1932
260	Eley  C. King
261	Legge  James  1815-1897
262	Glyn  Elinor  1864-1943
263	Allies  T. W. (Thomas William)  1813-1903
264	Keable  Robert  1887-1927
265	La Fontaine  Jean de  1621-1695
266	Ewers  Hanns Heinz  1871-1943
267	Carroll  Lewis  1832-1898
268	Dumas  Alexandre  1802-1870
269	Rohlfs  Gerhard  1831-1896
270	Poland  Addison B.
271	Kingston  William Henry Giles  1814-1880
272	Ward  Humphry  Mrs.  1851-1920
273	Thurston  Katherine Cecil  1875-1911
274	Abbott  Eleanor Hallowell  1872-1958
275	Burton  Richard Francis  Sir  1821-1890
276	Poole  Ernest  1880-1950
277	Huish  Robert  1777-1850
278	Thomas  Northcote Whitridge  1868-1936
279	Atticus  1836  -1912
280	West  John  1809-1873
281	Stockley  Cynthia  1883-1936
282	Robinson  Rowland E. (Evans)  1833-1900
283	Cook  James  1728-1779
284	Burnett  Frances Hodgson  1849-1924
285	Rabelais  FranÃ§ois  1483-1553
286	Symonds  John Addington  1840-1893
287	Stokes  John Lort  1812-1885
288	Pascal  Blaise  1623-1662
289	Sienkiewicz  Henryk  1846-1916
290	Schmidel  Ulrich  1510  -1579  
291	Wells  H. G. (Herbert George)  1866-1946
292	`Abdu'l-BahÃ¡  1844-1921
293	Pilling  James Constantine  1846-1895
294	Runkle  Bertha  1879-1958
295	Wharton  Edith  1862-1937
296	Carnegie  David Wynford  1871-1900
297	Peat  Harold Reginald  1893-1960
298	Ovid  43 BC-18  
299	Schreiner  Olive  1855-1920
300	Smith  Francis Hopkinson  1838-1915
301	Haggard  Henry Rider  1856-1925
302	Thompson  Slason  1849-1935
303	Sewell  Anna  1820-1878
304	Hichens  Robert Smythe  1864-1950
305	Wilson  Woodrow  1856-1924
306	Thomes  William Henry  1824-1895
307	Voltaire  1694-1778
308	Disraeli  Isaac  1766-1848
309	Dury  John  1596-1680
310	Zola  Ã‰mile  1840-1902
311	Ragozin  ZÃ©naÃ¯de A. (ZÃ©naÃ¯de AlexeÃ¯evna)  1835-1924
312	Hurll  Estelle M. (Estelle May)  1863-1924
313	Eliot  George  1819-1880
314	Maupassant  Guy de  1850-1893
315	Dante Alighieri  1265-1321
316	Browne  Francis F. (Francis Fisher)  1843-1913
317	Gronniosaw  James Albert Ukawsaw
318	Sinclair  May  1863-1946
319	Bacon  Mary Schell Hoke  1870-1934
320	Strachey  Lytton  1880-1932
321	Montgomery  L. M. (Lucy Maud)  1874-1942
322	Florian  1755-1794
323	Hales  A. G. (Alfred Greenwood)  1870-1936
324	Eyre  Edward John  1815-1901
325	Trusler  John  1735-1820
326	Churchill  Winston  1871-1947
327	Todd  David Peck
328	Cuttriss  G. P.
329	Shaw  Bernard  1856-1950
330	Boccaccio  Giovanni  1313-1375
331	Gilbert  W. S. (William Schwenck)  Sir  1836-1911
332	MacKenzie  Compton  1883-1972
333	Dennis  C. J. (Clarence James)  1876-1938
334	Adams  Henry  1838-1918
335	Pinkerton  John  1758-1826
336	Richardson  James  1806-1851
337	Newcomb  Simon  1835-1909
338	Menant  Delphine  1850-
339	Viedma  Francisco de  1737-1809
340	Roberts  W. (William)  1862-1940
341	Waters  Clara Erskine Clement  1834-1916
342	Roosevelt  Theodore  1858-1919
343	Begbie  Harold  1871-1929
344	Worley  George
345	Kitson  Arthur
346	Benham  William  1831-1910
347	Hardy  Thomas  1840-1928
348	Ouida  1839-1908
349	Oppenheim  E. Phillips (Edward Phillips)  1866-1946
350	Allan  P. B. M. (Philip Bertram Murray)  1884-1973
351	#N/A
352	Ball  Robert S. (Robert Stawell)  Sir  1840-1913
353	McCutcheon  John T. (John Tinney)  1870-1949
354	Wills  William John  1834-1861
355	D'Annunzio  Gabriele  1863-1938
356	Bruce  Mary Grant  1878-1958
357	Hull  E. M. (Edith Maude)  -1947
358	Fox  John  1863-1919
359	Quiroga  JosÃ©  1707  -1784
360	Gogol  Nikolai Vasilievich  1809-1852
361	Conwell  Russell H.
362	Lindsay  Norman  1879-1969
363	Burnet  John  1784-1868
364	Wells-Barnett  Ida B.  1862-1931
365	Sinclair  Upton  1878-1968
366	Clarke  Marcus Andrew Hislop  1846-1881
367	London  Jack  1876-1916
368	Davis  Richard Harding  1864-1916
369	Beers  R. W.
370	Kipling  Rudyard  1865-1936
371	Twain  Mark  1835-1911
372	Tasso  Torquato  1544-1595
373	De Wet  Christiaan Rudolf  1854-1922
374	Erasmus  Desiderius  1469-1536
375	Pedley  Ethel C.  1860  -1898
376	Keysor  Jennie Ellis  1860-
377	Beazley  C. Raymond (Charles Raymond)  1868-1955
378	Moore  George (George Augustus)  1852-1933
379	Menpes  Mortimer  1855-1938
380	Milton  John  1608-1674
381	Stendhal  1783-1842
382	Stuart  John McDouall  1815-1866
383	Montaigne  Michel de  1533-1592
384	Glanville  Ernest  1855-1925
385	Humphrey  S. D. (Samuel Dwight)  1823-1883
386	Bakunin  Mikhail Aleksandrovic  1814-1876
387	Phillip  Arthur  1738-1814
388	Orchard  Thomas Nathaniel
389	Mackinlay  M. (Malcolm) Sterling  1876-1952
390	Murray  Margaret Alice  1863-1963
391	Flinders  Matthew  1774-1814
392	Burne  C. R. N. (Charles Richard Newdigate)
393	Swedenborg  Emanuel  1688-1772
394	Bailey  Temple  -1953
395	Henty  G. A. (George Alfred)  1832-1902
396	Ellis  Havelock  1859-1939
397	Flammarion  Camille  1842-1925
398	Clacy  Ellen
399	Corfield  W. H. (William Henry)  1843-1903
400	Cervantes Saavedra  Miguel de  1547-1616
401	Grosclaude  Etienne  1858-1932
402	Camp  Wadsworth  1879-1936
403	Lang  Andrew  1844-1912
404	Gilbert  Clinton W. (Clinton Wallace)  1871-1933
405	Orr  Lyndon
406	Shoghi  Effendi  1897-1957
407	CouÃ©  Emile  1857-1926
408	Knox  Thomas Wallace  1835-1896
409	McKinlay  John
410	Appleton  Everard Jack  1872-1931
411	Swinburne  Algernon Charles  1837-1909
412	Wilson  Robert Pierpont
413	Lane  Elinor Macartney  1864-1909
414	Huxley  Thomas Henry  1825-1895
415	Powell  John Wesley  1834-1902
416	Banfield  E. J. (Edmund James)  1852-1923
417	Frazer  James George  Sir  1854-1941
418	Locke  John  1632-1704
419	La Motte  Ellen Newbold  1873-1961
\.


--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 171
-- Name: autor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('autor_id_seq', 419, true);


--
-- TOC entry 2060 (class 0 OID 26387)
-- Dependencies: 178
-- Data for Name: critica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY critica (uid, isbn, puntuacion) FROM stdin;
2772	1690	10
2772	21391	8
3437	17700	1
1616	5305	7
2772	3810	4
1616	2225	1
3743	711	8
3206	1690	1
3743	11617	3
4999	7937	7
3167	15240	0
4440	17700	7
2071	11772	4
1720	17599	10
3738	17599	10
3167	1711	2
1720	14451	7
1424	2761	4
4728	5760	8
4440	21448	8
1720	15399	3
1616	16280	1
1736	21490	10
4440	21448	1
3738	15399	2
3738	1458	7
3738	21472	3
2772	15042	6
4440	15399	6
4875	2710	5
3437	7937	7
4440	1690	4
4136	1458	0
1616	2857	7
1720	2710	4
2071	21391	7
3206	15399	2
3738	11772	4
3206	11772	4
4440	8564	9
4999	15399	1
1720	1690	6
2068	215	1
3437	1690	8
3738	11772	6
3206	21448	1
1720	16280	10
3167	2710	0
4728	1711	8
4136	21391	9
4875	2761	6
1720	14466	2
1616	1458	7
2772	2761	10
4999	6693	7
3167	21490	0
1616	589	5
4875	6693	5
3738	16280	9
1424	18544	6
3606	11617	0
4999	1458	5
3606	2710	8
2068	12667	3
4999	15240	3
2068	8564	5
3743	2710	7
1736	3657	5
2089	21448	7
3437	3657	7
1736	21472	8
4136	21391	1
1424	15399	1
1435	1458	3
2068	7937	1
2089	2710	10
1435	36791	6
1435	21490	4
2071	21391	1
3437	2681	2
1736	21472	3
2772	2713	5
3743	21254	10
4728	17599	0
4999	16280	3
4440	11772	6
3167	5305	8
3743	17700	1
3437	11772	4
2089	21490	4
2089	23638	8
2772	8564	4
3738	2761	4
1736	3657	4
3606	23638	7
3167	36791	2
1736	23638	3
3738	12428	4
1424	17164	10
4728	21391	6
4999	15399	1
2068	5305	2
2068	18544	7
3206	5157	2
2068	2681	6
1435	2761	8
4440	2225	2
2089	12428	10
4875	21490	8
3167	17700	2
3206	2710	7
3437	21060	9
1736	1441	1
3743	3657	6
4875	3810	7
4999	21060	4
1616	1690	7
1424	2713	0
4440	21391	1
1616	21060	1
4728	21472	5
4875	18544	10
4440	1711	9
1424	2713	6
1424	6886	10
1736	5157	4
2071	2841	1
4440	6886	2
1720	8564	4
3606	7937	3
4999	21472	0
1424	2710	3
4875	21060	7
1616	711	1
3167	5760	4
4440	2759	3
2071	2761	6
3167	589	5
3437	1458	3
4136	1441	6
3738	3810	5
1616	17615	5
3206	5305	5
1424	5157	1
4999	1690	3
3738	2857	2
3437	17599	0
4999	12428	8
4999	15240	9
1424	6693	8
4875	17700	3
3167	15042	5
3606	15042	10
3743	14451	4
2071	21490	2
3738	21472	8
3206	1711	5
3437	7937	6
4728	1441	8
3167	1441	10
4136	21472	1
2772	2225	9
2089	21391	0
3167	2710	1
4136	215	3
3606	11617	10
4999	2225	4
2068	3810	9
2772	14466	4
4728	21472	9
1435	17164	8
2089	2857	7
2071	1441	10
3743	21472	6
1736	2713	0
3206	2761	3
3437	5760	3
3738	17700	7
4728	21254	1
3167	15240	2
3167	21490	3
1736	15399	10
2068	6693	0
3738	11772	4
4728	11617	10
4728	12428	0
3738	6886	9
4728	16280	10
1435	1690	2
3738	17700	4
3743	21472	8
4999	21899	2
1736	2710	0
2068	6886	8
3606	2761	0
4875	21391	8
3167	21899	2
2068	14466	10
1435	21448	2
1424	1441	3
\.


--
-- TOC entry 2057 (class 0 OID 26353)
-- Dependencies: 175
-- Data for Name: isbnrautor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY isbnrautor (isbn, id_autor) FROM stdin;
217	1
4240	1
28948	1
5719	2
5157	3
31	4
2270	5
1531	5
25667	5
2266	5
1515	5
2250	5
15066	6
4731	7
35744	8
24994	9
25527	9
22608	10
6693	11
1695	12
20416	13
30719	14
17814	14
27315	14
2562	14
15399	15
4390	16
37171	17
813	18
9879	19
13831	20
160	21
17498	22
103	23
3748	23
7523	24
13755	25
13029	26
15620	27
6315	28
10743	29
21060	30
18289	31
22574	32
481	33
1693	34
1601	34
1970	34
1590	34
9931	34
1671	34
16891	35
29208	36
23917	36
20665	37
3546	38
30396	39
3436	39
3435	39
11000	39
17289	39
19643	39
22990	39
804	40
25317	41
14056	42
19240	43
16983	43
16984	43
16939	43
16940	43
13913	44
12441	44
37190	44
10509	45
13763	45
13497	45
17370	46
17730	46
15622	47
21302	48
14264	49
30607	50
27573	51
30268	51
22522	52
36780	52
7849	53
37274	54
31053	55
30344	55
14555	56
5712	57
3819	58
3833	58
11030	59
16494	60
22136	61
228	62
21899	63
1323	64
15602	65
28054	66
9489	67
35188	67
12418	68
307	69
304	69
1036	70
214	70
16664	71
14001	72
14355	72
61	73
19856	74
19715	75
18723	76
12482	77
3791	77
26685	78
4708	78
14696	79
14571	79
16572	80
25344	81
3828	82
4287	82
14669	82
4379	82
14395	82
16227	83
7450	84
24505	85
15492	86
33281	87
23615	87
16105	87
15020	87
14987	87
13575	87
13642	87
36676	87
27341	87
27262	87
27118	87
26600	87
22575	87
11617	87
22260	88
12090	89
4799	90
4797	90
6353	91
14284	91
14818	91
5971	91
13967	91
6801	91
17910	92
35588	93
34297	94
13985	94
14303	94
7978	95
14145	96
5305	97
8564	97
8387	98
1237	99
8700	100
6245	101
6249	101
22601	102
15126	103
12565	104
12668	104
5500	105
19115	106
4830	107
23306	108
19164	109
19980	109
23593	109
17774	109
22606	110
19487	111
16767	112
26556	112
17968	113
4684	114
10201	114
1027	114
3160	115
20580	116
22048	116
9976	116
29549	116
20915	117
3810	118
4028	119
29031	120
5005	121
30107	122
27942	122
23638	123
4300	124
2814	124
13812	125
14513	125
14597	126
18273	127
14885	128
15896	129
14740	130
17192	131
18783	132
11302	133
18733	134
18431	135
28752	135
14851	136
14400	137
20577	138
36826	138
21262	139
16145	140
16027	140
18236	141
6702	142
7937	143
19767	144
3265	145
11715	145
6997	145
30115	146
20195	147
28536	148
4699	149
3233	150
3657	150
24807	151
24639	151
25059	151
14028	152
17244	153
3330	154
19172	155
24951	156
3069	156
3070	156
2852	156
1661	156
15995	157
2413	157
25053	157
2095	158
2046	158
15662	159
3832	160
7509	161
15240	162
2082	163
4667	164
12046	165
11203	165
1198	166
4221	166
1603	167
12784	168
4737	168
21959	169
3151	170
4097	171
5970	172
14079	172
4377	172
31824	173
5267	173
14451	174
15359	175
408	175
17700	175
25750	176
15759	177
12427	178
12648	179
12625	179
16896	180
2799	181
17237	181
14150	181
12440	181
5129	182
3317	183
4786	184
689	185
4602	185
7446	186
4521	187
3288	188
3249	188
3242	188
18937	189
1906	190
62	191
14646	192
4790	193
15675	194
8172	195
18545	196
36865	197
26710	198
6099	198
652	199
13993	200
16672	201
1666	202
14466	203
20607	204
10461	205
17186	206
4060	207
11620	208
3743	209
6312	210
13813	211
14852	211
15293	212
8112	213
444	214
13033	215
12928	215
9943	215
26034	216
27977	217
30433	218
5427	218
2386	219
20967	220
26163	221
29571	222
17606	223
19606	224
1951	225
14645	226
1611	227
1098	227
402	227
3428	227
17018	228
2021	229
7163	230
10840	230
17487	231
6593	232
6828	232
11772	233
16659	234
19998	235
1322	236
22832	237
9779	238
8741	238
34435	239
17450	240
23784	241
16180	242
209	243
17280	244
25717	245
25702	246
589	247
20191	248
4219	249
12406	250
601	251
1400	252
26198	253
10633	254
12428	254
31732	255
14394	256
3420	257
26378	258
19415	258
19746	259
11057	259
11228	259
19881	260
3100	261
4094	261
10959	262
8899	262
34172	263
14579	264
17941	265
20589	266
28885	267
2759	268
2681	268
2710	268
17599	269
16280	269
3725	270
23050	271
21383	271
21464	271
21448	271
21490	271
21472	271
21391	271
14126	272
13782	272
14054	273
33490	273
18665	274
6886	275
5760	275
29932	276
12667	277
17404	278
10479	279
22849	280
22568	281
36844	282
8106	283
6491	284
2514	284
506	284
113	284
1200	285
11242	286
12115	287
12146	287
29772	288
18269	288
35560	289
20401	290
14060	291
19300	292
19292	292
19296	292
19312	292
19279	292
19238	292
19284	292
19289	292
17262	293
14219	294
541	295
4975	296
16685	297
21765	298
1440	299
1441	299
1458	299
5229	300
4516	300
2857	301
2761	301
2841	301
1711	301
1690	301
2713	301
711	301
12985	302
271	303
4603	304
3637	304
14811	305
16050	306
18569	307
31078	308
16350	308
15199	309
17831	310
20974	310
8563	310
24654	311
17212	312
19602	312
19009	312
13119	312
19570	312
145	313
4788	314
7114	314
8800	315
1012	315
1000	315
14004	316
15042	317
13883	318
6932	319
2447	320
1265	320
47	321
32527	322
16131	323
5346	324
22500	325
5394	326
3684	326
3766	326
5388	326
5373	326
35261	327
16588	328
5722	329
19591	330
23700	330
808	331
33798	332
33797	332
21518	333
2044	334
2660	335
18544	336
17164	336
4065	337
14648	338
18798	339
22607	340
24726	341
6467	342
14996	343
21511	344
10842	345
16531	346
153	347
110	347
37178	348
5815	349
9836	349
22716	350
984	351
12058	351
1199	351
18157	351
15041	351
1980	351
24236	352
21254	353
5816	354
27825	355
22642	355
23297	355
4050	356
8730	356
7031	357
5145	358
5122	358
20852	359
1081	360
37036	361
23625	362
22690	363
14975	364
14977	364
14976	364
140	365
3424	366
215	367
405	368
36791	369
2225	370
3193	371
3197	371
3195	371
3194	371
76	371
74	371
392	372
18794	373
27846	374
9371	374
18891	375
3703	375
22564	376
18757	377
7508	378
17215	379
608	380
796	381
798	381
8911	382
3600	383
17615	384
167	385
20677	386
15100	387
28434	388
37298	389
20411	390
12929	391
25117	392
11248	393
18056	394
32934	395
13611	396
13610	396
25267	397
4054	398
27099	399
996	400
5946	400
13855	401
33733	402
1961	403
3812	404
4691	405
4693	405
19254	406
19243	406
19274	406
27203	407
23995	408
13248	409
20072	410
27401	411
6841	412
14263	413
2634	414
18869	415
5113	416
20116	417
10616	418
10615	418
26884	419
\.


--
-- TOC entry 2058 (class 0 OID 26366)
-- Dependencies: 176
-- Data for Name: isbnrtraductor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY isbnrtraductor (isbn, id_traductor) FROM stdin;
17941	1
23306	2
18289	2
29208	3
27825	3
14648	3
798	4
20577	4
18783	4
18723	5
18798	5
22642	6
20401	6
27846	7
796	8
18733	8
13855	9
20974	9
15995	10
1000	11
20665	11
32934	12
16131	12
17968	12
21302	12
24951	12
3069	12
18794	12
26198	12
12427	12
25117	12
16494	12
12985	12
2447	12
6702	12
18757	12
14555	12
19767	12
4691	12
4693	12
2082	12
3725	12
984	12
6312	12
12090	12
813	12
14004	12
4667	12
17192	12
20416	12
15199	12
26378	12
22608	12
22607	12
22606	12
22136	12
4684	12
541	12
22716	12
30396	12
31078	12
16350	12
1961	12
19415	12
1693	12
3193	12
5394	12
10509	12
34297	12
4786	12
18665	12
3828	12
14696	12
21959	12
5970	12
14001	12
17498	12
27203	12
17018	12
14996	12
3812	12
1265	12
1601	12
32527	12
14579	12
6491	12
14145	12
25702	12
1970	12
7031	12
2799	12
14885	12
3317	12
2386	12
6467	12
13763	12
5815	12
17237	12
2044	12
14646	12
18056	12
3265	12
3288	12
10201	12
16685	12
405	12
3197	12
3195	12
3194	12
12418	12
20072	12
9836	12
3249	12
13497	12
13993	12
1590	12
13883	12
4603	12
4287	12
14150	12
29571	12
14571	12
14060	12
1611	12
1027	12
29932	12
5229	12
14669	12
9931	12
9489	12
1098	12
6353	12
402	12
4379	12
11715	12
14811	12
15759	12
2514	12
14597	12
9879	12
5145	12
13985	12
1440	12
26163	12
30115	12
14394	12
13813	12
14303	12
6997	12
5129	12
1671	12
14054	12
14395	12
14355	12
14284	12
14263	12
9779	12
4516	12
5122	12
3684	12
4790	12
3242	12
14852	12
14818	12
8741	12
506	12
13913	12
7523	12
6315	12
5971	12
12441	12
3766	12
14740	12
33490	12
13967	12
3637	12
14079	12
14126	12
6801	12
13812	12
481	12
12482	12
13782	12
23784	12
1603	12
3428	12
3070	12
2852	12
14513	12
4377	12
12440	12
10959	12
6245	12
6249	12
14219	12
5388	12
31	12
4097	12
5373	12
5719	12
3791	12
14645	12
1695	12
103	12
209	12
271	12
652	12
14851	12
3748	12
1200	12
1081	12
228	12
1951	12
62	12
1906	12
2270	12
3420	12
33281	12
1322	12
76	12
3436	12
3435	12
7849	12
12406	12
1531	12
21765	12
12058	12
16659	12
4300	12
15492	12
8387	12
1237	12
145	12
11000	12
28054	12
1400	12
8800	12
2021	12
23700	12
31732	12
13611	12
13610	12
113	12
1661	12
996	12
5722	12
7508	12
808	12
47	12
37298	12
160	12
4788	12
18545	12
153	12
110	12
27401	12
61	12
2413	12
74	12
28885	12
25053	12
12784	12
20580	12
30107	12
25344	12
31053	12
217	12
4240	12
28948	12
140	12
33798	12
33797	12
2814	12
26884	12
31824	12
5267	12
5946	12
8899	12
27942	12
4799	12
16896	12
4797	12
3743	12
25717	12
6593	12
601	12
804	12
30433	12
5427	12
6828	12
18569	12
11248	12
4737	12
608	12
33733	12
30344	12
10616	12
10615	12
18269	12
2266	12
1515	12
2250	12
5500	12
3600	12
392	12
21262	12
1666	12
9371	12
3330	12
3100	12
4094	12
3160	12
2562	12
19254	12
19243	12
19300	12
19292	12
19240	12
16983	12
4219	12
16891	12
23625	12
7114	12
19296	12
19312	12
19279	12
19238	12
19284	12
19289	12
16984	12
16939	12
16940	12
23050	12
16588	12
15896	12
10842	12
4975	12
1036	12
214	12
4830	12
21518	12
4050	12
3819	12
3833	12
1198	12
7509	12
12115	12
5005	12
5346	12
15602	12
12565	12
27977	12
24807	12
24639	12
3424	12
11620	12
1199	12
3832	12
19172	12
21383	12
4731	12
22849	12
23995	12
25059	12
26034	12
21464	12
18891	12
3703	12
25750	12
4221	12
16664	12
4699	12
24994	12
25527	12
27099	12
19274	12
5113	12
307	12
304	12
8730	12
16050	12
3546	12
4054	12
15100	12
34172	12
12929	12
12146	12
5816	12
8911	12
13033	12
12928	12
9943	12
13248	12
12046	12
11203	12
4521	12
16145	12
16027	12
10461	12
15662	12
7163	12
10840	12
7450	12
2660	12
17450	12
15675	12
12668	12
8106	12
30607	12
16767	12
18431	12
16227	12
24236	12
29031	12
4065	12
35588	12
15620	12
28752	12
35261	12
26556	12
25267	12
15622	12
17370	12
8172	12
35744	12
28536	12
28434	12
3151	12
24726	12
22522	12
11242	12
17212	12
19602	12
22690	12
17215	12
19009	12
13119	12
4390	12
19164	12
19980	12
4060	12
6932	12
13755	12
14264	12
167	12
20195	12
37274	12
20915	12
6841	12
22574	12
16180	12
13029	12
5712	12
17730	12
14056	12
17244	12
17289	12
22564	12
20607	12
22500	12
19570	12
37190	12
37178	12
18937	12
4028	12
7446	12
37171	12
37036	12
36865	12
19715	12
23593	12
12648	12
15020	12
14987	12
19998	12
20967	12
36844	12
22260	12
21511	12
19487	12
20191	12
19881	12
22832	12
22990	12
10479	12
16531	12
12625	12
17774	12
24654	12
13575	12
19606	12
35188	12
19856	12
17606	12
24505	12
17487	12
15126	12
19115	12
14400	12
17910	12
22601	12
1323	12
17262	12
17280	12
17404	12
16572	12
8112	12
7978	12
20411	12
13642	12
20116	12
13831	12
18273	12
15293	12
18869	12
689	12
2634	12
8700	12
4602	12
444	12
27341	12
27262	12
27118	12
26600	12
20677	12
14975	12
14977	12
15041	12
19746	12
2095	12
14976	12
11030	12
15359	12
408	12
11057	12
11228	12
2046	12
10633	12
1980	12
22568	12
16672	12
11772	12
21254	12
21899	12
1441	12
1458	12
21448	12
21490	12
21472	12
2857	12
2761	12
17615	12
21060	12
17700	12
12428	12
23638	12
14466	12
21391	12
15042	12
15399	12
36791	12
15240	12
3810	12
14451	12
18544	12
17164	12
5305	12
8564	12
5157	12
2759	12
6886	12
2681	12
12667	12
5760	12
2225	12
7937	12
3233	12
6693	12
3657	12
589	12
215	12
2841	12
1711	12
1690	12
2713	12
711	12
10743	12
2710	12
11617	12
30268	13
27315	13
6099	14
34435	14
25317	14
36780	15
17186	16
22575	17
17814	18
16105	19
17831	20
14028	21
19591	22
26685	23
25667	24
36826	24
18157	24
1012	25
23917	26
29772	26
20852	26
16280	27
35560	28
15066	29
23297	30
18236	31
36676	31
17599	32
26710	33
29549	34
27573	35
11302	36
19643	37
23615	38
8563	39
22048	39
30719	39
9976	40
20589	41
4708	42
\.


--
-- TOC entry 2052 (class 0 OID 26323)
-- Dependencies: 170
-- Data for Name: libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY libro (isbn, libro, fecha, idioma, genero) FROM stdin;
11617	Punch  or the London Charivari  Volume 156  April 2  1919	2004-03-01	English	English wit and humor -- Periodicals
2710	Louise de la Valliere	2001-07-01	English	France -- History -- Louis XIV  1643-1715 -- Fiction
10743	Moonfleet	2004-01-01	English	England -- Fiction
711	Allan Quatermain	2004-11-18	English	Adventure stories
2713	Maiwa's Revenge	2006-03-31	English	Africa  East -- Fiction
1690	Marie--An Episode in The Life of the late Allan Quatermain	1999-03-01	English	Quatermain  Allan (Fictitious character) -- Fiction
1711	Child of Storm	1999-04-01	English	Zulu (African people) -- Fiction
2841	The Ivory Child	2006-03-31	English	Fantasy fiction  English
215	The Call of the Wild	2008-07-02	English	Adventure stories
589	Catriona	1996-07-01	English	Scotland -- History -- 18th century -- Fiction
3657	Wild Beasts and Their Ways  Reminiscences of Europe  Asia  Africa and America â€” Volume 1	2003-01-01	English	Animal behavior
6693	People of Africa	2004-10-01	English	Ethnology -- Africa
3233	In the Heart of Africa	2002-05-01	English	Sudan -- Description and travel
7937	Journal of an African Cruiser	2005-04-01	English	#N/A
2225	Captains Courageous	2000-06-01	English	Sea stories
5760	Two Trips to Gorilla Land and the Cataracts of the Congo Volume 1	2004-05-01	English	#N/A
12667	Lander's Travels--The Travels of Richard Lander into the Interior of Africa	2004-06-01	English	#N/A
2681	Ten Years Later	2001-06-01	English	Historical fiction
6886	First Footsteps in East Africa	2004-11-01	English	Harari language
2759	The Man in the Iron Mask	2001-08-01	English	Historical fiction
5157	How I Found Livingstone; travels  adventures  and discoveres in Central Africa  including an account of four months' residence with Dr. Livingstone  by Henry M. Stanley	2004-02-01	English	Africa  Central -- Description and travel
8564	Life and Travels of Mungo Park in Central Africa	2005-07-01	English	#N/A
5305	Travels in the Interior of Africa â€” Volume 02	2004-03-01	English	Niger River
17164	Narrative of a Mission to Central Africa Performed in the Years 1850-51  Volume 1--Under the Orders and at the Expense of Her Majesty's Government	2005-11-27	English	Africa  Central -- Description and travel
18544	Narrative of a Mission to Central Africa Performed in the Years 1850-51  Volume 2--Under the Orders and at the Expense of Her Majesty's Government	2006-06-09	English	Africa  Central -- Description and travel
14451	African Camp Fires	2004-12-24	English	#N/A
3810	The Man-Eaters of Tsavo and Other East African Adventures	2003-03-01	English	Uganda Railway
15240	A Journal of a Tour in the Congo Free State	2005-03-04	English	#N/A
16280	BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875	2005-07-13	German	Africa  Central -- Description and travel
36791	The Mormon Puzzle  and How to Solve It	2011-07-20	English	#N/A
15399	The Interesting Narrative of the Life of Olaudah Equiano  Or Gustavus Vassa  The African--Written By Himself	2005-03-17	English	Equiano  Olaudah  1745-1797
15042	A Narrative of the Most Remarkable Particulars in the Life of James Albert Ukawsaw Gronniosaw  an African Prince  as Related by Himself	2005-02-14	English	#N/A
21391	Great African Travellers--From Mungo Park to Livingstone and Stanley	2007-05-08	English	Explorers
14466	South African Memories--Social  Warlike & Sporting from Diaries Written at the Time	2004-12-25	English	South Africa -- Description and travel
23638	Reminiscences of a South African Pioneer	2007-11-26	English	Scully  W. C. (William Charles)  1855-1943
12428	The History of the Rise  Progress and Accomplishment of the Abolition of the African Slave Trade by the British Parliament (1808)  Volume I	2004-05-01	English	Slavery
17599	Von Tripolis nach Alexandrien - 1. Band	2006-01-24	German	Africa  North -- Description and travel
17700	The Suppression of the African Slave Trade to the United States of America--1638-1870	2006-02-07	English	Slave trade -- United States -- History
21060	The Congo Rovers--A Story of the Slave Squadron	2007-04-13	English	Slave trade -- Juvenile fiction
17615	In Search of the Okapi--A Story of Adventure in Central Africa	2006-01-28	English	Adventure stories
2761	Benita  an African romance	2006-03-28	English	Africa  East -- Fiction
2857	A Yellow God: an Idol of Africa	2006-04-04	English	Africa -- Fiction
21472	Ned Garth--Made Prisoner in Africa. A Tale of the Slave Trade	2007-05-15	English	Sailors -- Juvenile fiction
21490	The Two Supercargoes--Adventures in Savage Africa	2007-05-16	English	Adventure and adventurers -- Juvenile fiction
21448	The African Trader--The Adventures of Harry Bayford	2007-05-15	English	Conduct of life -- Juvenile fiction
1458	Dream Life and Real Life; a little African story	1998-09-01	English	Essays
1441	The Story of an African Farm  a novel	1998-09-01	English	Africa -- Fiction
21899	A Rip Van Winkle Of The Kalahari--And Other Tales of South-West Africa	2007-06-22	English	Africa -- Fiction
21254	In Africa--Hunting Adventures in the Big Game Country	2007-04-29	English	Hunting -- Africa  East
11772	Naufrage de la frigate la MÃ©duse. English	2004-04-01	English	MÃ©duse (Ship)
16672	The Last Journals of David Livingstone  in Central Africa  from 1865 to His Death  Volume I (of 2)  1866-1868	2005-09-07	English	Africa  Central -- Description and travel
22575	Le Tour du Monde; Afrique Orientale--Journal des voyages et des voyageurs; 2. sem. 1860	2007-09-11	French	Geography -- Pictorial works -- Periodicals
22568	Blue Aloes--Stories of South Africa	2007-09-10	English	South Africa -- Social life and customs -- Fiction
1980	Stories by English Authors: Africa (Selected by Scribners)	2006-03-26	English	Africa -- Fiction
10633	The History of the Rise  Progress and Accomplishment of the Abolition of the African Slave-Trade  by the British Parliament (1839)	2004-01-01	English	Slavery
2046	Clotel; or  the President's Daughter	2000-01-01	English	Children of presidents -- Fiction
11228	The Marrow of Tradition	2004-02-01	English	#N/A
11057	The Wife of his Youth and Other Stories of the Color Line  and Selected Essays	2004-02-01	English	#N/A
408	The Souls of Black Folk	1996-01-01	English	African Americans
15359	The Negro	2005-03-14	English	Africa -- History
11030	Incidents in the Life of a Slave Girl--Written by Herself	2004-02-01	English	#N/A
14976	Mob Rule in New Orleans--Robert Charles and His Fight to Death  the Story of His Life  Burning--Human Beings Alive  Other Lynching Statistics	2005-02-08	English	Lynching
167	American Hand Book of the Daguerreotype	1994-09-01	English	Daguerreotype
2095	Clotelle: a Tale of the Southern States	2000-03-01	English	Women slaves -- Fiction
19746	The Colonel's Dream	2006-11-09	English	Failure (Psychology) -- Fiction
15041	The Negro Problem	2005-02-14	English	#N/A
14977	The Red Record--Tabulated Statistics and Alleged Causes of Lynching in the United States	2005-02-08	English	African Americans -- History -- 1877-1964
14975	Southern Horrors--Lynch Law in All Its Phases	2005-02-08	English	Lynching
20677	God and the State	2007-02-03	English	Atheism
26600	Mother Earth  Vol. 1 No. 1  March 1906	2008-09-12	English	Anarchism -- Periodicals
27118	Mother Earth  Vol. 1 No. 2  April 1906--Monthly Magazine Devoted to Social Science and Literature	2008-11-01	English	Anarchism -- Periodicals
27262	Mother Earth  Vol. 1 No. 3  May 1906--Monthly Magazine Devoted to Social Science and Literature	2008-11-14	English	Anarchism -- Periodicals
27341	Mother Earth  Vol. 1 No. 4  June 1906--Monthly Magazine Devoted to Social Science and Literature	2008-11-27	English	Anarchism -- Periodicals
444	System of Economical Contradictions; or  the Philosophy of Misery	1996-02-01	English	Philosophy
4602	The Kingdom of God Is Within You	2003-11-01	English	Evil  Non-resistance to
8700	The Evolution of Man	2005-08-01	English	Embryology  Human
2634	Evolution of Theology: an Anthropological Study	2001-05-01	English	Paleontology
689	The Kreutzer Sonata and Other Stories	2006-03-18	English	Fiction
36676	L'Illustration  No. 3271  4 Novembre 1905	2011-07-09	French	#N/A
18869	On Limitations To The Use Of Some Anthropologic Data	2006-07-19	English	Anthropology
15293	Influences of Geographic Environment--On the Basis of Ratzel's System of Anthropo-Geography	2005-03-08	English	Human geography
14028	Ãœber das Aussterben der NaturvÃ¶lker	2004-11-12	German	Ethnology
18273	The Wild Tribes of Davao District  Mindanao--The R. F. Cummings Philippine Expedition	2006-04-28	English	Ethnology -- Philippines -- Mindanao Island
14648	Bij de Parsi's van Bombay en Gudsjerat--De Aarde en haar Volken  1909-1910	2005-01-10	Dutch	Parsees
13831	Evolution Of The Japanese  Social And Psychic	2004-10-22	English	Japan -- Civilization
20116	The Belief in Immortality and the Worship of the Dead  Volume I (of 3)--The Belief Among the Aborigines of Australia  the Torres Straits Islands  New Guinea and Melanesia	2006-12-15	English	Ancestor worship -- Oceania
17186	NoÃ§Ãµes elementares de archeologia	2005-11-29	Portuguese	Archaeology
13642	The Journal of Negro History  Volume 1  January 1916	2004-10-05	English	African Americans -- Periodicals
35560	Quo Vadis (Î Î¿Ï Ï€Î·Î³Î±Î¯Î½ÎµÎ¹Ï‚)--ÎœÏ…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎÎµÏÏ‰Î½Î¹ÎºÎ®Ï‚ Î•Ï€Î¿Ï‡Î®Ï‚	2011-03-12	Greek	#N/A
20411	The Witch-cult in Western Europe--A Study in Anthropology	2007-01-22	English	Witchcraft -- Great Britain
20665	De Nederlandsche Nationale Kleederdrachten	2007-02-25	Dutch	Costume -- Netherlands -- History
18236	In de Amsterdamsche Jodenbuurt--De Aarde en haar Volken  1907	2006-04-23	Dutch	Jews -- Netherlands -- Amsterdam
7978	Legends  Traditions  and Laws of the Iroquois  or Six Nations  and History of the Tuscarora Indians	2005-04-01	English	Tuscarora Indians
8112	Houses and House-Life of the American Aborigines	2005-05-01	English	Indians of North America -- Dwellings
16572	Indians of the Yosemite Valley and Vicinity--Their History  Customs and Traditions	2005-08-21	English	Yosemite Valley (Calif.)
17404	Kinship Organisations and Group Marriage in Australia	2005-12-28	English	Aboriginal Australians -- Kinship
17280	Anthropology	2005-12-11	English	Anthropology
17262	Catalogue Of Linguistic Manuscripts In The Library Of The Bureau Of Ethnology. (1881 N 01 / 1879-1880 (Pages 553-578))	2005-12-09	English	Indians of North America -- Languages -- Bibliography
1323	History of the Conquest of Peru; with a preliminary view of the civilization of the Incas	1998-05-01	English	Peru -- History -- Conquest  1522-1548
22601	Hiawatha and the Iroquois Confederation--A Study in Anthropology. A Paper Read at the Cincinnati Meeting of the American Association for the Advancement of Science  in August  1881  under the Title of A Lawgiver of the Stone Age.	2007-09-14	English	Hiawatha  15th cent.
17910	The Mafulu--Mountain People of British New Guinea	2006-03-04	English	Mafulus
14400	Manual of Egyptian Archaeology and Guide to the Study of Antiquities in Egypt	2004-12-20	English	Egypt -- Antiquities
19115	Roman Britain in 1914	2006-08-25	English	Great Britain -- Antiquities  Roman
15126	Lecture on the Aborigines of Newfoundland--Delivered Before the Mechanics' Institute  at St. John's --Newfoundland  on Monday  17th January  1859	2005-02-21	English	Indians of North America -- Newfoundland and Labrador
17487	Casa Grande Ruin--Thirteenth Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution  1891-92 --Government Printing Office  Washington  1896  pages 289-318	2006-01-10	English	Hohokam architecture
24505	The Forest of Dean--An Historical and Descriptive Account	2008-02-03	English	Technology  History of
17606	Throwing-sticks in the National Museum--Third Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution  1883-'84 --Government Printing Office  Washington  1890  pages 279-289	2006-01-25	English	United States National Museum -- Collections
19856	A Study of Pueblo Architecture: Tusayan and Cibola--Eighth Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution  1886-1887 --Government Printing Office  Washington  1891  pages 3-228	2006-11-17	English	Pueblo Indians -- Antiquities
35188	The Fire Bird	2011-02-06	English	#N/A
19606	Illustrated Catalogue of the Collections Obtained from the Pueblos of ZuÃ±i  New Mexico  and Wolpi  Arizona  in 1881--Third Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution  1881-82 --Government Printing Office  Washington  1884  pages 511-594	2006-10-23	English	Zuni Indians -- Antiquities
13575	How to Observe in Archaeology	2004-10-01	English	Archaeology
24654	Chaldea--From the Earliest Times to the Rise of Assyria	2008-02-20	English	Babylonia -- History
17774	The Poetry of Architecture--Or  the Architecture of the Nations of Europe Considered in its Association with Natural Scenery and National Character	2006-02-16	English	Architecture
12625	Architecture and Democracy	2004-06-01	English	Sullivan  Louis H.  1856-1924
16531	Old St. Paul's Cathedral	2005-08-15	English	St. Paul's Cathedral (London  England)
14264	The Practice and Science of Drawing	2004-12-06	English	Drawing
13755	How to See the British Museum in Four Visits	2004-10-15	English	British Museum
10479	Our Churches and Chapels--Their Parsons  Priests  & Congregations--Being a Critical and Historical Account of Every Place of Worship in Preston	2003-12-01	English	Preston (Lancashire  England) -- Church history
22990	Historical Sketch of the Cathedral of Strasburg	2007-10-12	English	Strassburger MÃ¼nster
22832	The Cathedral Church of Canterbury [2nd ed.]--A Description of Its Fabric and a Brief History of the Archiepiscopal See	2007-10-02	English	Canterbury Cathedral
19881	Bell's Cathedrals: The Cathedral Church of Carlisle--A Description of Its Fabric and A Brief History of the Episcopal See	2006-11-20	English	Carlisle Cathedral (Carlisle  England)
20191	Bell's Cathedrals: The Cathedral Church of Durham--A Description of Its Fabric and A Brief History of the Espiscopal See	2006-12-26	English	Durham Cathedral
19487	Bellâ€™s Cathedrals: The Cathedral Church of Hereford  A Description--Of Its Fabric And A Brief History Of The Episcopal See	2006-10-07	English	Hereford Cathedral
36780	Lettres de mon moulin	2011-07-18	French	#N/A
21511	Bell's Cathedrals: The Priory Church of St. Bartholomew-the-Great  Smithfield--A Short History of the Foundation and a Description of the--Fabric and also of the Church of St. Bartholomew-the-Less	2007-05-17	English	St. Bartholomew-the-Great (Church : London  England)
22260	Bell's Cathedrals: The Abbey Church of Tewkesbury--with some Account of the Priory Church of Deerhurst Gloucestershire	2007-08-07	English	Deerhurst (England). Priory church
36844	In New England Fields and Woods	2011-07-25	English	#N/A
20967	A Guide to Peterborough Cathedral--Comprising a brief history of the monastery from its foundation to the present time  with a descriptive account of its architectural peculiarities and recent improvements; compiled from the works of Gunton  Britton  and original & authentic documents	2007-04-03	English	Peterborough Cathedral -- Guidebooks
19998	Rural Architecture--Being a Complete Description of Farm Houses  Cottages  and Out Buildings	2006-12-03	English	Architecture  Domestic
14987	The Brochure Series of Architectural Illustration  Volume 01  No. 10  October 1895.--French Farmhouses.	2005-02-09	English	Architecture -- Periodicals
15020	The Brochure Series of Architectural Illustration  Volume 01  No. 11  November  1895--The Country Houses of Normandy	2005-02-12	English	Architecture -- Periodicals
16105	ColecciÃ³n de viages y expediciÃ³nes Ã  los campos de Buenos Aires y a las costas de Patagonia	2005-06-22	Spanish	#N/A
12648	The Beautiful Necessity--Seven Essays on Theosophy and Architecture	2004-06-01	English	Architecture
23593	Lectures on Architecture and Painting--Delivered at Edinburgh in November 1853	2007-11-22	English	Architecture
19715	Bell's Cathedrals: The Cathedral Church of Norwich--A Description of Its Fabric and A Brief History of the Episcopal See	2006-11-05	English	Norwich Cathedral (Norwich  England)
18783	Diario del viaje al rio Bermejo	2006-07-08	Spanish	Bermejo River (Bolivia and Argentina) -- Discovery and exploration
11302	Diario de la navegacion empredida en 1781	2004-02-01	Spanish	#N/A
18289	Diario de un viage a la costa de la mar Magallanica	2006-04-30	Spanish	Argentina -- Discovery and exploration
19643	Actas capitulares desde el 21 hasta el 25 de mayo de 1810 en Buenos Aires	2006-10-27	Spanish	Argentina -- History -- War of Independence  1810-1817
18157	FundaciÃ³n de la ciudad de Buenos-Aires	2006-04-12	Spanish	Garay  Juan de  1528  -1583
18798	Memoria dirigida al Sr. Marquez de Loreto  Virey y Capitan General de las Provincias del Rio de La Plata	2006-07-09	Spanish	Argentina -- History -- 1776-1810
36865	Responsibilities--and other poems	2011-07-27	English	#N/A
37036	The Key to Success	2011-08-11	English	#N/A
37171	Lost Sir Massingberd  v. 2/2--A Romance of Real Life	2011-08-23	English	#N/A
20401	Viage al Rio de La Plata y Paraguay	2007-01-20	Spanish	Paraguay -- History -- To 1811
25317	La Argentina--La conquista del Rio de La Plata. Poema histÃ³rico	2008-05-03	Spanish	America -- Discovery and exploration -- Spanish -- Poetry
20852	Descripcion del rio Paraguay  desde la boca del Xauru hasta la confluencia del Parana	2007-03-20	Spanish	Paraguay River
18723	Proyecto de traslacion de las fronteras de Buenos Aires al Rio Negro y Colorado	2006-07-01	Spanish	Mountain passes -- Andes
15066	La Vuelta de MartÃ­n Fierro	2005-02-15	Spanish	#N/A
7446	The Naturalist in La Plata	2005-02-01	English	PR
4028	Autobiography of Benvenuto Cellini	2003-05-01	English	Cellini  Benvenuto  1500-1571
18937	My First Picture Book--With Thirty-six Pages of Pictures Printed in Colours by Kronheim	2006-07-29	English	Children's poetry
37178	Cecil Castlemaine's Gage  Lady Marabout's Troubles  and Other Stories	2011-08-23	English	#N/A
37190	The Main Chance	2011-08-24	English	#N/A
19570	Van Dyck--A Collection Of Fifteen Pictures And A Portrait Of The--Painter With Introduction And Interpretation	2006-10-18	English	Van Dyck  Anthony  Sir  1599-1641
22500	The Works of William Hogarth: In a Series of Engravings--With Descriptions  and a Comment on Their Moral Tendency	2007-09-04	English	Hogarth  William  1697-1764
20607	Rembrandt	2007-02-16	English	Rembrandt Harmenszoon van Rijn  1606-1669
22564	Great Artists  Vol 1.--Raphael  Rubens  Murillo  and Durer	2007-09-10	English	Artists
17289	The Dance (by An Antiquary)--Historic Illustrations of Dancing from 3300 B.C. to 1911 A.D.	2005-12-12	English	Dance -- History
17244	French Art--Classic and Contemporary Painting and Sculpture	2005-12-06	English	Art  French
14056	The French Impressionists (1860-1900)	2004-11-15	English	Impressionism (Art)
17730	A Study Of The Textile Art In Its Relation To The Development Of Form And Ornament--Sixth Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution  1884-'85 --Government Printing Office  Washington  1888  (pages--189-252)	2006-02-09	English	Indian textile fabrics -- North America
5712	Sculpture of the Exposition Palaces and Courts	2004-05-01	English	Sculpture
13029	The Art of the Moving Picture	2004-07-26	English	Motion pictures
16180	Roman Mosaics--Or  Studies in Rome and Its Neighbourhood	2005-07-02	English	Rome (Italy) -- Description and travel
22574	The Best Portraits in Engraving	2007-09-11	English	Engraving
6841	Mosaics of Grecian History	2004-11-01	English	Greece -- History
18733	Die Italienische Plastik	2006-07-01	German	Sculpture -- Italy -- History
20915	Field's Chromatography--or Treatise on Colours and Pigments as Used by Artists	2007-03-27	English	Colors
37274	The Assembly of God--Miscellaneous Writings of C. H. Mackintosh  volume III	2011-08-30	English	#N/A
20195	Wood-Block Printing--A Description of the Craft of Woodcutting and Colour Printing Based on the Japanese Practice	2006-12-26	English	Wood-engraving -- Printing
6932	Pictures Every Child Should Know--A Selection of the World's Art Masterpieces for Young People	2004-11-01	English	Painting -- Juvenile literature
4060	The Renaissance: studies in art and poetry	2003-05-01	English	Renaissance
19980	A Joy For Ever--(And Its Price in the Market)	2006-11-30	English	Art
19164	Lectures on Art--Delivered before the University of Oxford in Hilary term  1870	2006-09-03	English	Art
4390	A History of Greek Art	2003-08-01	English	Art  Greek -- History
13119	Jean Francois Millet	2004-08-05	English	Millet  Jean FranÃ§ois  1814-1875
19009	Sir Joshua Reynolds--A Collection of Fifteen Pictures and a Portrait of the--Painter with Introduction and Interpretation	2006-08-08	English	Reynolds  Joshua  Sir  1723-1792
17215	Rembrandt	2005-12-03	English	Rembrandt Harmenszoon van Rijn  1606-1669
22690	Rembrandt and His Works--Comprising a Short Account of His Life; with a Critical Examination into His Principles and Practice of Design  Light  Shade  and Colour. Illustrated by Examples from the Etchings of Rembrandt.	2007-09-20	English	Etching -- Catalogs
19602	Rembrandt--A Collection Of Fifteen Pictures and a Portrait of the--Painter with Introduction and Interpretation	2006-10-22	English	Rembrandt Harmenszoon van Rijn  1606-1669
17212	Michelangelo--A Collection Of Fifteen Pictures And A Portrait Of The--Master  With Introduction And Interpretation	2005-12-03	English	Michelangelo Buonarroti  1475-1564
11242	The Life of Michelangelo Buonarroti	2004-02-01	English	Michelangelo Buonarroti  1475-1564
22522	Femmes d'artistes. English	2007-09-05	English	Short stories
24726	A History of Art for Beginners and Students--Painting  Sculpture  Architecture	2008-03-01	English	Art -- History
3151	The City of Domes : a walk with an architect about the courts and palaces of the Panama-Pacific International Exposition  with a discussion of its architecture  its sculpture  its mural decorations  its coloring and its lighting  preceded by a history of its growth	2002-04-01	English	Panama-Pacific International Exposition (1915 : San Francisco  Calif.)
28434	The Astronomy of Milton's 'Paradise Lost'	2009-03-29	English	Epic poetry  English -- History and criticism
28536	The Astronomy of the Bible--An Elementary Commentary on the Astronomical References of Holy Scripture	2009-04-08	English	Astronomy in the Bible
35744	The gradual acceptance of the Copernican theory of the universe	2011-04-01	English	#N/A
8172	History of Astronomy	2005-05-01	English	Astronomy -- History
17370	Prehistoric Textile Fabrics Of The United States  Derived From Impressions On Pottery--Third Annual Report of the Bureau of Ethnology to the Secretary of the Smithsonian Institution  1881-82  Government Printing Office  Washington  1884  pages 393-425	2005-12-22	English	Indian pottery -- North America
15622	Handbook on Japanning: 2nd Edition--For Ironware  Tinware  Wood  Etc. With Sections on Tinplating and--Galvanizing	2005-04-14	English	Japanning
25267	Astronomy for Amateurs	2008-04-30	English	Astronomy
26556	Myths and Marvels of Astronomy	2008-09-08	English	Astronomy
35261	A New Astronomy	2011-02-13	English	#N/A
28752	Pleasures of the telescope--An Illustrated Guide for Amateur Astronomers and a Popular--Description of the Chief Wonders of the Heavens for General--Readers	2009-05-10	English	Astronomy -- Observers' manuals
15620	Recreations in Astronomy--With Directions for Practical Experiments and Telescopic Work	2005-04-14	English	#N/A
35588	Scientific Papers by Sir George Howard Darwin--Volume V. Supplementary Volume	2011-03-16	English	#N/A
4065	Side-Lights on Astronomy and Kindred Fields of Popular Science	2003-05-01	English	Compass
29031	Sir William Herschel: His Life and Works	2009-06-03	English	Astronomy -- Great Britain -- History -- 18th century
34435	Le SystÃ¨me Solaire se mouvant	2010-11-25	French	Astronomy
24236	Time and Tide--A Romance of the Moon	2008-01-10	English	Satellites
16227	The Uses of Astronomy--An Oration Delivered at Albany on the 28th of July  1856	2005-07-06	English	#N/A
18431	Other Worlds--Their Nature  Possibilities and Habitability in the Light of the Latest Discoveries	2006-05-22	English	Astronomy
16767	Half-hours with the Telescope--Being a Popular Guide to the Use of the Telescope as a--Means of Amusement and Instruction.	2005-09-28	English	Astronomy
30607	Australia  its history and present condition--containing an account both of the bush and of the colonies --with their respective inhabitants	2009-12-05	English	Australia -- Description and travel
8106	Captain Cook's Journal During the First Voyage Round the World	2005-05-01	English	#N/A
12668	An Account of the English Colony in New South Wales  Volume 2	2004-06-01	English	#N/A
15675	A Voyage to New Holland	2005-04-21	English	#N/A
17450	The Part Borne by the Dutch in the Discovery of Australia 1606-1765	2006-01-03	English	Australia -- Discovery and exploration
2660	Early Australian Voyages: Pelsart  Tasman  Dampier	2001-06-01	English	Australia -- Discovery and exploration
7450	Terre NapoleÃ³n; a History of French Explorations and Projects in Australia	2005-02-01	English	Australia -- Discovery and exploration
10840	The Explorers of Australia and their Life-work	2004-01-01	English	#N/A
7163	The History of Australian Exploration from 1788 to 1888	2004-12-01	English	#N/A
15662	An Historical Journal of the Transactions at Port Jackson and Norfolk Island	2005-04-20	English	New South Wales -- History -- Sources
10461	Journals of Australian Explorations	2003-12-01	English	#N/A
16027	Journals of Two Expeditions of Discovery in North-West and Western Australia  Volume 1	2005-06-09	English	#N/A
16145	Journals of Two Expeditions of Discovery in North-West and Western Australia  Volume 2	2005-06-29	English	#N/A
4521	Narrative of the Overland Expedition of the Messrs. Jardine from Rockhampton to Cape York  Northern Queensland	2004-08-28	English	Explorers -- Australia
11203	Narrative of a Survey of the Intertropical and Western Coasts of Australia--Performed between the years 1818 and 1822 â€” Volume 1	2004-02-01	English	#N/A
12046	Narrative of a Survey of the Intertropical and Western Coasts of Australia--Performed between the years 1818 and 1822 â€” Volume 2	2004-04-01	English	#N/A
13248	McKinlay's Journal of Exploration in the Interior of Australia	2004-08-22	English	#N/A
9943	Journal of an Expedition into the Interior of Tropical Australia	2004-08-28	English	#N/A
12928	Three Expeditions into the Interior of Eastern Australia  Volume 1	2004-07-17	English	#N/A
13033	Three Expeditions into the Interior of Eastern Australia  Volume 2	2004-07-27	English	#N/A
8911	Explorations in Australia--The Journals of John McDouall Stuart	2004-08-30	English	#N/A
5816	Successful Exploration Through the Interior of Australia	2004-06-01	English	#N/A
12146	Discoveries in Australia  Volume 2--Discoveries in Australia; with an Account of the Coasts and Rivers--Explored and Surveyed During the Voyage of H.M.S. Beagle  in The--Years 1837-38-39-40-41-42-43. By Command of the Lords Commissioners--Of the Admiralty. Also a Narrative of Captain Owen Stanley's Visits--To the Islands in the Arafura Sea	2004-04-01	English	#N/A
12929	A Voyage to Terra Australis â€” Volume 1	2004-07-17	English	#N/A
34172	Peter's Rock in Mohammed's Flood  from St. Gregory the Great to St. Leo III	2010-10-30	English	#N/A
15100	The Voyage of Governor Phillip to Botany Bay--With an Account of the Establishment of the Colonies of Port Jackson--and Norfolk Island (1789)	2005-02-18	English	#N/A
4054	A Lady's Visit to the Gold Diggings of Australia in 1852-53	2003-05-01	English	Australia -- Description and travel
3546	The Eureka Stockade	2002-11-01	English	Eureka Stockade (Ballarat  Vic.)
16050	The Gold Hunters' Adventures--Or  Life in Australia	2005-06-13	English	Australia -- Fiction
8730	A Little Bush Maid	2005-08-01	English	Country life -- Australia -- Juvenile fiction
304	Rio Grande's Last Race & Other Verses	1995-08-01	English	Australian poetry
307	Three Elephant Power and Other Stories	2008-06-29	English	Frontier and pioneer life -- Australia -- Fiction
5113	Confessions of a Beachcomber	2004-02-01	English	Natural history -- Queensland
19274	Letters from the Guardian to Australia and New Zealand	2006-09-17	English	Shoghi  Effendi  1897-1957 -- Correspondence
27099	Reminiscences of Queensland--1862-1869	2008-10-30	English	Frontier and pioneer life -- Australia -- Queensland
25527	Australia  The Dairy Country	2008-05-19	English	Dairying -- Australia
24994	Wheat Growing in Australia	2008-04-05	English	Wheat -- Australia
4699	We of the Never-Never	2003-11-01	English	Frontier and pioneer life -- Australia
16664	Town Life in Australia	2005-09-06	English	Adelaide (S. Aust.) -- Social life and customs
4221	Shearing in the Riverina	2003-07-01	English	Sheep-shearing -- Australia
25750	Colonial Born--A tale of the Queensland bush	2008-06-10	English	Australia -- Fiction
3703	Dot and the Kangaroo	2003-02-01	English	Kangaroos -- Juvenile fiction
18891	Dot and the Kangaroo	2006-07-22	English	Kangaroos -- Juvenile fiction
21464	The Gilpins and their Fortunes--A Story of Early Days in Australia	2007-05-15	English	Christian life -- Juvenile fiction
26034	Grey Town--An Australian Story	2008-07-12	English	Australia -- Fiction
25059	In The Far North--1901	2008-04-12	English	Short stories
23995	The Land of the Kangaroo--Adventures of Two Youths in a Journey through the Great Island Continent	2007-12-26	English	Voyages and travels -- Juvenile fiction
22849	The History of Tasmania   Volume II	2007-10-02	English	Tasmania -- History
4731	Seven Little Australians	2003-12-01	English	Australia -- History -- 1788-1900 -- Fiction
21383	Adventures in Australia	2007-05-08	English	Aboriginal Australians -- Juvenile fiction
19172	An Australian in China--Being the Narrative of a Quiet Journey Across China to Burma	2006-09-04	English	China -- Description and travel
3832	Australia Felix	2003-03-01	English	Australia -- Fiction
1199	An Anthology of Australian Verse	1998-02-01	English	Poetry
11620	My Brilliant Career	2004-03-01	English	#N/A
3424	For the Term of His Natural Life	2002-09-01	English	Australia -- Fiction
24639	The Colonial Mortuary Bard; 'Reo  The Fisherman; and The Black Bream Of Australia--1901	2008-02-18	English	Short stories
24807	A Memory Of The Southern Seas--1904	2008-03-11	English	Short stories
27977	Austral English--A dictionary of Australasian words  phrases and usages with those aboriginal-Australian and Maori words which have become incorporated in the language  and the commoner scientific words that have had their origin in Australasia	2009-02-03	English	English language -- Foreign words and phrases -- Maori
36826	Le barbier de SÃ©ville ou la prÃ©caution inutile	2011-07-23	French	Comedies
23615	Le Tour du Monde; Australie--Journal des voyages et des voyageurs; 2. sem. 1860	2007-11-25	French	Geography -- Pictorial works -- Periodicals
12565	An Account of the English Colony in New South Wales  Volume 1--With Remarks on the Dispositions  Customs  Manners  Etc. of The--Native Inhabitants of That Country. to Which Are Added  Some--Particulars of New Zealand; Compiled  By Permission  From--The Mss.         of Lieutenant-Governor King.	2004-06-01	English	#N/A
15602	Statistical  Historical and Political Description of the Colony of New South Wales and its Dependent Settlements in Van Diemen's Land--With a Particular Enumeration of the Advantages Which These Colonies Offer for Emigration  and Their Superiority in Many Respects Over Those Possessed by the United States of America	2005-04-11	English	#N/A
5346	Journals of Expeditions of Discovery into Central Australia and Overland from Adelaide to King George's Sound in the Years 1840-1: Sent By the Colonists of South Australia  with the Sanction and Support of the Government: Including an Account of the Manners and Customs of the Aborigines and the State of Their Relations with Europeans â€” Complete	2004-03-01	English	Australia -- Discovery and exploration
5005	Journal of an Overland Expedition in Australia : from Moreton Bay to Port Essington  a distance of upwards of 3000 miles  during the years 1844-1845	2004-09-25	English	Australia -- Discovery and exploration
12115	Discoveries in Australia  Volume 1.--With an Account of the Coasts and Rivers Explored and Surveyed During--The Voyage of H.M.S. Beagle  in the Years 1837-38-39-40-41-42-43.--By Command of the Lords Commissioners of the Admiralty. Also a Narrative--Of Captain Owen Stanley's Visits to the Islands in the Arafura Sea.	2004-04-01	English	#N/A
7509	The Logbooks of the Lady Nelson--With the journal of her first commander Lieutenant James Grant	2004-08-28	English	Australia -- Discovery and exploration
1198	Robbery under Arms; a story of life and adventure in the bush and in the Australian goldfields	1998-02-01	English	Frontier and pioneer life -- Australia -- Fiction
3833	Australian Legendary Tales: folklore of the Noongahburrahs as told to the Piccaninnies	2003-03-01	English	Folklore -- Australia
3819	The Euahlayi Tribe; a study of aboriginal life in Australia	2003-03-01	English	Euahlayi (Australian people)
4050	Mates at Billabong	2003-05-01	English	Australia -- Fiction
21518	The Glugs of Gosh	2007-05-22	English	Australian poetry
4830	The Rise of the Dutch Republic â€” Volume 28: 1578  part II	2004-01-01	English	Netherlands -- History -- Wars of Independence  1556-1648
214	In the Days When the World Was Wide and Other Verses	2008-07-03	English	Australian poetry
1036	Joe Wilson and His Mates	1997-09-01	English	Frontier and pioneer life -- Australia -- Fiction
4975	Spinifex and Sand	2004-01-01	English	Western Australia -- Description and travel
10842	The Life of Captain James Cook	2004-01-01	English	Cook  James  1728-1779
15896	Five Months at Anzac--A Narrative of Personal Experiences of the Officer Commanding the 4th Field Ambulance  Australian Imperial Force	2005-05-24	English	World War  1914-1918 -- Personal narratives  Australian
16588	Over the Top With the Third Australian Division	2005-08-24	English	World War  1914-1918 -- Personal narratives  English
23050	Peter Biddulph--The Story of an Australian Settler	2007-10-17	English	Conduct of life -- Juvenile fiction
16940	Gleanings from the Writings of BahÃ¡'u'llÃ¡h	2005-06-23	English	Bahai Faith -- Doctrines
16939	Gems of Divine Mysteries	2005-06-23	English	Bahai Faith
16984	Prayers and Meditations	2005-11-02	English	Bahai Faith -- Prayers and devotions
19289	Some Answered Questions	2006-09-18	English	Bahai Faith -- Doctrines
19284	Paris Talks	2006-09-18	English	Bahai Faith
19238	Foundations of World Unity	2006-09-12	English	Bahai Faith
19279	Memorials of the Faithful	2006-09-17	English	Bahais -- Biography
19312	Tablets of Abdul-Baha Abbas	2006-09-20	English	Bahai Faith
19296	Tablets of the Divine Plan	2006-09-18	English	Bahai Faith
7114	Une Vie  a Piece of String and Other Stories	2004-12-01	English	PQ
23625	The Magic Pudding	2007-11-26	English	Fantasy
16891	Peter Parley's Tales About America and Australia	2005-10-17	English	America -- History -- Juvenile literature
4219	The Art of Living in Australia ;--together with three hundred Australian cookery recipes and accessory kitchen information by Mrs. H. Wicken	2003-07-01	English	Health
16983	The KitÃ¡b-i-ÃqÃ¡n	2005-11-02	English	Bahai Faith -- Doctrines
19240	BahÃ¡â€™Ã­ Prayers: A Selection of Prayers Revealed by BahÃ¡â€™uâ€™llÃ¡h  the--BÃ¡b  and â€˜Abduâ€™l-BahÃ¡	2006-09-12	English	Bahai Faith -- Prayers and devotions
19292	`Abdu'l-BahÃ¡'s Tablet to Dr. Forel	2006-09-18	English	Bahai Faith
19300	A Traveler's Narrative Written to Illustrate the Episode of the BÃ¡b	2006-09-18	English	Babism
19243	The Advent of Divine Justice	2006-09-15	English	Shoghi  Effendi  1897-1957 -- Correspondence
19254	Citadel of Faith	2006-09-16	English	Bahai Faith -- North America
2562	Clouds	2001-03-01	English	Classical literature
3160	The Odyssey	2002-04-01	English	Odysseus (Greek mythology) -- Poetry
4094	The Chinese Classics â€” Volume 1: Confucian Analects	2003-05-01	English	Chinese literature
3100	The Chinese Classics: with a translation  critical and exegetical notes  prolegomena and copious indexes--(Shih ching. English) â€” Volume 1	2002-02-01	English	Chinese literature
3330	The Analects of Confucius (from the Chinese Classics)	2002-07-01	English	Chinese literature
9371	The Praise of Folly	2005-11-01	English	#N/A
27315	ÎŒÏÎ½Î¹Î¸ÎµÏ‚	2008-11-22	Greek	Birds -- Drama
1666	The Golden Asse	2006-02-22	English	Classical literature
21262	The Works of Christopher Marlowe  Vol. 3 (of 3)	2007-04-30	English	English poetry
17814	Î›Ï…ÏƒÎ¹ÏƒÏ„ÏÎ¬Ï„Î·	2006-02-21	Greek	Peace movements -- Drama
392	Jerusalem Delivered	1996-01-01	English	Epic poetry  Italian -- Translations into English
1000	La Divina Commedia di Dante	1997-08-01	Italian	Poetry
27846	Moriae encomium. Dutch	2009-01-20	Dutch	Folly -- Early works to 1800
3600	The Essays of Montaigne â€” Complete	2004-10-26	English	Essays
1012	La Divina Commedia di Dante	1997-08-01	Italian	Italian poetry -- To 1400
5500	The Advancement of Learning	2004-04-01	English	Philosophy
2250	Richard II	2000-07-01	English	Historical drama
1515	The Merchant of Venice	1998-11-01	English	Comedies
2266	King Lear	2000-07-01	English	Kings and rulers -- Succession -- Drama
23306	Meditationes de prima philosophia	2007-11-03	Latin	First philosophy
18269	Pascal's PensÃ©es	2006-04-27	English	Philosophy
17941	Fables de La Fontaine--Tome Premier	2006-03-07	French	Fables  French
10615	An Essay Concerning Humane Understanding  Volume 1--MDCXC  Based on the 2nd Edition  Books 1 and 2	2004-01-01	English	#N/A
10616	An Essay Concerning Humane Understanding  Volume 2--MDCXC  Based on the 2nd Edition  Books 3 and 4	2004-01-01	English	#N/A
30344	The Fortunate Mistress (Parts 1 and 2)--or a History of the Life of Mademoiselle de Beleau Known by the Name of the Lady Roxana	2009-10-27	English	Mistresses -- Fiction
33733	The Guarded Heights	2010-09-15	English	#N/A
608	Areopagitica--A speech for the Liberty of Unlicensed Printing to the Parliament of England	2006-01-21	English	Books
4737	A Tale of a Tub	2003-12-01	English	Satire  English
11248	The Delights of Wisdom Pertaining to Conjugial Love	2004-02-01	English	#N/A
30268	Lettres persanes  tome I	2009-10-16	French	Montesquieu  Charles de Secondat  baron de  1689-1755
18569	Voltaire's Philosophical Dictionary	2006-06-12	English	Philosophy -- Dictionaries
6828	The Works of Henry Fielding--Edited by George Saintsbury in 12 Volumes $p Volume 12	2004-11-01	English	PR
5427	Emile	2004-04-01	English	Education -- Early works to 1800
30433	Ã‰mile--or  Concerning Education; Extracts	2009-11-09	English	Education
804	A Sentimental Journey Through France and Italy	1997-02-01	English	France -- Fiction
601	The Monk; a romance	1996-07-01	English	Monks -- Fiction
6593	History of Tom Jones  a Foundling	2004-09-01	English	Humorous stories
20577	La Folle JournÃ©e ou le Mariage de Figaro	2007-02-13	French	Comedies
25717	The History Of The Decline And Fall Of The Roman Empire--Table of Contents with links in the HTML file to the two--Project Gutenberg editions (12 volumes)	2008-06-07	English	Byzantine Empire -- History
3743	Writings of Thomas Paine â€” Volume 4 (1794-1796): the Age of Reason	2003-02-01	English	Rationalism
4797	The Complete Poetical Works of Percy Bysshe Shelley â€” Volume 1	2003-12-01	English	PR
16896	Corinne  Volume 1 (of 2)--Or Italy	2005-10-17	English	Italy -- History -- 1789-1815 -- Fiction
29549	Le Roi s'amuse	2009-07-30	French	French drama -- 19th century
4799	The Complete Poetical Works of Percy Bysshe Shelley â€” Volume 3	2003-12-01	English	PR
9976	Hernani	2006-02-01	French	#N/A
798	Le Rouge et le noir	1997-01-01	French	Fiction
27942	A System Of Logic  Ratiocinative And Inductive	2009-01-31	English	Knowledge  Theory of
23297	La Gioconda	2007-11-03	Italian	Italian drama -- 19th century
22642	L'Innocente	2007-09-16	Italian	Fiction
27825	Isaotta GuttadÃ uro ed altre poesie	2009-01-18	Italian	Poetry
8899	Three Weeks	2005-09-01	English	#N/A
4708	Les Chansons De Bilitis	2003-12-01	French	PQ
26685	Aphrodite--Moeurs antiques	2008-09-21	French	Courtesans -- Egypt -- Alexandria -- Fiction
30719	ÎÎµÏ†Î­Î»Î±Î¹	2009-12-20	Greek	Comedies
5946	The History of Don Quixote  Volume 2  Complete	2004-06-01	English	Spain -- Social life and customs -- 16th century -- Fiction
5267	Sister Carrie	2004-03-01	English	PS
31824	The Genius	2010-03-30	English	#N/A
26884	The Backwash of War--The Human Wreckage of the Battlefield as Witnessed by an--American Hospital Nurse	2008-10-12	English	World War  1914-1918 -- Personal narratives
2814	Dubliners	2001-09-01	English	Short stories
33797	Sinister Street  vol. 1	2010-09-22	English	#N/A
33798	Sinister Street  vol. 2	2010-09-22	English	#N/A
140	The Jungle	2006-03-11	English	Meat industry and trade -- Fiction
28948	The Rainbow	2009-05-23	English	Family -- England -- Midlands -- Fiction
4240	Women in Love	2003-07-01	English	Love stories
217	Sons and Lovers	2006-01-16	English	Working class families -- Fiction
29772	Oeuvres de Blaise Pascal--Nouvelle Ã‰dition. Tome Second.	2009-08-23	French	B
31053	The History of the Devil--As Well Ancient as Modern: In Two Parts	2010-01-23	English	#N/A
27573	Esprit des lois--livres I Ã  V  prÃ©cÃ©dÃ©s d'une introduction de l'Ã©diteur	2008-12-20	French	Political science
22048	NapolÃ©on Le Petit	2007-07-11	French	Napoleon III  Emperor of the French  1808-1873
25344	The Scarlet Letter	2008-05-05	English	Adultery -- Fiction
30107	Principles Of Political Economy--Abridged with Critical  Bibliographical  and Explanatory Notes  and a Sketch of the History of Political Economy	2009-09-27	English	Economics
20580	Napoleon the Little	2007-02-14	English	France -- History -- Second Republic  1848-1852
12784	The Prose Works of Jonathan Swift  D.D. â€” Volume 06--The Drapier's Letters	2004-06-29	English	#N/A
25053	Tentation de saint Antoine. English	2008-04-12	English	Christian saints -- Fiction
28885	Alice's Adventures in Wonderland--Illustrated by Arthur Rackham. With a Proem by Austin Dobson	2009-05-19	English	Fantasy
74	The Adventures of Tom Sawyer	2004-07-01	English	Male friendship -- Fiction
6099	Les Fleurs du Mal	2004-07-01	French	PQ
2413	Madame Bovary	2006-02-26	English	Adultery -- Fiction
26710	Les Ã©paves de Charles Baudelaire	2008-09-27	French	PQ
61	The Communist Manifesto	2005-01-25	English	Communism
15995	Salambo--Ein Roman aus Alt-Karthago	2005-06-06	German	Carthage (Extinct city) -- History -- Fiction
27401	Poems & Ballads (Second Series)--Swinburne's Poems Volume III	2008-12-04	English	English poetry
110	Tess of the d'Urbervilles	1994-02-01	English	Man-woman relationships -- Fiction
153	Jude the Obscure	1994-08-01	English	Stonemasons -- Fiction
8563	La Terre	2005-07-01	French	#N/A
20974	J'accuse...!	2007-04-04	French	Dreyfus  Alfred  1859-1935
18545	A Mummer's Tale	2006-06-09	English	Fiction
4788	Mademoiselle Fifi	2003-12-01	English	PQ
160	The Awakening and Selected Short Stories	2006-03-11	English	Adultery -- Fiction
37298	Garcia the Centenarian And His Times--Being a Memoir of Manuel Garcia's Life and Labours for the--Advancement of Music and Science	2011-09-03	English	#N/A
47	Anne of Avonlea	2006-03-08	English	Teachers -- Fiction
808	The Complete Plays of Gilbert and Sullivan	1997-02-01	English	Operas -- Librettos
7508	A Mummer's Wife	2005-02-01	English	PR
5722	The Shewing-up of Blanco Posnet	2004-05-01	English	#N/A
23917	SalomÃ©	2007-12-19	French	Tragedies
29208	Salome en Een Florentijnsch Treurspel	2009-06-23	Dutch	Tragedies
996	Don Quixote	2004-07-27	English	Knights and knighthood -- Spain -- Fiction
1661	The Adventures of Sherlock Holmes	1999-03-01	English	Holmes  Sherlock (Fictitious character) -- Fiction
113	The Secret Garden	1994-03-01	English	Yorkshire (England) -- Fiction
13610	Studies in the Psychology of Sex  Volume 1--The Evolution of Modesty; The Phenomena of Sexual Periodicity; Auto-Erotism	2004-10-08	English	Sex
13611	Studies in the Psychology of Sex  Volume 2--Sexual Inversion	2004-10-08	English	Sex
31732	The Sex Side of Life--An Explanation for Young People	2010-03-22	English	#N/A
23700	The Decameron of Giovanni Boccaccio	2007-12-03	English	Allegories
19591	De Decamerone van Boccaccio	2006-10-20	Dutch	Allegories
2021	Nostromo  a Tale of the Seaboard	2006-01-09	English	Revolutions -- Fiction
8800	The Divine Comedy by Dante  Illustrated	2005-09-01	English	Poetry
1400	Great Expectations	1998-07-01	English	Man-woman relationships -- Fiction
28054	The Brothers Karamazov	2009-02-12	English	Didactic fiction
11000	An Old Babylonian Version of the Gilgamesh Epic	2006-07-04	English	#N/A
145	Middlemarch	1994-07-01	English	England -- Social life and customs -- 19th century -- Fiction
1237	Father Goriot	2004-10-06	English	French literature
8387	Hunger	2005-06-01	English	Authors -- Fiction
15492	A Doll's House	2005-03-29	English	Wives -- Drama
4300	Ulysses	2003-07-01	English	Domestic fiction
16659	Translations of Shakuntala and Other Works	2005-09-05	English	Sanskrit drama -- Translations into English
12058	The Mahabharata of Krishna-Dwaipayana Vyasa Translated into English Prose --Virata Parva	2004-04-01	English	#N/A
21765	The Metamorphoses of Ovid--Vol. I   Books I-VII	2007-06-08	English	Classical literature
25667	Hamlet: Drama em cinco Actos	2008-06-01	Portuguese	Denmark -- Drama
1531	Othello	1998-11-01	English	Interracial marriage -- Drama
12406	Kepler	2004-05-01	English	Kepler  Johannes  1571-1630
7849	The Trial	2005-04-01	English	Social problems -- Fiction
3435	Arabian nights. English	2002-09-01	English	Fairy tales
3436	Arabian nights. English	2002-09-01	English	Fairy tales
76	Adventures of Huckleberry Finn	2004-06-29	English	Male friendship -- Fiction
1322	Leaves of Grass	1998-05-01	English	Poetry
33281	Punch  or the London Charivari  Vol. 98  May 31  1890	2010-07-28	English	English wit and humor -- Periodicals
3420	Vindication of the Rights of Woman	2002-09-01	English	Women's rights -- Great Britain
2270	Shakespeare's First Folio	2000-07-01	English	Drama
1906	Erewhon	1999-09-01	English	Utopias
62	A Princess of Mars	1993-04-01	English	Mars (Planet) -- Fiction
1951	The Coming Race	2006-02-19	English	Civilization  Subterranean -- Fiction
228	The Aeneid--English	1995-03-01	English	Legends -- Rome -- Poetry
1081	Mertvye dushi. English	1997-10-01	English	Humorous stories
1200	Gargantua and Pantagruel	2004-08-08	English	Giants -- Fiction
3748	Voyage au centre de la terre. English	2003-02-01	English	Science fiction
14851	Uncle Silas--A Tale of Bartram-Haugh	2005-01-31	English	#N/A
652	Rasselas  Prince of Abyssinia	1996-09-01	English	Princes -- Fiction
271	Black Beauty	2006-01-16	English	Horses -- Juvenile fiction
209	The Turn of the Screw	1995-02-01	English	England -- Fiction
17831	La dÃ©bÃ¢cle	2006-02-22	French	War stories
103	Around the World in 80 Days	1994-01-01	English	Adventure stories
1695	The Man Who Was Thursday  a nightmare	1999-04-01	English	Detective and mystery stories
796	La Chartreuse De Parme	1997-01-01	French	Fiction
14645	Unleavened Bread	2005-01-10	English	#N/A
3791	The Reign of Law; a tale of the Kentucky hemp fields	2003-02-01	English	Hemp farmers -- Fiction
5719	Janice Meredith	2004-05-01	English	#N/A
5373	Richard Carvel â€” Complete	2004-10-18	English	Maryland -- History -- Fiction
4097	Alice of Old Vincennes	2003-05-01	English	Orphans -- Fiction
31	Oedipus Trilogy	2006-03-08	English	Classical literature
5388	The Crisis â€” Volume 01	2004-10-19	English	United States -- History -- Civil War  1861-1865 -- Fiction
14219	Helmet of Navarre	2004-11-30	English	#N/A
6249	The Right of Way â€” Complete	2004-11-18	English	PS
6245	The Right of Way â€” Volume 03	2004-08-01	English	PS
10959	The Visits of Elizabeth	2004-02-01	English	#N/A
12440	D'Ri and I	2004-05-01	English	#N/A
4377	Mrs. Wiggs of the Cabbage Patch	2003-08-01	English	Kentucky -- Fiction
14513	Audrey	2004-12-29	English	#N/A
2852	The Hound of the Baskervilles	2001-10-01	English	Holmes  Sherlock (Fictitious character) -- Fiction
3070	The Hound of the Baskervilles	2002-02-01	English	Holmes  Sherlock (Fictitious character) -- Fiction
3428	The Two Vanrevels	2002-09-01	English	American fiction -- 20th century
1603	The Blue Flower	1999-01-01	English	Short stories
23784	The History of Sir Richard Calmady--A Romance	2007-12-09	English	Mothers and sons -- Fiction
13782	Lady Rose's Daughter	2004-10-18	English	#N/A
12482	The Mettle of the Pasture	2004-06-01	English	#N/A
20589	Edgar Allan Poe--Die Dichtung  Band XLII	2007-02-16	German	Poe  Edgar Allan  1809-1849 -- Appreciation
481	In the Bishop's Carriage	1996-04-01	English	Crime -- Fiction
13812	Sir Mortimer	2004-10-20	English	#N/A
6801	Beverly of Graustark	2004-11-01	English	PS
14126	The Marriage of William Ashe	2004-11-22	English	#N/A
14079	Sandy	2004-11-18	English	#N/A
3637	The Garden of Allah	2006-04-13	English	Africa  North -- Fiction
13967	Nedra	2004-11-06	English	#N/A
33490	The Gambler--A Novel	2010-08-22	English	#N/A
14740	The Princess Passes	2005-01-20	English	Automobiles -- Fiction
3766	Coniston â€” Complete	2004-10-17	English	New England -- Fiction
12441	The House of a Thousand Candles	2004-05-01	English	#N/A
5971	Jane Cable	2004-06-01	English	#N/A
6315	The Awakening of Helena Richie	2004-08-01	English	#N/A
7523	The Lady of the Decoration	2005-02-01	English	Japan -- History -- Meiji period  1868-1912 -- Fiction
13913	The Port of Missing Men	2004-11-01	English	#N/A
506	The Shuttle	2006-03-18	English	Fiction
8741	The Brass Bowl	2005-08-01	English	#N/A
14818	The Daughter of Anderson Crow	2005-01-27	English	#N/A
14852	The Younger Set	2005-02-01	English	#N/A
3242	The Doctor : a Tale of the Rockies	2006-06-03	English	Canada -- Fiction
4790	Half a Rogue	2003-12-01	English	Fiction
3684	Mr. Crewe's Career â€” Complete	2004-10-16	English	Political fiction
5122	The Trail of the Lonesome Pine	2004-02-01	English	Love stories
4516	Peter: a novel of which he is not the hero	2003-10-01	English	New York (N.Y.) -- Fiction
9779	The Black Bag	2006-01-01	English	#N/A
14263	Katrine	2004-12-06	English	PS
14284	Truxton King--A Story of Graustark	2004-12-07	English	#N/A
14355	54-40 or Fight	2004-12-15	English	#N/A
14395	Septimus	2004-12-20	English	#N/A
14054	Max	2004-11-15	English	#N/A
1671	When a Man Marries	1999-03-01	English	Fiction
5129	The Prodigal Judge	2004-02-01	English	PS
6997	The Winning of Barbara Worth	2004-11-01	English	PS
14303	Queed	2004-12-08	English	PS
13813	The Common Law	2004-10-20	English	#N/A
14394	The Street Called Straight	2004-12-20	English	#N/A
30115	Tante	2009-09-27	English	Fiction
26163	Evolution crÃ©atrice. English	2008-08-01	English	Metaphysics
1440	Woman and Labour	1998-08-01	English	Women -- Social and moral questions
13985	V. V.'s Eyes	2004-11-08	English	#N/A
5145	The Heart of the Hills	2004-02-01	English	Bildungsromans
9879	The Amateur Gentleman	2006-02-01	English	#N/A
14597	The Woman Thou Gavest Me--Being the Story of Mary O'Neill	2005-01-04	English	#N/A
2514	T. Tembarom	2001-02-01	English	Man-woman relationships -- Fiction
15759	Crowds--A Moving-Picture of Democracy	2005-05-03	English	#N/A
14811	The New Freedom--A Call For the Emancipation of the Generous Energies of a People	2005-01-26	English	#N/A
11715	The Eyes of the World	2004-03-01	English	#N/A
4379	The Fortunate Youth	2003-08-01	English	Great Britain -- Fiction
402	Penrod	2006-03-15	English	Juvenile literature
6353	The Prince of Graustark	2004-08-01	English	#N/A
1098	The Turmoil  a novel	1997-11-01	English	Young men -- Fiction
9489	Michael O'Halloran	2005-12-01	English	City and town life -- Fiction
9931	K	2006-02-01	English	Mystery fiction
14669	Jaffery	2005-01-11	English	#N/A
5229	Felix O'Day	2004-03-01	English	PS
29932	The Harbor	2009-09-09	English	Fiction
1027	The Lone Star Ranger  a romance of the border	1997-08-01	English	Fiction
1611	Seventeen--A Tale of Youth and Summer Time and the Baxter Family Especially William	2006-02-22	English	Fiction
14060	Mr. Britling Sees It Through	2004-11-16	English	#N/A
14571	Life and Gabriella--The Story of a Woman's Courage	2005-01-03	English	#N/A
29571	Nan of Music Mountain	2009-08-02	English	Western stories
14150	The Light in the Clearing	2004-11-25	English	#N/A
4287	The Red Planet	2003-07-01	English	World War  1914-1918 -- England -- Fiction
4603	In the Wilderness	2006-04-13	English	English fiction -- 20th century
13883	The Tree of Heaven	2004-10-27	English	#N/A
1590	The Amazing Interlude	1999-01-01	English	World War  1914-1918 -- Fiction
13993	Dere Mable--Love Letters of a Rookie	2004-11-09	English	World War  1914-1918 -- Humor  caricatures  etc.
13497	Greatheart	2004-09-18	English	#N/A
3249	The Major	2006-05-30	English	Canada -- Fiction
9836	The Pawns Count	2006-02-01	English	Detective and mystery stories
20072	With the Colors--Songs of the American Service	2006-12-09	English	World War  1914-1918 -- Poetry
12418	The Land of Deepening Shadow--Germany-at-War	2004-05-01	English	#N/A
3194	Mark Twain's Letters â€” Volume 2 (1867-1875)	2004-09-18	English	Authors  American -- 19th century -- Correspondence
3195	Mark Twain's Letters â€” Volume 3 (1876-1885)	2004-09-18	English	Authors  American -- 19th century -- Correspondence
3197	Mark Twain's Letters â€” Volume 5 (1901-1906)	2004-09-19	English	Authors  American -- 19th century -- Correspondence
405	Adventures and Letters of Richard Harding Davis	1996-01-01	English	United States -- History -- 1865-1921
16685	Private Peat	2005-09-12	English	World War  1914-1918 -- Personal narratives  Canadian
10201	The Desert of Wheat	2003-11-01	English	#N/A
3288	The Sky Pilot in No Man's Land	2006-06-03	English	World War  1914-1918 -- Fiction
3265	The Re-Creation of Brian Kent	2006-06-03	English	Ozark Mountains -- Fiction
18056	The Tin Soldier	2006-03-27	English	World War  1914-1918 -- Fiction
14646	Christopher and Columbus	2005-01-10	English	#N/A
2044	The Education of Henry Adams	2000-01-01	English	Adams  Henry  1838-1918
17237	A Man for the Ages--A Story of the Builders of Democracy	2005-12-05	English	Lincoln  Abraham  1809-1865 -- Fiction
5815	The Great Impersonation	2006-04-22	English	Spy stories
13763	The Lamp in the Desert	2004-10-16	English	#N/A
6467	Letters to His Children	2006-04-22	English	#N/A
2386	Theodore Roosevelt; an Intimate Biography	2000-11-01	English	Roosevelt  Theodore  1858-1919
3317	Now It Can Be Told	2002-07-01	English	World War  1914-1918 -- Great Britain
14885	Red Pottage	2005-02-02	English	#N/A
2799	Eben Holden  a tale of the north country	2001-09-01	English	Farm life -- Fiction
7031	The Sheik	2004-12-01	English	PR
1970	A Poor Wise Man	1999-11-01	English	Mystery fiction
25702	The Kingdom Round the Corner--A Novel	2008-06-05	English	PS
14145	If Winter Comes	2004-11-24	English	#N/A
6491	The Head of the House of Coombe	2004-09-01	English	England -- Social life and customs -- Fiction
14579	Simon Called Peter	2005-01-03	English	#N/A
32527	The adventures of Alphonso and Marina	2010-05-25	English	#N/A
1601	The Breaking Point	1999-01-01	English	Fiction
1265	Queen Victoria	2006-02-19	English	Victoria  Queen of Great Britain  1819-1901
3812	The Mirrors of Washington	2003-03-01	English	Washington (D.C.) -- Biography
14996	Painted Windows--Studies in Religious Personality	2005-02-09	English	#N/A
17018	The Life and Letters of Walter H. Page  Volume II	2005-11-06	English	Page  Walter Hines  1855-1918
27203	MaÃ®trise de soi-mÃªme par l'autosuggestion consciente. English	2008-11-08	English	Mental suggestion
17498	When Knighthood Was in Flower--or  the Love Story of Charles Brandon and Mary Tudor the King's Sister  and Happening in the Reign of His August Majesty King Henry the Eighth	2006-01-13	English	Suffolk  Charles Brandon  Duke of  d. 1545 -- Fiction
14001	The Mississippi Bubble	2004-11-10	English	#N/A
5970	Lovey Mary	2004-06-01	English	#N/A
21959	Letters from a Self-Made Merchant to His Son--Being the Letters written by John Graham  Head of the House--of Graham & Company  Pork-Packers in Chicago  familiarly--known on 'Change as Old Gorgon Graham  to his Son --Pierrepont  facetiously known to his intimates as Piggy.	2007-06-28	English	Fathers and sons -- Fiction
14696	The Wheel of Life	2005-01-15	English	#N/A
3828	Simon the Jester	2006-04-13	English	Wit and humor
18665	Molly Make-Believe	2006-06-23	English	Letter writing -- Fiction
4786	Zone Policeman 88; a close range study of the Panama canal and its workers	2003-12-01	English	Police -- Panama -- Canal Zone
34297	Angela's Business	2010-11-12	English	#N/A
10509	The Bars of Iron	2003-12-01	English	#N/A
5394	The Crisis â€” Volume 07	2004-10-19	English	United States -- History -- Civil War  1861-1865 -- Fiction
3193	Mark Twain's Letters â€” Volume 1 (1835-1866)	2004-09-18	English	Authors  American -- 19th century -- Correspondence
1693	Dangerous Days	1999-04-01	English	Fiction
19415	Libraries in the Medieval and Renaissance Periods--The Rede Lecture Delivered June 13  1894	2006-10-01	English	Libraries -- History -- 400-1400
1961	Books and Bookmen	1999-11-01	English	Books
16350	Curiosities of Literature   Vol. 2	2005-07-24	English	Literature
31078	Curiosities of Literature  Vol. 3	2010-01-25	English	#N/A
30396	Books and Authors--Curious Facts and Characteristic Sketches	2009-11-02	English	Authors
22716	The Book-Hunter at Home	2007-09-22	English	Book collecting
541	The Age of Innocence	1996-05-01	English	Separated people -- Fiction
4684	The U. P. Trail	2003-11-01	English	Union Pacific Railroad Company -- Fiction
22136	The Book-Hunter--A New Edition  with a Memoir of the Author	2007-07-24	English	Book collecting
22606	The Booklover and His Books	2007-09-15	English	Books
22607	The Book-Hunter in London--Historical and Other Studies of Collectors and Collecting	2007-09-15	English	Book collecting
22608	A Book for All Readers--An Aid to the Collection  Use  and Preservation of Books--and the Formation of Public and Private Libraries	2007-09-15	English	Library science
26378	The Care of Books	2008-08-20	English	Library fittings and supplies -- History
15199	The Reformed Librarie-Keeper (1650)	2005-02-28	English	#N/A
20416	The Annual Catalogue (1737)--Or  A New and Compleat List of All The New Books  New--Editions of Books  Pamphlets  &c.	2007-01-22	English	English literature -- Bibliography -- Early
17192	The Raven	2005-11-30	English	Poetry
4667	Seven Wives and Seven Prisons; Or  Experiences in the Life of a Matrimonial Monomaniac. a True Story	2003-11-01	English	Marriage customs and rites -- United States
14004	The Every-day Life of Abraham Lincoln--A Narrative And Descriptive Biography With Pen-Pictures And Personal--Recollections By Those Who Knew Him	2004-11-10	English	Lincoln  Abraham  1809-1865
813	Reminiscences of Tolstoy	1997-02-01	English	Biography
12090	The Lives of the Poets of Great Britain and Ireland (1753) Volume V.	2004-04-01	English	Poets  English -- Biography -- Early works to 1800
6312	Representative Men	2004-08-01	English	Biography
984	Who Was Who: 5000 BC - 1914 Biographical Dictionary of the Famous and Those Who Wanted to Be	1997-07-01	English	Parodies
3725	Famous Men of the Middle Ages	2003-02-01	English	Europe -- Biography
2082	Memoirs of the Comtesse Du Barry; with intimate details of her entire career as favorite of Louis XV	2000-02-01	English	Du Barry  Jeanne BÃ©cu  comtesse  1743-1793
4693	Famous Affinities of History  Vol 1-4  Complete--The Romance of Devotion	2003-11-01	English	Biography
4691	Famous Affinities of History â€” Volume 3--The Romance of Devotion	2003-11-01	English	Women -- Biography
19767	George Borrow and His Circle--Wherein May Be Found Many Hitherto Unpublished Letters Of--Borrow And His Friends	2006-11-12	English	Borrow  George Henry  1803-1881
14555	William Lloyd Garrison--The Abolitionist	2005-01-01	English	Garrison  William Lloyd  1805-1879
18757	Prince Henry the Navigator  the Hero of Portugal and of Modern Discovery  1394-1460 A.D.--With an Account of Geographical Progress Throughout the Middle Ages As the Preparation for His Work.	2006-07-04	English	Henry  Infante of Portugal  1394-1460
6702	Life of Harriet Beecher Stowe--Compiled From Her Letters and Journals by Her Son Charles Edward Stowe	2004-10-01	English	Stowe  Harriet Beecher  1811-1896
2447	Eminent Victorians	2000-12-01	English	Great Britain -- History -- Victoria  1837-1901 -- Biography
12985	Eugene Field  a Study in Heredity and Contradictions â€” Volume 2	2004-07-22	English	Poets  American -- 19th century -- Biography
16494	The Transvaal from Within--A Private Record of Public Affairs	2005-08-09	English	Jameson's Raid  1895-1896
25117	With the Naval Brigade in Natal (1899-1900)--Journal of Active Service	2008-04-21	English	South African War  1899-1902
12427	Neutral Rights and Obligations in the Anglo-Boer War	2004-05-01	English	Neutrality
26198	South Africa and the Transvaal War  Vol. 2--From the Commencement of the War to the Battle of Colenso  15th Dec. 1899	2008-08-06	English	South African War  1899-1902
18794	Strijd tusschen Boer en Brit. English	2006-07-08	English	De Wet  Christiaan Rudolf  1854-1922
3069	The Great Boer War	2002-02-01	English	South African War  1899-1902
24951	The War in South Africa--Its Cause and Conduct	2008-03-29	English	South African War  1899-1902
21302	Charge!--A Story of Briton and Boer	2007-05-04	English	South African War  1899-1902 -- Fiction
13855	Une politique europÃ©enne : la France  la Russie  l'Allemagne et la guerre au Transvaal	2004-10-25	French	South Africa -- History -- 1836-1909
17968	Boer Politics	2006-03-12	English	Transvaal (South Africa) -- Politics and government
16131	Campaign Pictures of the War in South Africa (1899-1900)--Letters from the Front	2005-06-25	English	South African War  1899-1902 -- Personal narratives
32934	The Young Colonists--A Story of the Zulu and Boer Wars	2010-06-20	English	#N/A
\.


--
-- TOC entry 2056 (class 0 OID 26344)
-- Dependencies: 174
-- Data for Name: traductor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY traductor (id, nombre) FROM stdin;
1	ISRAEL
2	LEGIT
3	JUL
4	TTYS
5	HUSTON
6	HEALTH
7	OBIT
8	GAYNOR
9	EFFLUX
10	WHOP
11	AMANDA
12	#N/A
13	BITCHY
14	PHILCO
15	DAWN
16	TOYOTA
17	MANTIS
18	BAYLOR
19	MESH
20	HAND
21	FROWN
22	THYMUS
23	QUIRK
24	REOPEN
25	HOMELY
26	EDIT
27	BOO
28	BELTED
29	CAPITA
30	MEDUSA
31	ABOARD
32	FRAIL
33	BUNCHE
34	FURY
35	EXUDE
36	DEWEY
37	BED
38	LIQUOR
39	FLOE
40	DETOX
41	BENDER
42	ORDAIN
\.


--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 173
-- Name: traductor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('traductor_id_seq', 42, true);


--
-- TOC entry 2059 (class 0 OID 26379)
-- Dependencies: 177
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (uid, nombre, sexo, edad) FROM stdin;
4440	Kate	M	32
4875	Sean	H	53
1616	Rosa	M	39
4999	Celia	M	57
2071	Pat	M	45
1424	Joseph	H	59
3437	Susan	M	64
3606	Freddy	H	57
3206	Bob	H	15
2068	Leonard	H	65
4728	Thomas	H	54
3167	Ana	M	78
3738	Gabriel	H	38
1736	Juan	H	33
1435	Jordi	H	22
3743	Roberto	H	52
2089	Mar	M	66
1720	Nacho	H	39
2772	Daniel	H	58
4136	Eduardo	H	41
\.


--
-- TOC entry 1934 (class 2606 OID 26341)
-- Name: autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);


--
-- TOC entry 1932 (class 2606 OID 26330)
-- Name: libro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY libro
    ADD CONSTRAINT libro_pkey PRIMARY KEY (isbn);


--
-- TOC entry 1936 (class 2606 OID 26352)
-- Name: traductor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY traductor
    ADD CONSTRAINT traductor_pkey PRIMARY KEY (id);


--
-- TOC entry 1938 (class 2606 OID 26386)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (uid);


--
-- TOC entry 1944 (class 2606 OID 26395)
-- Name: critica_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY critica
    ADD CONSTRAINT critica_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1943 (class 2606 OID 26390)
-- Name: critica_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY critica
    ADD CONSTRAINT critica_uid_fkey FOREIGN KEY (uid) REFERENCES usuario(uid);


--
-- TOC entry 1940 (class 2606 OID 26361)
-- Name: isbnrautor_id_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrautor
    ADD CONSTRAINT isbnrautor_id_autor_fkey FOREIGN KEY (id_autor) REFERENCES autor(id);


--
-- TOC entry 1939 (class 2606 OID 26356)
-- Name: isbnrautor_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrautor
    ADD CONSTRAINT isbnrautor_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1942 (class 2606 OID 26374)
-- Name: isbnrtraductor_id_traductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrtraductor
    ADD CONSTRAINT isbnrtraductor_id_traductor_fkey FOREIGN KEY (id_traductor) REFERENCES traductor(id);


--
-- TOC entry 1941 (class 2606 OID 26369)
-- Name: isbnrtraductor_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrtraductor
    ADD CONSTRAINT isbnrtraductor_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-10-17 11:33:16 CEST

--
-- PostgreSQL database dump complete
--

