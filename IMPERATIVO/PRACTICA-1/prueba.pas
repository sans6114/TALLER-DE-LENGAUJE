program PRUEBA;
const
	maxIndice = 50;
    maxVentas = 99;
type
	codigo = 1..15;
	cantidadVendida = 1..maxVentas;
	rangoV = 1..maxIndice;
	venta = record 
		dia: integer;
		cod: codigo;
		cantidadV: integer;
	end;
	vectorVentas = array[rangoV] of venta;
procedure leerVenta(var v: venta);
var
	codigoActual: codigo;
begin
	codigoActual:= random(15) + 1;
	v.cod:= codigoActual;
	writeln('ingrese el dia en el que se realizo la venta: ');
	readln(v.dia);
	if(v.dia <> 0) then begin
		writeln('ingrese la cantidad de ventas operadas: ');
		readln(v.cantidadV);
	end;
	writeln('venta generada con codigo: ', v.cod); 
end;
procedure cargarV( var vector: vectorVentas; var dimL: integer);
var
	v: venta;
begin		
	dimL:= 0;
	randomize;
	leerVenta(v);
	while((v.dia <> 0) and (dimL < maxIndice)) do begin
		dimL:= dimL + 1;
		vector[dimL]:= v;
		leerVenta(v);
	end;
end;
procedure imprimirV(v: vectorVentas; dimL: integer);
var
	i: rangoV;
begin
	for i:= 1 to dimL do begin
		writeln('codigo de la venta numero ', i, ': ', v[i].cod);
		writeln('cantidad de ventas: ', v[i].cantidadV);
		writeln('dia: ', v[i].dia);
	end;
end;
procedure ordenarV(var vector:vectorVentas; dimL: integer); //PREGUNTAR SOBRE CONSISTENCIA EN TIPO DE DATO DE DIML, PODRIA HABER PUESTO DIML: RANGOV?
var
	i, j, pos: rangoV;
	item: venta;
begin
	for i:= 1 to dimL - 1 do begin
		pos:= i;
		for j:= i + 1 to dimL do begin
			if(vector[j].cod < vector[pos].cod) then pos:= j;
		end;
		item:= vector[pos];
		vector[pos]:= vector[i];
		vector[i]:= item;
	end;
end;
var
	ventas: vectorVentas;
	dimL: integer;
BEGIN
	cargarV(ventas, dimL);
	imprimirV(ventas,dimL); // imprime desordenado
	ordenarV(ventas, dimL);
	imprimirV(ventas,dimL); // imprime ordenado
END.

