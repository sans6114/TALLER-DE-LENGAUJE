Program ejercicio03;
const 
	maxGenero = 8;
type genero = 1..maxGenero;
	peliculaAGuardar = record
		codigo: integer;
		puntaje: real;
	end;
	listaPeliculas = ^nodo; 
	nodo = record
		ele: peliculaAGuardar;
		sig: listaPeliculas;
	end;
	elem = record 
		pri: listaPeliculas;
		ult: listaPeliculas;
	end;
	pelicula = record 
		codigo: integer;
		codGenero: genero;
		puntaje: real;
	end;
	vectorPeliculas = array [genero] of elem;
	vectorMaximos = array [genero] of peliculaAGuardar;
procedure crearV(var v: vectorPeliculas);
var
    i: genero;
begin
    for i:= 1 to maxGenero do begin
        v[i].pri:= nil
    end;
end;
procedure leerPelicula(var p: pelicula);
begin
    writeln('ingrese el codigo de su pelicula: ');
    readln(p.codigo);
    if(p.codigo <> -1) then begin
        writeln('ingrese el codigo de genero que tiene la pelicula: ');
        readln(p.codGenero);
        writeln('ingrese el puntaje promedio de la pelicula');
        readln(p.puntaje);
    end;
end;
procedure agregarNodo (var l: listaPeliculas; var ult: listaPeliculas; peliculaActual: pelicula);
var
    nuevo: listaPeliculas;
begin
    new(nuevo);
    nuevo^.ele.codigo:= peliculaActual.codigo;
    nuevo^.ele.puntaje:= peliculaActual.puntaje;
    nuevo^.sig:= nil;
    if(l = nil) then begin
        l:= nuevo;
        ult:= nuevo;
    end
    else begin
        ult^.sig:= nuevo;
        ult:= nuevo;
    end;
end;
procedure cargarV(var v: vectorPeliculas);
var
    peliculaActual: pelicula;
begin
    leerPelicula(peliculaActual);
    while (peliculaActual.codigo <> -1) do begin
        agregarNodo(v[peliculaActual.codGenero].pri, v[peliculaActual.codGenero].ult, peliculaActual);
        leerPelicula(peliculaActual);
    end;
end;
procedure buscarMax(l: listaPeliculas; max: real; var elemMax: peliculaAGuardar);
begin
	while (l <> nil) do begin
		if(l^.ele.puntaje > max) then begin
			max:= l^.ele.puntaje;
			elemMax:= l^.ele;
		end;
		l:= l^.sig;	
	end;
end;
procedure generarV(v: vectorPeliculas; var dimL: integer; var nuevo: vectorMaximos);
var
	i: genero;
	nodoInicial: listaPeliculas;
	maximo: real;
	elemMax: peliculaAGuardar;
begin
	dimL:= 0;
	for i:= 1 to maxGenero do begin
		maximo:= -1;
		nodoInicial:= v[i].pri;
		if(nodoInicial <> nil) then begin
			buscarMax(nodoInicial, maximo, elemMax);
			dimL:= dimL + 1;
			nuevo[dimL]:= elemMax;
		end;
	end;
end;
procedure ordenarV(var v: vectorMaximos; dimL: integer);
var
	i, j, pos: genero;
	item: peliculaAGuardar;
begin
	for i:= 1 to dimL -1 do begin
		pos:= i;
		for j:= i + 1 to dimL do begin
			if (v[j].puntaje < v[pos].puntaje) then begin 
				pos:= j
			end;
		end;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
end;
var
    vPeliculas: vectorPeliculas;
    vMaximos: vectorMaximos;
    dimL: integer;
begin
    crearV(vPeliculas);
    cargarV(vPeliculas);
    generarV(vPeliculas, dimL, vMaximos);
    ordenarV(vMaximos, dimL);
    writeln(vMaximos[1].codigo, vMaximos[dimL].codigo);
end.
