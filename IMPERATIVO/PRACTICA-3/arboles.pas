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
function minimo(a: arbol):integer;
begin
	if(a^.HI = nil) then begin
		minimo:= a^.ele; //---> cuando lleguemos al ultimo nodo del lado izquierdo lo devolveremos a la llamada anterior.
	end	
	else begin
		minimo:= minimo(a^.HI); // llamada recursiva
	end;
end;
function minimoNodo(a: arbol): arbol; // funcion que retorna el nodo con el valor minimo.
begin
	if(a = nil ) then begin //caso en que el arbol este vacion, si se verifica antes de llamar a la funcion esta linea esta de mas.
		minimoNodo:= nil;
	end
	else if(a^.HI = nil) then begin
		minimoNodo:= a;
	end
	else begin
		minimoNodo:= minimoNodo(a^.HI);
	end;
end;
function maximo(a: arbol): integer;
begin
	if(a^.HD = nil) then begin
		maximo:= a^.ele;
	end 
	else begin
		maximo:= maximo(a^.HD);
	end;
end;
function buscar(a: arbol; x: integer): boolean;
begin
	if(a = nil) then begin
		buscar:= false;
	end
	else begin
		if(a^.ele = x) then begin
			buscar:= true;
		end
		else if(x < a^.ele) then begin // llamada recursiva hacia izq
			buscar:= buscar(a^.HI, x);
		end
		else begin
			buscar:= buscar(a^.HD, x);
		end;
	end;
end;
var
	a: arbol;
	num: integer;
	ok: boolean;
begin
	a:= nil; // indicamos que el arbol no posee ningun hijo hasta este punto (arbol vacio)
	read(num);
	while(num <> 50) do begin
		agregar(a, num); // ----> llamamos a modulo encargado de la carga de hijos para dicho arbol "a"
		read(num);
	end;
	// en este punto poseemos un arbol cargado(si se ingresaron numeros que no sean 50)
	writeln(minimo(a));// ---> funcion que devuelve el minimo entero dentro de nuestro arbol 
	minimoNodo(a);
	writeln(maximo(a));
	ok:= buscar(a, 10);
	writeln(ok); // ---> esta el valor 10 en el arbol?
end.
