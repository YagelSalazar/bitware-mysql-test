/* 
a) Generar script para poblar todas las tablas. 
*/

CREATE SCHEMA `eBitware_Almacen` ;

CREATE TABLE `almacenes`.`Cajeros` (
  `Cajero` INT NOT NULL,
  `NomApels` VARCHAR(215) NULL,
  PRIMARY KEY (`Cajero`));

CREATE TABLE `almacenes`.`Productos` (
  `Producto` INT NOT NULL,
  `Nombre` VARCHAR(100) NULL,
  `Precio` FLOAT NULL,
  PRIMARY KEY (`Producto`));

CREATE TABLE `almacenes`.`Maquinas_Registradoras` (
  `Maquina` INT NOT NULL,
  `Piso` INT NULL,
  PRIMARY KEY (`Maquina`));

CREATE TABLE `almacenes`.`Venta` (
  `Cajero` INT NULL,
  `Maquina` INT NULL,
  `Producto` INT NULL,
  INDEX `Cajero_idx` (`Cajero` ASC) VISIBLE,
  INDEX `Maquina_idx` (`Maquina` ASC) VISIBLE,
  INDEX `Producto_idx` (`Producto` ASC) VISIBLE,
  CONSTRAINT `Cajero`
    FOREIGN KEY (`Cajero`)
    REFERENCES `almacenes`.`Cajeros` (`Cajero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Maquina`
    FOREIGN KEY (`Maquina`)
    REFERENCES `almacenes`.`Maquinas_Registradoras` (`Maquina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Producto`
    FOREIGN KEY (`Producto`)
    REFERENCES `almacenes`.`Productos` (`Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
/*
b) Mostrar el número de ventas de cada producto, ordenado de más a menos ventas. 
*/

SELECT Producto, COUNT(Producto) FROM almacenes.Venta
group by Producto HAVING COUNT(Producto > 0)
ORDER BY COUNT(PRODUCTO) DESC;

/*
c) Obtener un informe completo de ventas, indicando el nombre del cajero que realizo 
	la venta, nombre y precios de los productos vendidos, y el piso en el que se encuentra 
	la máquina registradora donde se realizó la venta.
*/

SELECT Cajeros.NomApels, Productos.Nombre, Productos.Precio, Maquinas_Registradoras.Piso FROM almacenes.Venta
INNER JOIN almacenes.Cajeros ON almacenes.Venta.Cajero=Cajeros.Cajero
INNER JOIN almacenes.Productos ON almacenes.Venta.Producto=Productos.Producto
INNER JOIN almacenes.Maquinas_Registradoras ON almacenes.Venta.Maquina=Maquinas_Registradoras.Maquina;

/*
d) Obtener las ventas totales realizadas en cada piso.
*/
    
SELECT Maquinas_Registradoras.Piso, COUNT(Venta.Maquina) FROM almacenes.Venta CROSS JOIN almacenes.Maquinas_Registradoras
GROUP BY Maquinas_Registradoras.Piso
HAVING COUNT(Venta.Maquina);
    
/*
e) Obtener el código y nombre de cada cajero junto con el importe total de sus ventas.  
*/
  
SELECT Cajeros.NomApels, Venta.Cajero, SUM(Productos.Precio) FROM almacenes.Venta
INNER JOIN almacenes.Cajeros ON almacenes.Venta.Cajero=Cajeros.Cajero
INNER JOIN almacenes.Productos ON almacenes.Venta.Producto=Productos.Producto
GROUP BY Venta.Cajero
HAVING SUM(Productos.Precio);
  
/*
f) Obtener el código y nombre de aquellos cajeros que hayan realizado ventas en pisos cuyas 
	ventas totales sean inferiores a los 5000 pesos. 
*/

/*
SELECT Cajeros.NomApels, Venta.Cajero FROM almacenes.Venta
INNER JOIN almacenes.Cajeros ON almacenes.Venta.Cajero=Cajeros.Cajero
INNER JOIN almacenes.Productos ON almacenes.Venta.Producto=Productos.Producto
INNER JOIN almacenes.Maquinas_Registradoras ON almacenes.Venta.Maquina=Maquinas_Registradoras.Maquina

GROUP BY Maquinas_Registradoras.Piso
HAVING SUM(Productos.Precio) < 5000;
*/
    
#------------------------ Datos de prueba
INSERT INTO `almacenes`.`Cajeros` (`Cajero`, `NomApels`) VALUES ('1', 'Rodrigo');
INSERT INTO `almacenes`.`Cajeros` (`Cajero`, `NomApels`) VALUES ('2', 'German');
INSERT INTO `almacenes`.`Cajeros` (`Cajero`, `NomApels`) VALUES ('3', 'Ignacio');
INSERT INTO `almacenes`.`Cajeros` (`Cajero`, `NomApels`) VALUES ('4', 'Laura');
INSERT INTO `almacenes`.`Cajeros` (`Cajero`, `NomApels`) VALUES ('5', 'Esteban');

INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('1', '1');
INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('2', '2');
INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('3', '1');
INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('4', '1');
INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('5', '2');
INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('6', '2');
INSERT INTO `almacenes`.`Maquinas_Registradoras` (`Maquina`, `Piso`) VALUES ('7', '1');

INSERT INTO `almacenes`.`Productos` (`Producto`, `Nombre`, `Precio`) VALUES ('1', 'refreso', '22');
INSERT INTO `almacenes`.`Productos` (`Producto`, `Nombre`, `Precio`) VALUES ('2', 'caja', '34');
INSERT INTO `almacenes`.`Productos` (`Producto`, `Nombre`, `Precio`) VALUES ('3', 'cheetos', '24');
INSERT INTO `almacenes`.`Productos` (`Producto`, `Nombre`, `Precio`) VALUES ('4', 'jugueta', '54');
INSERT INTO `almacenes`.`Productos` (`Producto`, `Nombre`, `Precio`) VALUES ('5', 'mesa', '87');
INSERT INTO `almacenes`.`Productos` (`Producto`, `Nombre`, `Precio`) VALUES ('6', 'casco', '10');

INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('1', '1', '1');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('2', '2', '2');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('3', '3', '3');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('4', '4', '5');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('5', '5', '4');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('1', '6', '6');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('2', '7', '1');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('3', '1', '2');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('4', '2', '3');
INSERT INTO `almacenes`.`Venta` (`Cajero`, `Maquina`, `Producto`) VALUES ('5', '3', '4');


    