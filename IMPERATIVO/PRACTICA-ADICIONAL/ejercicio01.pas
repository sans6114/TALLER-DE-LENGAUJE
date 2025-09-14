program ejercicio01;
const dimF = 300;
type
	oficina = record 
		codigo: integer;
		DNIprop: integer;
		valor: real;
	end;
	v = array [1..dimF] of oficina;
procedure leerOfi(var ofi: oficina);
begin
	writeln('ingrese el codigo de la oficina: ');
	readln(ofi.codigo);
	writeln('ingrese el DNI del propietario de la oficina: ');
	readln(ofi.DNIprop);
	if(ofi.DNIprop <> 0) then begin
		writeln('ingrese el valor de la expensa correspondiente a su oficina: ');
		readln(ofi.valor);
	end;
end;
procedure moduloA(var vector: v; var dimL: integer);
var
	oficinaActual: oficina;
begin
	leerOfi(oficinaActual);
	dimL:= 0;
	while((dimL < dimF) and (oficinaActual.DNIprop <> 0)) do begin
		dimL:= dimL + 1;
		vector[dimL]:= oficinaActual;
		leerOfi(oficinaActual);
	end;
end;
procedure moduloB(var vector: v; dimL:integer);
var
	i, j, pos:integer;
	item: oficina;
begin
	for i:= 1 to dimL - 1 do begin
		pos:= i;
		for j:= i + 1 to dimL do begin
			if(vector[j].codigo < vector[pos].codigo) then begin // cambia en algo si comparo con v en i?
				pos:= j;
			end;
			item:= vector[pos];
			vector[pos]:= vector[i];
			vector[i]:= item;
		end;
	end;
end;
procedure moduloC(vector: v; inicio, dimL: integer; codigo: integer; var pos: integer);
var
	centro: integer;
begin
	if(inicio > dimL) then begin
		pos:=  0;
	end
	else begin
		centro:= (inicio + dimL) DIV 2;
		if(vector[centro].codigo = codigo) then begin
			pos:= centro;
		end
		else begin
			if(codigo > vector[centro].codigo) then begin
				moduloC(vector, (centro + 1), dimL, codigo, pos);
			end 
			else begin
				moduloC(vector, inicio, (centro - 1), codigo, pos);
			end;
		end;
	end;
end;
function moduloD(vector: v; dimL: integer; inicio: integer): real;
begin
	if(inicio > dimL) then begin
		moduloD:= 0;
	end
	else begin
		moduloD:= vector[inicio].valor + moduloD(vector, dimL, inicio + 1);
	end;
end;
var
	posicion: integer;
	dimL: integer;
	vectorOFicinas: v;
	montoTotal: real;
begin
	moduloA(vectorOficinas, dimL);
	moduloB(vectorOficinas, dimL);
	moduloC(vectorOficinas, 1,dimL, 32000, posicion);
	montoTotal:= moduloD(vectorOficinas, dimL, 1);
end.
