program ejercio02;
const 
	max = 300;
type
	oficina = record 
		codigo: integer;
		dni: integer;
		valor: real;
	end;
	
	vOficina = array [1..max] of oficina;

procedure leerOficina (var ofi: oficina);
begin
	writeln('ingrese el codigo de identificacion de su oficina: ');
	readln(ofi.codigo);
	if(ofi.codigo <> -1) then begin
		writeln('ingrese su dni: ');
		readln(ofi.dni);
		writeln('ingrese el valor de su expensa: ');
		readln(ofi.valor);
	end;
end;

procedure cargarV(var vector: vOficina; var dimL: integer );
var
	oficinaActual: oficina;
begin
	dimL:= 0;
	leerOficina(oficinaActual);
	while ((oficinaActual.codigo <> -1) and (dimL < max)) do begin
		dimL:= dimL + 1;
		vector[dimL]:= oficinaActual;
		leerOficina(oficinaActual);
	end;
end;

procedure ordenarInsercion (var vector: vOficina; dimL: integer);
var
	i, j: integer;
	item: oficina;
begin
	for i:= 2 to dimL do begin
		item:= vector[i];
		j:= i - 1;
		while ((j > 0) and (vector[j].codigo > item.codigo)) do begin
			vector[j + 1]:= vector[j];
			j:= j - 1;
		end;
		vector[j + 1]:= item;
	end;
end;
procedure ordenarSeleccion (var vector: vOficina; dimL: integer);
var
	i, j, pos: integer;
	item: oficina;
begin
	for i:= 1 to dimL - 1 do begin
		pos:= i;
		for j:= i + 1 to dimL do begin
			if vector[j].codigo < vector[pos].codigo then pos:= j;
		end;
		item:= vector[pos];
		vector[pos]:= vector[i];
		vector[i]:= item;
	end;
end;
var
	dimL: integer;
	vectorOficinas: vOficina;
begin
	cargarV(vectorOficinas, dimL);
	ordenarInsercion(vectorOficinas, dimL);
	ordenarSeleccion(vectorOficinas, dimL);
end.
