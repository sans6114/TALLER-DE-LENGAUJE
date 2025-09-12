program ejercicio03;
type
	pAlmacenar = record // registro de arbol
		codigo: integer;
		unidades: integer;
		monto: real;
	end;
	venta = record //registro de lectura
		codigo: integer;
		codigoP: integer;
		unidades: integer;
		precioUnitario: real;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record 
		ele: pAlmacenar;
		HI: arbol;
		HD: arbol;
	end;
procedure leerV(var v: venta);
begin
	writeln('ingrese el codigo de venta: ');
	readln(v.codigo);
	if(v.codigo <> -1) then begin
		writeln('ingrese el codigo del producto que se vendio: ');
		readln(v.codigoP);
		writeln('ingrese las unidades vendidas');
		readln(v.unidades);
		writeln('ingrese el precio por unidad del producto: ');
		readln(v.precioUnitario);
	end;
end;
procedure agregar(var a: arbol; v: venta);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.codigo:= v.codigoP;
		a^.ele.unidades:= v.unidades;
		a^.ele.monto:= v.unidades * v.precioUnitario;
	end
	else begin
		if(v.codigoP = a^.ele.codigo) then begin
			a^.ele.unidades:= a^.ele.unidades + v.unidades;
			a^.ele.monto:= a^.ele.monto + (v.unidades * v.precioUnitario)
		end
		else if (v.codigoP < a^.ele.codigo) then begin
			agregar(a^.HI, v);
		end
		else begin
			agregar(a^.HD, v);
		end;
	end;
end;
procedure almacenar(var a: arbol);
var 
	ventaActual: venta;
begin
	leerV(ventaActual);
	while (ventaActual.codigo <> -1) do begin
		agregar(a, ventaActual);
		leerV(ventaActual);
	end;
end;
procedure imprimir(a: arbol);
begin
	if(a<>nil) then begin
		imprimir(a^.HI);
		writeln(a^.ele.codigo);
		writeln(a^.ele.unidades);
		writeln(a^.ele.monto); // ----> imprime de izquierda a derecha (en orden)
		imprimir(a^.HD); // --- > si quisiera imprimir de derecha(nodo mas grande) hacia izquierda (nodo mas chico) podria hacer un "inOrder" pero llamando primero con HD.
	end;
end;
procedure maximo( a : arbol; var maxUnidades: integer ;var codigoMax: integer); // cuando tengo que obtener un maximo a partir de un dato que no es el orden de ordenamiento del arbol, hay que usar proceso si o si.
begin
	if(a <> nil) then begin
		if(a^.ele.unidades > maxUnidades) then begin
			maxUnidades:= a^.ele.unidades;
			codigoMax:= a^.ele.codigo;
		end;
		maximo(a^.HI, maxUnidades, codigoMax);
		maximo(a^.HD, maxUnidades, codigoMax);
	end;
end;
function menoresA(a: arbol; x: integer): integer; // si es una cantidad dentro del arbol, se puede hacer con funcion (y es por el orden de ordenamiento)
begin
	if(a = nil) then begin //caso base
		menoresA:= 0;
	end
	else begin // caso recursion
		if( a^.ele.codigo < x) then begin // caso que mi condicion sea verdadera
			menoresA:= 1 + menoresA(a^.HI,x) + menoresA(a^.HD,x);
		end
		else begin // en ese caso llamamos con HI porque no hace falta fijarse con rama derecha. No tiene sentido ya que si en el nodo donde estoy parado es mas grande el siguiente derecho sera mas grande aun.
			menoresA:= menoresA(a^.HI,x);
		end;
	end;
end;
function retornarMonto (a: arbol; cotaMin, cotaMax: integer): real;
begin
	if(a = nil) then begin
		retornarMonto:= 0;
	end
	else begin
		if(a^.ele.codigo > cotaMin) then begin
			if(a^.ele.codigo < cotaMax) then begin
				retornarMonto:= a^.ele.monto + retornarMonto(a^.HI, cotaMin, cotaMax) + retornarMonto(a^.HD, cotaMin, cotaMax);//esta en rango y posiblemente las dos ramas estaran en rango.
			end
			else begin
				retornarMonto:= retornarMonto(a^.HI, cotaMin, cotaMax); // si no entro en el if de arriba, el nodo tiene un codigo mayor a la cotamin, pero mayor a la cotaMax.
			end;
		end
		else begin
			retornarMonto:= retornarMonto(a^.HD, cotaMin, cotaMax);
		end;
	end;
end;
var
	codigoMax, cantMax: integer;
	arbolProductos: arbol;
BEGIN
	almacenar(arbolProductos);
	imprimir(arbolProductos);
	cantMax:= -1;
	maximo(arbolProductos, cantMax, codigoMax);
	menoresA(arbolProductos, 10); // ---> esta funcion devuelve cuantos nodos del arbol tienen codigo menos a 10.
	retornarMonto(arbolProductos, 10, 20);
END.
