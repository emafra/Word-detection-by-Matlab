clc
close all;
clear all;

global elementos;
global lista; % Variaveis declaradas como global

I = iread('castle.png'); % Captura a imagem
I_bw = im2bw(I,0.8); % Homogeniza a imagem a fim de retirar ru�dos
[label, m, parents, cls] = ilabel(I_bw); % atribui �ndices aos objetos da imagem
amin = 40;
amax = 4500; % Restringe a �rea para identificar uma letra
idisp(I); % Mostra a Imagem
hold on


retornaletras(label,m,cls,amin,amax); % fun��o que encontra e reotarna as


elementos1=[];
u=0; % vari�vel ultilizada para atribuir valores da matrix elemento para uma
% nova matrix chamada de matrix elemento1.

for i = 1:size(lista,2)    
    bbox = 0; % Se condi��o para saber se as box est�o perto
    vetorXmax = []; 
    vetorXmin = [];
    vetorYmin = [];
    vetorYmax = []; % Vetores que armazenam as posi��es das bounding box
    for j= i:size(lista,2)
        
        if elementos(i,2) >= 0.7*elementos(j,1) && elementos(i,2) <= 1*elementos(j,1) && ...
        elementos(j,2)>1 && elementos(i,3)>= 0.85*elementos(j,3) && elementos(i,3) <= 1.15*elementos(j,3)...
        || elementos(i,1) >= 0.7*elementos(j,1) && elementos(i,1) <= elementos(j,1) && ...
        elementos(j,2)>1 && elementos(i,3)>= 0.85*elementos(j,3) && elementos(i,3) <= 1.15*elementos(j,3)...
        || elementos(j,1) >= 0.7*elementos(i,2) && elementos(j,1) <= 1*elementos(i,2) && ...
        elementos(j,2)>1 && elementos(i,3)>= 0.85*elementos(j,3) && elementos(i,3) <= 1.15*elementos(j,3)
        % Condi��es que determina se as bounding box ser�o agrupadas ou n�o
        
        
        vetorXmax(j) = elementos(j,2);
        elementos(j,2) = 0; 
        vetorXmin(j) = elementos(j,1);
        vetorYmin(j) = elementos(j,3);
        vetorYmax(j) = elementos(j,4); % Vetor onde s�o aplicadas as coordenadas
        % bounding box caso a condi��o anterior seja verdadeira.
        bbox = 1; % As bounding box est�o pr�ximas
        end
            
    end
    if bbox == 1 && elementos(i,1)>0
        
        for k = 1:size(vetorXmin,2)
            if vetorXmin(k) == 0
                vetorXmin(k) = 15000; % evitar que aconte�a erros quando for
                % v=encotrar o valor m�nimo do vetor "vetorXmin".
            end
        end
        for k = 1:size(vetorYmin,2)
            if vetorYmin(k) == 0
                
                vetorYmin(k) = 15000; % evitar que aconte�a erros quando for
                % v=encotrar o valor m�nimo do vetor "vetorXmin".                
                
            end
        end
        
        xmin = min(vetorXmin); 
        xmax = max(vetorXmax);
        ymin = min(vetorYmin);
        ymax = max(vetorYmax); % Encontra as posi��es para criar a bounding box
        u=u+1; % Altera linha de elementos1
        elementos1(u,:)=[xmin,xmax,ymin,ymax,u] % Nova matrix com as bounding box agrupadas
    end
end
elementos=elementos1(:,:);
elementos = sortrows(elementos,3) % Ordena as matrizes do maior y para o menor

[n,m] = size(elementos) % Captura a quantidade de linas da matrix elementos

% La�o para relacionar bounding box pr�ximas aplicando nelas um mesmo �ndice 
for i= 1: n
     for j=i:n
         if elementos(i,2)>=0.98*elementos(j,1) && elementos(i,4)>= 0.9*elementos(j,4)...
                 && elementos(i,4)<= 1.1*elementos(j,4) 
           elementos(j,5) = elementos(i,5); % Relaciona os bounding box pr�ximos aplicando um mesmo
           % �ndice
         end
     end
 end

% La�o para fazer as bounding box finais agrupando as bounding box de mesmo �ndice 
for i= 1:n
    vetorXmax = [];
    vetorXmin = [];
    vetorYmin = [];
    vetorYmax = [];
    for j = 1:n
        if elementos(i,5) == elementos(j,5)
        vetorXmax(j) = elementos(j,2)        
        vetorXmin(j) = elementos(j,1)
        vetorYmin(j) = elementos(j,3)
        vetorYmax(j) = elementos(j,4) % Atribui as coordenas de mesmo �ndice nos vetores de 
        % posi��o
        for k = 1:size(vetorXmin,2)
            if vetorXmin(k) == 0
                vetorXmin(k) = 15000;
            end
        end
        for k = 1:size(vetorYmin,2)
            if vetorYmin(k) == 0               
                vetorYmin(k) = 15000;                
            end
        end
        end
    end
    xmin = min(vetorXmin);
    xmax = max(vetorXmax);
    ymin = min(vetorYmin);
    ymax = max(vetorYmax); % fun��es para encontrar os pontos extremos de 
    % cada �ndice, podendo assim gerar o bounding box
    desenha(I,xmin,xmax,ymin,ymax); % fun��o criada para desenhar o bounding box
end
            