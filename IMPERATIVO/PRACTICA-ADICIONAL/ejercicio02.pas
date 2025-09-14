program ejercicio02;
type
	//tipos de utilidad
	anoFabricacion = 2015..2024;
	// tipos para campo "elemento" del arbol.
	auto = record 
		patente: integer;
		ano: anoFabricacion;
		marca: string;
		modelo: integer; // interpreto un modelo de auto como un entero, ejemplo modelo 1, 2, 3 etc.
		color: string;
	end;
	//campos de listas
	registroLista = record 
		patente: integer;
		color: string;
	end;
	lista = ^nodoLista;
	nodoLista = record 
		ele: registroLista;
		sig: lista;
	end;
	registroArbol2 = record
		marca: string;
		l: lista;
	end; 
	

	//definicion de arboles.
	arbol1 = ^nodoArbol1;
	nodoArbol1 = record 
		ele: auto;
		HI: arbol1;
		HD: arbol1;
	end;
	arbol2 = ^nodoArbol2;
	nodoArbol2 = record 
		ele: registroArbol2;
		HI: arbol2;
		HD: arbol2;
	end;
	// definicion vectores
	autoVector = record
		patente: integer;
		marca: string;
		modelo: integer;
		color: string;
	end;
	registroVector = ^nodoVector;
	nodoVector = record 
		ele: autoVector;
		sig: registroVector;
	end;
	vector = array [anoFabricacion] of registroVector;
procedure leerAuto(var a: auto); // cuando dice generar se refiere a un modelo de lectura no? PREGUNTAR
begin
	writeln('Ingrese la marca MMM para finalizar:');
    readln(a.marca);
    if (a.marca <> 'MMM') then
    begin
        write('Ingrese la patente (numero): ');
        readln(a.patente);
        write('Ingrese el año de fabricación (2015-2024): ');
        readln(a.ano);
        write('Ingrese el modelo (ej: 1, 2, 3): ');
        readln(a.modelo);
        write('Ingrese el color: ');
        readln(a.color);
        writeln('-----------------------------------');
    end;
end;
procedure agregarA1(var a: arbol1; autoA: auto );
begin
	if(a = nil) then begin
		new(a);
		a^.ele:= autoA;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(autoA.patente < a^.ele.patente) then begin
			agregarA1(a^.HI, autoA);
		end
		else begin
			agregarA1(a^.HD, autoA);
		end;
	end;
end;
procedure agregarL(var l: lista; autoA: auto);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.ele.patente:= autoA.patente;
	nuevo^.ele.color:= autoA.color;
end;
procedure agregarA2 (var a: arbol2; autoA: auto);
begin
	if(a = nil) then begin
		new(a);
		a^.ele.marca:= autoA.marca;
		a^.ele.l:= nil;
		agregarL(a^.ele.l, autoA);
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else begin
		if(autoA.marca = a^.ele.marca) then begin
			agregarL(a^.ele.l, autoA); // aprovecho que cargo de forma 1 a 1 en proceso padre, entonces puedo actualizar los nodos de la lista si la ,arca es igual.
		end
		else if(autoA.marca < a^.ele.marca) then begin
			agregarA2(a^.HI, autoA);
		end
		else begin
			agregarA2(a^.HD, autoA);
		end;
	end;
end;
procedure cargarArboles(var a1: arbol1; var a2: arbol2);
var
	autoActual: auto;
begin
	leerAuto(autoActual);
	while(autoActual.marca <> 'MMM') do begin
		agregarA1(a1, autoActual);
		agregarA2(a2, autoActual);
		leerAuto(autoActual);
	end;
end;
function retornarPorMarca (a: arbol1; marca: string): integer;
begin
	if(a = nil) then begin
		retornarPorMarca:= 0;
	end
	else begin
		if(a^.ele.marca = marca) then begin
			retornarPorMarca:= 1 + retornarPorMarca(a^.HI, marca) + retornarPorMarca(a^.HD, marca);
		end
		else begin // ---> como hay que recorrer todo el arbol necesito llamar recursivamente por hijo derecho y izquierdo.
			retornarPorMarca:= retornarPorMarca(a^.HI, marca) + retornarPorMarca(a^.HD,marca);
		end;
	end;
end;
function contarNodos(l: lista): integer;
var
	cant: integer;
begin
	cant:= 0;
	while (l<> nil) do begin
		cant:= cant + 1;
	end;
	contarNodos:= cant;
end;
function retornarPorMarca2(a: arbol2; marca: string): integer;
begin
	if (a= nil) then begin
		retornarPorMarca2:= 0;
	end
	else begin
		if(a^.ele.marca = marca) then begin
			retornarPorMarca2:= contarNodos(a^.ele.l) + retornarPorMarca2(a^.HI, marca) + retornarPorMarca2(a^.HD,marca);
		end
		else if (marca < a^.ele.marca) then begin
			retornarPorMarca2:= retornarPorMarca2(a^.HI, marca);
		end
		else begin
			retornarPorMarca2:= retornarPorMarca2(a^.HD, marca);
		end;
	end;
end;
procedure agregarListaVector(var l: registroVector; autoA: auto);
var
	nuevo: registroVector;
begin
	new(nuevo);
	nuevo^.ele.patente:= autoA.patente;
	nuevo^.ele.marca:= autoA.marca;
	nuevo^.ele.modelo:= autoA.modelo;
	nuevo^.ele.color:= autoA.color;
	nuevo^.sig:= l;
	l:= nuevo;
end;
procedure generarVector(a: arbol1; var v: vector);
begin
	if(a<>nil)then begin
		agregarListaVector(v[a^.ele.ano], a^.ele);
		generarVector(a^.HI, v);
		generarVector(a^.HD, v);
	end;
end;
procedure crearV(var v: vector);
var
	i: anoFabricacion;
begin
	for i:= 2015 to 2024 do begin
		v[i]:= nil;
	end;
end;
function modeloPorPatente(a: arbol1; patente: integer): integer; //aclaro que devuelve integer por que yo estoy manejando los modelos con ese tipo.
begin
	if(a = nil) then begin
		modeloPorPatente:= 0; // ---> modelo 0 = modelo invalido.
	end
	else begin
		if(a^.ele.patente = patente) then begin
			modeloPorPatente:= a^.ele.modelo;
		end
		else if(patente < a^.ele.patente) then begin
			modeloPorPatente:= modeloPorPatente(a^.HI,patente);
		end 
		else begin
			modeloPorPatente:= modeloPorPatente(a^.HD,patente);
		end;
	end;
end;
procedure colorPorPatente(a: arbol2; patente: integer; var color: string; var encontrado: boolean);
var
	//ok:= boolean; // 	<----- PREGUNTAR: SE PISA ESTA VARIABLE? QUE ALTERNATIVA TENGO?
	aux: lista;
begin
	if(a<> nil) then begin
		aux:= a^.ele.l;
		while((aux <> nil)and not(encontrado)) do begin // ---> OJO! hay que usar variable auxiliar, la lista del nodo del arbol quedara defectuoso en caso contrario.
			if(aux^.ele.patente = patente) then begin
				color:= aux^.ele.color;
				encontrado:= true;
			end;
			aux:= aux^.sig;
		end;
		if(not encontrado) then begin
			colorPorPatente(a^.HI, patente, color, encontrado);
			if not(encontrado) then begin
				colorPorPatente(a^.HD, patente, color, encontrado);
			end;
		end;
	end;
end;
var
	encontrado: boolean;
	arbolAutos: arbol1;
	arbolMarcas: arbol2;
	v: vector;
	colorDeBuscado: string;
begin
	arbolAutos:= nil;
	arbolMarcas:= nil;
	cargarArboles(arbolAutos, arbolMarcas);
	writeln(retornarPorMarca(arbolAutos, 'ford'));
	writeln(retornarPorMarca2(arbolMarcas, 'fiat'));
	crearV(v); // ---> ponemos todos las posiciones del vector en nil.
	generarVector(arbolAutos, v);
	writeln(modeloPorPatente(arbolAutos, 6114)); // ---> devolvera el modelo del auto cuya patente sea igual a la pasada como argumento.
	encontrado:= false;
	colorPorPatente(arbolMarcas, 6114, colorDeBuscado, encontrado);
end.
