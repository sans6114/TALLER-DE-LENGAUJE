program ejercicio03;
type
	vEnteros = array [1..20] of integer;
procedure cargarV(var v: vEnteros; var dimL: integer);
var
	num: integer;
begin
	if(dimL < 20) then begin
		num:= random(1550 - 300 + 1) + 300;
		dimL:= dimL + 1;
		v[dimL]:= num;
		cargarV(v, dimL);
	end;
end;
procedure ordenarV(var v: vEnteros; dimL: integer);
var
	i, j, pos, item: integer;
begin
	for i:= 1 to dimL - 1 do begin
		pos:= i;
		for j:= i + 1 to dimL do begin
			if(v[j] < v[pos]) then begin
				pos:= j;
			end;
		end;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item; 
	end;
end;
Procedure busquedaDicotomica (v: vEnteros; ini,fin: integer; dato:integer; var pos: integer);
var
	centro: integer;
begin
	if(ini > fin) then begin
		pos:= -1;
	end 
	else begin
		centro:= (ini + fin) DIV 2;
		if(v[centro] = dato) then begin
			pos:= centro;
		end
		else begin
			if (dato > v[centro]) then begin
				ini:= centro + 1;
				busquedaDicotomica(v, ini, fin, dato, pos);
			end 
			else begin
				fin:= centro - 1;
				busquedaDicotomica(v, ini, fin, dato, pos)
			end;
		end;
	end;
end;
var
	vectorEnteros: vEnteros;
	dimL, pos: integer;
begin
	randomize;
	cargarV(vectorEnteros, dimL);
	ordenarV(vectorEnteros, dimL);
	busquedaDicotomica(vectorEnteros, 1, dimL, 400, pos);
end.
