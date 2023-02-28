function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Voi folosi algoritmul Gram-Schmidt modificat (facut si la laborator)
    % pentru a descompune matricea A in Q*R, unde Q este o matrice
    % ortogonala iar R este o matrice superior triunghiulara. Spre
    % deosebire de G-S obisnuit, acest algoritm modificat este mai stabil
    % numeric. Ideea consta in faptul ca se ia fiecare vector si se modifica
    % vectorii urmatori pentru a fi ortogonali cu acesta.

    %matricea A pe care aplic algoritmul
    [n, n] =  size(A);
    %matricea Q ortogonala
    Q = A;
    %matricea superior triunghiulara
    R = zeros(n, n);
    %se calculeaza matricea Q, iar matricea R = inv(Q) * A, adica Q' * A,
    %pentru ca inversa = transpusa pentru matricile ortogonale
    for i = 1:n
        R(i, i) = norm(Q(1:n, i));
        Q(1:n, i) = Q(1:n, i) / R(i, i);
        for j = i+1 : n
            R(i, j) = Q(1:n, i)' * Q(1:n, j);
            Q(1:n, j) = Q(1:n, j) - Q(1:n, i) * R(i, j);
        end
    end

    

    %urmeaza apoi rezolvarea sistemul superior triunghiular, care este un sistem
    %foarte simplu, folosind descompunerea matricii A
    %sistemul superior triunghiular are drept scop obtinerea matricei B,
    %care este inversa matricei A
    %explicatie rezolvare sistem: A * x = b => Q * R * x = b => R * x = transpose(Q) * b
    %in sistemul nostru inversa este x, b ul este Q', iar A este R

    %Q devine Q' pentru ca este mutat in partea dreapta in sistem, inversa
    %fiind transpusa
    Q = Q';  
    for contor = 1 : n
    %imi iniatiliez vectorul solutie al sistemului cu 0
    x = zeros(n, 1);
    %b-ul sistemului devine pe rand fiecare coloana din matricea Q
    b = Q(:, contor);
    % acum voi calcula x(k)
    %voi face o parcurgere de la "coada la cap" pentru ca intr-un SST
    %incep sa se afle necunoscutele incepand cu ultima ecuatie datorita
    %formei matricei sup triung.
    for k = n : -1 : 1
      %acum initializez suma cu 0 si apoi o voi calcula inmultind matricea
      %cu vectorul
      sum = 0;
      for t = k+1 : n
        sum = sum + R(k, t) * x(t);
      end
      x(k) = (b(k, 1) - sum) / R(k, k);
    end
    %acum voi insera in matricea B fiecare x aflat in urma rezolvarii celor
    %n sisteme mentionate si in enunt
    B(:, contor) = x;
    end
end





