program ejercicio04;
procedure calcularBinario(num: integer; var resultado: string);
var
	temp: string;
begin
	if(num < 2) then begin
		if(num = 1) then begin
			resultado:= '1';
		end 
		else begin
			resultado:= '0';
		end;
	end
	else begin
        calcularBinario(num DIV 2, temp);
        if(num MOD 2 = 1) then begin
            resultado := temp + '1';
        end
        else begin
            resultado := temp + '0';
        end;
	end;
end;
var
	num: integer;
	binario: string;
begin
repeat
    writeln('Ingrese un número (0 para terminar):');
    readln(num);
    if (num <> 0) then begin
        calcularBinario(num, binario);
        writeln('Binario: ', binario);
    end;
    until num = 0;
end.
