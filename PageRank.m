function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out

    %folosesc functia strcat pentru a realiza concatenarea numelui de
    %fisier cu string-ul .out
    nume_out = strcat (nume, '.out');
    fid1 = fopen(nume, 'r');
    N = fscanf(fid1, '%d', 1);

    %parcurg fisierul linie cu linie ca sa ajung la cele doua valori
    for i = 1 : N+1
        fgets(fid1);
    end

    %extrag valorile val1 si val2 din fisier
    val1 = fscanf(fid1, '%f', 1);
    val2 = fscanf(fid1, '%f', 1);
    %inchid fisierul
    fclose(fid1);

    %deschid fiserul nou creat in modul de scriere
    fid2 = fopen(nume_out, 'w');
    %scriu in fisier numarul de pagini 
    fprintf(fid2, '%d \n', N);
    %calculez vectorul PageRank cu metoda iterativa si il salvez in R1
    R1 = Iterative(nume, d, eps);
    %il scriu pe R1 in fisier
    %parcurg element cu element vectorul pentru a realiza scrierea
    for i = 1 : N
        fprintf(fid2, '%.6f\n', R1(i));  
    end
    fprintf(fid2, '\n');
    %calculez vectorul PageRank cu metoda algebrica si il salvez in R2
    %folosind aceeasi parcurgere
    R2 = Algebraic(nume, d);
    for i = 1 : N
        fprintf(fid2, '%.6f \n', R2(i)); 
    end
    fprintf(fid2, '\n'); 
    %sortez vectorul R2 descrescator utilizand 2 for-uri, compar elementele
    %apoi le interschimb si salvez vectorul sortat in PR1
    PR1 = R2;
    for i = 1 : N-1
        for j = i + 1 : N
            if PR1(i) < PR1(j)
                aux = PR1(i);
                PR1(i) = PR1(j);
                PR1(j) = aux;
            end
        end
    end
    %afisare N linii de forma:i j F.
    %se parcurg cei 2 vectori cu 2 for-uri. i-ul este indicele, iar j-ul
    %este calculat prin verificarea egalitatii dintre PR1 si R2 pentru a se
    %face un clasament al paginilor
   for i = 1 : N
     for j = 1 : N
       if PR1(i) == R2(j)
            fprintf(fid2, '%d ', i);
            fprintf(fid2, '%d ', j);
         break
       end
     end
    % scriu in fisier si gradul de apartenenta al paginii, utilizand functia Apartenenta
    y = Apartenenta(PR1(i), val1, val2);
        fprintf(fid2, '%f\n', y);
   end
   fclose(fid2);
end