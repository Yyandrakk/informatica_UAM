all: p4a.com p4c.exe
p4a.com: p4a.obj
	tlink /t p4a.obj
p4a.obj: p4a.asm
	tasm /zi p4a.asm	
p4c.exe: p4c.obj
	tlink /v p4c
p4c.obj: p4c.asm
	tasm /zi p4c.asm