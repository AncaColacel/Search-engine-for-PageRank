function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1

    %aflu coeficientii a si b in functie de val1 si val2 cunoscand faptul
    %ca functia este continua
    %am dedus formulele calculand limitele laterale ale functiei in cele 2
    %valori mentionate

    a = 1 / (val2-val1);
    b = -a * val1;

    %acum voi preciza valorile lui y, facand discutie potrivit ramurilor
    %functiei din enunt prin utilizarea unei instructiuni if

    if x < val1
        y = 0;
    elseif val2 < x && x<=1
        y = 1;
    else
        y = a*x+b
    end
end




	