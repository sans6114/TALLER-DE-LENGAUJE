program ejercicio04;
type
	rubro = 1..6;
	producto = record 
		codigo: integer;
		codRubro: rubro;
		precio: real;
	end;
	productoAGuardar = record
		codigo: integer;
		precio: real;
	end;
	listaProductos = ^nodo;
	nodo = record
		ele: productoAGuardar;
		sig: listaProductos;
	end;
	vProductos = array [rubro] of listaProductos;
	vRubroTres = array [1..20] of productoAGuardar;
procedure crearV(var v: vProductos);
var 
	i: rubro;
begin
	for i:= 1 to 6 do begin
		v[i]:= nil;
	end;
end;
procedure leerP(var p: producto);
begin
	writeln('Ingrese el precio del producto:');
	readln(p.precio);
	if (p.precio <> -1) then begin
		writeln('Ingrese el código del producto:');
		readln(p.codigo);
		writeln('Ingrese el código de rubro (1 a 6):');
		readln(p.codRubro);
	end;
end;
procedure insertarOrdenado(var l: listaProductos; p: producto);
var
	actual, anterior, nuevo: listaProductos;
begin
	new(nuevo);
	nuevo^.ele.codigo:= p.codigo;
	nuevo^.ele.precio:= p.precio;
	if(l = nil) then begin
		l:= nuevo;
	end
	else begin
		actual:= l;
		while( (actual <> nil) and (actual^.ele.codigo < nuevo^.ele.codigo) ) do begin
			anterior:= actual;
			actual:= actual^.sig;
		end;
		if(actual = l) then begin
			nuevo^.sig:= l;
			l:= nuevo;
		end
		else begin
			anterior^.sig:= nuevo;
			nuevo^.sig:= actual;
		end;
	end;
end;
procedure cargarV(var v: vProductos);
var
	productoActual: producto;
begin
	leerP(productoActual);
	while (productoActual.precio <> -1) do begin
		insertarOrdenado(v[productoActual.codRubro], productoActual);
		leerP(productoActual);
	end;
end;
procedure imprimirV(v: vProductos);
var
	i: rubro;
begin
	for i:= 1 to 6 do begin
		if(v[i] = nil) then begin
			writeln('el rubro numero: ', i, 'no tiene productos asociados');
		end
		else begin
			while(v[i] <> nil) do begin
				writeln(v[i]^.ele.codigo);
				v[i]:= v[i]^.sig;
			end;
		end;
	end;
	
end;
procedure cargarNuevoV(vectorP: vProductos; var v: vRubroTres; var dimL: integer);
begin
	dimL:= 0;
	if not(vectorP[3] = nil) then begin
		while ((vectorP[3] <> nil) and (dimL < 20)) do begin
			dimL:= dimL + 1;
			v[dimL]:= vectorP[3]^.ele;
			vectorP[3]:= vectorP[3]^.sig;
		end;
	end;
end;
procedure ordenarV(v: vRubroTres; dimL: integer);
var
	i, j, pos: integer;
	item: productoAGuardar;
begin
	for i:= 1 to dimL -1 do begin
		pos:= i;
		for j:= i + 1 to dimL do begin
			if( v[j].precio < v[i].precio) then begin
				pos:= j;
			end;
		end;
		item:= v[pos];
		v[j]:= v[i];
		v[i]:= item;
	end;
end;
procedure imprimirV(v: vRubroTres; dimL : integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln(v[i].precio);
	end;
end;
function calcularPromedio(v: vRubroTres; dimL: integer): real;
var 
	cantP: integer;
	total: real;
	i: integer;
begin
	cantP:= 0;
	total:= 0;
	for i:= 1 to dimL do begin
		cantP:= cantP + 1;
		total:= total + v[i].precio;
	end;
	calcularPromedio:= total / cantP;
end;
var
	vectorProductos: vProductos;
	vectorRubro: vRubroTres;
	dimL: integer;
begin
	crearV(vectorProductos);
	cargarV(vectorProductos);
	imprimirV(vectorProductos);
	cargarNuevoV(vectorProductos, vectorRubro, dimL);
	ordenarV(vectorRubro, dimL);
	imprimirV(vectorRubro, dimL);
	writeln(calcularPromedio(vectorRubro,dimL));
end.

