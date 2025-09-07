program arboles;
type
	arbol = ^nodo;
	nodo = record
		ele: integer; // dato de cada nodo del arbol
		HI: arbol; // hijo izquierdo
		HD: arbol; // este campo representa el hijo derecho de cada nodo del arbol (casi siempre en la materia este nodo es mas grande que su padre)
	end;
procedure agregar(var arbolALlenar: arbol; num : integer);// recibimos los dos parametros necesarios para la carga de datos en la estructura jerarquica
begin
	if(arbolALlenar = nil) then begin // el arbol esta vacio.
		new(arbolALlenar);
		arbolALlenar^.ele:= num;
		arbolALlenar^.HI:= nil;
		arbolALlenar^.HD:= nil; // ---> 
	end
	else begin
		if(num <= arbolALlenar^.ele) then begin // ---> en este caso tengo que moverme hacia el lado izquierdo del arbol 
			agregar(arbolALlenar^.HI, num); // llamada recursiva
			//IMPORTANTE: el menor igual es muy importante ya que si no, los valores repetidos entrarian en "else" y se movera al lado derecho.
		end
		else begin
			agregar(arbolALlenar^.HD, num);
		end;
	end;

end;
var
	a: arbol;
	num: integer;
begin
	a:= nil; // indicamos que el arbol no posee ningun hijo hasta este punto (arbol vacio)
	read(num);
	while(num <> 50) do begin
		agregar(a, num); // ----> llamamos a modulo encargado de la carga de hijos para dicho arbol "a"
		read(num;)
	end;
end.
