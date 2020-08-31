function desenha(I,xmin,xmax,ymin,ymax)
hold on 
% Função criada para desenhar os bounding box finais
        plot([xmin xmax],[ymin, ymin], 'b','LineWidth',2); 
        plot([xmin xmin],[ymin, ymax], 'b','LineWidth',2); 
        plot([xmin xmax],[ymax, ymax], 'b','LineWidth',2); 
        plot([xmax xmax],[ymin, ymax], 'b','LineWidth',2);
end
