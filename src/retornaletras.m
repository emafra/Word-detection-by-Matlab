function retornaletras(label,m,cls,amin,amax)
a=1;
lista=[];
global lista;
for i = 1:m    
    I2 = (label == i); 

    [v,u] = find(I2); % encontra as posi��es dos objetos na imagem
    umin = min(u);
    umax = max(u);
    vmin = min(v);
    vmax = max(v);
    
    xmin(i) = umin; % atribui as posi��es a vetores
    xmax(i) = umax;
    ymin(i) = vmin;
    ymax(i) = vmax;
    %area
    
    area(i) = ((xmax(i)-xmin(i))*(ymax(i)-ymin(i))); % Calcula a �rea de cada objeto
    
    if area(i) >= amin && area(i) <= amax && cls(i,1)==1
        lista(a) = i; % Cria uma lista com os �ndices das letras
        a = a+1;
    end
end
hold on;
[a1,a] = size(lista) 
elementos=zeros(a,5); 
global elementos
for k = 1:a
    b = lista(k); % atribu� a vari�vel "b" apenas os �ndices das letras
        
    elementos(k,:) = [xmin(b),xmax(b),ymin(b),ymax(b),b] % Cria uma matriz com todas as coordenadas
    % das bounding box de cada letra e a label atribu�da a ela    
end
elementos = sortrows(elementos)
end