program ejercicio03;
type
	genero = 1..8;
	pelicula = record
		codigo: integer;
		codGenero: genero;
		puntaje: real;
	end;
	listaPeliculas = ^nodo
	nodo = record
		ele: pelicula;
		sig: listaPeliculas;
	end;
begin
	writeln('hola');
end.
