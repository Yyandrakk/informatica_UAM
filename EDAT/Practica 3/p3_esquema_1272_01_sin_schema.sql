--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.10
-- Dumped by pg_dump version 9.1.10
-- Started on 2013-11-10 21:24:56 CET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 170 (class 3079 OID 11719)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 170
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 163 (class 1259 OID 49175)
-- Dependencies: 5
-- Name: autor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE autor (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.autor OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 49173)
-- Dependencies: 163 5
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
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 162
-- Name: autor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE autor_id_seq OWNED BY autor.id;


--
-- TOC entry 166 (class 1259 OID 49195)
-- Dependencies: 5
-- Name: isbnrautor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isbnrautor (
    isbn integer,
    id_autor integer
);


ALTER TABLE public.isbnrautor OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 49208)
-- Dependencies: 5
-- Name: isbnrtraductor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isbnrtraductor (
    isbn integer,
    id_traductor integer
);


ALTER TABLE public.isbnrtraductor OWNER TO postgres;

--
-- TOC entry 161 (class 1259 OID 49165)
-- Dependencies: 5
-- Name: libro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE libro (
    isbn integer NOT NULL,
    libro text NOT NULL,
    fecha date NOT NULL,
    idioma text NOT NULL,
    genero text NOT NULL,
    num_total integer,
    num_dis integer
);


ALTER TABLE public.libro OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 49229)
-- Dependencies: 5
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prestamo (
    uid integer,
    isbn integer,
    fecha_prestamo date NOT NULL,
    devuelto integer,
    puntuacion integer
);


ALTER TABLE public.prestamo OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 49186)
-- Dependencies: 5
-- Name: traductor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE traductor (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.traductor OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 49184)
-- Dependencies: 5 165
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
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 164
-- Name: traductor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE traductor_id_seq OWNED BY traductor.id;


--
-- TOC entry 168 (class 1259 OID 49221)
-- Dependencies: 5
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    uid integer NOT NULL,
    nombre text NOT NULL,
    sexo character(1) NOT NULL,
    edad integer NOT NULL,
    activado integer NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 1855 (class 2604 OID 49178)
-- Dependencies: 162 163 163
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY autor ALTER COLUMN id SET DEFAULT nextval('autor_id_seq'::regclass);


--
-- TOC entry 1856 (class 2604 OID 49189)
-- Dependencies: 165 164 165
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY traductor ALTER COLUMN id SET DEFAULT nextval('traductor_id_seq'::regclass);


--
-- TOC entry 1974 (class 0 OID 49175)
-- Dependencies: 163 1981
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY autor (id, nombre) FROM stdin;
1	Quiroga, JosÃ©, 1707?-1784
2	Carnegie, David Wynford, 1871-1900
3	Macmillan, Hugh
4	Darwin, George
5	Serviss, Garrett Putman, 1851-1929
6	Carboni, Raffaello, 1817-1885
7	Sinclair, Upton, 1878-1968
8	Hull, E. M. (Edith Maude), -1947
9	Mason, Otis Tufton, 1838-1908
10	Kester, Vaughan, 1869-1911
11	Withers, Hartley, 1867-1950
12	Twopeny, Richard Ernest Nowell, 1857-1915
13	Australia. Dept. of External Affairs
14	Hamsun, Knut, 1859-1952
15	Arnim, Elizabeth von, 1866-1941
16	Dickens, Charles, 1812-1870
17	Grey, Zane, 1872-1939
18	Eliot, George, 1819-1880
19	Marett, R. R. (Robert Ranulph), 1866-1943
20	Camp, Wadsworth, 1879-1936
21	Lee, Gerald Stanley, 1862-1944
22	Dell, Ethel M. (Ethel May), 1881-1939
23	Nicholls, H. G. (Henry George), 1825-1867
24	MassÃ©, H. J. L. J. (Henri Jean Louis Joseph), 1860-
25	Flammarion, Camille, 1842-1925
26	Orr, Lyndon
27	Sterne, Laurence, 1713-1768
28	Keable, Robert, 1887-1927
29	Rinehart, Mary Roberts, 1876-1958
30	Beeston, Joseph Lievesley, 1859-1921
31	Ovid, 43 BC-18?
32	MacKenzie, Compton, 1883-1972
33	Montaigne, Michel de, 1533-1592
34	Defoe, Daniel, 1661?-1731
35	Spearman, Frank H. (Frank Hamilton), 1859-1937
36	Dorman, Marcus Roberts Phipps
37	Rohlfs, Gerhard, 1831-1896
38	Anonymous
39	Barco Centenera, MartÃ­n del, 1535-
40	Rabelais, FranÃ§ois, 1483-1553
41	Payn, James, 1830-1898
42	Gregory, Augustus Charles, 1819-1905
43	Ford, Paul Leicester, 1865-1902
44	Gronniosaw, James Albert Ukawsaw
45	McKinlay, John
46	Emerson, Ralph Waldo, 1803-1882
47	McCutcheon, John T. (John Tinney), 1870-1949
48	Newcomb, Simon, 1835-1909
49	Tarbell, Frank Bigelow, 1853-1920
50	Murray, Margaret Alice, 1863-1963
51	Bode, Wilhelm, 1845-1929
52	Gogol, Nikolai Vasilievich, 1809-1852
53	King, Basil, 1859-1928
54	Wilson, Robert Pierpont
55	Flaubert, Gustave, 1821-1880
56	Wills, William John, 1834-1861
57	Ruskin, John, 1819-1900
58	Phillips, George S. (George Searle), 1815-1889
59	Cole, Fay-Cooper, 1881-1961
60	Streeter, Edward, 1891-1976
61	Livingstone, David, 1813-1873
62	Muskett, Philip E., -1909
63	Montesquieu, Charles de Secondat, baron de, 1689-1755
64	Twain, Mark, 1835-1911
65	Marlowe, Christopher, 1564-1593
66	Spofford, Ainsworth Rand, 1825-1908
67	Johnson, Elias
68	Clark, Galen, 1814-1910
69	Appleton, Everard Jack, 1872-1931
70	Marx, Karl, 1818-1883
71	Glyn, Elinor, 1864-1943
72	Mindeleff, Victor, 1860-1948
73	Maunder, E. Walter (Edward Walter), 1851-1928
74	Tischner, August, 1819-
75	Shelley, Percy Bysshe, 1792-1822
76	Deland, Margaret Wade Campbell, 1857-1945
77	Koopman, Harry Lyman, 1860-1937
78	Sienkiewicz, Henryk, 1846-1916
79	Bygate, Joseph E.
80	Smith, Francis Hopkinson, 1838-1915
81	Lewis, M. G. (Matthew Gregory), 1775-1818
82	Shorter, Clement King, 1857-1926
83	Various
84	Knox, Thomas Wallace, 1835-1896
85	Roberts, W. (William), 1862-1940
86	Noad, Joseph, 1823-1898
87	Tarkington, Booth, 1869-1946
88	CouÃ©, Emile, 1857-1926
89	Campbell, Robert Granville
90	Burton, John Hill, 1809-1881
91	Hales, A. G. (Alfred Greenwood), 1870-1936
92	Stimson, Dorothy, 1890-1988
93	Lindsay, Norman, 1879-1969
94	Speed, Harold
95	Kronheim, Joseph Martin, 1810-1896
96	Scott, Ernest, 1867-1939
97	Begbie, Harold, 1871-1929
98	Cervantes Saavedra, Miguel de, 1547-1616
99	Little, Frances, 1863-1941
100	Franklin, Miles, 1879-1954
101	Wells, H. G. (Herbert George), 1866-1946
102	Bacheller, Irving, 1859-1950
103	Richardson, James, 1806-1851
104	Morgan, Lewis H., 1818-1881
105	Mill, John Stuart, 1806-1873
106	Swift, Jonathan, 1667-1745
107	Haeckel, Ernst Heinrich Philipp August, 1834-1919
108	Swinburne, Algernon Charles, 1837-1909
109	Lane, Elinor Macartney, 1864-1909
110	Schmidel, Ulrich, 1510?-1579?
111	Lindsay, Vachel, 1879-1931
112	Burne, C. R. N. (Charles Richard Newdigate)
113	Forbes, George, 1849-1936
114	Allies, T. W. (Thomas William), 1813-1903
115	Ball, Robert S. (Robert Stawell), Sir, 1840-1913
116	Fielding, Henry, 1707-1754
117	Carroll, Lewis, 1832-1898
118	Creswicke, Louis
119	Baldwin, Gerald
120	Dennett, Mary
121	Pridden, W. (William), 1810-
122	Burton, Richard Francis, Sir, 1821-1890
123	Vance, Louis Joseph, 1879-1933
247	Pedley, Ethel C., 1860?-1898
124	Browne, Francis F. (Francis Fisher), 1843-1913
125	Haverfield, F. (Francis), 1860-1919
126	BahÃ¡'u'llÃ¡h, 1817-1892
127	Florian, 1755-1794
128	James, Henry, 1843-1916
129	Apuleius, Lucius, 125?-180
130	Conwell, Russell H.
131	Allen, James Lane, 1849-1925
132	Grosclaude, Etienne, 1858-1932
133	Hale, Horatio, 1817-1896
134	Collins, David, 1754-1810
135	Thomes, William Henry, 1824-1895
136	Brown, William N.
137	Grey, George, 1812-1898
138	Hawthorne, Nathaniel, 1804-1864
139	Johnson, Samuel, 1709-1784
140	Robinson, Rowland E. (Evans), 1833-1900
141	Chambers, Robert W. (Robert William), 1865-1933
142	Allan, P. B. M. (Philip Bertram Murray), 1884-1973
143	Cornell, Frederick Carruthers, 1867-1921
144	Brownell, W. C. (William Crary), 1851-1928
145	Cuttriss, G. P.
146	Balzac, HonorÃ© de, 1799-1850
147	Lozano, Pedro, 1697-1752
148	Fenn, George Manville, 1831-1909
149	Phillip, Arthur, 1738-1814
150	Gilbert, Clinton W. (Clinton Wallace), 1871-1933
151	Humphrey, S. D. (Samuel Dwight), 1823-1883
152	Clacy, Ellen
153	Mindeleff, Cosmos, 1863-
154	Trusler, John, 1735-1820
155	Barry, John D. (John Daniel), 1866-1942
156	Paine, Thomas, 1737-1809
157	Gibbs, Philip, 1877-1962
158	Daudet, Alphonse, 1840-1897
159	Homer, 750? BC-650? BC
160	Holden, Edward Singleton, 1846-1914
161	Ward, Humphry, Mrs., 1851-1920
162	Locke, William John, 1863-1930
163	Hutchinson, A. S. M. (Arthur Stuart-Menteth), 1879-1971
164	Hurll, Estelle M. (Estelle May), 1863-1924
165	Hichens, Robert Smythe, 1864-1950
166	MacGrath, Harold, 1871-1932
167	Morris, Edward Ellis, 1843-1901
168	Montgomery, L. M. (Lucy Maud), 1874-1942
169	Erasmus, Desiderius, 1469-1536
170	Hugo, Victor, 1802-1885
171	Baker, Samuel White, Sir, 1821-1893
172	Wilde, Oscar, 1854-1900
173	Kipling, Rudyard, 1865-1936
174	Frazer, James George, Sir, 1854-1941
175	Villarino, Basilio, 1741-1785
176	Verne, Jules, 1828-1905
177	Joyce, James, 1882-1941
178	Powell, John Wesley, 1834-1902
179	Corfield, W. H. (William Henry), 1843-1903
180	Quennell, C. H. B. (Charles Henry Bourne), 1872-1935
181	Jardine, Frank, 1841-1919
182	Stendhal, 1783-1842
183	Ewers, Hanns Heinz, 1871-1943
184	Butler, Samuel, 1835-1902
185	Malet, Lucas, 1852-1931
186	Schreiner, Olive, 1855-1920
187	Atticus, 1836?-1912
188	Ellis, Havelock, 1859-1939
189	Confucius, 551 BC-479 BC
190	Silva, Joaquim PossidÃ³nio Narciso da, 1806-1896
191	Dreiser, Theodore, 1871-1945
192	Franck, Harry Alverson, 1881-1962
193	Descartes, RenÃ©, 1596-1650
194	James, Juliet Helena Lumbard, 1864-
195	Pinkerton, John, 1758-1826
196	Wentworth, William Charles, 1790-1872
197	D'Annunzio, Gabriele, 1863-1938
198	Conrad, Joseph, 1857-1924
199	StaÃ«l, Madame de (Anne-Louise-Germaine), 1766-1817
200	Maspero, G. (Gaston), 1846-1916
201	Stanley, Henry M. (Henry Morton), 1841-1904
202	Equiano, Olaudah, 1745-1797
203	Thayer, William Roscoe, 1859-1923
204	Strachey, Lytton, 1880-1932
205	Locke, John, 1632-1704
206	Undiano y Gastelu, Sebastian
207	Collingwood, Harry, 1851-1922
208	Bacon, Francis, 1561-1626
209	Stowe, Harriet Beecher, 1811-1896
210	Allen, Lewis Falley, 1800-1890
211	Cellini, Benvenuto, 1500-1571
212	Motley, John Lothrop, 1814-1877
213	Thompson, Maurice, 1844-1901
214	Sinclair, May, 1863-1946
215	Dumas, Alexandre, 1802-1870
216	Bragdon, Claude Fayette, 1866-1946
217	Chesterton, G. K. (Gilbert Keith), 1874-1936
218	Bryant, Walter W. (Walter William)
219	Park, Mungo, 1771-1806
220	Henty, G. A. (George Alfred), 1832-1902
221	Kalidasa
222	Tolstoi, Ilia Lvovich, Graf, 1866-1933
223	Johnston, Mary, 1870-1936
224	Beers, R. W.
225	Scott, G. Firth
226	Wollstonecraft, Mary, 1759-1797
227	Burroughs, Edgar Rice, 1875-1950
228	La Motte, Ellen Newbold, 1873-1961
229	London, Jack, 1876-1916
230	Mitchell, Thomas, 1792-1855
231	Semple, Ellen Churchill, 1863-1932
232	Sophocles, 495? BC-406 BC
233	Pater, Walter, 1839-1894
234	Kitson, Arthur
235	Prescott, William Hickling, 1796-1859
236	Abbott, Eleanor Hallowell, 1872-1958
237	Bakunin, Mikhail Aleksandrovic, 1814-1876
238	Doyle, Arthur Conan, Sir, 1859-1930
239	Thurston, Katherine Cecil, 1875-1911
240	Lawrence, D. H. (David Herbert), 1885-1930
241	Gilbert, W. S. (William Schwenck), Sir, 1836-1911
242	Burnett, Frances Hodgson, 1849-1924
243	Harrison, Henry Sydnor, 1880-1930
244	Poland, Addison B.
245	GrimkÃ©, Archibald Henry, 1849-1930
246	How, Edith A.
248	Fox, John, 1863-1919
249	Feith, Jan, 1874-1944
250	Ragozin, ZÃ©naÃ¯de A. (ZÃ©naÃ¯de AlexeÃ¯evna), 1835-1924
251	Waters, Clara Erskine Clement, 1834-1916
252	Lamothe-Langon, Etienne-LÃ©on, baron de, 1786-1864
253	Menant, Delphine, 1850-
254	Holmes, William Henry, 1846-1933
255	Baudelaire, Charles, 1821-1867
256	Swedenborg, Emanuel, 1688-1772
257	Hardy, Thomas, 1840-1928
258	Goodrich, Samuel G. (Samuel Griswold), 1793-1860
259	Zola, Ã‰mile, 1840-1902
260	Proctor, Richard A. (Richard Anthony), 1837-1888
261	Bruce, Mary Grant, 1878-1958
262	Becke, Louis, 1855-1913
263	Clark, John Willis, 1833-1910
264	Clarkson, Thomas, 1760-1846
265	Sedgwick, Anne Douglas, 1873-1935
266	Falkner, John Meade, 1858-1932
267	LouÃ¿s, Pierre, 1870-1925
268	Runkle, Bertha, 1879-1958
269	Gulick, Sidney Lewis, 1860-1945
270	Fitzpatrick, Percy, Sir, 1862-1931
271	Viedma, Francisco de, 1737-1809
272	Warren, Henry White, 1831-1912
273	Adams, Henry, 1838-1918
274	Lawson, Henry, 1867-1922
275	Favenc, Ernest, 1845-1908
276	Maupassant, Guy de, 1850-1893
277	Mackinlay, M. (Malcolm) Sterling, 1876-1952
278	Poole, Ernest, 1880-1950
279	Thomas, Northcote Whitridge, 1868-1936
280	Mauclair, Camille, 1872-1945
281	Symonds, John Addington, 1840-1893
282	`Abdu'l-BahÃ¡, 1844-1921
283	Dostoyevsky, Fyodor, 1821-1881
284	Farnol, Jeffery, 1878-1952
285	Le Fanu, Joseph Sheridan, 1814-1873
286	Parker, Gilbert, 1862-1932
287	Dury, John, 1596-1680
288	Huish, Robert, 1777-1850
289	Kafka, Franz, 1883-1924
290	Parker, K. Langloh (Katie Langloh), 1856-1940
291	Michelson, Miriam, 1870-1942
292	Lang, Andrew, 1844-1912
293	Bergson, Henri, 1859-1941
294	CorrÃ©ard, Alexandre, 1788-1857
295	Rice, Alice Caldwell Hegan, 1870-1942
296	Hough, Emerson, 1857-1923
297	Orchard, Thomas Nathaniel
298	Fisher, A. Hugh (Alfred Hugh), 1867-1945
299	Cibber, Theophilus, 1703-1758
300	Curtin, D. Thomas
301	Hudson, W. H. (William Henry), 1841-1922
302	Chopin, Kate, 1850-1904
303	Peat, Harold Reginald, 1893-1960
304	Leichhardt, Ludwig, 1813-1848
305	Sumner, Charles, 1811-1874
306	Menpes, Mortimer, 1855-1938
307	Pilling, James Constantine, 1846-1895
308	Gunn, Jeannie, 1870-1961
309	Lee, Ida, 1865-1943
310	McCutcheon, George Barr, 1866-1928
311	IsraÃ«ls, Jozef, 1824-1911
312	Wilson, Woodrow, 1856-1924
313	Bacon, Mary Schell Hoke, 1870-1934
314	Heeres, J. E. (Jan Ernst), 1858-1932
315	Kingston, William Henry Giles, 1814-1880
316	Stuart, John McDouall, 1815-1866
317	Eyre, Edward John, 1815-1901
318	Jerrold, W. Blanchard, 1826-1884
319	Glanville, Ernest, 1855-1925
320	Field, George, 1777?-1854
321	Mackintosh, C. (Charles) H. (Henry)
322	Everett, Edward, 1794-1865
323	Poe, Edgar Allan, 1809-1849
324	Burnet, John, 1784-1868
325	Thompson, Slason, 1849-1935
326	King, Phillip Parker, 1793?-1856
327	Whitman, Walt, 1819-1892
328	Caine, Hall, Sir, 1853-1931
329	Flinders, Matthew, 1774-1814
330	Keysor, Jennie Ellis, 1860-
331	Shaw, Bernard, 1856-1950
332	Brown, William Wells, 1816?-1884
333	Williamson, A. M. (Alice Muriel), 1869-1933
334	Aristophanes, 446? BC-385? BC
335	Major, Charles, 1856-1913
336	Cook, James, 1728-1779
337	Dennis, C. J. (Clarence James), 1876-1938
338	Van Dyke, Henry, 1852-1933
339	Davis, Richard Harding, 1864-1916
340	France, Anatole, 1844-1924
341	HernÃ¡ndez, JosÃ©, 1834-1886
342	Morrison, George Ernest, 1862-1920
343	Hendrick, Burton Jesse, 1870-1949
344	Grant, Robert, 1852-1940
345	#N/A
346	Disraeli, Isaac, 1766-1848
347	La Fontaine, Jean de, 1621-1695
348	Milton, John, 1608-1674
349	Wright, Harold Bell, 1872-1944
350	Bailey, Temple, -1953
351	Legge, James, 1815-1897
352	Worley, George
353	Turner, Ethel Sybil, 1872-1958
354	Oppenheim, E. Phillips (Edward Phillips), 1866-1946
355	Molkenboer, Theodoor, 1871-1920
356	Proudhon, P.-J. (Pierre-Joseph), 1809-1865
357	Tasso, Torquato, 1544-1595
358	Stevenson, James, 1840-1888
359	Connor, Ralph, 1860-1937
360	Benham, William, 1831-1910
361	Shakespeare, William, 1564-1616
362	Cholmondeley, Mary, 1859-1925
363	Ibsen, Henrik, 1828-1906
364	Bridge, Horatio, 1806-1893
365	Shoghi, Effendi, 1897-1957
366	Dante Alighieri, 1265-1321
367	Stratton-Porter, Gene, 1863-1924
368	Wells-Barnett, Ida B., 1862-1931
369	Richardson, Henry Handel, 1870-1946
370	Stevenson, Robert Louis, 1850-1894
371	Morillo, Francisco
372	Moore, George (George Augustus), 1852-1933
373	Du Bois, W. E. B. (William Edward Burghardt), 1868-1963
374	Todd, David Peck
375	Banfield, E. J. (Edmund James), 1852-1923
376	Wharton, Edith, 1862-1937
377	Lytton, Edward Bulwer Lytton, Baron, 1803-1873
378	Lorimer, George Horace, 1869-1937
379	Hunter, John, 1738-1821
380	Virgil, 70 BC-19 BC
381	Clarke, Marcus Andrew Hislop, 1846-1881
382	Dawson, Coningsby, 1883-1959
383	Roosevelt, Theodore, 1858-1919
384	Guyot, Yves, 1843-1928
385	Patterson, J. H. (John Henry), 1867-1947
386	Dampier, William, 1652-1715
387	Sewell, Anna, 1820-1878
388	Beaumarchais, Pierre Augustin Caron de, 1732-1799
389	Williamson, Robert Wood, 1856-1932
390	Ouida, 1839-1908
391	Boccaccio, Giovanni, 1313-1375
392	Nicholson, Meredith, 1866-1947
393	Warner, William
394	West, John, 1809-1873
395	Churchill, Winston, 1871-1947
396	Gerland, Georg Karl Cornelius, 1833-1921
397	Paterson, A. B. (Andrew Barton), 1864-1941
398	Jacobs, Harriet Ann, 1813-1897
399	Scully, W. C. (William Charles), 1855-1943
400	Stokes, John Lort, 1812-1885
401	Gibbon, Edward, 1737-1794
402	Stockley, Cynthia, 1883-1936
403	Tolstoy, Leo, graf, 1828-1910
404	Rousseau, Jean-Jacques, 1712-1778
405	Wilson, Sarah Isabella Augusta, Lady, 1865-1929
406	Abbott, L. A., 1813-
407	Beazley, C. Raymond (Charles Raymond), 1868-1955
408	Voltaire, 1694-1778
409	Huxley, Thomas Henry, 1825-1895
410	Boldrewood, Rolf, 1826-1915
411	Glasgow, Ellen Anderson Gholson, 1873-1945
412	Eley, C. King
413	Fletcher, F. Morley (Frank Morley), 1866-1949
414	Haggard, Henry Rider, 1856-1925
415	Chesnutt, Charles W. (Charles Waddell), 1858-1932
416	De Wet, Christiaan Rudolf, 1854-1922
417	White, Stewart Edward, 1873-1946
418	Pascal, Blaise, 1623-1662
419	Yeats, W. B. (William Butler), 1865-1939
\.


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 162
-- Name: autor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('autor_id_seq', 419, true);


--
-- TOC entry 1977 (class 0 OID 49195)
-- Dependencies: 166 1981
-- Data for Name: isbnrautor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY isbnrautor (isbn, id_autor) FROM stdin;
20852	1
4975	2
16180	3
35588	4
18431	5
28752	5
3546	6
140	7
7031	8
17606	9
5129	10
22832	11
16664	12
24994	13
25527	13
8387	14
14646	15
1400	16
4684	17
10201	17
1027	17
145	18
17280	19
33733	20
15759	21
10509	22
13763	22
13497	22
24505	23
22260	24
25267	25
4691	26
4693	26
804	27
14579	28
1693	29
1601	29
1970	29
1590	29
9931	29
1671	29
15896	30
21765	31
33798	32
33797	32
3600	33
31053	34
30344	34
29571	35
15240	36
17599	37
16280	37
30396	38
3436	38
3435	38
11000	38
17289	38
19643	38
22990	38
25317	39
1200	40
37171	41
10461	42
5719	43
15042	44
13248	45
6312	46
21254	47
4065	48
4390	49
20411	50
18733	51
1081	52
14394	53
6841	54
15995	55
2413	55
25053	55
5816	56
19164	57
19980	57
23593	57
17774	57
20967	58
18273	59
13993	60
16672	61
4219	62
27573	63
30268	63
3193	64
3197	64
3195	64
3194	64
76	64
74	64
21262	65
22608	66
7978	67
16572	68
20072	69
61	70
10959	71
8899	71
19856	72
28536	73
34435	74
4799	75
4797	75
6315	76
22606	77
35560	78
20191	79
5229	80
4516	80
601	81
19767	82
33281	83
23615	83
16105	83
15020	83
14987	83
13575	83
13642	83
36676	83
27341	83
27262	83
27118	83
26600	83
22575	83
11617	83
23995	84
22607	85
15126	86
1611	87
1098	87
402	87
3428	87
27203	88
12427	89
22136	90
16131	91
35744	92
23625	93
14264	94
18937	95
7450	96
14996	97
996	98
5946	98
7523	99
11620	100
14060	101
2799	102
17237	102
14150	102
12440	102
18544	103
17164	103
8112	104
30107	105
27942	105
12784	106
4737	106
8700	107
27401	108
14263	109
20401	110
13029	111
25117	112
8172	113
34172	114
24236	115
6593	116
6828	116
28885	117
26198	118
26034	119
31732	120
30607	121
6886	122
5760	122
9779	123
8741	123
18891	247
3703	247
14004	124
19115	125
19240	126
16983	126
16984	126
16939	126
16940	126
32527	127
209	128
1666	129
37036	130
12482	131
3791	131
13855	132
22601	133
12565	134
12668	134
16050	135
15622	136
16145	137
16027	137
25344	138
652	139
36844	140
13813	141
14852	141
22716	142
21899	143
17244	144
16588	145
1237	146
18289	147
21302	148
15100	149
3812	150
167	151
4054	152
17487	153
22500	154
3151	155
3743	156
3317	157
22522	158
36780	158
3160	159
29031	160
14126	161
13782	161
3828	162
4287	162
14669	162
4379	162
14395	162
14145	163
17212	164
19602	164
19009	164
13119	164
19570	164
4603	165
3637	165
4790	166
27977	167
47	168
27846	169
9371	169
20580	170
22048	170
9976	170
29549	170
3233	171
3657	171
29208	172
23917	172
2225	173
20116	174
11302	175
103	176
3748	176
4300	177
2814	177
18869	178
27099	179
19715	180
4521	181
796	182
798	182
20589	183
1906	184
23784	185
1440	186
1441	186
1458	186
10479	187
13611	188
13610	188
3330	189
17186	190
31824	191
5267	191
4786	192
23306	193
5712	194
2660	195
15602	196
27825	197
22642	197
23297	197
2021	198
16896	199
14400	200
5157	201
15399	202
2386	203
2447	204
1265	204
10616	205
10615	205
18723	206
21060	207
5500	208
6702	209
19998	210
4028	211
4830	212
4097	213
13883	214
2759	215
2681	215
2710	215
12648	216
12625	216
1695	217
12406	218
5305	219
8564	219
32934	220
16659	221
813	222
13812	223
14513	223
36791	224
25750	225
3420	226
62	227
26884	228
215	229
13033	230
12928	230
9943	230
15293	231
31	232
4060	233
10842	234
1323	235
18665	236
20677	237
24951	238
3069	238
3070	238
2852	238
1661	238
14054	239
33490	239
217	240
4240	240
28948	240
808	241
6491	242
2514	242
506	242
113	242
34297	243
13985	243
14303	243
3725	244
14555	245
6693	246
5145	248
5122	248
18236	249
24654	250
24726	251
2082	252
14648	253
17370	254
17730	254
26710	255
6099	255
11248	256
153	257
110	257
16891	258
17831	259
20974	259
8563	259
16767	260
26556	260
4050	261
8730	261
24807	262
24639	262
25059	262
26378	263
19415	263
10633	264
12428	264
30115	265
10743	266
26685	267
4708	267
14219	268
13831	269
16494	270
18798	271
15620	272
2044	273
1036	274
214	274
7163	275
10840	275
4788	276
7114	276
37298	277
29932	278
17404	279
14056	280
11242	281
19300	282
19292	282
19296	282
19312	282
19279	282
19238	282
19284	282
19289	282
28054	283
9879	284
14851	285
6245	286
6249	286
15199	287
12667	288
7849	289
3819	290
3833	290
481	291
1961	292
26163	293
11772	294
5970	295
14079	295
4377	295
14001	296
14355	296
28434	297
19487	298
12090	299
12418	300
7446	301
160	302
16685	303
5005	304
22574	305
17215	306
17262	307
4699	308
7509	309
6353	310
14284	310
14818	310
5971	310
13967	310
6801	310
20607	311
14811	312
6932	313
17450	314
23050	315
21383	315
21464	315
21448	315
21490	315
21472	315
21391	315
8911	316
5346	317
13755	318
17615	319
20915	320
37274	321
16227	322
17192	323
22690	324
12985	325
12046	326
11203	326
1322	327
14597	328
12929	329
22564	330
5722	331
2095	332
2046	332
14740	333
30719	334
17814	334
27315	334
2562	334
17498	335
8106	336
21518	337
1603	338
405	339
18545	340
15066	341
19172	342
17018	343
14645	344
984	345
12058	345
1199	345
18157	345
15041	345
1980	345
31078	346
16350	346
17941	347
608	348
3265	349
11715	349
6997	349
18056	350
3100	351
4094	351
21511	352
4731	353
5815	354
9836	354
20665	355
444	356
392	357
19606	358
3288	359
3249	359
3242	359
16531	360
2270	361
1531	361
25667	361
2266	361
1515	361
2250	361
14885	362
15492	363
7937	364
19254	365
19243	365
19274	365
8800	366
1012	366
1000	366
9489	367
35188	367
14975	368
14977	368
14976	368
3832	369
589	370
18783	371
7508	372
15359	373
408	373
17700	373
35261	374
5113	375
541	376
1951	377
21959	378
15662	379
228	380
3424	381
25702	382
6467	383
17968	384
3810	385
15675	386
271	387
20577	388
36826	388
17910	389
37178	390
19591	391
23700	391
13913	392
12441	392
37190	392
20416	393
22849	394
5394	395
3684	395
3766	395
5388	395
5373	395
14028	396
307	397
304	397
11030	398
23638	399
12115	400
12146	400
25717	401
22568	402
689	403
4602	403
30433	404
5427	404
14466	405
4667	406
18757	407
18569	408
2634	409
1198	410
4221	410
14696	411
14571	411
19881	412
20195	413
2857	414
2761	414
2841	414
1711	414
1690	414
2713	414
711	414
19746	415
11057	415
11228	415
18794	416
14451	417
29772	418
18269	418
36865	419
\.


--
-- TOC entry 1978 (class 0 OID 49208)
-- Dependencies: 167 1981
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
-- TOC entry 1972 (class 0 OID 49165)
-- Dependencies: 161 1981
-- Data for Name: libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY libro (isbn, libro, fecha, idioma, genero, num_total, num_dis) FROM stdin;
11617	Punch, or the London Charivari, Volume 156, April 2, 1919	2004-03-01	English	English wit and humor -- Periodicals	10	10
2710	Louise de la Valliere	2001-07-01	English	France -- History -- Louis XIV, 1643-1715 -- Fiction	10	10
10743	Moonfleet	2004-01-01	English	England -- Fiction	10	10
711	Allan Quatermain	2004-11-18	English	Adventure stories	10	10
2713	Maiwa's Revenge	2006-03-31	English	Africa, East -- Fiction	10	10
1690	Marie--An Episode in The Life of the late Allan Quatermain	1999-03-01	English	Quatermain, Allan (Fictitious character) -- Fiction	10	10
1711	Child of Storm	1999-04-01	English	Zulu (African people) -- Fiction	10	10
2841	The Ivory Child	2006-03-31	English	Fantasy fiction, English	10	10
215	The Call of the Wild	2008-07-02	English	Adventure stories	10	10
589	Catriona	1996-07-01	English	Scotland -- History -- 18th century -- Fiction	10	10
3657	Wild Beasts and Their Ways, Reminiscences of Europe, Asia, Africa and America â€” Volume 1	2003-01-01	English	Animal behavior	10	10
6693	People of Africa	2004-10-01	English	Ethnology -- Africa	10	10
3233	In the Heart of Africa	2002-05-01	English	Sudan -- Description and travel	10	10
7937	Journal of an African Cruiser	2005-04-01	English	#N/A	10	10
2225	Captains Courageous	2000-06-01	English	Sea stories	10	10
5760	Two Trips to Gorilla Land and the Cataracts of the Congo Volume 1	2004-05-01	English	#N/A	10	10
12667	Lander's Travels--The Travels of Richard Lander into the Interior of Africa	2004-06-01	English	#N/A	10	10
2681	Ten Years Later	2001-06-01	English	Historical fiction	10	10
6886	First Footsteps in East Africa	2004-11-01	English	Harari language	10	10
2759	The Man in the Iron Mask	2001-08-01	English	Historical fiction	10	10
5157	How I Found Livingstone; travels, adventures, and discoveres in Central Africa, including an account of four months' residence with Dr. Livingstone, by Henry M. Stanley	2004-02-01	English	Africa, Central -- Description and travel	10	10
8564	Life and Travels of Mungo Park in Central Africa	2005-07-01	English	#N/A	10	10
5305	Travels in the Interior of Africa â€” Volume 02	2004-03-01	English	Niger River	10	10
17164	Narrative of a Mission to Central Africa Performed in the Years 1850-51, Volume 1--Under the Orders and at the Expense of Her Majesty's Government	2005-11-27	English	Africa, Central -- Description and travel	10	10
18544	Narrative of a Mission to Central Africa Performed in the Years 1850-51, Volume 2--Under the Orders and at the Expense of Her Majesty's Government	2006-06-09	English	Africa, Central -- Description and travel	10	10
14451	African Camp Fires	2004-12-24	English	#N/A	10	10
3810	The Man-Eaters of Tsavo and Other East African Adventures	2003-03-01	English	Uganda Railway	10	10
15240	A Journal of a Tour in the Congo Free State	2005-03-04	English	#N/A	10	10
16280	BeitrÃ¤ge zur Entdeckung und Erforschung Africa's.--Berichte aus den Jahren 1870-1875	2005-07-13	German	Africa, Central -- Description and travel	10	10
36791	The Mormon Puzzle, and How to Solve It	2011-07-20	English	#N/A	10	10
15399	The Interesting Narrative of the Life of Olaudah Equiano, Or Gustavus Vassa, The African--Written By Himself	2005-03-17	English	Equiano, Olaudah, 1745-1797	10	10
15042	A Narrative of the Most Remarkable Particulars in the Life of James Albert Ukawsaw Gronniosaw, an African Prince, as Related by Himself	2005-02-14	English	#N/A	10	10
21391	Great African Travellers--From Mungo Park to Livingstone and Stanley	2007-05-08	English	Explorers	10	10
14466	South African Memories--Social, Warlike & Sporting from Diaries Written at the Time	2004-12-25	English	South Africa -- Description and travel	10	10
23638	Reminiscences of a South African Pioneer	2007-11-26	English	Scully, W. C. (William Charles), 1855-1943	10	10
12428	The History of the Rise, Progress and Accomplishment of the Abolition of the African Slave Trade by the British Parliament (1808), Volume I	2004-05-01	English	Slavery	10	10
17599	Von Tripolis nach Alexandrien - 1. Band	2006-01-24	German	Africa, North -- Description and travel	10	10
17700	The Suppression of the African Slave Trade to the United States of America--1638-1870	2006-02-07	English	Slave trade -- United States -- History	10	10
21060	The Congo Rovers--A Story of the Slave Squadron	2007-04-13	English	Slave trade -- Juvenile fiction	10	10
17615	In Search of the Okapi--A Story of Adventure in Central Africa	2006-01-28	English	Adventure stories	10	10
2761	Benita, an African romance	2006-03-28	English	Africa, East -- Fiction	10	10
2857	A Yellow God: an Idol of Africa	2006-04-04	English	Africa -- Fiction	10	10
21472	Ned Garth--Made Prisoner in Africa. A Tale of the Slave Trade	2007-05-15	English	Sailors -- Juvenile fiction	10	10
21490	The Two Supercargoes--Adventures in Savage Africa	2007-05-16	English	Adventure and adventurers -- Juvenile fiction	10	10
21448	The African Trader--The Adventures of Harry Bayford	2007-05-15	English	Conduct of life -- Juvenile fiction	10	10
1458	Dream Life and Real Life; a little African story	1998-09-01	English	Essays	10	10
1441	The Story of an African Farm, a novel	1998-09-01	English	Africa -- Fiction	10	10
21899	A Rip Van Winkle Of The Kalahari--And Other Tales of South-West Africa	2007-06-22	English	Africa -- Fiction	10	10
21254	In Africa--Hunting Adventures in the Big Game Country	2007-04-29	English	Hunting -- Africa, East	10	10
11772	Naufrage de la frigate la MÃ©duse. English	2004-04-01	English	MÃ©duse (Ship)	10	10
16672	The Last Journals of David Livingstone, in Central Africa, from 1865 to His Death, Volume I (of 2), 1866-1868	2005-09-07	English	Africa, Central -- Description and travel	10	10
22575	Le Tour du Monde; Afrique Orientale--Journal des voyages et des voyageurs; 2. sem. 1860	2007-09-11	French	Geography -- Pictorial works -- Periodicals	10	10
22568	Blue Aloes--Stories of South Africa	2007-09-10	English	South Africa -- Social life and customs -- Fiction	10	10
1980	Stories by English Authors: Africa (Selected by Scribners)	2006-03-26	English	Africa -- Fiction	10	10
10633	The History of the Rise, Progress and Accomplishment of the Abolition of the African Slave-Trade, by the British Parliament (1839)	2004-01-01	English	Slavery	10	10
2046	Clotel; or, the President's Daughter	2000-01-01	English	Children of presidents -- Fiction	10	10
11228	The Marrow of Tradition	2004-02-01	English	#N/A	10	10
11057	The Wife of his Youth and Other Stories of the Color Line, and Selected Essays	2004-02-01	English	#N/A	10	10
408	The Souls of Black Folk	1996-01-01	English	African Americans	10	10
15359	The Negro	2005-03-14	English	Africa -- History	10	10
11030	Incidents in the Life of a Slave Girl--Written by Herself	2004-02-01	English	#N/A	10	10
14054	Max	2004-11-15	English	#N/A	10	10
14976	Mob Rule in New Orleans--Robert Charles and His Fight to Death, the Story of His Life, Burning--Human Beings Alive, Other Lynching Statistics	2005-02-08	English	Lynching	10	10
2095	Clotelle: a Tale of the Southern States	2000-03-01	English	Women slaves -- Fiction	10	10
19746	The Colonel's Dream	2006-11-09	English	Failure (Psychology) -- Fiction	10	10
15041	The Negro Problem	2005-02-14	English	#N/A	10	10
33733	The Guarded Heights	2010-09-15	English	#N/A	10	10
14977	The Red Record--Tabulated Statistics and Alleged Causes of Lynching in the United States	2005-02-08	English	African Americans -- History -- 1877-1964	10	10
14975	Southern Horrors--Lynch Law in All Its Phases	2005-02-08	English	Lynching	10	10
20677	God and the State	2007-02-03	English	Atheism	10	10
26600	Mother Earth, Vol. 1 No. 1, March 1906	2008-09-12	English	Anarchism -- Periodicals	10	10
27118	Mother Earth, Vol. 1 No. 2, April 1906--Monthly Magazine Devoted to Social Science and Literature	2008-11-01	English	Anarchism -- Periodicals	10	10
27262	Mother Earth, Vol. 1 No. 3, May 1906--Monthly Magazine Devoted to Social Science and Literature	2008-11-14	English	Anarchism -- Periodicals	10	10
27341	Mother Earth, Vol. 1 No. 4, June 1906--Monthly Magazine Devoted to Social Science and Literature	2008-11-27	English	Anarchism -- Periodicals	10	10
444	System of Economical Contradictions; or, the Philosophy of Misery	1996-02-01	English	Philosophy	10	10
4602	The Kingdom of God Is Within You	2003-11-01	English	Evil, Non-resistance to	10	10
8700	The Evolution of Man	2005-08-01	English	Embryology, Human	10	10
2634	Evolution of Theology: an Anthropological Study	2001-05-01	English	Paleontology	10	10
689	The Kreutzer Sonata and Other Stories	2006-03-18	English	Fiction	10	10
36676	L'Illustration, No. 3271, 4 Novembre 1905	2011-07-09	French	#N/A	10	10
18869	On Limitations To The Use Of Some Anthropologic Data	2006-07-19	English	Anthropology	10	10
15293	Influences of Geographic Environment--On the Basis of Ratzel's System of Anthropo-Geography	2005-03-08	English	Human geography	10	10
14028	Ãœber das Aussterben der NaturvÃ¶lker	2004-11-12	German	Ethnology	10	10
18273	The Wild Tribes of Davao District, Mindanao--The R. F. Cummings Philippine Expedition	2006-04-28	English	Ethnology -- Philippines -- Mindanao Island	10	10
14648	Bij de Parsi's van Bombay en Gudsjerat--De Aarde en haar Volken, 1909-1910	2005-01-10	Dutch	Parsees	10	10
13831	Evolution Of The Japanese, Social And Psychic	2004-10-22	English	Japan -- Civilization	10	10
20116	The Belief in Immortality and the Worship of the Dead, Volume I (of 3)--The Belief Among the Aborigines of Australia, the Torres Straits Islands, New Guinea and Melanesia	2006-12-15	English	Ancestor worship -- Oceania	10	10
17186	NoÃ§Ãµes elementares de archeologia	2005-11-29	Portuguese	Archaeology	10	10
13642	The Journal of Negro History, Volume 1, January 1916	2004-10-05	English	African Americans -- Periodicals	10	10
35560	Quo Vadis (Î Î¿Ï Ï€Î·Î³Î±Î¯Î½ÎµÎ¹Ï‚)--ÎœÏ…Î¸Î¹ÏƒÏ„ÏŒÏÎ·Î¼Î± Ï„Î·Ï‚ ÎÎµÏÏ‰Î½Î¹ÎºÎ®Ï‚ Î•Ï€Î¿Ï‡Î®Ï‚	2011-03-12	Greek	#N/A	10	10
20411	The Witch-cult in Western Europe--A Study in Anthropology	2007-01-22	English	Witchcraft -- Great Britain	10	10
20665	De Nederlandsche Nationale Kleederdrachten	2007-02-25	Dutch	Costume -- Netherlands -- History	10	10
18236	In de Amsterdamsche Jodenbuurt--De Aarde en haar Volken, 1907	2006-04-23	Dutch	Jews -- Netherlands -- Amsterdam	10	10
7978	Legends, Traditions, and Laws of the Iroquois, or Six Nations, and History of the Tuscarora Indians	2005-04-01	English	Tuscarora Indians	10	10
8112	Houses and House-Life of the American Aborigines	2005-05-01	English	Indians of North America -- Dwellings	10	10
16572	Indians of the Yosemite Valley and Vicinity--Their History, Customs and Traditions	2005-08-21	English	Yosemite Valley (Calif.)	10	10
17404	Kinship Organisations and Group Marriage in Australia	2005-12-28	English	Aboriginal Australians -- Kinship	10	10
17280	Anthropology	2005-12-11	English	Anthropology	10	10
17262	Catalogue Of Linguistic Manuscripts In The Library Of The Bureau Of Ethnology. (1881 N 01 / 1879-1880 (Pages 553-578))	2005-12-09	English	Indians of North America -- Languages -- Bibliography	10	10
1323	History of the Conquest of Peru; with a preliminary view of the civilization of the Incas	1998-05-01	English	Peru -- History -- Conquest, 1522-1548	10	10
22601	Hiawatha and the Iroquois Confederation--A Study in Anthropology. A Paper Read at the Cincinnati Meeting of the American Association for the Advancement of Science, in August, 1881, under the Title of A Lawgiver of the Stone Age.	2007-09-14	English	Hiawatha, 15th cent.	10	10
17910	The Mafulu--Mountain People of British New Guinea	2006-03-04	English	Mafulus	10	10
14400	Manual of Egyptian Archaeology and Guide to the Study of Antiquities in Egypt	2004-12-20	English	Egypt -- Antiquities	10	10
19115	Roman Britain in 1914	2006-08-25	English	Great Britain -- Antiquities, Roman	10	10
15126	Lecture on the Aborigines of Newfoundland--Delivered Before the Mechanics' Institute, at St. John's,--Newfoundland, on Monday, 17th January, 1859	2005-02-21	English	Indians of North America -- Newfoundland and Labrador	10	10
17487	Casa Grande Ruin--Thirteenth Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution, 1891-92,--Government Printing Office, Washington, 1896, pages 289-318	2006-01-10	English	Hohokam architecture	10	10
24505	The Forest of Dean--An Historical and Descriptive Account	2008-02-03	English	Technology, History of	10	10
17606	Throwing-sticks in the National Museum--Third Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution, 1883-'84,--Government Printing Office, Washington, 1890, pages 279-289	2006-01-25	English	United States National Museum -- Collections	10	10
19856	A Study of Pueblo Architecture: Tusayan and Cibola--Eighth Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution, 1886-1887,--Government Printing Office, Washington, 1891, pages 3-228	2006-11-17	English	Pueblo Indians -- Antiquities	10	10
35188	The Fire Bird	2011-02-06	English	#N/A	10	10
19606	Illustrated Catalogue of the Collections Obtained from the Pueblos of ZuÃ±i, New Mexico, and Wolpi, Arizona, in 1881--Third Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution, 1881-82,--Government Printing Office, Washington, 1884, pages 511-594	2006-10-23	English	Zuni Indians -- Antiquities	10	10
13575	How to Observe in Archaeology	2004-10-01	English	Archaeology	10	10
24654	Chaldea--From the Earliest Times to the Rise of Assyria	2008-02-20	English	Babylonia -- History	10	10
17774	The Poetry of Architecture--Or, the Architecture of the Nations of Europe Considered in its Association with Natural Scenery and National Character	2006-02-16	English	Architecture	10	10
12625	Architecture and Democracy	2004-06-01	English	Sullivan, Louis H., 1856-1924	10	10
16531	Old St. Paul's Cathedral	2005-08-15	English	St. Paul's Cathedral (London, England)	10	10
506	The Shuttle	2006-03-18	English	Fiction	10	10
10479	Our Churches and Chapels--Their Parsons, Priests, & Congregations--Being a Critical and Historical Account of Every Place of Worship in Preston	2003-12-01	English	Preston (Lancashire, England) -- Church history	10	10
22990	Historical Sketch of the Cathedral of Strasburg	2007-10-12	English	Strassburger MÃ¼nster	10	10
22832	The Cathedral Church of Canterbury [2nd ed.]--A Description of Its Fabric and a Brief History of the Archiepiscopal See	2007-10-02	English	Canterbury Cathedral	10	10
19881	Bell's Cathedrals: The Cathedral Church of Carlisle--A Description of Its Fabric and A Brief History of the Episcopal See	2006-11-20	English	Carlisle Cathedral (Carlisle, England)	10	10
20191	Bell's Cathedrals: The Cathedral Church of Durham--A Description of Its Fabric and A Brief History of the Espiscopal See	2006-12-26	English	Durham Cathedral	10	10
19487	Bellâ€™s Cathedrals: The Cathedral Church of Hereford, A Description--Of Its Fabric And A Brief History Of The Episcopal See	2006-10-07	English	Hereford Cathedral	10	10
36780	Lettres de mon moulin	2011-07-18	French	#N/A	10	10
21511	Bell's Cathedrals: The Priory Church of St. Bartholomew-the-Great, Smithfield--A Short History of the Foundation and a Description of the--Fabric and also of the Church of St. Bartholomew-the-Less	2007-05-17	English	St. Bartholomew-the-Great (Church : London, England)	10	10
22260	Bell's Cathedrals: The Abbey Church of Tewkesbury--with some Account of the Priory Church of Deerhurst Gloucestershire	2007-08-07	English	Deerhurst (England). Priory church	10	10
36844	In New England Fields and Woods	2011-07-25	English	#N/A	10	10
20967	A Guide to Peterborough Cathedral--Comprising a brief history of the monastery from its foundation to the present time, with a descriptive account of its architectural peculiarities and recent improvements; compiled from the works of Gunton, Britton, and original & authentic documents	2007-04-03	English	Peterborough Cathedral -- Guidebooks	10	10
19998	Rural Architecture--Being a Complete Description of Farm Houses, Cottages, and Out Buildings	2006-12-03	English	Architecture, Domestic	10	10
14987	The Brochure Series of Architectural Illustration, Volume 01, No. 10, October 1895.--French Farmhouses.	2005-02-09	English	Architecture -- Periodicals	10	10
15020	The Brochure Series of Architectural Illustration, Volume 01, No. 11, November, 1895--The Country Houses of Normandy	2005-02-12	English	Architecture -- Periodicals	10	10
16105	ColecciÃ³n de viages y expediciÃ³nes Ã  los campos de Buenos Aires y a las costas de Patagonia	2005-06-22	Spanish	#N/A	10	10
12648	The Beautiful Necessity--Seven Essays on Theosophy and Architecture	2004-06-01	English	Architecture	10	10
23593	Lectures on Architecture and Painting--Delivered at Edinburgh in November 1853	2007-11-22	English	Architecture	10	10
19715	Bell's Cathedrals: The Cathedral Church of Norwich--A Description of Its Fabric and A Brief History of the Episcopal See	2006-11-05	English	Norwich Cathedral (Norwich, England)	10	10
18783	Diario del viaje al rio Bermejo	2006-07-08	Spanish	Bermejo River (Bolivia and Argentina) -- Discovery and exploration	10	10
11302	Diario de la navegacion empredida en 1781	2004-02-01	Spanish	#N/A	10	10
18289	Diario de un viage a la costa de la mar Magallanica	2006-04-30	Spanish	Argentina -- Discovery and exploration	10	10
19643	Actas capitulares desde el 21 hasta el 25 de mayo de 1810 en Buenos Aires	2006-10-27	Spanish	Argentina -- History -- War of Independence, 1810-1817	10	10
18157	FundaciÃ³n de la ciudad de Buenos-Aires	2006-04-12	Spanish	Garay, Juan de, 1528?-1583	10	10
18798	Memoria dirigida al Sr. Marquez de Loreto, Virey y Capitan General de las Provincias del Rio de La Plata	2006-07-09	Spanish	Argentina -- History -- 1776-1810	10	10
36865	Responsibilities--and other poems	2011-07-27	English	#N/A	10	10
37036	The Key to Success	2011-08-11	English	#N/A	10	10
37171	Lost Sir Massingberd, v. 2/2--A Romance of Real Life	2011-08-23	English	#N/A	10	10
20401	Viage al Rio de La Plata y Paraguay	2007-01-20	Spanish	Paraguay -- History -- To 1811	10	10
25317	La Argentina--La conquista del Rio de La Plata. Poema histÃ³rico	2008-05-03	Spanish	America -- Discovery and exploration -- Spanish -- Poetry	10	10
20852	Descripcion del rio Paraguay, desde la boca del Xauru hasta la confluencia del Parana	2007-03-20	Spanish	Paraguay River	10	10
18723	Proyecto de traslacion de las fronteras de Buenos Aires al Rio Negro y Colorado	2006-07-01	Spanish	Mountain passes -- Andes	10	10
15066	La Vuelta de MartÃ­n Fierro	2005-02-15	Spanish	#N/A	10	10
7446	The Naturalist in La Plata	2005-02-01	English	PR	10	10
4028	Autobiography of Benvenuto Cellini	2003-05-01	English	Cellini, Benvenuto, 1500-1571	10	10
18937	My First Picture Book--With Thirty-six Pages of Pictures Printed in Colours by Kronheim	2006-07-29	English	Children's poetry	10	10
37178	Cecil Castlemaine's Gage, Lady Marabout's Troubles, and Other Stories	2011-08-23	English	#N/A	10	10
37190	The Main Chance	2011-08-24	English	#N/A	10	10
19570	Van Dyck--A Collection Of Fifteen Pictures And A Portrait Of The--Painter With Introduction And Interpretation	2006-10-18	English	Van Dyck, Anthony, Sir, 1599-1641	10	10
22500	The Works of William Hogarth: In a Series of Engravings--With Descriptions, and a Comment on Their Moral Tendency	2007-09-04	English	Hogarth, William, 1697-1764	10	10
20607	Rembrandt	2007-02-16	English	Rembrandt Harmenszoon van Rijn, 1606-1669	10	10
22564	Great Artists, Vol 1.--Raphael, Rubens, Murillo, and Durer	2007-09-10	English	Artists	10	10
17289	The Dance (by An Antiquary)--Historic Illustrations of Dancing from 3300 B.C. to 1911 A.D.	2005-12-12	English	Dance -- History	10	10
17244	French Art--Classic and Contemporary Painting and Sculpture	2005-12-06	English	Art, French	10	10
14056	The French Impressionists (1860-1900)	2004-11-15	English	Impressionism (Art)	10	10
17730	A Study Of The Textile Art In Its Relation To The Development Of Form And Ornament--Sixth Annual Report of the Bureau of Ethnology to the--Secretary of the Smithsonian Institution, 1884-'85,--Government Printing Office, Washington, 1888, (pages--189-252)	2006-02-09	English	Indian textile fabrics -- North America	10	10
5712	Sculpture of the Exposition Palaces and Courts	2004-05-01	English	Sculpture	10	10
13029	The Art of the Moving Picture	2004-07-26	English	Motion pictures	10	10
16180	Roman Mosaics--Or, Studies in Rome and Its Neighbourhood	2005-07-02	English	Rome (Italy) -- Description and travel	10	10
22574	The Best Portraits in Engraving	2007-09-11	English	Engraving	10	10
6841	Mosaics of Grecian History	2004-11-01	English	Greece -- History	10	10
18733	Die Italienische Plastik	2006-07-01	German	Sculpture -- Italy -- History	10	10
20915	Field's Chromatography--or Treatise on Colours and Pigments as Used by Artists	2007-03-27	English	Colors	10	10
37274	The Assembly of God--Miscellaneous Writings of C. H. Mackintosh, volume III	2011-08-30	English	#N/A	10	10
20195	Wood-Block Printing--A Description of the Craft of Woodcutting and Colour Printing Based on the Japanese Practice	2006-12-26	English	Wood-engraving -- Printing	10	10
167	American Hand Book of the Daguerreotype	1994-09-01	English	Daguerreotype	10	10
14264	The Practice and Science of Drawing	2004-12-06	English	Drawing	10	10
13755	How to See the British Museum in Four Visits	2004-10-15	English	British Museum	10	10
6932	Pictures Every Child Should Know--A Selection of the World's Art Masterpieces for Young People	2004-11-01	English	Painting -- Juvenile literature	10	10
4060	The Renaissance: studies in art and poetry	2003-05-01	English	Renaissance	10	10
19980	A Joy For Ever--(And Its Price in the Market)	2006-11-30	English	Art	10	10
19164	Lectures on Art--Delivered before the University of Oxford in Hilary term, 1870	2006-09-03	English	Art	10	10
4390	A History of Greek Art	2003-08-01	English	Art, Greek -- History	10	10
13119	Jean Francois Millet	2004-08-05	English	Millet, Jean FranÃ§ois, 1814-1875	10	10
19009	Sir Joshua Reynolds--A Collection of Fifteen Pictures and a Portrait of the--Painter with Introduction and Interpretation	2006-08-08	English	Reynolds, Joshua, Sir, 1723-1792	10	10
17215	Rembrandt	2005-12-03	English	Rembrandt Harmenszoon van Rijn, 1606-1669	10	10
22690	Rembrandt and His Works--Comprising a Short Account of His Life; with a Critical Examination into His Principles and Practice of Design, Light, Shade, and Colour. Illustrated by Examples from the Etchings of Rembrandt.	2007-09-20	English	Etching -- Catalogs	10	10
19602	Rembrandt--A Collection Of Fifteen Pictures and a Portrait of the--Painter with Introduction and Interpretation	2006-10-22	English	Rembrandt Harmenszoon van Rijn, 1606-1669	10	10
17212	Michelangelo--A Collection Of Fifteen Pictures And A Portrait Of The--Master, With Introduction And Interpretation	2005-12-03	English	Michelangelo Buonarroti, 1475-1564	10	10
11242	The Life of Michelangelo Buonarroti	2004-02-01	English	Michelangelo Buonarroti, 1475-1564	10	10
22522	Femmes d'artistes. English	2007-09-05	English	Short stories	10	10
24726	A History of Art for Beginners and Students--Painting, Sculpture, Architecture	2008-03-01	English	Art -- History	10	10
3151	The City of Domes : a walk with an architect about the courts and palaces of the Panama-Pacific International Exposition, with a discussion of its architecture, its sculpture, its mural decorations, its coloring and its lighting, preceded by a history of its growth	2002-04-01	English	Panama-Pacific International Exposition (1915 : San Francisco, Calif.)	10	10
28434	The Astronomy of Milton's 'Paradise Lost'	2009-03-29	English	Epic poetry, English -- History and criticism	10	10
28536	The Astronomy of the Bible--An Elementary Commentary on the Astronomical References of Holy Scripture	2009-04-08	English	Astronomy in the Bible	10	10
35744	The gradual acceptance of the Copernican theory of the universe	2011-04-01	English	#N/A	10	10
8172	History of Astronomy	2005-05-01	English	Astronomy -- History	10	10
17370	Prehistoric Textile Fabrics Of The United States, Derived From Impressions On Pottery--Third Annual Report of the Bureau of Ethnology to the Secretary of the Smithsonian Institution, 1881-82, Government Printing Office, Washington, 1884, pages 393-425	2005-12-22	English	Indian pottery -- North America	10	10
15622	Handbook on Japanning: 2nd Edition--For Ironware, Tinware, Wood, Etc. With Sections on Tinplating and--Galvanizing	2005-04-14	English	Japanning	10	10
25267	Astronomy for Amateurs	2008-04-30	English	Astronomy	10	10
26556	Myths and Marvels of Astronomy	2008-09-08	English	Astronomy	10	10
35261	A New Astronomy	2011-02-13	English	#N/A	10	10
28752	Pleasures of the telescope--An Illustrated Guide for Amateur Astronomers and a Popular--Description of the Chief Wonders of the Heavens for General--Readers	2009-05-10	English	Astronomy -- Observers' manuals	10	10
15620	Recreations in Astronomy--With Directions for Practical Experiments and Telescopic Work	2005-04-14	English	#N/A	10	10
35588	Scientific Papers by Sir George Howard Darwin--Volume V. Supplementary Volume	2011-03-16	English	#N/A	10	10
4065	Side-Lights on Astronomy and Kindred Fields of Popular Science	2003-05-01	English	Compass	10	10
29031	Sir William Herschel: His Life and Works	2009-06-03	English	Astronomy -- Great Britain -- History -- 18th century	10	10
34435	Le SystÃ¨me Solaire se mouvant	2010-11-25	French	Astronomy	10	10
24236	Time and Tide--A Romance of the Moon	2008-01-10	English	Satellites	10	10
16227	The Uses of Astronomy--An Oration Delivered at Albany on the 28th of July, 1856	2005-07-06	English	#N/A	10	10
18431	Other Worlds--Their Nature, Possibilities and Habitability in the Light of the Latest Discoveries	2006-05-22	English	Astronomy	10	10
16767	Half-hours with the Telescope--Being a Popular Guide to the Use of the Telescope as a--Means of Amusement and Instruction.	2005-09-28	English	Astronomy	10	10
30607	Australia, its history and present condition--containing an account both of the bush and of the colonies,--with their respective inhabitants	2009-12-05	English	Australia -- Description and travel	10	10
8106	Captain Cook's Journal During the First Voyage Round the World	2005-05-01	English	#N/A	10	10
12668	An Account of the English Colony in New South Wales, Volume 2	2004-06-01	English	#N/A	10	10
15675	A Voyage to New Holland	2005-04-21	English	#N/A	10	10
17450	The Part Borne by the Dutch in the Discovery of Australia 1606-1765	2006-01-03	English	Australia -- Discovery and exploration	10	10
2660	Early Australian Voyages: Pelsart, Tasman, Dampier	2001-06-01	English	Australia -- Discovery and exploration	10	10
7450	Terre NapoleÃ³n; a History of French Explorations and Projects in Australia	2005-02-01	English	Australia -- Discovery and exploration	10	10
10840	The Explorers of Australia and their Life-work	2004-01-01	English	#N/A	10	10
7163	The History of Australian Exploration from 1788 to 1888	2004-12-01	English	#N/A	10	10
15662	An Historical Journal of the Transactions at Port Jackson and Norfolk Island	2005-04-20	English	New South Wales -- History -- Sources	10	10
10461	Journals of Australian Explorations	2003-12-01	English	#N/A	10	10
16027	Journals of Two Expeditions of Discovery in North-West and Western Australia, Volume 1	2005-06-09	English	#N/A	10	10
16145	Journals of Two Expeditions of Discovery in North-West and Western Australia, Volume 2	2005-06-29	English	#N/A	10	10
8741	The Brass Bowl	2005-08-01	English	#N/A	10	10
4521	Narrative of the Overland Expedition of the Messrs. Jardine from Rockhampton to Cape York, Northern Queensland	2004-08-28	English	Explorers -- Australia	10	10
11203	Narrative of a Survey of the Intertropical and Western Coasts of Australia--Performed between the years 1818 and 1822 â€” Volume 1	2004-02-01	English	#N/A	10	10
12046	Narrative of a Survey of the Intertropical and Western Coasts of Australia--Performed between the years 1818 and 1822 â€” Volume 2	2004-04-01	English	#N/A	10	10
13248	McKinlay's Journal of Exploration in the Interior of Australia	2004-08-22	English	#N/A	10	10
9943	Journal of an Expedition into the Interior of Tropical Australia	2004-08-28	English	#N/A	10	10
12928	Three Expeditions into the Interior of Eastern Australia, Volume 1	2004-07-17	English	#N/A	10	10
13033	Three Expeditions into the Interior of Eastern Australia, Volume 2	2004-07-27	English	#N/A	10	10
8911	Explorations in Australia--The Journals of John McDouall Stuart	2004-08-30	English	#N/A	10	10
5816	Successful Exploration Through the Interior of Australia	2004-06-01	English	#N/A	10	10
12146	Discoveries in Australia, Volume 2--Discoveries in Australia; with an Account of the Coasts and Rivers--Explored and Surveyed During the Voyage of H.M.S. Beagle, in The--Years 1837-38-39-40-41-42-43. By Command of the Lords Commissioners--Of the Admiralty. Also a Narrative of Captain Owen Stanley's Visits--To the Islands in the Arafura Sea	2004-04-01	English	#N/A	10	10
12929	A Voyage to Terra Australis â€” Volume 1	2004-07-17	English	#N/A	10	10
34172	Peter's Rock in Mohammed's Flood, from St. Gregory the Great to St. Leo III	2010-10-30	English	#N/A	10	10
15100	The Voyage of Governor Phillip to Botany Bay--With an Account of the Establishment of the Colonies of Port Jackson--and Norfolk Island (1789)	2005-02-18	English	#N/A	10	10
4054	A Lady's Visit to the Gold Diggings of Australia in 1852-53	2003-05-01	English	Australia -- Description and travel	10	10
3546	The Eureka Stockade	2002-11-01	English	Eureka Stockade (Ballarat, Vic.)	10	10
16050	The Gold Hunters' Adventures--Or, Life in Australia	2005-06-13	English	Australia -- Fiction	10	10
8730	A Little Bush Maid	2005-08-01	English	Country life -- Australia -- Juvenile fiction	10	10
304	Rio Grande's Last Race & Other Verses	1995-08-01	English	Australian poetry	10	10
307	Three Elephant Power and Other Stories	2008-06-29	English	Frontier and pioneer life -- Australia -- Fiction	10	10
5113	Confessions of a Beachcomber	2004-02-01	English	Natural history -- Queensland	10	10
19274	Letters from the Guardian to Australia and New Zealand	2006-09-17	English	Shoghi, Effendi, 1897-1957 -- Correspondence	10	10
27099	Reminiscences of Queensland--1862-1869	2008-10-30	English	Frontier and pioneer life -- Australia -- Queensland	10	10
25527	Australia, The Dairy Country	2008-05-19	English	Dairying -- Australia	10	10
24994	Wheat Growing in Australia	2008-04-05	English	Wheat -- Australia	10	10
4699	We of the Never-Never	2003-11-01	English	Frontier and pioneer life -- Australia	10	10
16664	Town Life in Australia	2005-09-06	English	Adelaide (S. Aust.) -- Social life and customs	10	10
4221	Shearing in the Riverina	2003-07-01	English	Sheep-shearing -- Australia	10	10
25750	Colonial Born--A tale of the Queensland bush	2008-06-10	English	Australia -- Fiction	10	10
3703	Dot and the Kangaroo	2003-02-01	English	Kangaroos -- Juvenile fiction	10	10
18891	Dot and the Kangaroo	2006-07-22	English	Kangaroos -- Juvenile fiction	10	10
21464	The Gilpins and their Fortunes--A Story of Early Days in Australia	2007-05-15	English	Christian life -- Juvenile fiction	10	10
26034	Grey Town--An Australian Story	2008-07-12	English	Australia -- Fiction	10	10
25059	In The Far North--1901	2008-04-12	English	Short stories	10	10
23995	The Land of the Kangaroo--Adventures of Two Youths in a Journey through the Great Island Continent	2007-12-26	English	Voyages and travels -- Juvenile fiction	10	10
22849	The History of Tasmania , Volume II	2007-10-02	English	Tasmania -- History	10	10
4731	Seven Little Australians	2003-12-01	English	Australia -- History -- 1788-1900 -- Fiction	10	10
21383	Adventures in Australia	2007-05-08	English	Aboriginal Australians -- Juvenile fiction	10	10
19172	An Australian in China--Being the Narrative of a Quiet Journey Across China to Burma	2006-09-04	English	China -- Description and travel	10	10
3832	Australia Felix	2003-03-01	English	Australia -- Fiction	10	10
1199	An Anthology of Australian Verse	1998-02-01	English	Poetry	10	10
11620	My Brilliant Career	2004-03-01	English	#N/A	10	10
3424	For the Term of His Natural Life	2002-09-01	English	Australia -- Fiction	10	10
24639	The Colonial Mortuary Bard; 'Reo, The Fisherman; and The Black Bream Of Australia--1901	2008-02-18	English	Short stories	10	10
24807	A Memory Of The Southern Seas--1904	2008-03-11	English	Short stories	10	10
27977	Austral English--A dictionary of Australasian words, phrases and usages with those aboriginal-Australian and Maori words which have become incorporated in the language, and the commoner scientific words that have had their origin in Australasia	2009-02-03	English	English language -- Foreign words and phrases -- Maori	10	10
36826	Le barbier de SÃ©ville ou la prÃ©caution inutile	2011-07-23	French	Comedies	10	10
23615	Le Tour du Monde; Australie--Journal des voyages et des voyageurs; 2. sem. 1860	2007-11-25	French	Geography -- Pictorial works -- Periodicals	10	10
12565	An Account of the English Colony in New South Wales, Volume 1--With Remarks on the Dispositions, Customs, Manners, Etc. of The--Native Inhabitants of That Country. to Which Are Added, Some--Particulars of New Zealand; Compiled, By Permission, From--The Mss.         of Lieutenant-Governor King.	2004-06-01	English	#N/A	10	10
15602	Statistical, Historical and Political Description of the Colony of New South Wales and its Dependent Settlements in Van Diemen's Land--With a Particular Enumeration of the Advantages Which These Colonies Offer for Emigration, and Their Superiority in Many Respects Over Those Possessed by the United States of America	2005-04-11	English	#N/A	10	10
5346	Journals of Expeditions of Discovery into Central Australia and Overland from Adelaide to King George's Sound in the Years 1840-1: Sent By the Colonists of South Australia, with the Sanction and Support of the Government: Including an Account of the Manners and Customs of the Aborigines and the State of Their Relations with Europeans â€” Complete	2004-03-01	English	Australia -- Discovery and exploration	10	10
30344	The Fortunate Mistress (Parts 1 and 2)--or a History of the Life of Mademoiselle de Beleau Known by the Name of the Lady Roxana	2009-10-27	English	Mistresses -- Fiction	10	10
5005	Journal of an Overland Expedition in Australia : from Moreton Bay to Port Essington, a distance of upwards of 3000 miles, during the years 1844-1845	2004-09-25	English	Australia -- Discovery and exploration	10	10
18569	Voltaire's Philosophical Dictionary	2006-06-12	English	Philosophy -- Dictionaries	10	10
6828	The Works of Henry Fielding--Edited by George Saintsbury in 12 Volumes $p Volume 12	2004-11-01	English	PR	10	10
5427	Emile	2004-04-01	English	Education -- Early works to 1800	10	10
12115	Discoveries in Australia, Volume 1.--With an Account of the Coasts and Rivers Explored and Surveyed During--The Voyage of H.M.S. Beagle, in the Years 1837-38-39-40-41-42-43.--By Command of the Lords Commissioners of the Admiralty. Also a Narrative--Of Captain Owen Stanley's Visits to the Islands in the Arafura Sea.	2004-04-01	English	#N/A	10	10
7509	The Logbooks of the Lady Nelson--With the journal of her first commander Lieutenant James Grant	2004-08-28	English	Australia -- Discovery and exploration	10	10
1198	Robbery under Arms; a story of life and adventure in the bush and in the Australian goldfields	1998-02-01	English	Frontier and pioneer life -- Australia -- Fiction	10	10
3833	Australian Legendary Tales: folklore of the Noongahburrahs as told to the Piccaninnies	2003-03-01	English	Folklore -- Australia	10	10
3819	The Euahlayi Tribe; a study of aboriginal life in Australia	2003-03-01	English	Euahlayi (Australian people)	10	10
4050	Mates at Billabong	2003-05-01	English	Australia -- Fiction	10	10
21518	The Glugs of Gosh	2007-05-22	English	Australian poetry	10	10
4830	The Rise of the Dutch Republic â€” Volume 28: 1578, part II	2004-01-01	English	Netherlands -- History -- Wars of Independence, 1556-1648	10	10
214	In the Days When the World Was Wide and Other Verses	2008-07-03	English	Australian poetry	10	10
1036	Joe Wilson and His Mates	1997-09-01	English	Frontier and pioneer life -- Australia -- Fiction	10	10
4975	Spinifex and Sand	2004-01-01	English	Western Australia -- Description and travel	10	10
10842	The Life of Captain James Cook	2004-01-01	English	Cook, James, 1728-1779	10	10
15896	Five Months at Anzac--A Narrative of Personal Experiences of the Officer Commanding the 4th Field Ambulance, Australian Imperial Force	2005-05-24	English	World War, 1914-1918 -- Personal narratives, Australian	10	10
16588	Over the Top With the Third Australian Division	2005-08-24	English	World War, 1914-1918 -- Personal narratives, English	10	10
23050	Peter Biddulph--The Story of an Australian Settler	2007-10-17	English	Conduct of life -- Juvenile fiction	10	10
16940	Gleanings from the Writings of BahÃ¡'u'llÃ¡h	2005-06-23	English	Bahai Faith -- Doctrines	10	10
16939	Gems of Divine Mysteries	2005-06-23	English	Bahai Faith	10	10
16984	Prayers and Meditations	2005-11-02	English	Bahai Faith -- Prayers and devotions	10	10
19289	Some Answered Questions	2006-09-18	English	Bahai Faith -- Doctrines	10	10
19284	Paris Talks	2006-09-18	English	Bahai Faith	10	10
19238	Foundations of World Unity	2006-09-12	English	Bahai Faith	10	10
19279	Memorials of the Faithful	2006-09-17	English	Bahais -- Biography	10	10
19312	Tablets of Abdul-Baha Abbas	2006-09-20	English	Bahai Faith	10	10
19296	Tablets of the Divine Plan	2006-09-18	English	Bahai Faith	10	10
7114	Une Vie, a Piece of String and Other Stories	2004-12-01	English	PQ	10	10
23625	The Magic Pudding	2007-11-26	English	Fantasy	10	10
16891	Peter Parley's Tales About America and Australia	2005-10-17	English	America -- History -- Juvenile literature	10	10
4219	The Art of Living in Australia ;--together with three hundred Australian cookery recipes and accessory kitchen information by Mrs. H. Wicken	2003-07-01	English	Health	10	10
16983	The KitÃ¡b-i-ÃqÃ¡n	2005-11-02	English	Bahai Faith -- Doctrines	10	10
19240	BahÃ¡â€™Ã­ Prayers: A Selection of Prayers Revealed by BahÃ¡â€™uâ€™llÃ¡h, the--BÃ¡b, and â€˜Abduâ€™l-BahÃ¡	2006-09-12	English	Bahai Faith -- Prayers and devotions	10	10
19292	`Abdu'l-BahÃ¡'s Tablet to Dr. Forel	2006-09-18	English	Bahai Faith	10	10
19300	A Traveler's Narrative Written to Illustrate the Episode of the BÃ¡b	2006-09-18	English	Babism	10	10
19243	The Advent of Divine Justice	2006-09-15	English	Shoghi, Effendi, 1897-1957 -- Correspondence	10	10
19254	Citadel of Faith	2006-09-16	English	Bahai Faith -- North America	10	10
2562	Clouds	2001-03-01	English	Classical literature	10	10
3160	The Odyssey	2002-04-01	English	Odysseus (Greek mythology) -- Poetry	10	10
4094	The Chinese Classics â€” Volume 1: Confucian Analects	2003-05-01	English	Chinese literature	10	10
3100	The Chinese Classics: with a translation, critical and exegetical notes, prolegomena and copious indexes--(Shih ching. English) â€” Volume 1	2002-02-01	English	Chinese literature	10	10
3330	The Analects of Confucius (from the Chinese Classics)	2002-07-01	English	Chinese literature	10	10
9371	The Praise of Folly	2005-11-01	English	#N/A	10	10
27315	ÎŒÏÎ½Î¹Î¸ÎµÏ‚	2008-11-22	Greek	Birds -- Drama	10	10
1666	The Golden Asse	2006-02-22	English	Classical literature	10	10
21262	The Works of Christopher Marlowe, Vol. 3 (of 3)	2007-04-30	English	English poetry	10	10
17814	Î›Ï…ÏƒÎ¹ÏƒÏ„ÏÎ¬Ï„Î·	2006-02-21	Greek	Peace movements -- Drama	10	10
392	Jerusalem Delivered	1996-01-01	English	Epic poetry, Italian -- Translations into English	10	10
1000	La Divina Commedia di Dante	1997-08-01	Italian	Poetry	10	10
27846	Moriae encomium. Dutch	2009-01-20	Dutch	Folly -- Early works to 1800	10	10
3600	The Essays of Montaigne â€” Complete	2004-10-26	English	Essays	10	10
1012	La Divina Commedia di Dante	1997-08-01	Italian	Italian poetry -- To 1400	10	10
5500	The Advancement of Learning	2004-04-01	English	Philosophy	10	10
2250	Richard II	2000-07-01	English	Historical drama	10	10
1515	The Merchant of Venice	1998-11-01	English	Comedies	10	10
2266	King Lear	2000-07-01	English	Kings and rulers -- Succession -- Drama	10	10
23306	Meditationes de prima philosophia	2007-11-03	Latin	First philosophy	10	10
18269	Pascal's PensÃ©es	2006-04-27	English	Philosophy	10	10
17941	Fables de La Fontaine--Tome Premier	2006-03-07	French	Fables, French	10	10
10615	An Essay Concerning Humane Understanding, Volume 1--MDCXC, Based on the 2nd Edition, Books 1 and 2	2004-01-01	English	#N/A	10	10
10616	An Essay Concerning Humane Understanding, Volume 2--MDCXC, Based on the 2nd Edition, Books 3 and 4	2004-01-01	English	#N/A	10	10
608	Areopagitica--A speech for the Liberty of Unlicensed Printing to the Parliament of England	2006-01-21	English	Books	10	10
4737	A Tale of a Tub	2003-12-01	English	Satire, English	10	10
11248	The Delights of Wisdom Pertaining to Conjugial Love	2004-02-01	English	#N/A	10	10
30268	Lettres persanes, tome I	2009-10-16	French	Montesquieu, Charles de Secondat, baron de, 1689-1755	10	10
14395	Septimus	2004-12-20	English	#N/A	10	10
30433	Ã‰mile--or, Concerning Education; Extracts	2009-11-09	English	Education	10	10
804	A Sentimental Journey Through France and Italy	1997-02-01	English	France -- Fiction	10	10
601	The Monk; a romance	1996-07-01	English	Monks -- Fiction	10	10
6593	History of Tom Jones, a Foundling	2004-09-01	English	Humorous stories	10	10
20577	La Folle JournÃ©e ou le Mariage de Figaro	2007-02-13	French	Comedies	10	10
25717	The History Of The Decline And Fall Of The Roman Empire--Table of Contents with links in the HTML file to the two--Project Gutenberg editions (12 volumes)	2008-06-07	English	Byzantine Empire -- History	10	10
3743	Writings of Thomas Paine â€” Volume 4 (1794-1796): the Age of Reason	2003-02-01	English	Rationalism	10	10
4797	The Complete Poetical Works of Percy Bysshe Shelley â€” Volume 1	2003-12-01	English	PR	10	10
16896	Corinne, Volume 1 (of 2)--Or Italy	2005-10-17	English	Italy -- History -- 1789-1815 -- Fiction	10	10
29549	Le Roi s'amuse	2009-07-30	French	French drama -- 19th century	10	10
4799	The Complete Poetical Works of Percy Bysshe Shelley â€” Volume 3	2003-12-01	English	PR	10	10
9976	Hernani	2006-02-01	French	#N/A	10	10
798	Le Rouge et le noir	1997-01-01	French	Fiction	10	10
27942	A System Of Logic, Ratiocinative And Inductive	2009-01-31	English	Knowledge, Theory of	10	10
23297	La Gioconda	2007-11-03	Italian	Italian drama -- 19th century	10	10
22642	L'Innocente	2007-09-16	Italian	Fiction	10	10
27825	Isaotta GuttadÃ uro ed altre poesie	2009-01-18	Italian	Poetry	10	10
8899	Three Weeks	2005-09-01	English	#N/A	10	10
4708	Les Chansons De Bilitis	2003-12-01	French	PQ	10	10
26685	Aphrodite--Moeurs antiques	2008-09-21	French	Courtesans -- Egypt -- Alexandria -- Fiction	10	10
30719	ÎÎµÏ†Î­Î»Î±Î¹	2009-12-20	Greek	Comedies	10	10
5946	The History of Don Quixote, Volume 2, Complete	2004-06-01	English	Spain -- Social life and customs -- 16th century -- Fiction	10	10
5267	Sister Carrie	2004-03-01	English	PS	10	10
31824	The Genius	2010-03-30	English	#N/A	10	10
26884	The Backwash of War--The Human Wreckage of the Battlefield as Witnessed by an--American Hospital Nurse	2008-10-12	English	World War, 1914-1918 -- Personal narratives	10	10
2814	Dubliners	2001-09-01	English	Short stories	10	10
33797	Sinister Street, vol. 1	2010-09-22	English	#N/A	10	10
33798	Sinister Street, vol. 2	2010-09-22	English	#N/A	10	10
140	The Jungle	2006-03-11	English	Meat industry and trade -- Fiction	10	10
28948	The Rainbow	2009-05-23	English	Family -- England -- Midlands -- Fiction	10	10
4240	Women in Love	2003-07-01	English	Love stories	10	10
217	Sons and Lovers	2006-01-16	English	Working class families -- Fiction	10	10
29772	Oeuvres de Blaise Pascal--Nouvelle Ã‰dition. Tome Second.	2009-08-23	French	B	10	10
31053	The History of the Devil--As Well Ancient as Modern: In Two Parts	2010-01-23	English	#N/A	10	10
27573	Esprit des lois--livres I Ã  V, prÃ©cÃ©dÃ©s d'une introduction de l'Ã©diteur	2008-12-20	French	Political science	10	10
22048	NapolÃ©on Le Petit	2007-07-11	French	Napoleon III, Emperor of the French, 1808-1873	10	10
25344	The Scarlet Letter	2008-05-05	English	Adultery -- Fiction	10	10
30107	Principles Of Political Economy--Abridged with Critical, Bibliographical, and Explanatory Notes, and a Sketch of the History of Political Economy	2009-09-27	English	Economics	10	10
20580	Napoleon the Little	2007-02-14	English	France -- History -- Second Republic, 1848-1852	10	10
12784	The Prose Works of Jonathan Swift, D.D. â€” Volume 06--The Drapier's Letters	2004-06-29	English	#N/A	10	10
25053	Tentation de saint Antoine. English	2008-04-12	English	Christian saints -- Fiction	10	10
28885	Alice's Adventures in Wonderland--Illustrated by Arthur Rackham. With a Proem by Austin Dobson	2009-05-19	English	Fantasy	10	10
74	The Adventures of Tom Sawyer	2004-07-01	English	Male friendship -- Fiction	10	10
6099	Les Fleurs du Mal	2004-07-01	French	PQ	10	10
2413	Madame Bovary	2006-02-26	English	Adultery -- Fiction	10	10
26710	Les Ã©paves de Charles Baudelaire	2008-09-27	French	PQ	10	10
61	The Communist Manifesto	2005-01-25	English	Communism	10	10
15995	Salambo--Ein Roman aus Alt-Karthago	2005-06-06	German	Carthage (Extinct city) -- History -- Fiction	10	10
27401	Poems & Ballads (Second Series)--Swinburne's Poems Volume III	2008-12-04	English	English poetry	10	10
110	Tess of the d'Urbervilles	1994-02-01	English	Man-woman relationships -- Fiction	10	10
153	Jude the Obscure	1994-08-01	English	Stonemasons -- Fiction	10	10
8563	La Terre	2005-07-01	French	#N/A	10	10
20974	J'accuse...!	2007-04-04	French	Dreyfus, Alfred, 1859-1935	10	10
18545	A Mummer's Tale	2006-06-09	English	Fiction	10	10
4788	Mademoiselle Fifi	2003-12-01	English	PQ	10	10
160	The Awakening and Selected Short Stories	2006-03-11	English	Adultery -- Fiction	10	10
37298	Garcia the Centenarian And His Times--Being a Memoir of Manuel Garcia's Life and Labours for the--Advancement of Music and Science	2011-09-03	English	#N/A	10	10
47	Anne of Avonlea	2006-03-08	English	Teachers -- Fiction	10	10
808	The Complete Plays of Gilbert and Sullivan	1997-02-01	English	Operas -- Librettos	10	10
7508	A Mummer's Wife	2005-02-01	English	PR	10	10
5722	The Shewing-up of Blanco Posnet	2004-05-01	English	#N/A	10	10
23917	SalomÃ©	2007-12-19	French	Tragedies	10	10
29208	Salome en Een Florentijnsch Treurspel	2009-06-23	Dutch	Tragedies	10	10
996	Don Quixote	2004-07-27	English	Knights and knighthood -- Spain -- Fiction	10	10
1661	The Adventures of Sherlock Holmes	1999-03-01	English	Holmes, Sherlock (Fictitious character) -- Fiction	10	10
113	The Secret Garden	1994-03-01	English	Yorkshire (England) -- Fiction	10	10
7523	The Lady of the Decoration	2005-02-01	English	Japan -- History -- Meiji period, 1868-1912 -- Fiction	10	10
13610	Studies in the Psychology of Sex, Volume 1--The Evolution of Modesty; The Phenomena of Sexual Periodicity; Auto-Erotism	2004-10-08	English	Sex	10	10
13611	Studies in the Psychology of Sex, Volume 2--Sexual Inversion	2004-10-08	English	Sex	10	10
31732	The Sex Side of Life--An Explanation for Young People	2010-03-22	English	#N/A	10	10
23700	The Decameron of Giovanni Boccaccio	2007-12-03	English	Allegories	10	10
19591	De Decamerone van Boccaccio	2006-10-20	Dutch	Allegories	10	10
2021	Nostromo, a Tale of the Seaboard	2006-01-09	English	Revolutions -- Fiction	10	10
8800	The Divine Comedy by Dante, Illustrated	2005-09-01	English	Poetry	10	10
1400	Great Expectations	1998-07-01	English	Man-woman relationships -- Fiction	10	10
28054	The Brothers Karamazov	2009-02-12	English	Didactic fiction	10	10
11000	An Old Babylonian Version of the Gilgamesh Epic	2006-07-04	English	#N/A	10	10
145	Middlemarch	1994-07-01	English	England -- Social life and customs -- 19th century -- Fiction	10	10
1237	Father Goriot	2004-10-06	English	French literature	10	10
8387	Hunger	2005-06-01	English	Authors -- Fiction	10	10
15492	A Doll's House	2005-03-29	English	Wives -- Drama	10	10
4300	Ulysses	2003-07-01	English	Domestic fiction	10	10
16659	Translations of Shakuntala and Other Works	2005-09-05	English	Sanskrit drama -- Translations into English	10	10
12058	The Mahabharata of Krishna-Dwaipayana Vyasa Translated into English Prose --Virata Parva	2004-04-01	English	#N/A	10	10
21765	The Metamorphoses of Ovid--Vol. I,  Books I-VII	2007-06-08	English	Classical literature	10	10
25667	Hamlet: Drama em cinco Actos	2008-06-01	Portuguese	Denmark -- Drama	10	10
1531	Othello	1998-11-01	English	Interracial marriage -- Drama	10	10
12406	Kepler	2004-05-01	English	Kepler, Johannes, 1571-1630	10	10
7849	The Trial	2005-04-01	English	Social problems -- Fiction	10	10
3435	Arabian nights. English	2002-09-01	English	Fairy tales	10	10
3436	Arabian nights. English	2002-09-01	English	Fairy tales	10	10
76	Adventures of Huckleberry Finn	2004-06-29	English	Male friendship -- Fiction	10	10
1322	Leaves of Grass	1998-05-01	English	Poetry	10	10
33281	Punch, or the London Charivari, Vol. 98, May 31, 1890	2010-07-28	English	English wit and humor -- Periodicals	10	10
3420	Vindication of the Rights of Woman	2002-09-01	English	Women's rights -- Great Britain	10	10
2270	Shakespeare's First Folio	2000-07-01	English	Drama	10	10
1906	Erewhon	1999-09-01	English	Utopias	10	10
62	A Princess of Mars	1993-04-01	English	Mars (Planet) -- Fiction	10	10
1951	The Coming Race	2006-02-19	English	Civilization, Subterranean -- Fiction	10	10
228	The Aeneid--English	1995-03-01	English	Legends -- Rome -- Poetry	10	10
1081	Mertvye dushi. English	1997-10-01	English	Humorous stories	10	10
1200	Gargantua and Pantagruel	2004-08-08	English	Giants -- Fiction	10	10
3748	Voyage au centre de la terre. English	2003-02-01	English	Science fiction	10	10
14851	Uncle Silas--A Tale of Bartram-Haugh	2005-01-31	English	#N/A	10	10
652	Rasselas, Prince of Abyssinia	1996-09-01	English	Princes -- Fiction	10	10
271	Black Beauty	2006-01-16	English	Horses -- Juvenile fiction	10	10
209	The Turn of the Screw	1995-02-01	English	England -- Fiction	10	10
17831	La dÃ©bÃ¢cle	2006-02-22	French	War stories	10	10
103	Around the World in 80 Days	1994-01-01	English	Adventure stories	10	10
1695	The Man Who Was Thursday, a nightmare	1999-04-01	English	Detective and mystery stories	10	10
796	La Chartreuse De Parme	1997-01-01	French	Fiction	10	10
14645	Unleavened Bread	2005-01-10	English	#N/A	10	10
3791	The Reign of Law; a tale of the Kentucky hemp fields	2003-02-01	English	Hemp farmers -- Fiction	10	10
5719	Janice Meredith	2004-05-01	English	#N/A	10	10
5373	Richard Carvel â€” Complete	2004-10-18	English	Maryland -- History -- Fiction	10	10
4097	Alice of Old Vincennes	2003-05-01	English	Orphans -- Fiction	10	10
31	Oedipus Trilogy	2006-03-08	English	Classical literature	10	10
5388	The Crisis â€” Volume 01	2004-10-19	English	United States -- History -- Civil War, 1861-1865 -- Fiction	10	10
14219	Helmet of Navarre	2004-11-30	English	#N/A	10	10
6249	The Right of Way â€” Complete	2004-11-18	English	PS	10	10
6245	The Right of Way â€” Volume 03	2004-08-01	English	PS	10	10
10959	The Visits of Elizabeth	2004-02-01	English	#N/A	10	10
12440	D'Ri and I	2004-05-01	English	#N/A	10	10
4377	Mrs. Wiggs of the Cabbage Patch	2003-08-01	English	Kentucky -- Fiction	10	10
14513	Audrey	2004-12-29	English	#N/A	10	10
2852	The Hound of the Baskervilles	2001-10-01	English	Holmes, Sherlock (Fictitious character) -- Fiction	10	10
3070	The Hound of the Baskervilles	2002-02-01	English	Holmes, Sherlock (Fictitious character) -- Fiction	10	10
3428	The Two Vanrevels	2002-09-01	English	American fiction -- 20th century	10	10
1603	The Blue Flower	1999-01-01	English	Short stories	10	10
23784	The History of Sir Richard Calmady--A Romance	2007-12-09	English	Mothers and sons -- Fiction	10	10
13782	Lady Rose's Daughter	2004-10-18	English	#N/A	10	10
12482	The Mettle of the Pasture	2004-06-01	English	#N/A	10	10
20589	Edgar Allan Poe--Die Dichtung, Band XLII	2007-02-16	German	Poe, Edgar Allan, 1809-1849 -- Appreciation	10	10
481	In the Bishop's Carriage	1996-04-01	English	Crime -- Fiction	10	10
13812	Sir Mortimer	2004-10-20	English	#N/A	10	10
6801	Beverly of Graustark	2004-11-01	English	PS	10	10
14126	The Marriage of William Ashe	2004-11-22	English	#N/A	10	10
14079	Sandy	2004-11-18	English	#N/A	10	10
3637	The Garden of Allah	2006-04-13	English	Africa, North -- Fiction	10	10
13967	Nedra	2004-11-06	English	#N/A	10	10
33490	The Gambler--A Novel	2010-08-22	English	#N/A	10	10
14740	The Princess Passes	2005-01-20	English	Automobiles -- Fiction	10	10
3766	Coniston â€” Complete	2004-10-17	English	New England -- Fiction	10	10
12441	The House of a Thousand Candles	2004-05-01	English	#N/A	10	10
5971	Jane Cable	2004-06-01	English	#N/A	10	10
6315	The Awakening of Helena Richie	2004-08-01	English	#N/A	10	10
13913	The Port of Missing Men	2004-11-01	English	#N/A	10	10
14818	The Daughter of Anderson Crow	2005-01-27	English	#N/A	10	10
14852	The Younger Set	2005-02-01	English	#N/A	10	10
3242	The Doctor : a Tale of the Rockies	2006-06-03	English	Canada -- Fiction	10	10
4790	Half a Rogue	2003-12-01	English	Fiction	10	10
3684	Mr. Crewe's Career â€” Complete	2004-10-16	English	Political fiction	10	10
5122	The Trail of the Lonesome Pine	2004-02-01	English	Love stories	10	10
4516	Peter: a novel of which he is not the hero	2003-10-01	English	New York (N.Y.) -- Fiction	10	10
9779	The Black Bag	2006-01-01	English	#N/A	10	10
14263	Katrine	2004-12-06	English	PS	10	10
14284	Truxton King--A Story of Graustark	2004-12-07	English	#N/A	10	10
14355	54-40 or Fight	2004-12-15	English	#N/A	10	10
1671	When a Man Marries	1999-03-01	English	Fiction	10	10
5129	The Prodigal Judge	2004-02-01	English	PS	10	10
6997	The Winning of Barbara Worth	2004-11-01	English	PS	10	10
14303	Queed	2004-12-08	English	PS	10	10
13813	The Common Law	2004-10-20	English	#N/A	10	10
14394	The Street Called Straight	2004-12-20	English	#N/A	10	10
30115	Tante	2009-09-27	English	Fiction	10	10
26163	Evolution crÃ©atrice. English	2008-08-01	English	Metaphysics	10	10
1440	Woman and Labour	1998-08-01	English	Women -- Social and moral questions	10	10
13985	V. V.'s Eyes	2004-11-08	English	#N/A	10	10
5145	The Heart of the Hills	2004-02-01	English	Bildungsromans	10	10
9879	The Amateur Gentleman	2006-02-01	English	#N/A	10	10
14597	The Woman Thou Gavest Me--Being the Story of Mary O'Neill	2005-01-04	English	#N/A	10	10
2514	T. Tembarom	2001-02-01	English	Man-woman relationships -- Fiction	10	10
15759	Crowds--A Moving-Picture of Democracy	2005-05-03	English	#N/A	10	10
14811	The New Freedom--A Call For the Emancipation of the Generous Energies of a People	2005-01-26	English	#N/A	10	10
11715	The Eyes of the World	2004-03-01	English	#N/A	10	10
4379	The Fortunate Youth	2003-08-01	English	Great Britain -- Fiction	10	10
402	Penrod	2006-03-15	English	Juvenile literature	10	10
6353	The Prince of Graustark	2004-08-01	English	#N/A	10	10
1098	The Turmoil, a novel	1997-11-01	English	Young men -- Fiction	10	10
9489	Michael O'Halloran	2005-12-01	English	City and town life -- Fiction	10	10
9931	K	2006-02-01	English	Mystery fiction	10	10
14669	Jaffery	2005-01-11	English	#N/A	10	10
5229	Felix O'Day	2004-03-01	English	PS	10	10
29932	The Harbor	2009-09-09	English	Fiction	10	10
1027	The Lone Star Ranger, a romance of the border	1997-08-01	English	Fiction	10	10
1611	Seventeen--A Tale of Youth and Summer Time and the Baxter Family Especially William	2006-02-22	English	Fiction	10	10
14060	Mr. Britling Sees It Through	2004-11-16	English	#N/A	10	10
14571	Life and Gabriella--The Story of a Woman's Courage	2005-01-03	English	#N/A	10	10
29571	Nan of Music Mountain	2009-08-02	English	Western stories	10	10
14150	The Light in the Clearing	2004-11-25	English	#N/A	10	10
4287	The Red Planet	2003-07-01	English	World War, 1914-1918 -- England -- Fiction	10	10
4603	In the Wilderness	2006-04-13	English	English fiction -- 20th century	10	10
13883	The Tree of Heaven	2004-10-27	English	#N/A	10	10
1590	The Amazing Interlude	1999-01-01	English	World War, 1914-1918 -- Fiction	10	10
13993	Dere Mable--Love Letters of a Rookie	2004-11-09	English	World War, 1914-1918 -- Humor, caricatures, etc.	10	10
13497	Greatheart	2004-09-18	English	#N/A	10	10
3249	The Major	2006-05-30	English	Canada -- Fiction	10	10
9836	The Pawns Count	2006-02-01	English	Detective and mystery stories	10	10
20072	With the Colors--Songs of the American Service	2006-12-09	English	World War, 1914-1918 -- Poetry	10	10
12418	The Land of Deepening Shadow--Germany-at-War	2004-05-01	English	#N/A	10	10
3194	Mark Twain's Letters â€” Volume 2 (1867-1875)	2004-09-18	English	Authors, American -- 19th century -- Correspondence	10	10
3195	Mark Twain's Letters â€” Volume 3 (1876-1885)	2004-09-18	English	Authors, American -- 19th century -- Correspondence	10	10
3197	Mark Twain's Letters â€” Volume 5 (1901-1906)	2004-09-19	English	Authors, American -- 19th century -- Correspondence	10	10
405	Adventures and Letters of Richard Harding Davis	1996-01-01	English	United States -- History -- 1865-1921	10	10
16685	Private Peat	2005-09-12	English	World War, 1914-1918 -- Personal narratives, Canadian	10	10
10201	The Desert of Wheat	2003-11-01	English	#N/A	10	10
3288	The Sky Pilot in No Man's Land	2006-06-03	English	World War, 1914-1918 -- Fiction	10	10
3265	The Re-Creation of Brian Kent	2006-06-03	English	Ozark Mountains -- Fiction	10	10
18056	The Tin Soldier	2006-03-27	English	World War, 1914-1918 -- Fiction	10	10
14646	Christopher and Columbus	2005-01-10	English	#N/A	10	10
2044	The Education of Henry Adams	2000-01-01	English	Adams, Henry, 1838-1918	10	10
17237	A Man for the Ages--A Story of the Builders of Democracy	2005-12-05	English	Lincoln, Abraham, 1809-1865 -- Fiction	10	10
5815	The Great Impersonation	2006-04-22	English	Spy stories	10	10
13763	The Lamp in the Desert	2004-10-16	English	#N/A	10	10
6467	Letters to His Children	2006-04-22	English	#N/A	10	10
2386	Theodore Roosevelt; an Intimate Biography	2000-11-01	English	Roosevelt, Theodore, 1858-1919	10	10
3317	Now It Can Be Told	2002-07-01	English	World War, 1914-1918 -- Great Britain	10	10
14885	Red Pottage	2005-02-02	English	#N/A	10	10
2799	Eben Holden, a tale of the north country	2001-09-01	English	Farm life -- Fiction	10	10
7031	The Sheik	2004-12-01	English	PR	10	10
1970	A Poor Wise Man	1999-11-01	English	Mystery fiction	10	10
25702	The Kingdom Round the Corner--A Novel	2008-06-05	English	PS	10	10
14145	If Winter Comes	2004-11-24	English	#N/A	10	10
6491	The Head of the House of Coombe	2004-09-01	English	England -- Social life and customs -- Fiction	10	10
14579	Simon Called Peter	2005-01-03	English	#N/A	10	10
32527	The adventures of Alphonso and Marina	2010-05-25	English	#N/A	10	10
1601	The Breaking Point	1999-01-01	English	Fiction	10	10
1265	Queen Victoria	2006-02-19	English	Victoria, Queen of Great Britain, 1819-1901	10	10
3812	The Mirrors of Washington	2003-03-01	English	Washington (D.C.) -- Biography	10	10
14996	Painted Windows--Studies in Religious Personality	2005-02-09	English	#N/A	10	10
17018	The Life and Letters of Walter H. Page, Volume II	2005-11-06	English	Page, Walter Hines, 1855-1918	10	10
27203	MaÃ®trise de soi-mÃªme par l'autosuggestion consciente. English	2008-11-08	English	Mental suggestion	10	10
17498	When Knighthood Was in Flower--or, the Love Story of Charles Brandon and Mary Tudor the King's Sister, and Happening in the Reign of His August Majesty King Henry the Eighth	2006-01-13	English	Suffolk, Charles Brandon, Duke of, d. 1545 -- Fiction	10	10
14001	The Mississippi Bubble	2004-11-10	English	#N/A	10	10
5970	Lovey Mary	2004-06-01	English	#N/A	10	10
21959	Letters from a Self-Made Merchant to His Son--Being the Letters written by John Graham, Head of the House--of Graham & Company, Pork-Packers in Chicago, familiarly--known on 'Change as Old Gorgon Graham, to his Son,--Pierrepont, facetiously known to his intimates as Piggy.	2007-06-28	English	Fathers and sons -- Fiction	10	10
14696	The Wheel of Life	2005-01-15	English	#N/A	10	10
3828	Simon the Jester	2006-04-13	English	Wit and humor	10	10
18665	Molly Make-Believe	2006-06-23	English	Letter writing -- Fiction	10	10
4786	Zone Policeman 88; a close range study of the Panama canal and its workers	2003-12-01	English	Police -- Panama -- Canal Zone	10	10
34297	Angela's Business	2010-11-12	English	#N/A	10	10
10509	The Bars of Iron	2003-12-01	English	#N/A	10	10
5394	The Crisis â€” Volume 07	2004-10-19	English	United States -- History -- Civil War, 1861-1865 -- Fiction	10	10
3193	Mark Twain's Letters â€” Volume 1 (1835-1866)	2004-09-18	English	Authors, American -- 19th century -- Correspondence	10	10
1693	Dangerous Days	1999-04-01	English	Fiction	10	10
19415	Libraries in the Medieval and Renaissance Periods--The Rede Lecture Delivered June 13, 1894	2006-10-01	English	Libraries -- History -- 400-1400	10	10
1961	Books and Bookmen	1999-11-01	English	Books	10	10
16350	Curiosities of Literature,  Vol. 2	2005-07-24	English	Literature	10	10
31078	Curiosities of Literature, Vol. 3	2010-01-25	English	#N/A	10	10
30396	Books and Authors--Curious Facts and Characteristic Sketches	2009-11-02	English	Authors	10	10
22716	The Book-Hunter at Home	2007-09-22	English	Book collecting	10	10
541	The Age of Innocence	1996-05-01	English	Separated people -- Fiction	10	10
4684	The U. P. Trail	2003-11-01	English	Union Pacific Railroad Company -- Fiction	10	10
22136	The Book-Hunter--A New Edition, with a Memoir of the Author	2007-07-24	English	Book collecting	10	10
22606	The Booklover and His Books	2007-09-15	English	Books	10	10
22607	The Book-Hunter in London--Historical and Other Studies of Collectors and Collecting	2007-09-15	English	Book collecting	10	10
22608	A Book for All Readers--An Aid to the Collection, Use, and Preservation of Books--and the Formation of Public and Private Libraries	2007-09-15	English	Library science	10	10
26378	The Care of Books	2008-08-20	English	Library fittings and supplies -- History	10	10
15199	The Reformed Librarie-Keeper (1650)	2005-02-28	English	#N/A	10	10
20416	The Annual Catalogue (1737)--Or, A New and Compleat List of All The New Books, New--Editions of Books, Pamphlets, &c.	2007-01-22	English	English literature -- Bibliography -- Early	10	10
17192	The Raven	2005-11-30	English	Poetry	10	10
4667	Seven Wives and Seven Prisons; Or, Experiences in the Life of a Matrimonial Monomaniac. a True Story	2003-11-01	English	Marriage customs and rites -- United States	10	10
14004	The Every-day Life of Abraham Lincoln--A Narrative And Descriptive Biography With Pen-Pictures And Personal--Recollections By Those Who Knew Him	2004-11-10	English	Lincoln, Abraham, 1809-1865	10	10
813	Reminiscences of Tolstoy	1997-02-01	English	Biography	10	10
12090	The Lives of the Poets of Great Britain and Ireland (1753) Volume V.	2004-04-01	English	Poets, English -- Biography -- Early works to 1800	10	10
6312	Representative Men	2004-08-01	English	Biography	10	10
984	Who Was Who: 5000 BC - 1914 Biographical Dictionary of the Famous and Those Who Wanted to Be	1997-07-01	English	Parodies	10	10
3725	Famous Men of the Middle Ages	2003-02-01	English	Europe -- Biography	10	10
2082	Memoirs of the Comtesse Du Barry; with intimate details of her entire career as favorite of Louis XV	2000-02-01	English	Du Barry, Jeanne BÃ©cu, comtesse, 1743-1793	10	10
4693	Famous Affinities of History, Vol 1-4, Complete--The Romance of Devotion	2003-11-01	English	Biography	10	10
4691	Famous Affinities of History â€” Volume 3--The Romance of Devotion	2003-11-01	English	Women -- Biography	10	10
19767	George Borrow and His Circle--Wherein May Be Found Many Hitherto Unpublished Letters Of--Borrow And His Friends	2006-11-12	English	Borrow, George Henry, 1803-1881	10	10
14555	William Lloyd Garrison--The Abolitionist	2005-01-01	English	Garrison, William Lloyd, 1805-1879	10	10
18757	Prince Henry the Navigator, the Hero of Portugal and of Modern Discovery, 1394-1460 A.D.--With an Account of Geographical Progress Throughout the Middle Ages As the Preparation for His Work.	2006-07-04	English	Henry, Infante of Portugal, 1394-1460	10	10
6702	Life of Harriet Beecher Stowe--Compiled From Her Letters and Journals by Her Son Charles Edward Stowe	2004-10-01	English	Stowe, Harriet Beecher, 1811-1896	10	10
2447	Eminent Victorians	2000-12-01	English	Great Britain -- History -- Victoria, 1837-1901 -- Biography	10	10
12985	Eugene Field, a Study in Heredity and Contradictions â€” Volume 2	2004-07-22	English	Poets, American -- 19th century -- Biography	10	10
16494	The Transvaal from Within--A Private Record of Public Affairs	2005-08-09	English	Jameson's Raid, 1895-1896	10	10
25117	With the Naval Brigade in Natal (1899-1900)--Journal of Active Service	2008-04-21	English	South African War, 1899-1902	10	10
12427	Neutral Rights and Obligations in the Anglo-Boer War	2004-05-01	English	Neutrality	10	10
26198	South Africa and the Transvaal War, Vol. 2--From the Commencement of the War to the Battle of Colenso, 15th Dec. 1899	2008-08-06	English	South African War, 1899-1902	10	10
18794	Strijd tusschen Boer en Brit. English	2006-07-08	English	De Wet, Christiaan Rudolf, 1854-1922	10	10
3069	The Great Boer War	2002-02-01	English	South African War, 1899-1902	10	10
24951	The War in South Africa--Its Cause and Conduct	2008-03-29	English	South African War, 1899-1902	10	10
21302	Charge!--A Story of Briton and Boer	2007-05-04	English	South African War, 1899-1902 -- Fiction	10	10
13855	Une politique europÃ©enne : la France, la Russie, l'Allemagne et la guerre au Transvaal	2004-10-25	French	South Africa -- History -- 1836-1909	10	10
17968	Boer Politics	2006-03-12	English	Transvaal (South Africa) -- Politics and government	10	10
16131	Campaign Pictures of the War in South Africa (1899-1900)--Letters from the Front	2005-06-25	English	South African War, 1899-1902 -- Personal narratives	10	10
32934	The Young Colonists--A Story of the Zulu and Boer Wars	2010-06-20	English	#N/A	10	10
\.


--
-- TOC entry 1980 (class 0 OID 49229)
-- Dependencies: 169 1981
-- Data for Name: prestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY prestamo (uid, isbn, fecha_prestamo, devuelto, puntuacion) FROM stdin;
2772	21391	2013-09-13	1	8
3437	17700	2013-09-13	1	1
1616	5305	2013-09-13	1	7
2772	3810	2013-09-13	1	4
1616	2225	2013-09-13	1	1
3743	711	2013-09-13	1	8
3206	1690	2013-09-13	1	1
3743	11617	2013-09-13	1	3
4999	7937	2013-09-13	1	7
3167	15240	2013-09-13	1	0
4440	17700	2013-09-13	1	7
2071	11772	2013-09-13	1	4
1720	17599	2013-09-13	1	10
3738	17599	2013-09-13	1	10
3167	1711	2013-09-13	1	2
1720	14451	2013-09-13	1	7
1424	2761	2013-09-13	1	4
4728	5760	2013-09-13	1	8
4440	21448	2013-09-13	1	8
1720	15399	2013-09-13	1	3
1616	16280	2013-09-13	1	1
1736	21490	2013-09-13	1	10
4440	21448	2013-09-13	1	1
3738	15399	2013-09-13	1	2
3738	1458	2013-09-13	1	7
3738	21472	2013-09-13	1	3
2772	15042	2013-09-13	1	6
4440	15399	2013-09-13	1	6
4875	2710	2013-09-13	1	5
3437	7937	2013-09-13	1	7
4440	1690	2013-09-13	1	4
4136	1458	2013-09-13	1	0
1616	2857	2013-09-13	1	7
1720	2710	2013-09-13	1	4
2071	21391	2013-09-13	1	7
3206	15399	2013-09-13	1	2
3738	11772	2013-09-13	1	4
3206	11772	2013-09-13	1	4
4440	8564	2013-09-13	1	9
4999	15399	2013-09-13	1	1
1720	1690	2013-09-13	1	6
2068	215	2013-09-13	1	1
3437	1690	2013-09-13	1	8
3738	11772	2013-09-13	1	6
3206	21448	2013-09-13	1	1
1720	16280	2013-09-13	1	10
3167	2710	2013-09-13	1	0
4728	1711	2013-09-13	1	8
4136	21391	2013-09-13	1	9
4875	2761	2013-09-13	1	6
1720	14466	2013-09-13	1	2
1616	1458	2013-09-13	1	7
2772	2761	2013-09-13	1	10
4999	6693	2013-09-13	1	7
3167	21490	2013-09-13	1	0
1616	589	2013-09-13	1	5
4875	6693	2013-09-13	1	5
3738	16280	2013-09-13	1	9
1424	18544	2013-09-13	1	6
3606	11617	2013-09-13	1	0
4999	1458	2013-09-13	1	5
3606	2710	2013-09-13	1	8
2068	12667	2013-09-13	1	3
4999	15240	2013-09-13	1	3
2068	8564	2013-09-13	1	5
3743	2710	2013-09-13	1	7
1736	3657	2013-09-13	1	5
2089	21448	2013-09-13	1	7
3437	3657	2013-09-13	1	7
1736	21472	2013-09-13	1	8
4136	21391	2013-09-13	1	1
1424	15399	2013-09-13	1	1
1435	1458	2013-09-13	1	3
2068	7937	2013-09-13	1	1
2089	2710	2013-09-13	1	10
1435	36791	2013-09-13	1	6
1435	21490	2013-09-13	1	4
2071	21391	2013-09-13	1	1
3437	2681	2013-09-13	1	2
1736	21472	2013-09-13	1	3
2772	2713	2013-09-13	1	5
3743	21254	2013-09-13	1	10
4728	17599	2013-09-13	1	0
4999	16280	2013-09-13	1	3
4440	11772	2013-09-13	1	6
3167	5305	2013-09-13	1	8
3743	17700	2013-09-13	1	1
3437	11772	2013-09-13	1	4
2089	21490	2013-09-13	1	4
2089	23638	2013-09-13	1	8
2772	8564	2013-09-13	1	4
3738	2761	2013-09-13	1	4
1736	3657	2013-09-13	1	4
3606	23638	2013-09-13	1	7
3167	36791	2013-09-13	1	2
1736	23638	2013-09-13	1	3
3738	12428	2013-09-13	1	4
1424	17164	2013-09-13	1	10
4728	21391	2013-09-13	1	6
4999	15399	2013-09-13	1	1
2068	5305	2013-09-13	1	2
2068	18544	2013-09-13	1	7
3206	5157	2013-09-13	1	2
2068	2681	2013-09-13	1	6
1435	2761	2013-09-13	1	8
4440	2225	2013-09-13	1	2
2089	12428	2013-09-13	1	10
4875	21490	2013-09-13	1	8
3167	17700	2013-09-13	1	2
3206	2710	2013-09-13	1	7
3437	21060	2013-09-13	1	9
1736	1441	2013-09-13	1	1
3743	3657	2013-09-13	1	6
4875	3810	2013-09-13	1	7
4999	21060	2013-09-13	1	4
1616	1690	2013-09-13	1	7
1424	2713	2013-09-13	1	0
4440	21391	2013-09-13	1	1
1616	21060	2013-09-13	1	1
4728	21472	2013-09-13	1	5
4875	18544	2013-09-13	1	10
4440	1711	2013-09-13	1	9
1424	2713	2013-09-13	1	6
1424	6886	2013-09-13	1	10
1736	5157	2013-09-13	1	4
2071	2841	2013-09-13	1	1
4440	6886	2013-09-13	1	2
1720	8564	2013-09-13	1	4
3606	7937	2013-09-13	1	3
4999	21472	2013-09-13	1	0
1424	2710	2013-09-13	1	3
4875	21060	2013-09-13	1	7
1616	711	2013-09-13	1	1
3167	5760	2013-09-13	1	4
4440	2759	2013-09-13	1	3
2071	2761	2013-09-13	1	6
3167	589	2013-09-13	1	5
3437	1458	2013-09-13	1	3
4136	1441	2013-09-13	1	6
3738	3810	2013-09-13	1	5
1616	17615	2013-09-13	1	5
3206	5305	2013-09-13	1	5
1424	5157	2013-09-13	1	1
4999	1690	2013-09-13	1	3
3738	2857	2013-09-13	1	2
3437	17599	2013-09-13	1	0
4999	12428	2013-09-13	1	8
4999	15240	2013-09-13	1	9
1424	6693	2013-09-13	1	8
4875	17700	2013-09-13	1	3
3167	15042	2013-09-13	1	5
3606	15042	2013-09-13	1	10
3743	14451	2013-09-13	1	4
2071	21490	2013-09-13	1	2
3738	21472	2013-09-13	1	8
3206	1711	2013-09-13	1	5
3437	7937	2013-09-13	1	6
4728	1441	2013-09-13	1	8
3167	1441	2013-09-13	1	10
4136	21472	2013-09-13	1	1
2772	2225	2013-09-13	1	9
2089	21391	2013-09-13	1	0
3167	2710	2013-09-13	1	1
4136	215	2013-09-13	1	3
3606	11617	2013-09-13	1	10
4999	2225	2013-09-13	1	4
2068	3810	2013-09-13	1	9
2772	14466	2013-09-13	1	4
4728	21472	2013-09-13	1	9
1435	17164	2013-09-13	1	8
2089	2857	2013-09-13	1	7
2071	1441	2013-09-13	1	10
3743	21472	2013-09-13	1	6
1736	2713	2013-09-13	1	0
3206	2761	2013-09-13	1	3
3437	5760	2013-09-13	1	3
3738	17700	2013-09-13	1	7
4728	21254	2013-09-13	1	1
3167	15240	2013-09-13	1	2
3167	21490	2013-09-13	1	3
1736	15399	2013-09-13	1	10
2068	6693	2013-09-13	1	0
3738	11772	2013-09-13	1	4
4728	11617	2013-09-13	1	10
4728	12428	2013-09-13	1	0
3738	6886	2013-09-13	1	9
4728	16280	2013-09-13	1	10
1435	1690	2013-09-13	1	2
3738	17700	2013-09-13	1	4
3743	21472	2013-09-13	1	8
4999	21899	2013-09-13	1	2
1736	2710	2013-09-13	1	0
2068	6886	2013-09-13	1	8
3606	2761	2013-09-13	1	0
4875	21391	2013-09-13	1	8
3167	21899	2013-09-13	1	2
2068	14466	2013-09-13	1	10
1435	21448	2013-09-13	1	2
1424	1441	2013-09-13	1	3
\.


--
-- TOC entry 1976 (class 0 OID 49186)
-- Dependencies: 165 1981
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
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 164
-- Name: traductor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('traductor_id_seq', 42, true);


--
-- TOC entry 1979 (class 0 OID 49221)
-- Dependencies: 168 1981
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (uid, nombre, sexo, edad, activado) FROM stdin;
2071	Pat	M	45	1
1424	Joseph	H	59	1
1435	Jordi	H	22	1
3437	Susan	M	64	1
3738	Gabriel	H	38	1
4440	Kate	M	32	1
4875	Sean	H	53	1
1616	Rosa	M	39	1
4999	Celia	M	57	1
1736	Juan	H	33	1
4136	Eduardo	H	41	1
4728	Thomas	H	54	1
2068	Leonard	H	65	1
3167	Ana	M	78	1
3743	Roberto	H	52	1
2089	Mar	M	66	1
1720	Nacho	H	39	1
3206	Bob	H	15	1
2772	Daniel	H	58	1
3606	Freddy	H	57	1
69165	Angel	H	20	1
\.


--
-- TOC entry 1860 (class 2606 OID 49183)
-- Dependencies: 163 163 1982
-- Name: autor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id);


--
-- TOC entry 1858 (class 2606 OID 49172)
-- Dependencies: 161 161 1982
-- Name: libro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY libro
    ADD CONSTRAINT libro_pkey PRIMARY KEY (isbn);


--
-- TOC entry 1862 (class 2606 OID 49194)
-- Dependencies: 165 165 1982
-- Name: traductor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY traductor
    ADD CONSTRAINT traductor_pkey PRIMARY KEY (id);


--
-- TOC entry 1864 (class 2606 OID 49228)
-- Dependencies: 168 168 1982
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (uid);


--
-- TOC entry 1866 (class 2606 OID 49203)
-- Dependencies: 163 166 1859 1982
-- Name: isbnrautor_id_autor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrautor
    ADD CONSTRAINT isbnrautor_id_autor_fkey FOREIGN KEY (id_autor) REFERENCES autor(id);


--
-- TOC entry 1865 (class 2606 OID 49198)
-- Dependencies: 1857 166 161 1982
-- Name: isbnrautor_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrautor
    ADD CONSTRAINT isbnrautor_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1868 (class 2606 OID 49216)
-- Dependencies: 1861 165 167 1982
-- Name: isbnrtraductor_id_traductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrtraductor
    ADD CONSTRAINT isbnrtraductor_id_traductor_fkey FOREIGN KEY (id_traductor) REFERENCES traductor(id);


--
-- TOC entry 1867 (class 2606 OID 49211)
-- Dependencies: 1857 167 161 1982
-- Name: isbnrtraductor_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isbnrtraductor
    ADD CONSTRAINT isbnrtraductor_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1870 (class 2606 OID 49237)
-- Dependencies: 1857 169 161 1982
-- Name: prestamo_isbn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT prestamo_isbn_fkey FOREIGN KEY (isbn) REFERENCES libro(isbn);


--
-- TOC entry 1869 (class 2606 OID 49232)
-- Dependencies: 169 168 1863 1982
-- Name: prestamo_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY prestamo
    ADD CONSTRAINT prestamo_uid_fkey FOREIGN KEY (uid) REFERENCES usuario(uid);


--
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-11-10 21:24:56 CET

--
-- PostgreSQL database dump complete
--

