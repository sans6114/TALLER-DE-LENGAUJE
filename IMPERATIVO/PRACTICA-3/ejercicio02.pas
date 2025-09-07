program ejercicio02;
type
	diaMes = 1..30;
	producto = record
		codigo: integer;
		unidadesV: integer;
	end;
	venta = record 
		producto: producto;
		fecha: diaMes;
	end;
		
	arbol = ^nodo;
	nodo = record
		ele: venta;
		HI: arbol;
		HD: arbol;
	end;
	arbolProductos = ^nodoP;
	nodoP = record
		ele: ventaSinFecha;
		HI: arbol;
		HD: arbol;
	end;
procedure generarInfoAleatoria(var v: venta);
begin
	v.producto.codigo:= random(10) + 1; //codigo aleatorio de 1 a 10;
	v.producto.fecha:= random(30) + 1; //fecha entre 1 a 30 simulando dia del mes
	v.producto.unidadesV:= random(100) + 1; //simulo un rango de entre 1 a 100 unidades.
	writeln('venta aleatoria generada: ');
	writeln('codigo de producto: ', v.producto.codigo);
end;
procedure agregar(var a: arbol; v: venta);
begin
	if(a = nil) then begin
		new(a);
		a^.ele:= v;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(v.producto.codigo < a^.ele.codigo) then begin// --> uso menor estricto en condicion para que los repetidos vayan del lado derecho.
			agregar(a^.HI, v);
		end
		else begin
			agregar(a^.HD, v);
		end;
	end;
end;
procedure agregarArbolP(var a: arbol; cod, unidades: integer;);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.codigo:= cod;
		a^.ele.unidadesV:= unidades;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(v.codigo < a^.ele.producto.codigo) then begin// --> uso menor estricto en condicion para que los repetidos vayan del lado derecho.
			agregar(a^.HI, v);
		end
		else begin
			agregar(a^.HD, v);
		end;
	end;
end;
function unidadTotalP(a: arbol, codigo: integer): integer;
begin
	if(a = nil) then begin
		unidadTotalP:= 0;
	end
	else begin
		if(a^.ele.producto.codigo = codigo) then begin
			unidadTotalP := a^.ele.producto.unidadesV + unidadTotalP(a^.HI, codigo) + unidadTotalP(a^.HD, codigo);
		end
		else if(codigo < a^.ele.producto.codigo) then begin // ---> busco a la izquierda
			unidadTotalP(a^.HI, codigo)
		end
		else begin
			unidadTotalP := unidadTotalP(a^.HD, codigo); // ---> busco a la derecha
		end; 
	end;
end;
procedure generarArboles(var a1, a2, a3: arbol);
var
	ventaActual: venta;
begin
	generarInfoAleatoria(ventaActual);
	while(ventaActual.codigo <> 0) do begin
		agregar(a1, ventaActual);
		agregarArbolP(a2, ventaActual.codigo, unidadTotalP(a1, ventaActual.codigo));
		agregarArbolP(a3, ventaActual.codigo, ventasRealizadas(a1, ventaActual.codigo));
		generarInfoAleatoria(ventaActual);
	end;
end;
var
	arbol1, arbol2, arbol3: arbol;
begin
	randomize;
	generarArboles(arbol1, arbol2, arbol3);
end.
