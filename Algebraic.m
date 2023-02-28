function R = Algebraic (nume, d) 
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.

    %pentru inceput algoritmul seamana foarte mult cu varianta iterativa
    %voi calcula matricile A, K si M in acelasi mod
    fid =  fopen (nume, 'r');
    N = fscanf(fid, '%d', 1);
    A = zeros(N);
    K = zeros(N);
    v_grade = zeros(N:1);
    for i=1:N
        indice = fscanf(fid, '%d', 1);
        nr_vecini = fscanf(fid, '%d', 1);
        grad = 0;
        for j=1:nr_vecini
            vecin = fscanf(fid, '%d', 1);
            if not(indice == vecin)
                A(i,vecin) = 1;
                grad = grad + 1;
            end
        end
    v_grade(i) = grad;
    end
    K = diag(v_grade);
    I = PR_Inv(K);
    M = (I*A)';
    one = ones(N,1);
    I = eye(N);
    %acum ma voi folosi de functia PR_Inv pentru aflarea vectorului R in
    %mod algebric
    %calculez R(t)
    R_t = PR_Inv(I-d*M);
    R = R_t * ((1 - d) / N) * one;
    fclose(fid);
end
