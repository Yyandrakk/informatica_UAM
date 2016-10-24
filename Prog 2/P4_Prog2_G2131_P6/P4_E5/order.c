#include "order.h"

STATUS preOrderToFile(FILE* pf, BSTREE* pt)
{
	if ((!pf) || (!pt))
		return ERROR;

	if (isEmptyBSTree(pt) == TRUE)
		return ERROR;
	
	printNodeBTree(pf,*pt);
	
	preOrderToFile(pf,&LEFT(*pt));
	preOrderToFile(pf,&RIGHT(*pt));
	
	return OK;
}

STATUS inOrderToFile(FILE* pf, BSTREE* pt)
{
	if ((!pf) || (!pt))
		return ERROR;

	if (isEmptyBSTree(pt) == TRUE)
		return ERROR;
	
	inOrderToFile(pf, &LEFT(*pt));
	printNodeBTree(pf,*pt);
	inOrderToFile(pf, &RIGHT(*pt));
	
	return OK;
}

STATUS postOrderToFile(FILE* pf, BSTREE* pt)
{
	if ((!pf) || (!pt))
		return ERROR;

	if (isEmptyBSTree( pt) == TRUE)
		return ERROR;
		
	postOrderToFile(pf,&LEFT(*pt));
	postOrderToFile(pf,&RIGHT(*pt));
	
	printNodeBTree(pf,*pt);
	
	return OK;
}

/**--------------------------------------------------
* @name preOrderToList
* @brief: Devuelve un recorrido de un árbol en orden previo como lista.
*------------------------------------------------------*/
STATUS preOrderToList(LIST* pl, BSTREE* pt)
{
        
        if ((!pl) || (!pt))
		return ERROR;

	if (isEmptyBSTree(pt) == TRUE)
		return ERROR;
	
	insertLastEleList(pl, INFO(*pt));
	
	preOrderToList(pl,&LEFT(*pt));
	preOrderToList(pl,&RIGHT(*pt));
	
	return OK;
}