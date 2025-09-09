program ejercicio03;
type
	diaMes = 1..31;
	nota = 1..10;
	final = record
		legajo: integer;
		materia: integer;
		fecha: diaMes;
		nota: nota;
	end;
	registroArbol = record 
		legajo: integer;
		lista: lista;
	end;
	registroLista = record
		materia: integer;
		fecha: diaMes;
		nota: nota;
	end;
	nodoLista = record
		ele: registroLista;
		sig: lista;
	end;
	lista = ^nodoLista;
	
	arbol = ^nodo;
	nodo = record
		ele: registroArbol;
		HI: arbol;
		HD: arbol;
	end;
procedure leerFinal(var f: final);
begin
	writeln('Ingrese numero de legajo (0 para finalizar):');
    readln(f.legajo);
    if (f.legajo <> 0) then begin
        writeln('Ingrese codigo de materia:');
        readln(f.materia);
        writeln('Ingrese fecha (dia del mes):');
        readln(f.fecha);
        writeln('Ingrese nota (1-10):');
        readln(f.nota);
    end;
end;
procedure cargarArbol(var a: arbol);
var
	finalActual: final; 
begin
	leerFinal(finalActual);
	while (finalActual.legajo <> 0) do begin
		agregar(a, finalActual);
		leerFinal(finalActual);
	end;
end;
procedure agregarL(var l: lista; f: final);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.ele.materia:= f.materia;
	nuevo^.ele.nota:= f.nota;
	nuevo^.ele.fecha:= f.fecha;
	nuevo^.sig:= l;
	l:= nuevo;
end;
procedure agregar(var a: arbol; f: final);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.legajo:= f.legajo;
		a^.ele.lista:= nil;
		a^.ele.lista:= agregarL(a^.ele.lista, f);
	end
	else begin
		if(f.legajo = a^.ele.legajo) then begin
			agregarL(a^.ele.lista, f);
		end
		else if(f.legajo < a^.ele.legajo) then begin 
			agregar(a^.HI, f);
		end
		else begin
			agregar(a^.HD, f);
		end;
	end;
end;
var
	arbol1: arbol;
begin
	arbol1:= nil;
	cargarArbol(arbol1);
end;
