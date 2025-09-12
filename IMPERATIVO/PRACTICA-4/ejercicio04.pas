program ejericicio04;
type
	mesDelAno = 1..12;
	diaMes = 1..12;
	prestamo = record 
		ISBN: integer;
		numSocio: integer;
		dia: diaMes;
		mes: mesDelAno; 
		duracion: integer; // ---> (dias)
	end;
	registroLista = record 
		numSocio: integer;
		dia: diaMes;
		mes: mesDelAno;
		duracion: integer; 
	end;
	lista = ^nodoLista;
	nodoLista = record 
		ele: registroLista;
		sig: lista;
	end;
	registroArbol2 = record 
		ISBN: integer;
		lista: lista;
	end;
	arbol1 = ^nodoArbol1;
	nodoArbol1 = record 
		ele: prestamo;
		HI: arbol1;
		HD: arbol1;
	end;
	arbol2 = ^nodoArbol2;
	nodoArbol2 = record 
		ele: registroArbol2;
		HI: arbol2;
		HD: arbol2;
	end;
	datosListaISBN = record 
		ISBN: integer;
		vecesPrestadas: integer;
	end;
	listaISBN = ^nodoListaISBN;
	nodoListaISBN = record 
		ele: datosListaISBN;
		sig: listaISBN;
	end;
procedure leerP(var p: prestamo);
begin
	writeln('ingrese el ISBN (IDENTIFICADOR) del libro que se presto: ');
	readln(p.ISBN);
	if(p.ISBN <> 0) then begin
		writeln('ingrese el numero se socio al que se le presto el libro: ');
		readln(p.numSocio);
		writeln('ingrese el dia en que se realizo el prestamo ');
		readln(p.dia);
		writeln('ingrese el mes en que se realizo el prestamo ');
		readln(p.mes);
		writeln('ingrese la duracion del prestamo ');
		readln(p.duracion);
	end;
end;
procedure agregarA1(var a: arbol1; p: prestamo);
begin
	if(a = nil) then begin
		new(a);
		a^.ele:= p;
		a^.HI:= nil;
		A^.HD:= nil;
	end
	else begin
		if(p.ISBN < a^.ele.ISBN) then begin
			agregarA1(a^.HI,p);
		end
		else begin
			agregarA1(a^.HD,p);
		end;
	end;
end;
procedure agregarL(var l: lista; p: prestamo);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.ele.numSocio:= p.numSocio;
	nuevo^.ele.dia:= p.dia;
	nuevo^.ele.mes:= p.mes;
	nuevo^.ele.duracion:= p.duracion;
	nuevo^.sig:= l;
	l:= nuevo;
end;
procedure agregarA2(var a: arbol2; p: prestamo);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.ISBN:= p.ISBN;
		a^.ele.lista:= nil;
		agregarL(a^.ele.lista, p);
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(a^.ele.ISBN = p.ISBN) then begin
			agregarL(a^.ele.lista, p);
		end 
		else if(p.ISBN < a^.ele.ISBN) then begin
			agregarA2(a^.HI,p);
		end
		else begin
			agregarA2(a^.HD,p);
		end;
	end;
end;
procedure cargarArboles(var a1: arbol1; var a2: arbol2);
var
	prestamoActual: prestamo;
begin
	leerP(prestamoActual);
	while(prestamoActual.ISBN <> 0) do begin
		agregarA1(a1, prestamoActual);
		agregarA2(a2, prestamoActual);
		leerP(prestamoActual);
	end;
end;
function retornarMasGrande(a: arbol1): integer;
begin
	if(a^.HD = nil)then begin
		retornarMasGrande:= a^.ele.ISBN;
	end
	else begin
		retornarMasGrande:= retornarMasGrande(a^.HD); // me muevo al nodo que este mas a la derecha.
	end;
end;
function retornarMasPequeno(a: arbol2): integer;
begin
	if(a^.HI = nil) then begin
		retornarMasPequeno:= a^.ele.ISBN;
	end 
	else begin
		retornarMasPequeno:= retornarMaspequeno(a^.HI);
	end;
end;
function cantidadPorSocio(a: arbol1; socio: integer): integer;
begin
	if( a = nil)then begin
		cantidadPorSocio:= 0;
	end
	else begin
		if(a^.ele.numSocio = socio) then begin
			cantidadPorSocio:= 1 + cantidadPorSocio(a^.HI, socio) + cantidadPorSocio(a^.HD, socio);
		end
		// esto estaria mal ---> cantidadPorSocio:= cantidadPorSocio(a^HI, socio) + cantidadPorSocio(a^HD, socio);
		//sobrescribe el valor anterior si el numSocio coincide, codigo correcto: 
		else begin // el else es clave <----
			cantidadPorSocio:= cantidadPorSocio(a^.HI, socio) + cantidadPorSocio(a^.HD, socio);
		end;
	end;
end;
function contadorDeNodos(l: lista; socio: integer): integer;
var
	cant: integer;
begin
	cant:= 0;
	while (l <> nil) do begin
		if(l^.ele.numSocio = socio) then begin
			cant:= cant + 1;
		end;
		l:= l^.sig;
	end;
	contadorDeNodos:= cant;
end;
function cantidadPorSocio2(a: arbol2; socio: integer): integer;
begin
	if( a = nil)then begin
		cantidadPorSocio2:= 0;
	end
	else begin
		cantidadPorSocio2:= contadorDeNodos(a^.ele.lista, socio) + cantidadPorSocio2(a^.HI, socio) + cantidadPorSocio2(a^.HD, socio);
	end;
end;
procedure agregarListaISBN(var l: listaISBN; ISBN: integer);
var
	nuevo: listaISBN;
begin
	new(nuevo);
	nuevo^.ele.ISBN:= ISBN;
	nuevo^.ele.vecesPrestadas:= 1;
	nuevo^.sig:= l;
	l:= nuevo; 
end;
procedure actualizarL(var l: listaISBN; ISBN: integer);
var
	encontre: boolean;
	aux: listaISBN;
begin
	encontre:= false;
	aux:= l;
	while( (aux <> nil) and (not encontre)) do begin
		if(l^.ele.ISBN = ISBN) then begin
			l^.ele.vecesPrestadas:= l^.ele.vecesPrestadas + 1;
			encontre:= true;
		end;
	end;
	if(not encontre) then begin
		agregarListaISBN(l, ISBN);
	end;
end;
procedure crearListaISBN(a: arbol1; var l: listaISBN );
begin
	if(a<>nil) then begin
		crearListaISBN(a^.HD, l); // ---> llamo primero a la rama derecha para agregar delante los mas grandes y luego los mas chicos.
		actualizarL(l, a^.ele.ISBN);
		crearListaISBN(a^.HI, l);	
	end;
end;
var
	arbolPrestamos: arbol1;
	arbolISBN: arbol2;
	listaISBNNueva: listaISBN;
begin
	arbolPrestamos:= nil;
	arbolISBN:= nil;
	cargarArboles(arbolPrestamos, arbolISBN);
	retornarMasGrande(arbolPrestamos);
	retornarMasPequeno(arbolISBN);
	cantidadPorSocio(arbolPrestamos,10); // ejemplo con num de socio 10. el modulo retornara cuantos prestamos fueron solicitados con ese numSocio.
	cantidadPorSocio2(arbolISBN, 10);
	listaISBNNueva:= nil;
	crearListaISBN(arbolPrestamos, listaISBNNueva);
end.
