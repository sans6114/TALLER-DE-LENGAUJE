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
		agregarL(a^.ele.lista, f);
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
procedure cantidadLegajoImpar(a: arbol; var c: integer);
begin
	if(a <> nil) then begin
		if(esLegajoImpar(a^.ele.legajo)) then begin
			c:= c + 1;
		end;
		cantidadLegajoImpar(a^.HI, c);
		cantidadLegajoImpar(a^.HD, c);
	end
end;
function cantidadImpar(a: arbol): integer;
begin
	if(a = nil) the begin //caso base --- > llegue al final
		cantidadImpar:= 0;
	end 
	else begin
		cantidadImpar:= cantidadImpar(a^.HI) + cantidadImpar(a^.HD);
		
		if not( a^.ele.legajo MOD 2 = 0) then begin
			// es impar
			cantidadImpar:= cantidadImpar + 1;
		end;
	end;
end;
procedure informarNota(a: arbol);
var
	aprobados: integer;
	aux: lista;
begin
	if(a <> nil) then begin
		aprobados:= 0;
		aux:= a^.ele.lista;
		while(aux <> nil) do begin
			if(aux.nota > 4) then begin
				aprobados:= aprobados + 1;
			end;
			aux:= aux^.sig;
		end;
		writeln('legajo: ', a^.ele.legajo, ' finales aprobados: ', aprobados);
		informarNota(a^.HI);
		informarNota(a^.HD);
	end;
end;
var
	cant: integer;
	arbol1: arbol;
begin
	arbol1:= nil;
	cargarArbol(arbol1);
	cant:= 0;
	cantidadLegajoImpar(arbol1, cant);
	writeln(cant);
end;
