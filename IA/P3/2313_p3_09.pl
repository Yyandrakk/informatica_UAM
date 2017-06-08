%Ejercicio 1
%
% pertenece(X, L)
%   Comprueba si el elemento X pertenece a la lista L.
pertenece(X,[X|_]).
pertenece(X,[_|Ys]) :- pertenece(X,Ys).


%Ejercicio 2
%
% concatena(L1, L2, R)
%   Comprueba si R contiene la concatenacion de L1 y L2.
concatena([], L, L).
concatena([X|L1], L2, [X|L3]) :-
concatena(L1, L2, L3).

% invierte(L,R)
%   Comprueba si R contiene los mismos elementos que L, pero en orden inverso.
invierte([], []).
invierte([X|XS],R):- invierte(XS,Z),
                     concatena(Z,[X],R).


%Ejercicio 3
%
% reorder(Tree,List)
% inorder(Tree,List)
% postorder(Tree, List)
%   Recorren un arbol Tree segun la estrategia y guardan el recorrido en List.
inorder(nil,[]).
inorder(tree(Info,Left,Rigth),L) :- inorder(Left,XS),
                                    inorder(Rigth,YS),
                                    concatena(XS,[Info],ZS),
                                    concatena(ZS,YS,L).

postorder(nil,[]).
postorder(tree(Info,Left,Rigth),L) :- postorder(Left,XS),
                                      postorder(Rigth,YS),
                                      concatena(YS,[Info],ZS),
                                      concatena(XS,ZS,L).

preorder(nil,[]).
preorder(tree(Info,Left,Rigth),L) :- preorder(Left,XS),
                                     preorder(Rigth,YS),
                                     concatena([Info|XS],YS,L).


%Ejercicio 4
%
% insertar(X,L,P,R)
%   Inserta un elemento X en una Lista L, en la posicion P (desplazando los demas
%   elementos), y guarda el Resultado en R.
insertar(X, L, 1, [X | L]).
insertar(X, [L | LS], P, [L | RS]) :- % dejamos el primer elemento del resultado (primero de esta iteracion) como primer elemento del input
                                      P > 1,
                                      P2 is P - 1,
                                      insertar(X, LS, P2, RS).


%Ejercicio 5
%
% ​extract(L1,X,L2)
%   Extrae el elemento X de la lista L1, dejando el resultado en L2.
extract([X|L1],X,L1).
extract([Y|L1],X,[Y|L2]):- extract(L1,X,L2).


%Ejercicio 6
%
% Preferencias para el problema de los matrimonios estables.
man_pref(juan,[maria,carmen,pilar]).
man_pref(pedro,[carmen,maria,pilar]).
man_pref(mario,[maria,carmen,pilar]).

woman_pref(maria,[juan,pedro,mario]).
woman_pref(carmen,[pedro,juan,mario]).
woman_pref(pilar,[juan,pedro,mario]).


%Ejercicio 7
%
% pos(X,L,R)
%   Obtiene la posicion del elemento X en la lista L, y lo devuelve en R.
pos(X,[X|_],1).
pos(X,[_|R],N):- pos(X,R,M), N is M+1.

% unstable(M1-W1,Marriages)
%   Comprueba si un matrimonio candidato M1-W1 seria inestable, a partir de una
%   lista de matrimonios ya formados.
unstable(M1-W1,Marriages):- pertenece(M2-W2,Marriages), % En M2-W2 tendremos todos los pares contenidos en Marriages (evitamos recursion explicita)
                            man_pref(M1,MS), woman_pref(W2,WS),
                            pos(W2,MS,POSW2), pos(W1,MS,POSW1), POSW2<POSW1, % Si el hombre M1 prefiere a W2 antes que a su propia mujer W1
                            pos(M1,WS,POSM1), pos(M2,WS,POSM2), POSM1<POSM2. % y si la mujer W2 prefiere a M1 antes que a su propio marido M2


%Ejercicio 8
%
% smp(FreeMen,FreeWomen,MarriagesIn,MarriagesOut)
%   Calcula la lista de matrimonios estables entre FreeMen y FreeWomen, y los devuelve en MarriagesOut.
smp(_,[],_,[]).
smp(FreeMen,[W|WS],MarriagesIn,MarriagesOut):- pertenece(M,FreeMen), % Recursion implicita: M es cada valor de FreeMen
                                               not(unstable(M-W,MarriagesIn)),
                                               extract(FreeMen,M,RestM), smp(RestM,WS,[M-W|MarriagesIn],Out), % Llamada recursiva sobre el resto
                                               concatena(Out,[M-W],MarriagesOut). % Orden inverso
