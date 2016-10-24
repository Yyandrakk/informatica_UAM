all: p4a.com p4b.exe
p4a.com: p4a.obj
	tlink /t p4a.obj
p4a.obj: p4a.asm
	tasm /zi p4a.asm	
p4b.exe: p4b.obj
	tlink /v p4b
p4b.obj: p4b.asm
	tasm /zi p4b.asm