-- =====================================================
-- FINANZAS PERSONALES (valores en pesos colombianos, COP)


-- DIMENSIÓN CATEGORÍA
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (1, 'Alimentación');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (2, 'Transporte');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (3, 'Entretenimiento');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (4, 'Ropa');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (5, 'Educación');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (6, 'Salud');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (7, 'Servicios');
INSERT INTO dim_categoria (ca_id_categorias, ca_nombre_categorias) VALUES (8, 'Hogar');

-- DIMENSIÓN MEDIO DE PAGO
INSERT INTO dim_medio_pago (mp_id_medio_pago, mp_nombre_medio_pago) VALUES (1, 'Efectivo');
INSERT INTO dim_medio_pago (mp_id_medio_pago, mp_nombre_medio_pago) VALUES (2, 'Tarjeta débito');
INSERT INTO dim_medio_pago (mp_id_medio_pago, mp_nombre_medio_pago) VALUES (3, 'Tarjeta crédito');
INSERT INTO dim_medio_pago (mp_id_medio_pago, mp_nombre_medio_pago) VALUES (4, 'Transferencia');

-- DIMENSIÓN FECHA DE COMPRA
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (1, TO_DATE('2026-09-28','YYYY-MM-DD'), 9, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (2, TO_DATE('2026-09-30','YYYY-MM-DD'), 9, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (3, TO_DATE('2026-10-01','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (4, TO_DATE('2026-10-02','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (5, TO_DATE('2026-10-04','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (6, TO_DATE('2026-10-05','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (7, TO_DATE('2026-10-07','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (8, TO_DATE('2026-10-08','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (9, TO_DATE('2026-10-10','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (10, TO_DATE('2026-10-11','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (11, TO_DATE('2026-10-13','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (12, TO_DATE('2026-10-14','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (13, TO_DATE('2026-10-16','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (14, TO_DATE('2026-10-17','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (15, TO_DATE('2026-10-19','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (16, TO_DATE('2026-10-21','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (17, TO_DATE('2026-10-23','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (18, TO_DATE('2026-10-24','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (19, TO_DATE('2026-10-26','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (20, TO_DATE('2026-10-28','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (21, TO_DATE('2026-10-30','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (22, TO_DATE('2026-10-31','YYYY-MM-DD'), 10, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (23, TO_DATE('2026-11-01','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (24, TO_DATE('2026-11-02','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (25, TO_DATE('2026-11-03','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (26, TO_DATE('2026-11-04','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (27, TO_DATE('2026-11-05','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (28, TO_DATE('2026-11-06','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (29, TO_DATE('2026-11-07','YYYY-MM-DD'), 11, 2026);
INSERT INTO dim_fecha_compra (fc_id_fecha_compra, fecha, mes, anio) VALUES (30, TO_DATE('2026-11-08','YYYY-MM-DD'), 11, 2026);

-- TABLA DE HECHOS
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (1, 1, 1, 1, 'Almuerzo', 18000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (2, 2, 2, 1, 'Recarga tarjeta de transporte', 20000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (3, 7, 4, 2, 'Pago de internet del mes', 85000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (4, 1, 3, 3, 'Mercado de la semana', 142500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (5, 3, 3, 3, 'Suscripción de streaming', 24900);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (6, 2, 1, 4, 'Taxi a la universidad', 15000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (7, 1, 1, 4, 'Desayuno', 12500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (8, 5, 2, 5, 'Fotocopias y libros', 45000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (9, 6, 2, 6, 'Medicamentos', 38700);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (10, 1, 1, 6, 'Almuerzo', 19000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (11, 4, 3, 7, 'Camiseta', 69900);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (12, 2, 2, 7, 'Recarga tarjeta de transporte', 20000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (13, 3, 1, 8, 'Cine', 32000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (14, 1, 3, 8, 'Cena con amigos', 76000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (15, 8, 2, 9, 'Artículos de aseo', 54300);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (16, 1, 1, 9, 'Almuerzo', 17500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (17, 7, 4, 10, 'Pago de plan de celular', 69900);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (18, 2, 1, 10, 'Bus intermunicipal', 14000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (19, 1, 2, 11, 'Mercado de la semana', 128400);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (20, 3, 3, 11, 'Entrada a concierto', 180000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (21, 5, 4, 12, 'Curso en línea', 120000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (22, 1, 1, 12, 'Café y almojábana', 9500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (23, 2, 2, 13, 'Recarga tarjeta de transporte', 20000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (24, 4, 3, 14, 'Zapatos deportivos', 239000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (25, 1, 1, 14, 'Almuerzo', 18500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (26, 6, 2, 15, 'Consulta odontológica', 95000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (27, 8, 2, 15, 'Bombillos y extensión', 36800);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (28, 1, 3, 16, 'Mercado de la semana', 151200);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (29, 3, 1, 16, 'Salida a bolos', 28000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (30, 2, 1, 17, 'Taxi', 22000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (31, 7, 4, 18, 'Pago de energía', 112000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (32, 1, 1, 18, 'Almuerzo', 19500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (33, 5, 2, 19, 'Impresiones del trabajo final', 14500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (34, 3, 3, 19, 'Suscripción de música', 17900);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (35, 1, 2, 20, 'Domicilio de comida', 34500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (36, 2, 2, 20, 'Recarga tarjeta de transporte', 20000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (37, 4, 1, 21, 'Medias y ropa interior', 42000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (38, 1, 1, 21, 'Almuerzo', 18000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (39, 6, 3, 22, 'Vitaminas', 58000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (40, 1, 3, 22, 'Mercado de la semana', 137800);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (41, 7, 4, 23, 'Pago de arriendo', 1100000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (42, 3, 3, 23, 'Videojuego', 89900);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (43, 2, 2, 24, 'Recarga tarjeta de transporte', 20000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (44, 1, 1, 24, 'Almuerzo', 18500);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (45, 8, 2, 24, 'Detergente y suavizante', 31200);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (46, 1, 2, 25, 'Mercado de la semana', 146300);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (47, 5, 4, 25, 'Cuota de curso de idiomas', 150000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (48, 2, 1, 26, 'Bus intermunicipal', 16000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (49, 3, 1, 26, 'Helado y paseo', 21000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (50, 1, 1, 27, 'Almuerzo', 19000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (51, 4, 3, 27, 'Chaqueta', 185000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (52, 6, 2, 28, 'Crema hidratante y protector solar', 62000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (53, 1, 3, 28, 'Cena familiar', 98000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (54, 2, 2, 29, 'Recarga tarjeta de transporte', 20000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (55, 3, 3, 29, 'Entrada a teatro', 65000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (56, 1, 1, 29, 'Desayuno', 11000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (57, 7, 4, 30, 'Pago de agua', 64000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (58, 1, 2, 30, 'Mercado de la semana', 133900);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (59, 2, 1, 30, 'Taxi', 19000);
INSERT INTO hecho_gasto (hg_id_gasto, ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor) VALUES (60, 8, 2, 30, 'Escoba y trapero', 27500);

-- Sincronizar columnas IDENTITY con el máximo valor insertado
ALTER TABLE dim_categoria MODIFY ca_id_categorias GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE dim_medio_pago MODIFY mp_id_medio_pago GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE dim_fecha_compra MODIFY fc_id_fecha_compra GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE hecho_gasto MODIFY hg_id_gasto GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);

COMMIT;