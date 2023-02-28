function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

    %deschid fisier
    fid =  fopen (nume, 'r');
    %citesc numarul de pagini Web
    N = fscanf(fid, '%d', 1);
    %initializez matricile A si K
    A = zeros(N);
    K = zeros(N);
    v_grade = zeros(N:1);
    %creez matrice de adiacenta prin 2 for-uri si citiri ajutatoare
    for i=1:N
        %citesc indicele fiecarei pagini
        indice = fscanf(fid, '%d', 1);
        %citesc cati vecini are fiecare pagina
        nr_vecini = fscanf(fid, '%d', 1);
        grad = 0;
        for j=1:nr_vecini
            %citesc fiecare vecin in parte al paginii
            vecin = fscanf(fid, '%d', 1);
            %creez matrice de adiacenta adaungand legatura intre pagina si
            %vecini
            if not(indice == vecin)
                A(i,vecin) = 1;
                grad = grad + 1;
            end
        end
    v_grade(i) = grad;
    end
    K = diag(v_grade);
    %calculez matricea M potrivit formulei 
    I = inv(K);
    M = (I*A)';
    %creare vector de dimensiune Nx1 care contine doar 1
    one = ones(N,1);
    %initializez R_prev (R(0)) potrvit formulei
    R_prev(1:N,1) = 1/N;
    %initializez R_next cu zerouri
    R_next = zeros(N,1);
    %calculare vector de PageRank-uri utilizand formula de pe site
    while(eps <= norm(R_prev - R_next))
        R_next = R_prev;
        R_prev = d*M*R_prev + (one/N)*(1-d);  
    end
    R = R_next;
    %inchidere fisier
    fclose(fid);
    
    
end 





