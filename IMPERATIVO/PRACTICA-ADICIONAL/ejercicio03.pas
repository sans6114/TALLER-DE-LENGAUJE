program ejercicio03;
type
	mesDelAno = 1..12;
	//registro de lectura
	compra = record
		codigo: integer;
		codigoCliente:integer;
		mes: mesDelAno;
	end;
	registroLista = record
		codigoCliente: integer;
		mes: mesDelAno;
	end;
	listaArbol1 = ^nodoLista1;
	nodoLista1 = record 
		ele: registroLista;
		sig: listaArbol1;
	end; 
	//registro perteneciente al arbol
	registroArbol1 = record 
		codigo: integer;
		l: listaArbol1;
	end;
	a1 = ^nodoArbol1;
	nodoArbol1 = record 
		ele: registroArbol1;
		HI: a1;
		HD: a1;
	end;
procedure leerCompra(var c: compra);
begin
	writeln('Ingrese el codigo de cliente 0 para finalizar:');
	writeln('Ingrese el codigo de cliente: ');
    readln(c.codigo);
    write('Ingrese el codigo de cliente que realizo la compra: ');
    readln(c.codigoCliente);
    if (c.codigoCliente <> 0) then
    begin
        write('Ingrese el mes de la compra: ');
        readln(c.mes);
        writeln('-----------------------------------');
    end;
end;
procedure agregarL(var l: listaArbol1; c: compra);
var
	nuevo: listaArbol1;
begin
	new(nuevo);
	nuevo^.ele.codigoCliente:= c.codigoCliente;
	nuevo^.ele.mes:= c.mes;
	nuevo^.sig:= l;
	l:= nuevo;
end;
procedure agregarA1(var a: a1; c: compra);
begin
	if(a = nil) then begin
		a^.ele.codigo:= c.codigo;
		a^.ele.l:= nil;
		agregarL(a^.ele.l, c);
		a^.HI:= nil;
		a^.HD:= nil; 
	end
	else begin
		if (a^.ele.codigo = c.codigo) then begin
			// hay que modificar el nodo del codigo correspondiente.
			agregarL(a^.ele.l, c);
		end 
		else if (c.codigo < a^.ele.codigo) then begin
			agregarA1(a^.HI, c);
		end
		else begin
			agregarA1(a^.HD, c);
		end;
	end;
end;
procedure cargarArbol(var a: a1);
var
	compraActual: compra;
begin
	leerCompra(compraActual);
	while(compraActual.codigoCliente <> 0) do begin
		agregarA1(a, compraActual);
		leerCompra(compraActual);
	end;
end;
function retornarPorCod(a: a1; codigo: integer): listaArbol1;
begin
	if(a = nil) then begin
		retornarPorCod:= nil; // caso base, retorno nil.
	end
	else begin
		if(a^.ele.codigo = codigo) then begin
			retornarPorCod:= a^.ele.l;
		end
		else if(codigo < a^.ele.codigo) then begin
			retornarPorCod(a^.HI, codigo);
		end
		else begin
			retornarPorCod(a^.HD, codigo);
		end;
	end;
end;
function retornarComprasPorMes(l: listaArbol1; mes: integer): integer;

begin
	if (l = nil) then begin
		retornarComprasPorMes:= 0;
	end
	else begin
		if(l^.ele.mes = mes) then begin
			retornarComprasPorMes:= 1 + retornarComprasPorMes(l^.sig, mes);
		end
		else begin
			retornarComprasPorMes:= retornarComprasPorMes(l^.sig, mes);
		end;
	end;
end;
var
	listaVideoJuegos: listaArbol1;
	arbolCompras: a1;
begin
	arbolCompras:=nil;
	cargarArbol(arbolCompras);
	listaVideoJuegos:= retornarPorCod(arbolCompras, 1010); // en "listaVideojuego" se almacenara la lista (nodo inicial) de las compras hechas para ese juego.
	writeln(retornarComprasPorMes(listaVideoJuegos, 1)); // retornara cuantas compras hubo del juego 1010 en enero.
end.
