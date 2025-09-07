program ejercicio01;
type 
	lista = ^nodo;
	nodo = record 
		ele: integer;
		sig: lista;
	end;
procedure agregarNodo(var l: lista; num: integer);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.ele:= num;
	nuevo^.sig:= l;
	l:= nuevo;  
end;
procedure cargarL(var l: lista);
var 
	num: integer;
begin
	num:= random(200 - 100 + 1) + 100;
	agregarNodo(l, num); //agrego el nodo siempre antes de llamada recursiva.
	if(num <> 100) then begin
		cargarL(l);
	end;
end;
procedure imprimirEnOrden(l: lista);
begin
	if(l <> nil) then begin
		writeln(l^.ele);
		imprimirEnOrden(l^.sig); 
	end;
end;
procedure imprimirEnInverso(l: lista);
begin
	if(l <> nil) then begin
		imprimirEnInverso(l^.sig);
		writeln(l^.ele);
	end;
end;
function minimo(l: lista): integer;
var
	minResto: integer;
begin
	if(l^.sig = nil) then begin
		minimo:= l^.ele;
	end
	else begin
		minResto:= minimo(l^.sig);
		if(l^.ele < minResto) then begin
			minimo:= l^.ele;
		end
		else begin
			minimo:= minResto;
		end;
	end;
end;
function isOnList(l: lista; valor: integer):boolean;
begin
	if(l = nil) then begin
		isOnList:= false;
	end
	else if(l^.ele = valor) then begin
		isOnList:= true;
	end
	else begin
		isOnList:= isOnList(l^.sig, valor);
	end;
end;
var
	listaEnteros: lista;
begin
	randomize;
	listaEnteros:= nil;
	cargarL(listaEnteros);
	imprimirEnOrden(listaEnteros);
	imprimirEnInverso(listaEnteros);
	writeln(minimo(listaEnteros));
	writeln(isOnList(listaEnteros,100));
end.
