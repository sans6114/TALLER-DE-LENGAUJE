program ejercicio02;
type
	diaMes = 1..31;
	ventaSinCodigo = record 
		unidades: integer;
		fecha: diaMes;
	end;
	listaVentas = ^nodoLista;
	nodoLista = record 
		ele: ventaSinCodigo;
		sig: listaVentas;
	end;
	venta = record 
		codigo: integer;
		unidades: integer;
		fecha: diaMes;
	end; // ---> registro de lectura
	producto = record
		codigo: integer;
		unidades: integer;
	end; // ---> registro para arbol 2 (arbol de productos)
	productoConLista = record
		codigo: integer;
		lista: listaVentas;
	end; // ---> registro para arbol3 (arbol de productos con lista de ventas)

	
	
	arbol1 = ^nodoArbol1; // ----> tipo de arbol 1, contiene datos de tipo venta.
	nodoArbol1 = record
		ele: venta;
		HI: arbol1;
		HD: arbol1;
	end;
	arbol2 = ^nodoArbol2;
	nodoArbol2 = record
		ele: producto;
		HI: arbol2;
		HD: arbol2;
	end;
	arbol3 = ^nodoArbol3;
	nodoArbol3 = record
		ele: productoConLista;
		HI: arbol3;
		HD: arbol3;
	end;
procedure generarInfoAleatoria(var v: venta);
begin
	v.codigo:= random(10) + 1; //codigo aleatorio de 1 a 10;
	v.fecha:= random(31) + 1; //fecha entre 1 a 31 simulando dia del mes
	v.unidades:= random(100) + 1; //simulo un rango de entre 1 a 100 unidades.
	writeln('venta aleatoria generada: ');
	writeln('codigo de producto: ', v.codigo);
end;
procedure agregar1(var a: arbol1; v: venta);
begin
	if(a = nil) then begin
		new(a);
		a^.ele:= v;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(v.codigo < a^.ele.codigo) then begin// --> uso menor estricto en condicion para que los repetidos vayan del lado derecho.
			agregar1(a^.HI, v);
		end
		else begin
			agregar1(a^.HD, v);
		end;
	end;
end;
procedure agregar2(var a: arbol2;v: venta);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.codigo:= v.codigo;
		a^.ele.unidades:= v.unidades;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if (v.codigo = a^.ele.codigo) then begin
			a^.ele.unidades:= a^.ele.unidades + v.unidades; // ---> evaluamos primer caso en el que el producto ya posee un nodo en el arbol, tenemos que increcrementar sus cantidades.
		end
		else if(v.codigo < a^.ele.codigo) then begin
			agregar2(a^.HI, v);
		end
		else begin
			agregar2(a^.HD, v);
		end;
	end;
end;
procedure agregarL(var l: listaVentas; v: venta);
var
	nuevo: listaVentas;
begin
	new(nuevo);
	nuevo^.ele.unidades:= v.unidades;
	nuevo^.ele.fecha:= v.fecha;
	nuevo^.sig:= l;
	l:= nuevo;
end;
procedure agregar3(var a: arbol3; v: venta);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.codigo:= v.codigo;
		a^.ele.lista:= nil;
		agregarL(a^.ele.lista, v);
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(a^.ele.codigo = v.codigo) then begin
			agregarL(a^.ele.lista, v);
		end
		else if (v.codigo < a^.ele.codigo) then begin
			agregar3(a^.HI, v);
		end
		else begin	
			agregar3(a^.HD, v);
		end;
	end;
end;
procedure generarArboles(var a1: arbol1; var a2: arbol2; var a3: arbol3);
var
	ventaActual: venta;
begin
	generarInfoAleatoria(ventaActual);
	while(ventaActual.codigo <> 0) do begin
		agregar1(a1, ventaActual);
		agregar2(a2, ventaActual);
		agregar3(a3, ventaActual);
		generarInfoAleatoria(ventaActual);
	end;
end;
function totalPorFecha(a: arbol1; fecha: diaMes): integer;
begin
	if(a = nil) then begin // ---> primer caso base, si el arbol es nil significa que terminamos el recorrdio (pasamos por todos los nodos)
		totalPorFecha:= 0;
	end
	else begin
		totalPorFecha:= totalPorFecha(a^.HI, fecha) + totalPorFecha(a^.HD, fecha);
		if(a^.ele.fecha = fecha) then begin
			totalPorFecha:= totalPorFecha + a^.ele.unidades; // ---- > uso de variable local a la propia funcion.
		end;
	end;
end;
procedure codigoMax(a: arbol2; var cantMax: integer; var cod: integer);
begin
	if(a<>nil)then begin // recorrido en orden
		if(a^.ele.unidades > cantMax) then begin
			cantMax:= a^.ele.unidades;
			cod:= a^.ele.codigo;
		end;
		codigoMax(a^.HI, cantMax, cod);
		codigoMax(a^.HD, cantMax, cod);
	end;
end;
function calcularVentas(l: listaVentas): integer;
var
	cant: integer;
begin
	cant:= 0;
	while(l <> nil) do begin
		cant:= cant + 1;
		l:= l^.sig;
	end;
	calcularVentas:= cant;
end;
procedure calcularMaxVentas(a: arbol3; var codigoMaxVentas, cantMax: integer);
var
	numeroActual: integer;
begin 
	if(a<>nil) then begin
		numeroActual:= calcularVentas(a^.ele.lista);
		if(numeroActual > cantMax) then begin
			cantMax:= numeroActual;
			codigoMaxVentas:= a^.ele.codigo;
		end;
		calcularMaxVentas(a^.HI, codigoMaxVentas, cantMax);
		calcularMaxVentas(a^.HD, codigoMaxVentas, cantMax);
	end;
end;
var
	cantMax: integer;
	codMax: integer;
	codigoMaxVentas: integer;
	fechaRandom: diaMes;
	a1: arbol1;
	a2: arbol2;
	a3: arbol3;
begin
	randomize;
	a1:= nil;
	a2:= nil;
	a3:= nil;
	generarArboles(a1, a2, a3);
	fechaRandom:= random(31) + 1;
	writeln(totalPorFecha(a1, fechaRandom));
	cantMax:= -1;
	codigoMax(a2, cantMax, codMax);
	writeln(codMax);
	cantMax:= -1;
	calcularMaxVentas(a3, codigoMaxVentas, cantMax);
end.
