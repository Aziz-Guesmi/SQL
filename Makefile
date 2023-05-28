flex :	
	flex projet.l
bison :	
	bison -d projet.y

compile : 
	gcc projet.tab.c -o prog

exec : 
	./prog
