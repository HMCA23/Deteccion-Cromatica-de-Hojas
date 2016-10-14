
%Héctor Miguel Camarillo Abad
%137754
%Doctorado en Sistemas Inteligentes
%Detección Cromática de Hojas

%Limpieza de variables y command window
clear
clc

%Se le entrega la dirección de dónde obtener las imágenes
imageFiles=dir('C:\Users\k43e-msr1-red-r\OneDrive\Documentos\Otoño_2016\Realidad Aumentada\BSR_bsds500\BSR\BSDS500\data\images\train\*.*');
nFiles = length(imageFiles);    % Number of files found
disp('El número de imágenes son')
nFiles

%Va realizar el proceso para todas las imágenes encontradas
for imagen=3:nFiles-1
   %Obtiene el nombre de la imagen actual
    currentFileName = strcat('C:\Users\k43e-msr1-red-r\OneDrive\Documentos\Otoño_2016\Realidad Aumentada\BSR_bsds500\BSR\BSDS500\data\images\train\', imageFiles(imagen).name);
    %Guarda la imagen como matriz
   currentImageMatrix = imread(currentFileName);
   
   %Estos nombres son la dirección donde se guardarán los resultados
   nombrePrisma=strcat('C:\Users\k43e-msr1-red-r\OneDrive\Documentos\Otoño_2016\Realidad Aumentada\Imagenes_Hojas_Prisma/Pocesada',imageFiles(imagen).name);
   nombreCubo=strcat('C:\Users\k43e-msr1-red-r\OneDrive\Documentos\Otoño_2016\Realidad Aumentada\Imagenes_Hojas_Cubo/Pocesada',imageFiles(imagen).name);
   nombreEsfera=strcat('C:\Users\k43e-msr1-red-r\OneDrive\Documentos\Otoño_2016\Realidad Aumentada\Imagenes_Hojas_Esfera/Pocesada',imageFiles(imagen).name);
   
   %Estas matrices son donde se guardarán los cambios de la imagen
    MatrizFinalPrisma=currentImageMatrix;
    MatrizFinalCubo=currentImageMatrix;
    MatrizFinalEsfera=currentImageMatrix;
    
    %Se considerará un radio de 50
    %El centro es el promedio del color RGB de una hoja
    Radio=50;
    Centro=[114;153;72];
   
   %Obtenemos el ancho y alto de la imgen
   %La variable dummy solo nos indica que tiene R,G,B
   [ancho,alto,dummy]=size(currentImageMatrix);
   
   %Se recorrerán todos lo pixels
   for pixelx=1:1:ancho-1
       for pixely=1:1:alto-1
           
           %Un prisma rectangular, los límites fueron tomados del mínimo y
           %El máximo valor de todas las muestras de hojas
           if(currentImageMatrix(pixelx,pixely,1)<=197) && (currentImageMatrix(pixelx,pixely,1)>=35)
                if(currentImageMatrix(pixelx,pixely,2)<=236) && (currentImageMatrix(pixelx,pixely,2)>=50)
                     if(currentImageMatrix(pixelx,pixely,3)<=143) && (currentImageMatrix(pixelx,pixely,3)>=16)
                         MatrizFinalPrisma(pixelx,pixely,1)=255;
                         MatrizFinalPrisma(pixelx,pixely,2)=255;
                         MatrizFinalPrisma(pixelx,pixely,3)=255;
                     end
                end
           end
           %Fin de Prisma Rectangular
           
           %Un cubo, se toma el valor promedio y se le da un rango que lo
           %define el radio
           if(currentImageMatrix(pixelx,pixely,1)<=(Centro(1)+Radio)) && (currentImageMatrix(pixelx,pixely,1)>=(Centro(1)-Radio))
                if(currentImageMatrix(pixelx,pixely,2)<=(Centro(2)+Radio)) && (currentImageMatrix(pixelx,pixely,2)>=(Centro(2)-Radio))
                     if(currentImageMatrix(pixelx,pixely,3)<=(Centro(3)+Radio)) && (currentImageMatrix(pixelx,pixely,3)>=(Centro(3)-Radio))
                         MatrizFinalCubo(pixelx,pixely,1)=255;
                         MatrizFinalCubo(pixelx,pixely,2)=255;
                         MatrizFinalCubo(pixelx,pixely,3)=255;
                     end
                end
           end
           %Fin de Cubo
           
           %Una Esfera, se toma el valor promedio y verifica si se
           %encuentra dentro de la esfera denotada por radio, sacando la
           %distancia euclidiana del valorRGB y el valor promedio
          Distancia=((Centro(1)-currentImageMatrix(pixelx,pixely,1))^2+(Centro(2)-currentImageMatrix(pixelx,pixely,2))^2+(Centro(3)-currentImageMatrix(pixelx,pixely,3))^2)^1/2;
           if(Distancia<=Radio)
               MatrizFinalEsfera(pixelx,pixely,1)=255;
               MatrizFinalEsfera(pixelx,pixely,2)=255;
               MatrizFinalEsfera(pixelx,pixely,3)=255;
           end
           %Fin de Esfera
           
       end
   end
   
   %Escribe en sus respectivos folders el procesado de la imagen
   imwrite(MatrizFinalPrisma,nombrePrisma,'JPG');
   imwrite(MatrizFinalCubo,nombreCubo,'JPG');
   imwrite(MatrizFinalEsfera,nombreEsfera,'JPG');
end
disp('FIN')