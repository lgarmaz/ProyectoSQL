--Usando expresion. Devuelve los articulos cuyo valor total sea mayor de 50.
SELECT REF_INTERNA_ADORNO, PRECIO * STOCK AS TOTAL
FROM LGM_ADORNO
WHERE PRECIO * STOCK > 50;

--Usando funcion. Devuelve el promedio del precio total de los pedidos agrupados por mes en el año 2021.
SELECT MES, ANO, AVG(PRECIO_TOTAL) AS MEDIA_PRECIO_MES
FROM LGM_PEDIDO
WHERE ANO = 2021
GROUP BY MES, ANO;

--Usando una comparaci�n con una cadena. Devuelve todos los datos de los productos American Crafts.
SELECT * 
FROM LGM_PINTURA 
WHERE MARCA = 'American Crafts';

--Usando una comparacion con cadena y fecha. Devuelve todos los datos de los pedidos cuya calle se llame "del pueblo" y sean superiores a 2021.
SELECT *
FROM LGM_PEDIDO
WHERE CALLE = 'del pueblo' AND ANO > 2021;

--Query de verificacion. Devuelve los campos seleccionados de los clientes que usan Tarjeta de credito o PayPal.
SELECT EMAIL, DNI
FROM LGM_CLIENTE
WHERE METODO_DE_PAGO IN ('Tarjeta de credito', 'PayPal');

--Query de multiples tablas 1. Une las tablas y devuelve la id del pedido, el precio total y el cliente al que pertenecen.
SELECT P.ID_PEDIDO, P.PRECIO_TOTAL, C.EMAIL
FROM LGM_PEDIDO P
INNER JOIN LGM_CLIENTE C ON P.EMAIL_CLIENTE = C.EMAIL;

--Query de multiples tablas 2. Muestra una lista de filas que contienen el nombre y el ID del encargado junto con el número de teléfono del proveedor correspondiente.
SELECT E.NOMBRE_ENCARGADO, E.ID_ENCARGADO, P.TLF
FROM LGM_ENCARGADO E
LEFT JOIN LGM_PROVEEDOR P
ON E.IDPROVEEDOR_E = P.ID_PROVEEDOR;

--Campo calculado simple. Muestra un campo calculado del precio por el stock llamado valor total cuya marca sea Crat Paper.
SELECT REF_INTERNA_PAPEL, MARCA, PROVEEDOR_P, PRECIO*STOCK AS VALOR_TOTAL
FROM LGM_PAPEL
WHERE MARCA = 'Crate Paper';

--Campo calculado de consulta multiple. Muestra el valor total de todas las referencias de herramientas vendidas.
SELECT H.REF_INTERNA_HERRAMIENTA, H.MARCA, C.CANTIDAD * H.PRECIO AS VALOR_TOTAL
FROM LGM_HERRAMIENTA H
JOIN LGM_CONTIENE_HERRAMIENTA C ON H.REF_INTERNA_HERRAMIENTA = C.REF_INTERNA_H;
--Esta solo se podria aplicar a los productos que solo se han comprado una vez. 
--Si queremos sacar estos resultados con productos que se han comprado varias veces habr�a que hacer la siguiente query:
SELECT H.REF_INTERNA_HERRAMIENTA, H.MARCA, SUM(C.CANTIDAD*H.PRECIO) AS TOTAL_VENTAS
FROM LGM_HERRAMIENTA H
JOIN LGM_CONTIENE_HERRAMIENTA C ON H.REF_INTERNA_HERRAMIENTA = C.REF_INTERNA_H
GROUP BY H.REF_INTERNA_HERRAMIENTA, H.MARCA, H.STOCK;

--Campo calculado de consulta multiple y group by. Muestra el precio total vendido de cada referencia de adornos vendida.
SELECT A.REF_INTERNA_ADORNO, SUM(C.CANTIDAD * A.PRECIO) AS TotalVentas
FROM LGM_CONTIENE_ADORNO C
JOIN LGM_ADORNO A ON C.REF_INTERNA_A = A.REF_INTERNA_ADORNO
GROUP BY A.REF_INTERNA_ADORNO;