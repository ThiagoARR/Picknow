DROP SCHEMA IF EXISTS picknow;
CREATE SCHEMA picknow;
USE picknow;

create table cliente(
cd_cpf_cliente varchar(11) not null,
nm_cliente text not null,
cd_senha_cliente varchar(255) not null,
nm_email_cliente varchar(50) not null,
cd_img_cliente longtext,
qt_pontos int,
primary key cliente (cd_cpf_cliente)
);

create table tipo_prato(
cd_tipo_prato int not null,
nm_tipo_prato text not null,
primary key tipo_prato (cd_tipo_prato)
);

create table categoria(
cd_categoria char(2) not null,
nm_categoria text not null,
primary key categoria (cd_categoria)
);

create table restaurante(
cd_img_restaurante longtext,
cd_cnpj_restaurante varchar(14) not null,
nm_telefone_restaurante varchar (12) not null,
nm_restaurante text not null,
cd_categoria char(2) not null,
primary key restaurante (cd_cnpj_restaurante),
foreign key restaurante_categoria (cd_categoria) references categoria (cd_categoria)
);

create table adm_restaurante(
nm_email_restaurante varchar (50) not null,
cd_cnpj_restaurante varchar(14) not null,
cd_senha_adm_restaurante varchar(255) not null,
nm_estado_restaurante varchar (20) not null,
nm_cidade_restaurante varchar (90) not null,
cd_cep int (11) not null,
nm_endereco_restaurante varchar (150) not null,
nm_bairro_restaurante varchar (150) not null,
nm_complemento_restaurante varchar (150) null,
nm_contato_responsavel text not null,
cd_cpf_responsavel varchar(11) not null,
nm_latitude varchar(14) null,
nm_longitude varchar(14) null,
primary key adm_restaurante (nm_email_restaurante),
foreign key adm_restaurante_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);

create table prato(
cd_cnpj_restaurante varchar(16) not null,
cd_prato char(8) not null,
ic_destaque bool,
cd_tipo_prato int not null,
cd_img_prato longtext null,
nm_prato text not null,
ds_ingredientes_prato text,
vl_preco_prato text,
primary key prato (cd_prato),
foreign key prato_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante),
foreign key prato_tipo_prato (cd_tipo_prato) references tipo_prato (cd_tipo_prato)
);

create table forma_pagamento(
cd_cnpj_restaurante varchar(16) not null,
cd_tipo_pagamento char(4) not null,
nm_tipo_pagamento text not null,
primary key forma_pagamento (cd_tipo_pagamento),
foreign key forma_pagamento_restaurante(cd_cnpj_restaurante) references restaurante(cd_cnpj_restaurante)
);

create table recompensas(
cd_cnpj_restaurante varchar(16) not null,
cd_recompensa int not null,
cd_img_recompensa longtext null,
nm_recompensa text not null,
ds_recompensa longtext not null,
qt_pontos_troca int not null,
primary key recompensas(cd_recompensa),
foreign key recompensa_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);

create table cupom(
cd_cpf_cliente varchar(16) not null,
cd_recompensa int not null,
cd_cupom varchar(8) not null,
primary key cupom (cd_cupom),
foreign key cupom_recompensa (cd_recompensa) references recompensas (cd_recompensa),
foreign key cupom_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente)
);

create table pontos_valor(
cd_indice int,
nm_intervalo longtext,
qt_pontos_recompensas int,
primary key pontos_valor(cd_indice)
);

create table codigo(
cd_indice int not null,
cd_cnpj_restaurante varchar(20) not null,
cd_cpf_cliente varchar(16) not null,
cd_codigo_pontos varchar(10) not null,
dt_codigo_gerado datetime,
primary key codigo (cd_codigo_pontos),
foreign key codigo_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente),
foreign key codigo_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante),
foreign key codigo_pontos_valor (cd_indice) references pontos_valor (cd_indice)
);

create table codigos_usados(
cd_codigo_pontos varchar(10),
primary key codigos_usados (cd_codigo_pontos)
);

create table lugares_visitados(
cd_historico int auto_increment not null,
cd_cpf_cliente varchar(11) not null,
cd_cnpj_restaurante varchar(14) not null,
dt_visita datetime not null,
vl_compra int,
primary key lugares_visitados (cd_historico),
foreign key lugares_visitados_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente),
foreign key lugares_visitados_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);

create table lugares_favoritos(
cd_cnpj_restaurante varchar(11) not null,
cd_cpf_cliente varchar(11) not null,
foreign key lugares_favoritos_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante),
foreign key lugares_favoritos_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente)
);

/*Cliente*/
insert into cliente values ("45581469814","Thiago Amaro",md5('admin123'),"thiago.amaro.r@gmail.com","imagens/piccliente/3.jpg",3000);
insert into cliente values ("40781797896","Vinicius Costa",md5('admin123'),"vinicns91@gmail.com","imagens/piccliente/4.jpeg",3000);
insert into cliente values ("47925972858","Gabriel Costa",md5('admin123'),"gabriel.cns00@gmail.com","imagens/piccliente/1.jpeg",3000);
insert into cliente values ("47298410857","Luca Pedro",md5('admin123'),"lucadeveloperpk@gmail.com","imagens/piccliente/2.jpeg",3000);
insert into cliente values ("39185491861","Yuri Flausino",md5('admin123'),"yuriflausino14@gmail.com","imagens/piccliente/5.jpeg",3000);

/*Tipo Prato*/
insert into tipo_prato values (1,"Entradas");
insert into tipo_prato values (2,"Principais");
insert into tipo_prato values (3,"Porções");
insert into tipo_prato values (4,"Pizzas");
insert into tipo_prato values (5,"Salgados");
insert into tipo_prato values (6,"Massas");
insert into tipo_prato values (7,"Lanches");
insert into tipo_prato values (8,"Sobremesas");
insert into tipo_prato values (9,"Bebidas");
insert into tipo_prato values (10,"Açai");
insert into tipo_prato values (11,"Combo");
insert into tipo_prato values (12,"Acompanhamentos");
insert into tipo_prato values (13,"Adicionais");
insert into tipo_prato values (14,"Cafés");



/*Categoria*/
insert into categoria values (1,"Mexicana");
insert into categoria values (2,"Churrascaria");
insert into categoria values (3,"Árabe");
insert into categoria values (4,"Cafeteria");
insert into categoria values (5,"Pizzaria");
insert into categoria values (6,"Fast Food");
insert into categoria values (7,"Hamburgueria");
insert into categoria values (8,"Chinesa");
insert into categoria values (9,"Japonesa");
insert into categoria values (10,"Italiana");
insert into categoria values (11,"Lanchonete");
insert into categoria values (12,"Pastelaria");
insert into categoria values (13,"Sorveteria");
insert into categoria values (14,"Creperia");
insert into categoria values (15,"Por Quilo");
insert into categoria values (16,"Frutos do Mar");
insert into categoria values (17,"Saudável");
insert into categoria values (18,"Vegetariana");
insert into categoria values (19,"Açai");
insert into categoria values (20,"Brasileira");



/*Restaurantes*/
insert into restaurante values ("imagens/Ragazzo/logragazzo.png",'60746948510820','1333555443',"Ragazzo",10);/*1*/
insert into restaurante values ("imagens/china_in_box/log_china.jpg",'00517012000198','1333467683',"China In Box",8);/*2*/
insert into restaurante values ("imagens/Big_x_picanha/logbigxpicanha.webp",'17686110000151','1333675443',"Big X Picanha",7);/*3*/
insert into restaurante values ("imagens/croasonho/logo_croasonho.webp",'70543238876843','1333098743',"Croasonho",11);/*4*/
insert into restaurante values ("imagens/tio_sam_japa_food/logo_tio_sam.webp",'67594639571239','1333598453',"Tio Sam Japa Food",9);/*5*/
insert into restaurante values ("imagens/seu_temaki/logo_seutemaki.webp",'98450900034563','1333930244',"Seu Temaki",9);/*6*/
insert into restaurante values ("imagens/banzai/logo_ban.webp",'82300081236891','1332489630',"Banzai",9);/*7*/
insert into restaurante values ("imagens/quiosque_burgman/logo_burgman.webp",'62315943587966','1332659879',"Burgman",11);/*8*/
insert into restaurante values ("imagens/oakberry/logo_oakberry.webp",'40879632585865','1332322552',"Oakberry",19);/*9*/
insert into restaurante values ("imagens/brasileirinho/logo_brasileirinho.png",'65662348978806','1332705630',"Brasileirinho",20);/*10*/
insert into restaurante values ("imagens/mcdonald/logo_mcdonald.png",'21912193404921','1332066782',"Mc Donald's",6);/*11*/
insert into restaurante values ("imagens/salua/logo_salua.webp",'12136745334526','1333456238',"Saluá",3);/*12*/
insert into restaurante values ("imagens/nagasaki _ya/logo_nagasaki.webp",'69545560300155','1332300979',"Nagasaki Ya",9);/*13*/
insert into restaurante values ("imagens/kanashiro/logo_kanashiro.webp",'98445038000191','1332336556',"kanashiro",9);/*14*/
insert into restaurante values ("imagens/Okey-dokey/logo_okey-dokey.webp",'70348766554387','1332998782',"Okey-dokey American-mex",1);/*15*/
insert into restaurante values ("imagens/Cantina_di_lucca/logdilucca.png",'26549325558956','1332730782',"Cantina Di Lucca",10);/*16*/
insert into restaurante values ("imagens/spoleto/logo_spoleto.webp",'23248325558205','1332965782',"Spoleto",10);/*17*/
insert into restaurante values ("imagens/cozinha_do_roma/logo_cozinha_roma.webp",'50996645258098','1332963022',"Cozinha Do Roma",20);/*18*/
insert into restaurante values ("imagens/seven_kings/logo_seven_kings.webp",'32789896969632','1332973222',"Seven Kings",20);/*19*/
insert into restaurante values ("imagens/iphome/logo_iphome.webp",'98663233654044','1332528982',"Iphome",11);/*20*/
insert into restaurante values ("imagens/o_costelao/logo_o_costelao.webp",'60334456098530','1332528982',"Churrascaria O Custelão",2);/*21*/
insert into restaurante values ("imagens/cafe_87/logo_cafe87.webp",'56324591446635','1332118982',"Café 87",2);/*21*/
insert into restaurante values ("imagens/o_costelao/logo_o_costelao.webp",'39560145672313','1332528982',"Himalai Fit",17);/*29*/



/*adm restaurante*/
insert into adm_restaurante values ("ragazzo@ragazzo.com",'60746948510820',md5('admin123'),"São Paulo","Santos",'11060000', "Av Ana Costa, 437", "Gonzaga","","Marcelo Fernandes",'40787678995',"-23.961878","-46.332258");
insert into adm_restaurante values ("china_in_box@china.com",'00517012000198',md5('admin123'),"São Paulo","Santos",'11060470', "Rua Dr Tolentino Filgueiras, 54", "Gonzaga","","Hamilton Tavares",'55517489778',"-23.964697","-46.330218");
insert into adm_restaurante values ("big_x_picanha@big.com",'17686110000151',md5('admin123'),"São Paulo","Santos",'11060000', "Av Ana Costa, 318", "Campo Grande","Loja 3","Armindo Silva",'15900699862',"-23.958158","-46.331896");
insert into adm_restaurante values ("croasonho@croasonho.com",'70543238876843',md5('admin123'),"São Paulo","Santos",'11055200', "Rua Dr Galeão Carvalhal, 15", "Gonzaga","","Mario Algusto",'40787678995',"-23.968021","-46.330146");
insert into adm_restaurante values ("tiosamt@tiosam.com",'67594639571239',md5('admin123'),"São Paulo","São Vicenete",'11310070', "Rua Jacob Emmerich, 788", "Centro","","Fabiana Freitas",'13452678667',"-23.965829","-46.388459");
insert into adm_restaurante values ("seutemaki@seutemaki.com",'98450900034563',md5('admin123'),"São Paulo","Santos",'11060000',"Av Ana Costa, 108", "Vila Matias","","Danilo Gentil",'1713212139',"-23.948272","-46.3315722");
insert into adm_restaurante values ("banzai@banzai.com",'82300081236891',md5('admin123'),"São Paulo","Santos",'11050101',"R. Goiás, 26 ", "Boqueirão","","Josefa dos Remedios",'19478821322',"-23.96086","-46.3266267");
insert into adm_restaurante values ("quiosqueburgman@quiosqueburgman.com",'62315943587966',md5('admin123'),"São Paulo","Santos",'11030380',"Av. Rei Alberto I, 280 ","Ponta da Praia","","Maicon Rissi",'10598761322',"23.9890543","-46.3017353");
insert into adm_restaurante values ("oakberry@oakberry.com",'40879632585865',md5('admin123'),"São Paulo","Santos",' 11060002',"Av. Ana Costa, 549","Gonzaga","","Maicon Rissi",'25663215987',"-23.9687518","-46.3348945");







/*prato*/
/*Ragazzo Pizzas*/
insert into prato values ('60746948510820',1001,1,4,"imagens/Ragazzo/pizzas/pizza_portuguesa.png","Portuguesa","Mussarela, Presunto, Ovo Cozido, Ervilha, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$32,90");
insert into prato values ('60746948510820',1002,1,4,"imagens/Ragazzo/pizzas/pizza_4_queijo.png","4 Queijos","Mussarela, Provolone, Gorgonzola, Cremely, Oregano, Molho de Tomate e Azeitonas.","R$36,90");
insert into prato values ('60746948510820',1003,1,4,"imagens/Ragazzo/pizzas/pizza_mussarela.png","Mussarela","Mussarela, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('60746948510820',1004,1,4,"imagens/Ragazzo/pizzas/pizza_calabresa.png","Calabresa","Rodelas de Calabresa, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('60746948510820',1005,1,4,"imagens/Ragazzo/pizzas/pizza_margueita_speciale.png","Marguerita Speciale","Molho de Tomate, Mussarela, Tomate Cereja, Manjericão e Azeitonas Pretas.","R$36,90");
insert into prato values ('60746948510820',1006,1,4,"imagens/Ragazzo/pizzas/pizza_a_moda_da_casa.png","Moda da Casa","Mussarela, Rodelas de Calabresa, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('60746948510820',1007,1,4,"imagens/Ragazzo/pizzas/pizza_meia_margueita_speciale_meia_portuguesa.png","1/2 Marguerita Speciale 1/2 Portuguesa","Molho de Tomate, Mussarela, Tomate Cereja, Manjericão e Azeitonas Pretas, Mussarela, Presunto, Ovo Cozido, Ervilha, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$34,90");
insert into prato values ('60746948510820',1008,1,4,"imagens/Ragazzo/pizzas/pizza_meia_margueita_speciale_meia_4_queijo.png","1/2 Marguerita Speciale 1/2 4 Queijos","Molho de Tomate, Mussarela, Tomate Cereja, Manjericão e Azeitonas Pretas, Mussarela, Provolone, Gorgonzola, Cremely, Oregano, Molho de Tomate e Azeitonas.","R$36,90");
insert into prato values ('60746948510820',1009,1,4,"imagens/Ragazzo/pizzas/pizza_meia_brocolis_com_philadelphia_meia_peperoni_premiato.png","1/2 Brocolis com Philadelphia 1/2 Pepperoni Premiato ","Brocolis Frescos com Alho Frito, Bacon, Parmesão, Mussarela Premium, e Azeitonas, Tudo Coberto com Philadelphia, Molho de Tomate, Pepperoni Fatiado, Mussarela, Azeitonas Pretas e Queijo Philadelphia.","R$36,90");


/*Ragazzo Salgados*/
insert into prato values ('60746948510820',1010,1,5,"imagens/Ragazzo/salgados/big_croc.png","Big Croc","Maior E Com Mais Recheio, Creme De Frango Temperado E Cremely.","R$3,90");
insert into prato values ('60746948510820',1011,1,5,"imagens/Ragazzo/salgados/combo_crocantoso.png","Combo Crocantoso","15 Coxinhas De Qualquer Sabor.","R$27,90");
insert into prato values ('60746948510820',1012,1,5,"imagens/Ragazzo/salgados/coxinha_frango_com_cremily.png","Coxinha De Frango com Cremely","Massa Crocante Por Fora E Cremosa Por Dentro Recheada Com Creme De Frango Temperado E Cremely.","R$1,98");
insert into prato values ('60746948510820',1013,1,5,"imagens/Ragazzo/salgados/coxinha_bacon_chedar.png","Coxinha De Bacon com Chedar","Recheada Com Cheddar e Bacon Picado.","2,38");
insert into prato values ('60746948510820',1014,1,5,"imagens/Ragazzo/salgados/coxinha_calabresa.png","Coxinha De Calabresa","Massa Crocante Por Fora E Cremosa Por Dentro Recheada Com Pedaços De Calabresa.","R$1,98");
insert into prato values ('60746948510820',1015,1,5,"imagens/Ragazzo/salgados/coxinha_catupiry_com_bacon.png","Coxinha De Catupiry Com Bacon","Recheada Com Catupiry Com Bacon.","R$2,38");
insert into prato values ('60746948510820',1016,1,5,"imagens/Ragazzo/salgados/coxinha_4_queijo.png","Coxinha De 4 Queijos","Recheada Com Mussarela, Provolone, Gorgonzola E Cremely.","R$2,38");
insert into prato values ('60746948510820',1017,1,5,"imagens/Ragazzo/salgados/fogazza_mussarela.png","Fogazza De Mussarela","Massa Sequinha Recheada Com Mussarela E Pedaços De Tomates.","R$4,20");
insert into prato values ('60746948510820',1018,1,5,"imagens/Ragazzo/salgados/fogazza_calabresa.png","Fogazza De Calabresa","Massa Sequinha Recheada Com Pedaços De Calabresa.","R$4,20");


/*Ragazzo Massas*/
insert into prato values ('60746948510820',1019,1,6,"imagens/Ragazzo/massas/nhoque_sugo.png","Nhoque Ao Sugo","Massa Feita Com Batata E Coberta Por Molho Feito Com Tomates Frescos.","R$8,90");
insert into prato values ('60746948510820',1020,1,6,"imagens/Ragazzo/massas/nhoque_bolonhesa.png","Nhoque Ao Molho Bolonhesa","Massa Feita Com Batata E Coberta Por Molho Feito Com Tomates E Carne Moída.","R$11,90");
insert into prato values ('60746948510820',1021,1,6,"imagens/Ragazzo/massas/nhoque_recheado_com_queijo_ao_sugo.png","Nhoque Recheado Com Queijo Ao Sugo","Massa Recheada Com Queijo E Coberta Por Molho Feito Com Tomates Frescos.","R$14,90");
insert into prato values ('60746948510820',1022,1,6,"imagens/Ragazzo/massas/nhoque_recheado_com_queijo_a_bolonhesa.png","Nhoque Recheado Com Queijo A Bolonhesa","Massa Recheada Com Queijo E Coberta Por Molho Feito Com Tomates E Carne Moída.","R$17,90");
insert into prato values ('60746948510820',1023,1,6,"imagens/Ragazzo/massas/nhoque_recheado_com_queijo_a_4_queijo.png","Nhoque Com Molho 4 Queijos","Massa Feita Com Batata E Coberta Por Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$11,90");
insert into prato values ('60746948510820',1024,1,6,"imagens/Ragazzo/massas/nhoque_4_queijo.png","Nhoque Com Molho 4 Queijos","Massa Feita Com Batata E Coberta Por Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$11,90");
insert into prato values ('60746948510820',1025,1,6,"imagens/Ragazzo/massas/raviole_mussarela_com_molho_calabresa_e_bacon.png","Raviole De Mussarela Com Molho De Calabresa E Bacon","Raviole De Mussarela Coberto Com Molho De Calabresa E Pedaços De Bacon.","R$21,90");
insert into prato values ('60746948510820',1026,1,6,"imagens/Ragazzo/massas/fettuccine_sugo.png","Fettuccine Ao Sugo","Tirinhas De Massa Fresca Com Molho Feito Com Tomates E Especiarias.","R$8,90");
insert into prato values ('60746948510820',1027,1,6,"imagens/Ragazzo/massas/fettuccine_4_queijo.png","Fettuccine Com Molho 4 Queijos","Tirinhas De Massa Fresca Coberta Pelo Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone.","R$11,90");
insert into prato values ('60746948510820',1028,1,6,"imagens/Ragazzo/massas/fettuccine_bolonhesa.png","Fettuccine A Bolonhesa","Tirinhas De Massa Fresca Com Molho Feito Com Carne Moida E Tomates Frescos.","R$11,90");
insert into prato values ('60746948510820',1029,1,6,"imagens/Ragazzo/massas/espaguete_4_queijo.png","Espaguete Com Molho 4 Queijos","Massa Coberta Pelo Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$11,90");
insert into prato values ('60746948510820',1030,1,6,"imagens/Ragazzo/massas/espaguete_almondega_sg.png","Espaguete Com Almondega Sg","Massa Com Almondegas Coberta Por Molho Feito De Tomates Frescos.","R$17,50");
insert into prato values ('60746948510820',1031,1,6,"imagens/Ragazzo/massas/lasanha_bolonhesa.png","Lasanha Bolonhesa","Massa Recheada Com Mussarela, Presunto E Coberta Com Molho De Tomate.","R$21,90");
insert into prato values ('60746948510820',1032,1,6,"imagens/Ragazzo/massas/lasanha_vegetariana.png","Lasanha Vegetariana","Massa Verde Recheada Com Seleta De Legumesedaços E Coberta Com Molho Ao Sugo.","R$21,90");
insert into prato values ('60746948510820',1033,1,6,"imagens/Ragazzo/massas/lasanha_4_queijo.png","Lasanha 4 Queijos","Massa Recheada Com Mussarela, Presunto E Coberta Com Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$21,90");




/*Ragazzo Pratos Principais*/
insert into prato values ('60746948510820',1034,1,6,"imagens/Ragazzo/massas/file_a_parmegiana_com_penne.png","Filé A Parmegiana Com Penne","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$38,90");
insert into prato values ('60746948510820',1035,1,6,"imagens/Ragazzo/massas/file_mignom_com_penne.png","Filé Mignom Com Penne","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$36,90");
insert into prato values ('60746948510820',1036,1,6,"imagens/Ragazzo/pratos/polenta_com_molho_calabresa_com_bacon.png","Polenta Com Molho Calabresa Com Bacom","Coberto Com Molho De Calabresa E Pedaços De Bacon.","R$38,90");
insert into prato values ('60746948510820',1037,1,6,"imagens/Ragazzo/pratos/file_de_frango_grelhado.png","Filé De Frango Grelhado","Filé de frango deliciosamente grelhado e temperado na medida certa.","R$10,90");
insert into prato values ('60746948510820',1038,1,6,"imagens/Ragazzo/pratos/file_de_frango_a_parmegiana_com_arroz.png","Filé De Frango Á Parmegiana Com Arroz","Filé de frango empanado coberto com mussarela e molho de tomates. acompanha arroz branco.","R$26,90");
insert into prato values ('60746948510820',1039,1,6,"imagens/Ragazzo/pratos/risoto_camarao.png","Risoto De Camarão","Um risoto cremosíssimo preparado com camarões fresquinhos.","R$25,90");
insert into prato values ('60746948510820',1040,1,6,"imagens/Ragazzo/pratos/file_grelhado_com_fritas_e_arroz_branco.png","Filé Grelhado Com Fritas E Arroz Branco","Filé Mignom grelhado com batata-frita e arroz branco soltinho.","R$38,90");
insert into prato values ('60746948510820',1041,1,6,"imagens/Ragazzo/pratos/file_de_frango_grelhado_com_arroz_e_fritas.png","Filé De Frango Grelhado Arroz Branco E Fritas","Filé de frango grelhado com batata-frita e arroz branco soltinho.","R$19,50");
insert into prato values ('60746948510820',1042,1,6,"imagens/Ragazzo/pratos/file_de_frango_a_parmegiana_com_penne.png","Filé De Frango A Parmegiana Com Penne","Filé de frango empanado coberto com mussarela e molho de tomates. Acompanha massa.","R$26,90");
insert into prato values ('60746948510820',1043,1,6,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Risoto Funghi Secci","Um risoto cremosíssimo preparado com cogumélo funghi secchi.","R$22,90");


/*Ragazzo Saladas*/
insert into prato values ('60746948510820',1044,1,6,"imagens/Ragazzo/saladas/salada_ceasar.png","Salada Ceasar","Apenas com ingredientes selecionados e fresquinhos, nossa salada caesar é feita com alface americana, frango desfiado temperado, mussarela ralada, croutons e bacon para dar um toque especial do ragazzo. acompanha molho caesar.","R$16,90");
insert into prato values ('60746948510820',1045,1,6,"imagens/Ragazzo/saladas/salada_ceasar_de_camarao.png","Salada Ceasar com Camarão","Apenas com ingredientes selecionados e fresquinhos, nossa salada caesar é feita com alface americana, frango desfiado temperado, mussarela ralada,croutons, camarões cozidos e bacon para dar um toque especial do ragazzo. acompanha molho caesar.","R$22,90");


/*Ragazzo Lanches*/
insert into prato values ('60746948510820',1046,1,6,"imagens/Ragazzo/lanches/chicken_crispy_file.png","Chicken Crispy File","Chicken crispy filé é um sanduíche muito bem recheado com peito de frango de verdade empanado, alface, tomate e temperado com maionese especial e cremely.","R$12,90");
insert into prato values ('60746948510820',1047,1,6,"imagens/Ragazzo/lanches/panino_de_file_de_frango.png","Panino de File de Frango","Pão ciabatta, filé de frango grelhado, molho especial, queijo prato, azeitona, tomate, maionese e rúcula.","R$22,90");
insert into prato values ('60746948510820',1048,1,6,"imagens/Ragazzo/lanches/panino_de_peito_de_peru.png","Panino de Peito de Peru","Pão ciabatta, peito de peru, ovo frito, queijo prato, cremely, alface, tomate e maionese.","R$22,90");
insert into prato values ('60746948510820',1049,1,6,"imagens/Ragazzo/lanches/quadraburguer.png","Quadraburguer","Panino crocante recheado com ovo quadrado, hambúrguer quadrado com toque de churrasco*, queijos prato e cheddar, cremely, ketchup e mostarda, alface, tomate, maionese e molho especial. Vai","R$26,90");
insert into prato values ('60746948510820',1050,1,6,"imagens/Ragazzo/lanches/quadraburguer_picanha_chedar_bacon.png","Quadraburguer Picanha Chedar Bacon","Panino crocante recheado com ovo quadrado, hambúrguer quadrado com toque de churrasco*, bacon fatiado, queijos prato e cheddar, alface, tomate e maionese. Faz uma selfie antes!","R$26,90");

/*Ragazzo Sobremesas*/
insert into prato values ('60746948510820',1051,1,6,"imagens/Ragazzo/sobremesas/churros_de_doce_de_leite.png","Minichurros de Doce de Leite","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$1,98");
insert into prato values ('60746948510820',1052,1,6,"imagens/Ragazzo/sobremesas/minichurros_chocolate_com_avela.png","Minichurros de Chocolate com Avelã","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$1,98");
insert into prato values ('60746948510820',1053,1,6,"imagens/Ragazzo/sobremesas/minichurros_de_goiabada.png","Minichurros de Goiabada","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$1,98");
insert into prato values ('60746948510820',1054,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_chocolate_com_amendoas.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1055,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_coco.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1056,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_doce_de_leite.png","Sorvete Artesanal 1L","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$22,90");
insert into prato values ('60746948510820',1057,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_flocos.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1058,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_frutas_vermelhas.png","Sorvete Artesanal 1L","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$22,90");
insert into prato values ('60746948510820',1059,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_limao_siciliano.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1060,1,6,"imagens/Ragazzo/sobremesas/sorvete_artesanal_morango_com_pedacos.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1061,1,6,"imagens/Ragazzo/sobremesas/tacai.png","Taça de Açai","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$19,90");


/*Ragazzo Sobremesas*/
insert into prato values ('60746948510820',1062,1,6,"imagens/Ragazzo/bebidas/coca_cola_2L.png","Coca Cola 2L","Refrigerante gelado, perfeito para a galera e para a família inteira.","R$11,90");
insert into prato values ('60746948510820',1063,1,6,"imagens/Ragazzo/bebidas/coca_cola_zero_2L.png","Coca Cola Zero 2L","Refrigerante gelado, perfeito para a galera e para a família inteira.","R$11,90");
insert into prato values ('60746948510820',1064,1,6,"imagens/Ragazzo/bebidas/guarana_kuat_2L.png","Guarana Kuat 2L","Refrigerante gelado, perfeito para a galera e para a família inteira.","R$11,90");
insert into prato values ('60746948510820',1065,1,6,"imagens/Ragazzo/bebidas/coca_cola_lata.png","Coca Cola Lata","Refrigerante gelado, perfeito para você.","R$8,90");
insert into prato values ('60746948510820',1066,1,6,"imagens/Ragazzo/bebidas/coca_cola_zero_lata.png","Coca Cola Zero Lata","Refrigerante gelado, perfeito para você.","R$8,90");
insert into prato values ('60746948510820',1067,1,6,"imagens/Ragazzo/bebidas/guarana_kuat_lata.png","Guaraná Kuat Lata","Refrigerante gelado, perfeito para você.","R$8,90");
insert into prato values ('60746948510820',1068,1,6,"imagens/Ragazzo/bebidas/suco_abacaxi_500ml.png","Suco Abacaxi 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1069,1,6,"imagens/Ragazzo/bebidas/suco_abacaxi_com_hortela_500ml.png","Suco Abacaxi com hortelã 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$10,90");
insert into prato values ('60746948510820',1070,1,6,"imagens/Ragazzo/bebidas/suco_goiaba_500ml.png","Suco Goiaba 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1071,1,6,"imagens/Ragazzo/bebidas/suco_laranja_500ml.png","Suco Laranja 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1072,1,6,"imagens/Ragazzo/bebidas/suco_laranja_com_mamao_500ml.png","Suco Laranja com Mamão 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$10,90");
insert into prato values ('60746948510820',1073,1,6,"imagens/Ragazzo/bebidas/suco_limao_500ml.png","Suco Limao 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1074,1,6,"imagens/Ragazzo/bebidas/suco_manga_500ml.png","Suco Manga 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1075,1,6,"imagens/Ragazzo/bebidas/suco_maracuja_500ml.png","Suco Maracujá 500m","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1076,1,6,"imagens/Ragazzo/bebidas/suco_morango_500ml.png","Suco Morango 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1077,1,6,"imagens/Ragazzo/bebidas/suco_uva_500ml.png","Suco Uva 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1078,1,6,"imagens/Ragazzo/bebidas/suco_natureba_acai_500ml.png","Suco Natureba Acai 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1079,1,6,"imagens/Ragazzo/bebidas/suco_natureba_amora_500ml.png","Suco Natureba Amora 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1080,1,6,"imagens/Ragazzo/bebidas/suco_natureba_blueberry_500ml.png","Suco Natureba Blueberry 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1081,1,6,"imagens/Ragazzo/bebidas/suco_natureba_framboesa_500ml.png","Suco Natureba Framboesa 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1082,1,6,"imagens/Ragazzo/bebidas/suco_natureba_verde_detox_500ml.png","Suco Natureba Verde Detox 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");



/*Forma Pagamento*/
	/*Ragazzo*/
	insert into forma_pagamento values ('60746948510820',1001,"Cartão de Crédito");
	insert into forma_pagamento values ('60746948510820',1002,"Cartão de Débito");
	insert into forma_pagamento values ('60746948510820',1003,"Dinheiro");
	insert into forma_pagamento values ('60746948510820',1004,"Sodexo");
	insert into forma_pagamento values ('60746948510820',1005,"Ticket");

/*Recompensas*/
insert into recompensas values ('60746948510820',1001,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('60746948510820',1002,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('60746948510820',1003,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('60746948510820',1004,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('60746948510820',1005,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('60746948510820',1006,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('60746948510820',1007,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('60746948510820',1008,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*prato*/
/*China In Box Macarão Oriental*/
insert into prato values ('00517012000198',2001,1,6,"imagens/china_in_box/macarao_oriental/macarao_oriental_taiwan.png","Macarrão Oriental Taiwan","Macarrão Com Molho À Base De Shoyo Coberto Com Pedaços De Frango Crispy Ou Lombo Crispy E Cebolinha Picada.","R$16,90");
insert into prato values ('00517012000198',2002,1,6,"imagens/china_in_box/macarao_oriental/macarao_oriental_xian.png","Macarrão Oriental Xian","Macarrão Com Molho À Base De Shoyo Cubos De Frango E Legumes.","R$17,90");

/*China In Box Hotroll*/
insert into prato values ('00517012000198',2003,1,1,"imagens/china_in_box/hot_roll/hot_roll_salmao_grelhado.png","Hotroll Salmão Grelhado(3 Unidades)","Enrolado Empanado Com Salmão Grelhado, Cream Chese, Cebolinha E Molho Tarê.","R$7,90");
insert into prato values ('00517012000198',2004,1,1,"imagens/china_in_box/hot_roll/hot_roll_salmao_grelhado.png","Hotroll Salmão Grelhado(6 Unidades)","Enrolado Empanado Com Salmão Grelhado, Cream Chese, Cebolinha E Molho Tarê.","R$13,50");

/*China In Box China Bowl*/
insert into prato values ('00517012000198',2005,1,2,"imagens/china_in_box/china_bowl/china_bowl_camarao.png","China Bowl Camarão","Yakimeshi Com Camarão E Legumes Ao Molho De Soja.","R$33,90");
insert into prato values ('00517012000198',2006,1,2,"imagens/china_in_box/china_bowl/china_bowl_carne.png","China Bowl Carne","Yakimeshi Com Carne Fatiada, Cebola E Pimentão Ao Molho De Soja.","R$25,90");
insert into prato values ('00517012000198',2007,1,2,"imagens/china_in_box/china_bowl/china_bowl_frango.png","China Bowl Frango","Yakimeshi Com Frango, Cenoura E Cebolinha Ao Molho De Soja.","R$24,90");
insert into prato values ('00517012000198',2008,1,2,"imagens/china_in_box/china_bowl/china_bowl_frango_crispy.png","China Bowl Frango Crispy","Yakimeshi E Pedaços De Frango Empanado Com Farinha Crocante Salpicado Com Cebolinha E Molho Oriental.","R$20,90");

/*China In Box China Mix*/
insert into prato values ('00517012000198',2009,1,2,"imagens/china_in_box/china_mix/china_mix_carne_com_batata_imperial.png","Mix Carne Com Batata Imperial","Carne Com Batata + Nosso Tradicional Yakimeshi + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$35,90");
insert into prato values ('00517012000198',2010,1,2,"imagens/china_in_box/china_mix/china_mix_carne_com_legumes.png","Mix Carne Com Legumes","Carne Com Legumes + Nosso Tradicional Yakimeshi + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$35,90");
insert into prato values ('00517012000198',2011,1,2,"imagens/china_in_box/china_mix/china_mix_frango_oriental_karaague.png","Mix Frango Oriental Karaague","Frango Crocante Temparado à Moda Oriental Temparado Com Gengibre, Empanado E Frito + Yakissoba De Vegetariano+ Tradicional E Delicioso Rolinho Primavera Ou De Queijo + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$34,50");
insert into prato values ('00517012000198',2012,1,2,"imagens/china_in_box/china_mix/china_mix_frango_xadrez.png","Mix Frango Xadrez","Frango Xadrez + Nosso Tradicional Yakimeshi + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$34,50");
insert into prato values ('00517012000198',2013,1,2,"imagens/china_in_box/china_mix/china_mix_yakissoba_classico.png","Mix Yakissoba Clássico","Yakissoba + Tradicional E Delicioso Rolinho Primavera + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$34,50");




/*China In Box Yakissoba*/
insert into prato values ('00517012000198',2014,1,6,"imagens/china_in_box/yakissoba/yakissoba_classico_grande.png","Yakissoba Clássico","Mussarela, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('00517012000198',2015,1,6,"imagens/china_in_box/yakissoba/yakissoba_de_camarao_grande.png","Yakissoba De Camarão","Rodelas de Calabresa, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('00517012000198',2016,1,6,"imagens/china_in_box/yakissoba/yakissoba_de_carne_grande.png","Yakissoba De Carne","Nosso tradicional macarrão com carne, legumes e champignons.","R$34,50");
insert into prato values ('00517012000198',2017,1,6,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Yakissoba Especial","A Mistura Perfeita Do Nosso Clássico Yakissoba De Carne, Frango E Camarão Com Legumes Frescos E Champignons..","R$46,50");



/*China In Box Carnes*/
insert into prato values ('00517012000198',2018,1,2,"imagens/china_in_box/carne/carne_com_batata_imperial_pequeno.png","Carne Com Batata Imperial Pequeno","Carne fatiada com batata e cebolinha, temperadas ao molho de soja.","R$45,50");
insert into prato values ('00517012000198',2019,1,2,"imagens/china_in_box/carne/carne_com_batata_imperial_grande.png","Carne Com Batata Imperial Grande","Carne fatiada com batata e cebolinha, temperadas ao molho de soja.","R$62,90");
insert into prato values ('00517012000198',2020,1,2,"imagens/china_in_box/carne/carne_com_batata_imperial_executivo_pequeno.png","Carne Com Batata Imperial Executivo Pequeno","Carne fatiada com batata e cebolinha, temperadas ao molho de soja. acompanha yakimeshi.","R$36,50");
insert into prato values ('00517012000198',2021,1,2,"imagens/china_in_box/carne/carne_com_batata_imperial_executivo_grande.png","Carne Com Batata Imperial Executivo Grande","Carne fatiada com batata e cebolinha, temperadas ao molho de soja. acompanha yakimeshi.","R$47,50");
insert into prato values ('00517012000198',2022,1,2,"imagens/china_in_box/carne/carne_com_cebola_pequeno.png","Carne Com Cebola Pequeno","Carne fatiada com cebola temperada ao molho de soja.","R$45,50");
insert into prato values ('00517012000198',2023,1,2,"imagens/china_in_box/carne/carne_com_cebola_grande.png","Carne Com Cebola Grande","Carne fatiada com cebola temperada ao molho de soja.","R$62,90");
insert into prato values ('00517012000198',2024,1,2,"imagens/china_in_box/carne/carne_com_cebola_executivo_pequeno.png","Carne Com Cebola Executivo Pequeno","Carne fatiada com cebola temperada ao molho de soja. acompanha yakimeshi. acompanha yakimeshi.","R$47,50");
insert into prato values ('00517012000198',2025,1,2,"imagens/china_in_box/carne/carne_com_cebola_executivo_grande.png","Carne Com Cebola Executivo Grande","Carne fatiada com cebola temperada ao molho de soja. acompanha yakimeshi..","R$1,98");
insert into prato values ('00517012000198',2026,1,2,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_pequeno.png","Carne com legumes chop suey Pequeno","Carne fatiada com legumes temperados ao molho de soja.","R$43,50");
insert into prato values ('00517012000198',2027,1,2,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_grande.png","Carne com legumes chop suey Grande","Carne fatiada com legumes temperados ao molho de soja.","R$59,90");
insert into prato values ('00517012000198',2028,1,2,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_executivo_pequeno.png","Carne com legumes chop suey Executivo Pequeno","Carne fatiada com legumes temperados ao molho de soja. acompanha yakimeshi.","R$34,50");
insert into prato values ('00517012000198',2029,1,2,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_executivo_grande.png","Carne com legumes chop suey Executivo Grande","Carne fatiada com legumes temperados ao molho de soja. acompanha yakimeshi.","R$44,90");


/*China In Box Frangos*/
insert into prato values ('00517012000198',2030,1,2,"imagens/china_in_box/frango/frango_agridoce_pequeno.png","Frango Agridoce Pequeno","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão.","R$35,50");
insert into prato values ('00517012000198',2031,1,2,"imagens/china_in_box/frango/frango_agridoce_grande.png","Frango Agridoce Grande","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão.","R$49,50");
insert into prato values ('00517012000198',2032,1,2,"imagens/china_in_box/frango/frango_agridoce_executivo_pequeno.png","Frango Agridoce Executivo Pequeno","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$28,90");
insert into prato values ('00517012000198',2033,1,2,"imagens/china_in_box/frango/frango_agridoce_executivo_grande.png","Frango Agridoce Executivo Grande","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$37,90");
insert into prato values ('00517012000198',2034,1,2,"imagens/china_in_box/frango/frango_oriental_karaague.png","Frango Oriental Karaague Pequeno","Pedaços de frango empanados e temperados à moda oriental com gengibre.","R$38,50");
insert into prato values ('00517012000198',2035,1,2,"imagens/china_in_box/frango/frango_oriental_karaague.png","Frango Oriental Karaague Grande","Pedaços de frango empanados e temperados à moda oriental com gengibre.","R$53,90");
insert into prato values ('00517012000198',2036,1,2,"imagens/china_in_box/frango/frango_oriental_karaague_executivo.png","Frango Oriental Karaague Executivo Pequeno","Pedaços de frango empanados e temperados à moda oriental com gengibre. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$31,90");
insert into prato values ('00517012000198',2037,1,2,"imagens/china_in_box/frango/frango_oriental_karaague_executivo.png","Frango Oriental Karaague Executivo Grande","Pedaços de frango empanados e temperados à moda oriental com gengibre. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$41,50");
insert into prato values ('00517012000198',2038,1,2,"imagens/china_in_box/frango/frango_xadrez_pequeno.png","Frango Xadrez Pequeno","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu.","R$38,50");
insert into prato values ('00517012000198',2039,1,2,"imagens/china_in_box/frango/frango_xadrez_grande.png","Frango Xadrez Grande","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu.","R$53,90");
insert into prato values ('00517012000198',2040,1,2,"imagens/china_in_box/frango/frango_xadrez_executivo_pequeno.png","Frango Xadrez Executivo Pequeno","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$31,90");
insert into prato values ('00517012000198',2041,1,2,"imagens/china_in_box/frango/frango_xadrez_executivo_grande.png","Frango Xadrez Executivo Grande","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$41,50");
insert into prato values ('00517012000198',2042,1,2,"imagens/china_in_box/frango/frango_crispy_pequeno.png","Frango Crispy Pequeno","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$35,51");
insert into prato values ('00517012000198',2043,1,2,"imagens/china_in_box/frango/frango_crispy_grande.png","Frango Crispy Grande","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$49,91");
insert into prato values ('00517012000198',2044,1,2,"imagens/china_in_box/frango/frango_crispy_executivo_pequeno.png","Frango Crispy Executivo Pequeno","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$29,51");
insert into prato values ('00517012000198',2045,1,2,"imagens/china_in_box/frango/frango_crispy_executivo_grande.png","Frango Crispy Executivo Grande","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$37,91");
insert into prato values ('00517012000198',2046,1,2,"imagens/china_in_box/frango/frango_empanado_pequeno.png","Frango Empanado Pequeno","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$35,51");
insert into prato values ('00517012000198',2047,1,2,"imagens/china_in_box/frango/frango_empanado_grande.png","Frango Empanado Grande","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$49,91");
insert into prato values ('00517012000198',2048,1,2,"imagens/china_in_box/frango/frango_empanado_executivo_pequeno.png","Frango Empanado Executivo Pequeno","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha..","R$29,51");
insert into prato values ('00517012000198',2049,1,2,"imagens/china_in_box/frango/frango_empanado_executivo_grande.png","Frango Empanado Executivo Grande","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$37,91");


/*China In Box Camarão E Lombo*/
insert into prato values ('00517012000198',2050,1,2,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_pequeno.png","Lombo crispy Pequeno","Pedaços de lombo crispy com cebolinha.","R$35,50");
insert into prato values ('00517012000198',2051,1,2,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_grande.png","Lombo crispy Grande","Pedaços de lombo crispy com cebolinha.","R$49,90");
insert into prato values ('00517012000198',2052,1,2,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_executivo_pequeno.png","Lombo crispy Executivo Pequeno","Pedaços de lombo crispy com cebolinha. Acompanha Yakimeshi.","R$29,50");
insert into prato values ('00517012000198',2053,1,2,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_executivo_grande.png","Lombo crispy Executivo Grande","Pedaços de lombo crispy com cebolinha. Acompanha Yakimeshi.","R$37,90");
insert into prato values ('00517012000198',2054,1,2,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_pequeno.png","Camarão Ao Molho Apimentado Pequeno","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante.","R$67,80");
insert into prato values ('00517012000198',2055,1,2,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_grande.png","Camarão Ao Molho Apimentado Grande","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante.","R$94,20");
insert into prato values ('00517012000198',2056,1,2,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_executivo_pequeno.png","Camarão Ao Molho Apimentado Executivo Pequeno","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante. acompanha yakimeshi.","R$55,50");
insert into prato values ('00517012000198',2057,1,2,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_executivo_grande.png","Camarão Ao Molho Apimentado Executivo Grande","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante. acompanha yakimeshi.","R$71,20");

/*China In Box Entradas*/
insert into prato values ('00517012000198',2058,1,1,"imagens/china_in_box/entradas/batata_frita.png","Batata Frita","Deliciosa batata frita crocante (230g).","R$14,90");
insert into prato values ('00517012000198',2059,1,1,"imagens/china_in_box/entradas/camarao_empanado.png","Camarão Empanado (10 Unidades)","Camarão empanado e sequinho. Acompanha molho agridoce.","R$35,10");
insert into prato values ('00517012000198',2060,1,1,"imagens/china_in_box/entradas/gyoza.png","Gyoza","Massa fina recheada com carne temperado com gengibre.","R$23,90");
insert into prato values ('00517012000198',2061,1,1,"imagens/china_in_box/entradas/pao_chines.png","Pão Chinês (3 Unidades)","Pão macio e fofinho recheado de frango e legumes.","R$12,90");
insert into prato values ('00517012000198',2062,1,1,"imagens/china_in_box/entradas/rolinho_de_camarao_cremoso.png","Rolinho De Camarão Cremoso (2 Unidades)","Massa fina recheada com camarão, requeijão cremoso e cebolinha picada. Acompanha molho agridoce.","R$19,40");
insert into prato values ('00517012000198',2063,1,1,"imagens/china_in_box/entradas/rolinho_de_frango_com_requeijao.png","Rolinho De Frango Com Requeijão (2 Unidades)","Massa fina recheada com frango, cenoura, requeijão cremoso e cebolinha picada. Acompanha molho agridoce","R$10,80");
insert into prato values ('00517012000198',2064,1,1,"imagens/china_in_box/entradas/rolinho_de_queijo.png","Rolinho De Queijo (2 Unidades)","Massa fina recheada com mussarela. Acompanha molho agridoce.","R$10,80");
insert into prato values ('00517012000198',2065,1,1,"imagens/china_in_box/entradas/rolinho_primavera.png","Rolinho Primavera (2 Unidades)","Massa fina recheada com carne, repolho e cenoura. Acompanha molho agridoce.","R$10,40");
insert into prato values ('00517012000198',2066,1,1,"imagens/china_in_box/entradas/rolinho_vegetariano.png","Rolinho Vegetariano (2 Unidades)","Nossa tradicional receita de massa fina recheada com repolho e cenoura. Para acompanhar, molho agridoce.","R$10,40");
insert into prato values ('00517012000198',2067,1,1,"imagens/china_in_box/entradas/salada_china_in_box.png","Salada CIB Camarão","Camarão, Alface, Rúcula, Cenoura Desfiada, Palmito Pupunha E Azeitonas Pretas.","R$30,20");
insert into prato values ('00517012000198',2068,1,1,"imagens/china_in_box/entradas/salada_china_in_box.png","Salada CIB Frango","Frango, Alface, Rúcula, Cenoura Desfiada, Palmito Pupunha E Azeitonas Pretas.","R$21,50");

/*China In Box Sobremesas*/
insert into prato values ('00517012000198',2069,1,8,"imagens/china_in_box/sobremesas/banana_caramelada.png","Banana Caramelada (4 Unidades)","Pedaços de banana empanados e caramelados, salpicados com gergelim.","R$12,90");
insert into prato values ('00517012000198',2070,1,8,"imagens/china_in_box/sobremesas/rolinho_romeu_&_julieta.png","Rolinho Romeu E Julieta (2 Unidades)","Massa fina recheada com mussarela e goiabada coberta com canela e açúcar.","R$10,40");
insert into prato values ('00517012000198',2071,1,8,"imagens/china_in_box/sobremesas/rolinho_de_banana_com_chocolate.png","Rolinho Banana Com Chocolate (2 Unidades)","Massa fina recheada com banana e chocolate, coberta com canela e açúcar.","R$10,40");

/*China In Box Bebidas*/
insert into prato values ('00517012000198',2072,1,9,"imagens/china_in_box/bebidas/sucos.png","Suco Del Valle lata 290ml","Sabores: Maracujá, Pessego, Manga E Uva.","R$6,50");
insert into prato values ('00517012000198',2073,1,9,"imagens/china_in_box/bebidas/chas.png","Cha ice tea fuze 300ml","Sabores: Limão E Pessego.","R$6,90");
insert into prato values ('00517012000198',2074,1,9,"imagens/china_in_box/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$6,90");
insert into prato values ('00517012000198',2075,1,9,"imagens/china_in_box/bebidas/refrigerantes_2l.jpg","Refrigerante 2l","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$11,50");
insert into prato values ('00517012000198',2076,1,9,"imagens/china_in_box/bebidas/agua_gas.jpg","Agua C/gás 350 ml","Agua Mineral Com Gás.","R$4,60");
insert into prato values ('00517012000198',2077,1,9,"imagens/china_in_box/bebidas/agua.jpg","Agua S/gás 350 ml","Agua Mineral Sem Gás.","R$4,90");


/*Forma Pagamento*/
	/*China In Box*/
	insert into forma_pagamento values ('00517012000198',2001,"Cartão de Crédito");
	insert into forma_pagamento values ('00517012000198',2002,"Cartão de Débito");
	insert into forma_pagamento values ('00517012000198',2003,"Dinheiro");
	insert into forma_pagamento values ('00517012000198',2004,"Sodexo");
	insert into forma_pagamento values ('00517012000198',2005,"Ticket");

/*Recompensas*/
insert into recompensas values ('00517012000198',2001,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2002,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2003,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2004,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2005,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2006,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2007,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);


/*prato*/
/*Big X Picanha Burguers*/
insert into prato values ('17686110000151',3001,1,7,"imagens/Big_x_picanha/lanches/picanha_salada_burguer.webp","Picanha Salada Burguer","Hambúrguer de picanha 200g, queijo prato, maionese da casa, alface e tomate e pão brioche.","R$21,90");
insert into prato values ('17686110000151',3002,1,7,"imagens/Big_x_picanha/lanches/picanha_cheddar_burguer.webp","Picanha Cheddar Burguer","Hambúrguer de picanha 200g, cheddar, cebola caramelizada, maionese da casa e pão brioche.","R$22,90");
insert into prato values ('17686110000151',3003,1,7,"imagens/Big_x_picanha/lanches/cheddar_barbecue.webp","Cheddar Barbecue","Hambúrguer de picanha 200g, cheddar, bacon, cebola caramelizada, molho barbecue e pão brioche.","R$26,90");
insert into prato values ('17686110000151',3004,1,7,"imagens/Big_x_picanha/lanches/monstro_burguer.webp","Monstro Burguer","Hambúrguer de picanha 200g, queijo cheddar, bacon, picles, cebola roxa, alface, tomate, maionese da casa e pão brioche.","R$26,90");
insert into prato values ('17686110000151',3005,1,7,"imagens/Big_x_picanha/lanches/picanha_onion_rings.webp","Picanha Onion Rings","Hambúrguer de picanha 200g, cheddar, cebola empanada, bacon, molho bxp e pão brioche.","R$26,90");
insert into prato values ('17686110000151',3006,1,7,"imagens/Big_x_picanha/lanches/picanha_salada_egg_bacon.webp","Picanha Salada Egg Bacon","Hamburguer de picanha 200 g, ovo,bacon,queijo prato,maionese da casa,alface,tomate e pão com gergelim.","R$26,90");
insert into prato values ('17686110000151',3007,1,7,"imagens/Big_x_picanha/lanches/hamburguer_de_salmao.webp","Hamburguer De Salmão","Hamburguer de salmão,queijo mussarela,maionese da casa,alface,tomate e pão brioche","R$24,90");
insert into prato values ('17686110000151',3008,1,7,"imagens/Big_x_picanha/lanches/big_x_frango_catupiry.webp","Big X Frango Ao Catupiry","Frango filetado, queijo Catupiry, mussarela, maionese da casa e pão com gergelim.","R$23,90");


/*Forma Pagamento*/
	/*Big X Picanha*/
	insert into forma_pagamento values ('17686110000151',3001,"Cartão de Crédito");
	insert into forma_pagamento values ('17686110000151',3002,"Cartão de Débito");
	insert into forma_pagamento values ('17686110000151',3003,"Dinheiro");
	insert into forma_pagamento values ('17686110000151',3004,"Sodexo");
	insert into forma_pagamento values ('17686110000151',3005,"Ticket");

/*Recompensas*/
insert into recompensas values ('17686110000151',3001,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('17686110000151',3002,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('17686110000151',3003,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('17686110000151',3004,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('17686110000151',3005,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('17686110000151',3006,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('17686110000151',3007,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('17686110000151',3008,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);





/*Tabela de Pontos*/
insert into pontos_valor values (1,"R$10,00 - R$20,00",100);
insert into pontos_valor values (2,"R$20,00 - R$30,00",150);
insert into pontos_valor values (3,"R$30,00 - R$40,00",200);
insert into pontos_valor values (4,"R$40,00 - R$50,00",250);
insert into pontos_valor values (5,"R$50,00 - R$60,00",300);
insert into pontos_valor values (6,"R$60,00 - R$70,00",350);
insert into pontos_valor values (7,"R$70,00 - R$80,00",400);


/*Croasonhos salgados*/
insert into prato values ('70543238876843',4001,1,7,"imagens/croasonho/croasonhos_salgados/croaburger_classico.webp","Croaburger Classico","Molho parmesão, hambúrguer de carne, queijo cheddar, tomate, alface americana e batata chips.","R$16,90");
insert into prato values ('70543238876843',4002,1,7,"imagens/croasonho/croasonhos_salgados/croaburger_barbecue.webp","Croaburger Barbecue","Molho BBQ, hambúrguer de carne, queijo cheddar, anéis de cebola, bacon, tomate, alface americana e batata chips.","R$18,90");
insert into prato values ('70543238876843',4003,1,7,"imagens/croasonho/croasonhos_salgados/brocolis_requeijao_mussarela.webp","Brócolis, Requeijão e Mussarela","Brócolis, Requeijão, toque de Noz Moscada e Queijo Mussarela.","R$14,90");
insert into prato values ('70543238876843',4004,1,7,"imagens/croasonho/croasonhos_salgados/carne_de_panela.webp","Carne de Panela","Carne de Panela desfiada e Queijo Mussarela.","R$14,90");
insert into prato values ('70543238876843',4005,1,7,"imagens/croasonho/croasonhos_salgados/churrasco.webp","Churrasco","Assado de Vazio/Fraldinha com Cebola, Provolone e Mussarela.","R$16,50");
insert into prato values ('70543238876843',4006,1,7,"imagens/croasonho/croasonhos_salgados/estrogonofe_de_carne.webp","Estrogonofe de Carne","Estrogonofe de Carne e Champignon.","R$14,90");
insert into prato values ('70543238876843',4007,1,7,"imagens/croasonho/croasonhos_salgados/iscas_de_carne_5_queijos.webp","Iscas de Carne com 5 Queijos","Iscas de Carne com Queijos Mussarela, Prato, Provolone, Gorgonzola e Parmesão.","R$17,50");
insert into prato values ('70543238876843',4008,1,7,"imagens/croasonho/croasonhos_salgados/iscas_de_carne_cheddar.webp","Iscas de Carne e Queijo Cheddar","Iscas de Carne e Queijo Cheddar.","R$17,50");
insert into prato values ('70543238876843',4009,1,7,"imagens/croasonho/croasonhos_salgados/iscas_de_carne_requeijao_mussarela.webp","Iscas de Carne Requeijão e Mussarela","Iscas de Carne, Requeijão e Queijo Mussarela.","R$17,50");
insert into prato values ('70543238876843',4010,1,7,"imagens/croasonho/croasonhos_salgados/frango_com_5_queijos.webp","Frango com 5 Queijos","Peito de Frango em cubos, Palmito e Rucula com Queijos Mussarela, Prato, Provolone, Gorgonzola e Parmesão.","R$14,90");
insert into prato values ('70543238876843',4011,1,7,"imagens/croasonho/croasonhos_salgados/frango_creamcheese_bacon.webp","Frango com Cream Cheese e Bacon","Peito de Frango em cubos de frango, Cream Cheese, Bacon, Alface e Tomate.","R$15,50");
insert into prato values ('70543238876843',4012,1,7,"imagens/croasonho/croasonhos_salgados/frango_com_queijo_cremoso.webp","Frango com Queijo Cremoso","Peito de Frango Desfiado, Molho de Tomate e Queijo Cremoso.","R$14,90");
insert into prato values ('70543238876843',4013,1,7,"imagens/croasonho/croasonhos_salgados/peito_de_peru_com-requeija_e_mussarela.webp","Peito de Peru com Requeijão e Mussarela","Peito de Peru, Requeijão e Queijo Mussarela.","R$15,50");
insert into prato values ('70543238876843',4014,1,7,"imagens/croasonho/croasonhos_salgados/portuguesa.webp","Portuguesa","Presunto, Queijo Mussarela, Cebola, Tomate, Azeitona e Orégano.","R$15,50");
insert into prato values ('70543238876843',4015,1,7,"imagens/croasonho/croasonhos_salgados/presunto_queijo.webp","Presunto e Queijo","Presunto e Queijo Mussarela.","R$13,90");
insert into prato values ('70543238876843',4016,1,7,"imagens/croasonho/croasonhos_salgados/tomate_seco_mussarela_rucula.webp","Tomate Seco Mussarela e Rúcula","Tomate Seco, Queijo Mussarela, Rúcula e Orégano.","R$14,90");
insert into prato values ('70543238876843',4017,1,7,"imagens/croasonho/croasonhos_salgados/calabresa_com_mussarela.webp","Calabresa com Mussarela","Croasonho recheado com calabresa fatiada acebolada e queijo mussarela.","R$13,90");


/*Forma Pagamento*/
	/*Croasonhos*/
	insert into forma_pagamento values ('70543238876843',4001,"Cartão de Crédito");
	insert into forma_pagamento values ('70543238876843',4002,"Cartão de Débito");
	insert into forma_pagamento values ('70543238876843',4003,"Dinheiro");
	insert into forma_pagamento values ('70543238876843',4004,"Sodexo");
	insert into forma_pagamento values ('70543238876843',4005,"Ticket");

/*Recompensas*/
insert into recompensas values ('70543238876843',4001,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('70543238876843',4002,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('70543238876843',4003,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('70543238876843',4004,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('70543238876843',4005,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('70543238876843',4006,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('70543238876843',4007,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('70543238876843',4008,"imagens/Ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);






/*prato*/
/*Tio Sam Japa Food Combos*/
insert into prato values ('67594639571239',5001,1,11,"imagens/tio_sam_japa_food/combos/3_hot_roll.webp","3 Hot Rolls","3 hot roll (30 cortes) sabores: Filadelfia, Grelhado, kani, Grelhado Com Barbecue.","R$39,90");
insert into prato values ('67594639571239',5002,1,11,"imagens/tio_sam_japa_food/combos/2_temakis_1_hot_holl.webp","Combo: 2 temakis + 1 hot roll","Temaki Escolha 2 opções: Filadelfia, Grelhado, Shimeji, kani, California, Grelhado Com Barbecue. Hot roll Escolha 1 opção: Filadelfia, Grelhado, Grelhado Com Barbecue.","R$39,90");
insert into prato values ('67594639571239',5003,1,11,"imagens/tio_sam_japa_food/combos/2_temakis_grelhados_2_hot_roll.webp","2 temakis grelhados + 2 hot roll","Temaki Grelhado. Hot roll Escolha 2 opção: Filadelfia, Grelhado, Grelhado Com Barbecue.","R$54,90");
insert into prato values ('67594639571239',5004,1,11,"imagens/tio_sam_japa_food/combos/2_temakis_filadelfia_2_hot_roll_salmao.webp","2 temakis filadélfia + 2 hot roll salmão","2 Deliciosos temakis Filadelfia acompanhados de 2 hot rolls de salmão fresquinho.","R$54,90");
insert into prato values ('67594639571239',5005,1,11,"imagens/tio_sam_japa_food/combos/4_temakis.webp","4 temakis","Temaki Escolha 2 opções: Filadelfia, Grelhado, Shimeji, kani, California, Grelhado Com Barbecue.","R$55,90");
insert into prato values ('67594639571239',5006,1,11,"imagens/tio_sam_japa_food/combos/2_yakissoba_2hot_roll_salmao.webp","2 yakissoba + 2 hot roll salmão","Yakissoba de Carne, Frango ou Misto acompanhados de 2 hot rolls de salmão fresquinho.","R$54,90");
insert into prato values ('67594639571239',5007,1,11,"imagens/tio_sam_japa_food/combos/i_want_you.webp","Combo: i want you","2 hot grelhados + 8 unidades hossomaki grelhado + 8 unidades de uramaki grelhado + 2 temakis grelhados.","R$79,90");
insert into prato values ('67594639571239',5008,1,11,"imagens/tio_sam_japa_food/combos/1_temaki_8_hossomaki+8_uramaki.jpg","1 temaki + hossomaki (8 unidades) + uramaki (8 unidades)","Temaki Filadelfia, Grelhado,Hossomaki de salmão ou salmão grelhado, Uramaki Filadelfia, Grelhado ou California.","R$42,90");

/*Tio Sam Japa Food Entradas*/
insert into prato values ('67594639571239',5009,1,1,"imagens/tio_sam_japa_food/entradas/lula_na_manteiga.webp","Lula na manteiga","150g de lula na manteiga com shoyo.","R$12,00");
insert into prato values ('67594639571239',5010,1,1,"imagens/tio_sam_japa_food/entradas/lula_a_dore.webp","Lula à dorê","150g de lula empanada na farinha panko.","R$15,00");
insert into prato values ('67594639571239',5011,1,1,"imagens/tio_sam_japa_food/entradas/2_niguiri_de_kani.jpg","2 niguiri de kani","Niguiri feito com arroz e kani fresquinho.","R$6,99");
insert into prato values ('67594639571239',5012,1,1,"imagens/tio_sam_japa_food/entradas/2_niguiri_skin.webp","2 niguiri skin","Niguiri feito com arroz e pele de salmão grelhada.","R$4,99");
insert into prato values ('67594639571239',5013,1,1,"imagens/tio_sam_japa_food/entradas/carpaccio_de_salmao.jpg","Carpaccio de salmão","10 cortes de carpaccio de salmão ao molho ponzu.","R$23,00");
insert into prato values ('67594639571239',5014,1,1,"imagens/tio_sam_japa_food/entradas/enroladinho_sam.webp","Enroladinho sam","Enroladinho de salmão grelhado com cream cheese e cebolinha frito.","R$9,99");
insert into prato values ('67594639571239',5015,1,1,"imagens/tio_sam_japa_food/entradas/teppan_de_salmao.webp","Teppan de salmão","Teppan de salmão com cenoura, repolho e brocolis.","R$20,00");
insert into prato values ('67594639571239',5016,1,1,"imagens/tio_sam_japa_food/entradas/dupla_de_harumaki_de_queijo.webp","Dupla de Harumaki de queijo","Harumaki crocate recheado com queijo que derrete na boca.","R$10,00");
insert into prato values ('67594639571239',5017,1,1,"imagens/tio_sam_japa_food/entradas/ceviche.webp","Ceviche","Ceviche de salmão com peixe branco, cebola roxa e pepino marinado com molho ponzo.","R$15,00");
insert into prato values ('67594639571239',5018,1,1,"imagens/tio_sam_japa_food/entradas/8_esferas_de_salmao.jpg","8 Esferas de salmão","Esferas de salmão empanada no Doritos.","R$17,90");
insert into prato values ('67594639571239',5019,1,1,"imagens/tio_sam_japa_food/entradas/sunomono.webp","Sunomono","100g.","R$9,99");
insert into prato values ('67594639571239',5020,1,1,"imagens/tio_sam_japa_food/entradas/2_niguiri_de_salmao_fresco.webp","2 Niguiri de salmão fresco","Niguiri feito com arroz e salmão fresquinho.","R$7,90");
insert into prato values ('67594639571239',5021,1,1,"imagens/tio_sam_japa_food/entradas/2_joy_de_salmao_fresco.webp","2 Joy de salmão fresco","Joy feito com salmão fresquinho e temperado com cebolhinha picada.","R$10,90");

/*Tio Sam Japa Food Porções*/
insert into prato values ('67594639571239',5022,1,3,"imagens/tio_sam_japa_food/porcoes/porcao_suprema_de_fritas_e_onions_com_cheddar_vulcanico_de_casa_pequena.webp","Porção suprema de fritas e onions com cheddar vulcânico da casa PEQUENA","Serve 2 pessoas.","R$24,90");
insert into prato values ('67594639571239',5023,1,3,"imagens/tio_sam_japa_food/porcoes/porcao_suprema_de_fritas_e_onions_com_cheddar_vulcanico_de_casa_grande.webp","Porção suprema de fritas e onions com cheddar vulcânico da casa GRANDE","Porção serve de 4 a 5 pessoas.","R$49,90");
insert into prato values ('67594639571239',5024,1,3,"imagens/tio_sam_japa_food/porcoes/onion_rings.webp","Onion Rings","Cebola Empanada Frita, Crocante por fora e macia por dentro.","R$22,99");

/*Tio Sam Japa Food Bolota Sam*/
insert into prato values ('67594639571239',5025,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_filadelfia.webp","Bolota de salmão filadélfia","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5026,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_grelhado.webp","Bolota de salmão Grelhado","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5027,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");

/*Tio Sam Japa Food Combinados*/
insert into prato values ('67594639571239',5028,1,1,"imagens/tio_sam_japa_food/combinados/combinado_grelhado_selado_34_peças.webp","Combinado Grelhado/Selado (34 peças)","4 URAMAKI GRELHADO + 4 HOSSOMAKI GRELHADO + 4 NIGUIRI DE SALMÃO SELADO + 4 JOY SELADO + 10 SASHIMI DE SALMÃO SELADO + 4 URAMAKI GRELHADO COM CEBOLA CRISP + 4 URAMAI SKIN.","R$55,90");
insert into prato values ('67594639571239',5029,1,1,"imagens/tio_sam_japa_food/combinados/combinado_variado_43_peças.webp","Combinado Variado (43 peças)","4 URAMAKI DE PATÊ DE SALMÃO + 4 URAMAKI SKIN + 3 NIGUIRI SKIN + 4 HOSSOMAKI GRELHADO + 2 NIGUIRI DE SALMÃO + 2 NIGUIRI PHILADELPHIA + 4 URAMAKI PHILADELFIA + 2 JOY DE MORANGO + 2 JOY DE MARACUJÁ + 2 JOY DE SALMÃO + 10 SASHIMI DE SALMÃO + 4 HOSSOMAKI DE SALMÃO.","R$89,99");
insert into prato values ('67594639571239',5030,1,1,"imagens/tio_sam_japa_food/combinados/sashimi_20_cortes.jpg","Sashimi 20 Cortes","20 Fatias de Sashimi feito com salmão fresquinho.","R$39,00");
insert into prato values ('67594639571239',5031,1,1,"imagens/tio_sam_japa_food/combinados/sashimi_10_cortes.webp","Sashimi 10 cortes","10 Fatias de Sashimi feito com salmão fresquinho.","R$23,00");
insert into prato values ('67594639571239',5032,1,1,"imagens/tio_sam_japa_food/combinados/combinado_individual_13_peças.webp","Combinado individual (13 peças)","2 joy de salmão + 2 niguiri de salmão + 5 sashimi + 2 uramaki de salmão + 2 hossomaki de salmão.","R$29,99");
insert into prato values ('67594639571239',5033,1,1,"imagens/tio_sam_japa_food/combinados/combinado_1_26_peças.webp","Combinado 1 (26 peças)","4 uramaki (sabor da sua escolha) + 4 joy de salmão fresco + 4 niguiri salmão fresco + 4 hossomaki (sabor da sua escolha) + 10 sashimi de salmão fresco.","R$49,90");
insert into prato values ('67594639571239',5034,1,1,"imagens/tio_sam_japa_food/combinados/combinado_sushi_premium_17_peças.jpg","Combinado sushi premium (17 peças)","5 hot roll de salmão + 3 niguiri + 3 joy + 3 hossomaki de salmão + 3 uramaki de salmão.","R$39,90");
insert into prato values ('67594639571239',5035,1,1,"imagens/tio_sam_japa_food/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","6 sashimis + 3 Niguiri + 4 Uramaki + 4 Hossomaki + 2 Joy Tradicional + 2 Joy com Calda de Maracujá.","R$42,90");

/*Tio Sam Japa Food Temakis*/
/*
insert into prato values ('67594639571239',5036,1,1,"imagens/tio_sam_japa_food/combinados/combinado_grelhado_selado_34_peças.webp","Combinado Grelhado/Selado (34 peças)","4 URAMAKI GRELHADO + 4 HOSSOMAKI GRELHADO + 4 NIGUIRI DE SALMÃO SELADO + 4 JOY SELADO + 10 SASHIMI DE SALMÃO SELADO + 4 URAMAKI GRELHADO COM CEBOLA CRISP + 4 URAMAI SKIN..","R$55,90");
insert into prato values ('67594639571239',5037,1,1,"imagens/tio_sam_japa_food/combinados/combinado_variado_43_peças.webp","Combinado Variado (43 peças)","4 URAMAKI DE PATÊ DE SALMÃO + 4 URAMAKI SKIN + 3 NIGUIRI SKIN + 4 HOSSOMAKI GRELHADO + 2 NIGUIRI DE SALMÃO + 2 NIGUIRI PHILADELPHIA + 4 URAMAKI PHILADELFIA + 2 JOY DE MORANGO + 2 JOY DE MARACUJÁ + 2 JOY DE SALMÃO + 10 SASHIMI DE SALMÃO + 4 HOSSOMAKI DE SALMÃO.","R$89,99");
insert into prato values ('67594639571239',5038,1,1,"imagens/tio_sam_japa_food/combinados/sashimi_20_cortes.jpg","Sashimi 20 Cortes","20 Fatias de Sashimi feito com salmão fresquinho.","R$39,00");
insert into prato values ('67594639571239',5039,1,1,"imagens/tio_sam_japa_food/combinados/sashimi_10_cortes.webp","Sashimi 10 cortes","10 Fatias de Sashimi feito com salmão fresquinho.","R$23,00");
insert into prato values ('67594639571239',5040,1,1,"imagens/tio_sam_japa_food/combinados/combinado_individual_13_peças.webp","Combinado individual (13 peças)","2 joy de salmão + 2 niguiri de salmão + 5 sashimi + 2 uramaki de salmão + 2 hossomaki de salmão.","R$29,99");
insert into prato values ('67594639571239',5041,1,1,"imagens/tio_sam_japa_food/combinados/combinado_1_26_peças.webp","Combinado 1 (26 peças)","4 uramaki (sabor da sua escolha) + 4 joy de salmão fresco + 4 niguiri salmão fresco + 4 hossomaki (sabor da sua escolha) + 10 sashimi de salmão fresco.","R$49,90");
insert into prato values ('67594639571239',5042,1,1,"imagens/tio_sam_japa_food/combinados/combinado_sushi_premium_17_peças.jpg","Combinado sushi premium (17 peças)","5 hot roll de salmão + 3 niguiri + 3 joy + 3 hossomaki de salmão + 3 uramaki de salmão.","R$39,90");
insert into prato values ('67594639571239',5043,1,1,"imagens/tio_sam_japa_food/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","6 sashimis + 3 Niguiri + 4 Uramaki + 4 Hossomaki + 2 Joy Tradicional + 2 Joy com Calda de Maracujá.","R$42,90");
insert into prato values ('67594639571239',5044,1,1,"imagens/tio_sam_japa_food/combinados/sashimi_20_cortes.jpg","Sashimi 20 Cortes","20 Fatias de Sashimi feito com salmão fresquinho.","R$39,00");
insert into prato values ('67594639571239',5045,1,1,"imagens/tio_sam_japa_food/combinados/sashimi_10_cortes.webp","Sashimi 10 cortes","10 Fatias de Sashimi feito com salmão fresquinho.","R$23,00");
insert into prato values ('67594639571239',5046,1,1,"imagens/tio_sam_japa_food/combinados/combinado_individual_13_peças.webp","Combinado individual (13 peças)","2 joy de salmão + 2 niguiri de salmão + 5 sashimi + 2 uramaki de salmão + 2 hossomaki de salmão.","R$29,99");
insert into prato values ('67594639571239',5047,1,1,"imagens/tio_sam_japa_food/combinados/combinado_1_26_peças.webp","Combinado 1 (26 peças)","4 uramaki (sabor da sua escolha) + 4 joy de salmão fresco + 4 niguiri salmão fresco + 4 hossomaki (sabor da sua escolha) + 10 sashimi de salmão fresco.","R$49,90");
insert into prato values ('67594639571239',5048,1,1,"imagens/tio_sam_japa_food/combinados/combinado_sushi_premium_17_peças.jpg","Combinado sushi premium (17 peças)","5 hot roll de salmão + 3 niguiri + 3 joy + 3 hossomaki de salmão + 3 uramaki de salmão.","R$39,90");
insert into prato values ('67594639571239',5049,1,1,"imagens/tio_sam_japa_food/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","6 sashimis + 3 Niguiri + 4 Uramaki + 4 Hossomaki + 2 Joy Tradicional + 2 Joy com Calda de Maracujá.","R$42,90");
*/

/*Tio Sam Japa Food Yakissoba*/
/*
insert into prato values ('67594639571239',5050,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_filadelfia.webp","Bolota de salmão filadélfia","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5051,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_grelhado.webp","Bolota de salmão Grelhado","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5052,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5053,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
*/

/*Tio Sam Japa Food Hot Rolls*/
/*
insert into prato values ('67594639571239',5054,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_filadelfia.webp","Bolota de salmão filadélfia","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5055,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_grelhado.webp","Bolota de salmão Grelhado","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5056,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5057,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5058,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5059,1,3,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
*/

/*Tio Sam Japa Food Sobremesas*/

insert into prato values ('67594639571239',5060,1,8,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_chocolate_de_avela.webp","Dupla de Harumaki de chocolate de avelã","Delicioso Harumaki coberto com chocolate e com recheio de avelã.","R$10,00");
insert into prato values ('67594639571239',5061,1,8,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Dupla de Harumaki de Banana com canela e chocolate","Delicioso Harumaki recheado com banana,canela e chocolate.","R$12,00");

/*Tio Sam Japa Food Bebidas*/
insert into prato values ('67594639571239',5062,1,9,"imagens/tio_sam_japa_food/bebidas/sucos.png","Suco Del Valle lata 290ml","Sabores: Maracujá, Pessego, Manga E Uva.","R$6,50");
insert into prato values ('67594639571239',5063,1,9,"imagens/tio_sam_japa_food/bebidas/chas.png","Cha ice tea fuze 300ml","Sabores: Limão E Pessego.","R$6,90");
insert into prato values ('67594639571239',5064,1,9,"imagens/tio_sam_japa_food/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$6,90");
insert into prato values ('67594639571239',5065,1,9,"imagens/tio_sam_japa_food/bebidas/refrigerantes_2l.jpg","Refrigerante 2l","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$11,50");
insert into prato values ('67594639571239',5066,1,9,"imagens/tio_sam_japa_food/bebidas/agua_gas.jpg","Agua C/gás 350 ml","Agua Mineral Com Gás.","R$4,60");
insert into prato values ('67594639571239',5067,1,9,"imagens/tio_sam_japa_food/bebidas/agua.jpg","Agua S/gás 350 ml","Agua Mineral Sem Gás.","R$4,90");


/*Forma Pagamento*/
	/*Tio Sam Japa Food*/
	insert into forma_pagamento values ('67594639571239',5001,"Cartão de Crédito");
	insert into forma_pagamento values ('67594639571239',5002,"Cartão de Débito");
	insert into forma_pagamento values ('67594639571239',5003,"Dinheiro");
	insert into forma_pagamento values ('67594639571239',5004,"Sodexo");
	insert into forma_pagamento values ('67594639571239',5005,"Ticket");


/*Recompensas*/
insert into recompensas values ('67594639571239',5001,"imagens/tio_sam_japa_food/bebidas/agua.jpg","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('67594639571239',5002,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('67594639571239',5003,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('67594639571239',5004,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('67594639571239',5005,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('67594639571239',5006,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('67594639571239',5007,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('67594639571239',5008,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*prato*/
/*Seu Temaki Entradas*/
insert into prato values ('98450900034563',6001,1,1,"imagens/seu_temaki/entradas/joy_maracuja.webp","Joy de maracuja 4 unid","Bolinho de arroz, envolto por uma fatia fina de salmão, coberto com cream cheese e finalizado com nossa calda de maracuja.","R$16,90");
insert into prato values ('98450900034563',6002,1,1,"imagens/seu_temaki/entradas/joy_salmao.webp","Joy Salmão 4unid","bolinho de arroz, envolto por uma fatia fina de salmão, e coberto com salmão picado misturado com cream cheese e cebolinha.","R$21,90");
insert into prato values ('98450900034563',6003,1,1,"imagens/seu_temaki/entradas/ceviche_salmao.webp","Ceviche de salmão","Ceviche é um prato com salmão cru em cubos marinado em suco cítrico, ingredientes obrigatórios são a cebola roxa, pimentão, cebolinha, em leve toque de pimenta.","R$26,90");
insert into prato values ('98450900034563',6004,1,1,"imagens/seu_temaki/entradas/niguiri_salmao.webp","Niguiri Salmão 4und.","Niguiri feito com arroz e salmão fresco.","R$19,90");
insert into prato values ('98450900034563',6005,1,1,"imagens/seu_temaki/entradas/carpaccio_salmao.webp","Carpaccio de salmão 12 cortes","Laminas finas de salmão, levemente marinado no limão, finalizado no azeite e no shoyu.","R$26,90");


/*Seu Temaki Temakis*/
insert into prato values ('98450900034563',6006,1,1,"imagens/seu_temaki/temaki/temaki_salmao_grelhado.webp","Temaki salmão grelhado","Alga, arroz, Salmão grelhado, cream cheese e molho tarê e gergelim (Acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6007,1,1,"imagens/seu_temaki/temaki/temaki_salmao_completo.webp","Temaki salmão completo","Alga, arroz, Salmão, cream cheese, cebolinha e gergelim (acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6008,1,1,"imagens/seu_temaki/temaki/temaki_salmao_simples.webp","Temaki salmão simples","Alga, arroz, Salmão, cebolinha e gergelim (acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6009,1,1,"imagens/seu_temaki/temaki/temaki_skin.webp","Temaki skin","Alga, arroz, Pele de salmão frita, cream cheese, molho tarê e gergelim (Acompanha 1 sache de shoyu).","R$12,90");
insert into prato values ('98450900034563',6010,1,1,"imagens/seu_temaki/temaki/temaki_hot.webp","Temaki hot","Temaki todo empanado, recheio arroz, salmão, cream cheese e molho tarê (Acompanha 1 sache de shoyu).","R$18,90");
insert into prato values ('98450900034563',6011,1,1,"imagens/seu_temaki/temaki/temaki_chillimaki.webp","Temaki chillimaki (picante)","Alga, Arroz, Mistura de salmão cru, doritos, cream cheese e pimenta sriracha (Acompanha 1 sache de shoyu).","R$17,90");
insert into prato values ('98450900034563',6012,1,1,"imagens/seu_temaki/temaki/temaki_salmao_doritos.webp","Temaki salmão doritos","Alga, arroz, Salmão cru, cream cheese, cebolinha e doritos (Acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6013,1,1,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Temaki shimeji","Alga, arroz, Shimeji, cream cheese, cebolinha e gergelim (Acompanha 1 sache de shoyu).","R$16,90");


/*Seu Temaki Hot*/
insert into prato values ('98450900034563',6014,1,3,"imagens/seu_temaki/hot/shime_na_manteiga.webp","Shimeji na manteiga","Cogumelo salteado na manteiga, finalizado com cebolinha e gergelim.","R$17,90");
insert into prato values ('98450900034563',6015,1,3,"imagens/seu_temaki/hot/harumaki_legumes.webp","Harumaki legumes.","Delicioso harumaki feito com legumes frescos.","R$12,90");


/*Seu Temaki Hot Roll*/
insert into prato values ('98450900034563',6017,1,3,"imagens/seu_temaki/hot_rolls/hot_roll.webp","Hot Roll Salmão","Salmão, arroz, cebolinha, cream cheese, molho tare e gergelim /12 unidades.","R$18,90");
insert into prato values ('98450900034563',6018,1,3,"imagens/seu_temaki/hot_rolls/hot_roll_doritos.webp","Hot Roll Doritos","Salmão, arroz, cream cheese, Doritos e molho tare 1 unidades.","R$19,90");
insert into prato values ('98450900034563',6019,1,3,"imagens/seu_temaki/hot_rolls/hot_roll_crispy.webp","Hot Roll Crispy","Salmão, arroz, cream cheese, couve frita e molho tare 10 unidades.","R$19,90");


/*Seu Temaki Hossomaki*/
insert into prato values ('98450900034563',6020,1,1,"imagens/seu_temaki/hossomaki/hossomaki_pepino.webp","Hossomaki Pepino","Enrolado, arroz e pepino (Acompanha 1 sache de shoyu e 1 hashi).","R$12,90");
insert into prato values ('98450900034563',6021,1,1,"imagens/seu_temaki/hossomaki/hossomaki_salmao.webp","Hossomaki Salmão","Enrolado, arroz e salmão 10 un (Acompanha 1 sache de shoyu e 1 hashi).","R$15,90");


/*Seu Temaki Uramaki*/
insert into prato values ('98450900034563',6022,1,1,"imagens/seu_temaki/uramaki/uramaki_philadelphia.webp","Uramaki Philadelphia 10 unid","Ele possui o arroz por fora do nori, envolto de uma fina camada de salmão, que por sua vez enrola o recheio no centro com salmão e cream cheese, ( Acompanha 1 shoyu e 1 hashi ).","R$22,90");
insert into prato values ('98450900034563',6023,1,1,"imagens/seu_temaki/uramaki/uramaki_salmao_grelhado.webp","Uramaki Salmão Grelhado 10 und","Ele possui o arroz por fora do nori, que por sua vez enrola o recheio no centro com salmão grelhado e cream cheese, e finalizado com molho tarê ( Acompanha 1 shoyu e 1 hashi ).","R$19,90");



/*Seu Temaki Sashimi*/
insert into prato values ('98450900034563',6024,1,1,"imagens/seu_temaki/sashimi/sashimi_salmao_10_fatias.webp","Sashimi salmão 10 fatias","10 fatias de salmão fresquinho.","R$35,00");
insert into prato values ('98450900034563',6025,1,1,"imagens/seu_temaki/sashimi/sashimi_salmao_20_fatias.webp","Sashimi salmão 20 fatias","20 fatias de salmão fresquinho.","R$60,00");


/*Seu Temaki Combinados*/
insert into prato values ('98450900034563',6026,1,1,"imagens/seu_temaki/combinados/combinado_1_14_peças.webp","Combinado 1 - 14 peças","4 hossomaki pepino, 4 hossomaki salmão, 4 uramaki Philadelphia e 2 niguiris (acompanha 3 saches de shoyus + 2 hashis).","R$27,90");
insert into prato values ('98450900034563',6027,1,1,"imagens/seu_temaki/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","4 hossomaki pepino, 4 hossomaki salmão, 4 uramaki califórnia, 4 uramaki patê salmão e 5 sashimi salmão (acompanha 3 saches de shoyus + 2 hashis).","R$42,90");
insert into prato values ('98450900034563',6028,1,1,"imagens/seu_temaki/combinados/combinado_3_31_peças.webp","Combinado 3 - 31 peças","4 hossomaki pepino, 4 hossomaki salmão, 4 uramaki califórnia, 2 joy, 4 uramaki patê salmão, 4 uramaki Philadelphia, 2 niguiris e 7 sashimi salmão (acompanha 4 saches de shoyus + 2 hashis).","R$65,90");
insert into prato values ('98450900034563',6029,1,1,"imagens/seu_temaki/combinados/combinado_salmao.webp","Combinado de salmão - 17 peças","4 hossomaki salmão, 5 sashimi salmão, 4 uramaki philadelphia e 4 niguiris.","R$39,90");


/*Seu Temaki Doces*/
insert into prato values ('98450900034563',6030,1,1,"imagens/seu_temaki/doces/harumaki_romeu_e_julieta.webp","Harumaki romeu e julieta","Delicioso harumaki feito comqueijo e goiabada.","R$13,90");
insert into prato values ('98450900034563',6031,1,1,"imagens/seu_temaki/doces/harumaki_banana_com_chocolate.webp","Harumaki banana com chocolate","Delicioso harumaki feito com chocolate ao leite e banana fresquinha.","R$13,90");


/*Seu Temaki Bebidas*/
insert into prato values ('98450900034563',6032,1,9,"imagens/seu_temaki/bebidas/sucos.png","Suco Del Valle lata 290ml","Sabores: Maracujá, Pessego, Manga E Uva.","R$6,90");
insert into prato values ('98450900034563',6034,1,9,"imagens/seu_temaki/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$5,90");
insert into prato values ('98450900034563',6035,1,9,"imagens/seu_temaki/bebidas/refrigerantes_2l.jpg","Refrigerante 2l","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$12,00");

/*Forma Pagamento*/
	/*Seu Temaki*/
	insert into forma_pagamento values ('98450900034563',6001,"Cartão de Crédito");
	insert into forma_pagamento values ('98450900034563',6002,"Cartão de Débito");
	insert into forma_pagamento values ('98450900034563',6003,"Dinheiro");
	insert into forma_pagamento values ('98450900034563',6004,"Sodexo");
	insert into forma_pagamento values ('98450900034563',6005,"Ticket");



/*Recompensas*/
insert into recompensas values ('98450900034563',6001,"imagens/seu_temaki/combinados/combinado_1_14_peças.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('98450900034563',6002,"imagens/seu_temaki/uramaki/uramaki_philadelphia.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('98450900034563',6003,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('98450900034563',6004,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('98450900034563',6005,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('98450900034563',6006,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('98450900034563',6007,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('98450900034563',6008,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*Banzai Bebidas*/
insert into prato values ('82300081236891',7001,1,9,"imagens/banzai/temaki_salmao/temaki_salmao_simples.webp","Temaki Salmão Simples","Cerveja alemã feita de trigo.","R$16,00");
insert into prato values ('82300081236891',7002,1,9,"imagens/banzai/temaki_salmao/temaki_salmao_com_cebolinha.webp","Temaki de Salmão com Cebolinha","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$16,00");
insert into prato values ('82300081236891',7003,1,9,"imagens/banzai/temaki_salmao/temaki_salmao_completo.webp","Temaki Salmão Completo","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$16,50");
insert into prato values ('82300081236891',7004,1,9,"imagens/banzai/temaki_salmao/temaki_philadelphia.webp"," Temaki Philadelphia","Sabor Laranjá e Maracujá.","R$17,50");
insert into prato values ('82300081236891',7005,1,9,"imagens/banzai/temaki_salmao/salmao_skin.webp","Salmão Skin","/bebida Fermentada a base de arroz.","R$13,50");
insert into prato values ('82300081236891',7006,1,9,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Temaki Salmão com Shimeji","/Agua Mineral.","R$17,00");




/*Banzai Bebidas*/
insert into prato values ('82300081236891',7032,1,9,"imagens/banzai/bebidas/cerveja_erdinger_weib_bier.webp","Cerveja erdinger weib bier 500 ml","Cerveja alemã feita de trigo.","R$20,00");
insert into prato values ('82300081236891',7034,1,9,"imagens/banzai/bebidas/refrigerante_600_ml.webp","Refrigerante 600ml","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$5,90");
insert into prato values ('82300081236891',7035,1,9,"imagens/banzai/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$12,00");
insert into prato values ('82300081236891',7036,1,9,"imagens/banzai/bebidas/suco_naturacitrus.webp","suco naturacitrus","Sabor Laranjá e Maracujá.","R$7,50");
insert into prato values ('82300081236891',7037,1,9,"imagens/banzai/bebidas/saque_azuma_kirin.webp","garrafa de Saquê azuma kirin","/bebida Fermentada a base de arroz.","R$45,00");
insert into prato values ('82300081236891',7038,1,9,"imagens/banzai/bebidas/agua.jpg","Agua","/Agua Mineral.","R$45,00");


/*Recompensas*/
insert into recompensas values ('82300081236891',7001,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('82300081236891',7002,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('82300081236891',7003,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('82300081236891',7004,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('82300081236891',7005,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('82300081236891',7006,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('82300081236891',7007,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('82300081236891',7008,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*prato*/
/*Quiosque Burgman lanches*/
insert into prato values ('62315943587966',8001,1,1,"imagens/quiosque_burgman/lanches/hamburgman.webp","Hamburgman","Hamburguer artesanal de 200g de carne, maionese verde, rúcula, mussarela gratinada e bacon.","R$33,00");
insert into prato values ('62315943587966',8002,1,1,"imagens/quiosque_burgman/lanches/vegetariano.webp","Vegetariano","Hamburguer artesanal de soja defumado sabor calabresa de 160g, pão com gergelim, maionese verde, mussarela, rúcula e Doritos.","R$37,00");
insert into prato values ('62315943587966',8003,1,1,"imagens/quiosque_burgman/lanches/vegano.webp","Vegano","Hamburguer artesanal de cenoura 160g, pão com gergelim, maionese verde sem ovo, queijo de mandioca, rúcula e Doritos.","R$37,00");
insert into prato values ('62315943587966',8004,1,1,"imagens/quiosque_burgman/lanches/fishn_fries.webp","Fishn'fries"," Peixe com crosta crocante e fritas.","R$46,00");
insert into prato values ('62315943587966',8005,1,1,"imagens/quiosque_burgman/lanches/isca_a_parmegiana.webp","Isca a parmegiana","Carne empanada, mussarela gratinada, molho de tomate e fritas.","R$49,00");
insert into prato values ('62315943587966',8006,1,1,"imagens/quiosque_burgman/lanches/bufalo_wings.jpg","Búfalo wings","Asinha de frango apimentada com fritas.","R$42,00");
insert into prato values ('62315943587966',8007,1,1,"imagens/quiosque_burgman/lanches/onion_rings.webp","Onion rings","Acompanha molho barbecue.","R$35,00");
insert into prato values ('62315943587966',8008,1,1,"imagens/quiosque_burgman/lanches/batata.jpg","Batata"," 3 queijos, gratinadas c/ bacon e alho.","R$41,00");
insert into prato values ('62315943587966',8009,1,1,"imagens/quiosque_burgman/lanches/batata_rustica.webp","Batata Rústica","Acompanha molho especial.","R$37,00");


/*Quiosque Burgman bebidas*/
insert into prato values ('62315943587966',8010,1,1,"imagens/quiosque_burgman/bebidas/refrigerantes_lata.jpg","Refrigerante Lata","350ml - coca cola / coca cola zero / Fanta guarana.","R$6,00");
insert into prato values ('62315943587966',8011,1,1,"imagens/quiosque_burgman/bebidas/sucos.png","Suco Del Valle","300ml.","R$7,00");
insert into prato values ('62315943587966',8012,1,1,"imagens/quiosque_burgman/bebidas/agua_mineral_500ml.webp","Agua Mineral 500ml","Com gás ou sem gás.","R$6,00");


/*Oakberry Bowl*/
insert into prato values ('40879632585865',9001,1,1,"imagens/oakberry/bowl/the_oak_bowl_720ml.webp","The oak bowl (720ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$27,90");
insert into prato values ('40879632585865',9002,1,1,"imagens/oakberry/bowl/works_bowl_500ml.webp","Works bowl (500ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$21,90");
insert into prato values ('40879632585865',9003,1,1,"imagens/oakberry/bowl/classic_bowl_350ml.webp","Classic bowl (350ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$14,90");


/*Oakberry Smoothie*/
insert into prato values ('40879632585865',9004,1,1,"imagens/oakberry/smoothie/smoothie_the_oak_720ml.webp","Smoothie the oak (720ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$21,90");
insert into prato values ('40879632585865',9005,1,1,"imagens/oakberry/smoothie/smoothie_works_500ml.webp","Smoothie works (500ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$17,90");
insert into prato values ('40879632585865',9006,1,1,"imagens/oakberry/smoothie/smoothie_classic_350ml.webp","Smoothie classic (350ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$11,90");




/*brasileirinho Veganíssimos*/
insert into prato values ('65662348978806',10001,1,1,"imagens/brasileirinho/veganissimos/mexidinho_vegano.webp","Mexidinho vegano","Arroz, proteína de soja, tomate, milho verde, azeitona e cheiro verde.","R$22,99");
insert into prato values ('65662348978806',10002,1,1,"imagens/brasileirinho/veganissimos/nhoque_vegano_de_batata_doce.webp","Nhoque vegano de batata doce","Massa tipo nhoque de batata doce, proteína de soja, molho de tomate e creme de soja.","R$23,99");


/*brasileirinho Comida típica brasileira*/
insert into prato values ('65662348978806',10003,1,1,"imagens/brasileirinho/comida_tipica_brasileira/arroz_carreteiro.png","Arroz carreteiro","Arroz, carne seca, tomate, cebola, alho e cheiro verde e calabresa.","R$19,99");
insert into prato values ('65662348978806',10004,1,1,"imagens/brasileirinho/comida_tipica_brasileira/baiao_de_dois.png","Baião de Dois","Arroz, feijão de corda, carne seca, tomate, cebola, alho, calabresa e bacon.","R$21,99");
insert into prato values ('65662348978806',10005,1,1,"imagens/brasileirinho/comida_tipica_brasileira/brasileirinho.png","Brasileirinho","Arroz, feijão, carne bovina, tomate, cebola ovo, alho e cheiro verde.","R$20,99");
insert into prato values ('65662348978806',10006,1,1,"imagens/brasileirinho/comida_tipica_brasileira/do_chefe.png","Do Chéfe","Arroz, carne moida, azeitona verde, tomate, ovo, alho e molho de tomate.","R$19,99");
insert into prato values ('65662348978806',10007,1,1,"imagens/brasileirinho/comida_tipica_brasileira/estrogonofe_frango.png","Estrogonofe de frango","Arroz, frango, molho branco, champignon, ketchup, mostarda e alho. Acompanha batata palha.","R$19,99");
insert into prato values ('65662348978806',10008,1,1,"imagens/brasileirinho/comida_tipica_brasileira/feijao_tropeiro.png","Feijão tropeiro","Arroz, feijão, farofa, tomate, carne seca,  alho, cheiro verde e calabresa, bacon.","R$21,99");
insert into prato values ('65662348978806',10009,1,1,"imagens/brasileirinho/comida_tipica_brasileira/fitness.png","Fitness","Batata doce, frango, cenoura, ovo, alface e cheiro verde e sal.","R$24,99");
insert into prato values ('65662348978806',10010,1,1,"imagens/brasileirinho/comida_tipica_brasileira/galinhada.png","Galinhada","Arroz, frango, milho, tomate, cenoura, açafrão, cebola, alho e cheiro verde.","R$19,99");
insert into prato values ('65662348978806',10011,1,1,"imagens/brasileirinho/comida_tipica_brasileira/gaucho.png","Gaúcho","Arroz, picanha, palmito, tomate, catupiry e alho, e alho frito.","R$22,99");
insert into prato values ('65662348978806',10012,1,1,"imagens/brasileirinho/comida_tipica_brasileira/integral.png","Integral","Arroz integral, frango, brocolis, cenoura, ervilha e alho.","R$20,99");
insert into prato values ('65662348978806',10013,1,1,"imagens/brasileirinho/comida_tipica_brasileira/oriental.png","Oriental","Arroz, frango empanado, cenoura, omelete, pimentão, brocolis, ervilha, shoyo, alho e cheiro verde.","R$20,99");
insert into prato values ('65662348978806',10014,1,1,"imagens/brasileirinho/comida_tipica_brasileira/parmegiana_carne.png","Parmegiana de carne","Arroz, carne bovina empanada, molho de tomate e muçarela. Acompanha batata palha.","R$23,99");
insert into prato values ('65662348978806',10015,1,1,"imagens/brasileirinho/comida_tipica_brasileira/parmegiana_frango.png","Parmegiana de Frango","Arroz, frango empanado, molho de tomate e muçarela. Acompanha batata palha.","R$22,99");
insert into prato values ('65662348978806',10016,1,1,"imagens/brasileirinho/comida_tipica_brasileira/parmegiana_peixe.jpg","Parmegiana de Peixe","Arroz, Peixe Empanado, Molho de Tomate, Muçarela.","R$23,99");
insert into prato values ('65662348978806',10017,1,1,"imagens/brasileirinho/comida_tipica_brasileira/penne_a_primavera.png","Penne à Primavera","Massa tipo pene, molho branco,presunto, ervilha e queijo mussarela.","R$20,99");
insert into prato values ('65662348978806',10018,1,1,"imagens/brasileirinho/comida_tipica_brasileira/salada_brasileirinho.png","Salada Brasileirinho","Alface, frango, ervilha, ovo, cenoura, tomate e sal.","R$21,99");
insert into prato values ('65662348978806',10019,1,1,"imagens/brasileirinho/comida_tipica_brasileira/talharim_a_bolonhesa.png","Talharim a Bolonhesa","Massa tipo talharim, carne moida, calabresa, molho de tomate e cheiro verde. acompanha queijo ralado.","R$18,99");
insert into prato values ('65662348978806',10020,1,1,"imagens/brasileirinho/comida_tipica_brasileira/talharim_ao_molho_branco.webp","Talharim ao Molho Branco","Massa tipo talharim, molho branco, brócolis, milho verde. acompanha queijo ralado.","R$20,99");
insert into prato values ('65662348978806',10021,1,1,"imagens/brasileirinho/comida_tipica_brasileira/yakissoba_padrao.png","Yakissoba Padrão","Macarrão, frango, carne bovina, pimentão, cenoura, brocolis, vagem, acelga e shoyo.","R$24,99");



/*Mc Donald's Lançamentos McOfertas*/
insert into prato values ('21912193404921',11001,1,7,"imagens/mcdonald/mc_ofertas/big_four.webp","McOferta Big Four","Feito com pão de Big Mac, pepperoni, cebola crispy, 4 carnes de regulares e uma saborosa maionese defumada.","R$35,90");
insert into prato values ('21912193404921',11002,1,7,"imagens/mcdonald/mc_ofertas/big_beef_&_chicken.webp","McOferta Big Beef & Chicken","Carnes e frango juntos ? Sim! Além disso, vai queijo cheddar, maionese, cebola caramelizada, feito com pão de big.","R$35,90");
insert into prato values ('21912193404921',11003,1,7,"imagens/mcdonald/mc_ofertas/big_malt.webp","McOferta Big Malt","Feito com pão de Big Mac integral, bacon, cebola crispy, duas carnes 4:1 e uma surpreendente mostarda de cerveja.","R$35,90");
insert into prato values ('21912193404921',11004,1,7,"imagens/mcdonald/mc_ofertas/duplo_picanha.webp","McOferta Duplo Picanha","Dois deliciosos hambúrgueres de picanha, cebola crispy, tomate, mix de folhas e molho de picanha, acompanhamento e bebida.","R$42,90");
insert into prato values ('21912193404921',11005,1,7,"imagens/mcdonald/mc_ofertas/big_bourbon.webp","McOferta Big Bourbon","Feito com pão de Big Mac, bacon, cebola crispy, cheddar melt, duas carnes 4:1 e um delicioso molho barbecue sabor wishky.","R$35,90");
insert into prato values ('21912193404921',11006,1,7,"imagens/mcdonald/mc_ofertas/big_fire.webp","McOferta Big Fire","Feito com pão de Big Mac integral, bacon, duas carnes 4:1, queijo emmental e um molho pimenta biquinho.","R$35,90");


/*Mc Donald's McOfertas Premium*/
insert into prato values ('21912193404921',11007,1,7,"imagens/mcdonald/mc_ofertas/clubhouse.webp","McOferta ClubHouse","Dois hambúrgueres suculentos de carne 100% bovina, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche, com acompanhamento e bebida.","R$35,90");
insert into prato values ('21912193404921',11008,1,7,"imagens/mcdonald/mc_ofertas/clubhouse_chicken.webp","McOferta ClubHouse Chicken","Filé de frango empanado, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche, com acompanhamento e bebida.","R$35,90");
insert into prato values ('21912193404921',11009,1,7,"imagens/mcdonald/mc_ofertas/duplo_quarterao.webp","McOferta Duplo quarterao","Duplamente inigualável dois hambúrgueres, mostarda, ketchup, cebola e, claro, o delicioso queijo cheddar num pão com gergelim, acompanhamento e bebida.","R$34,90");
insert into prato values ('21912193404921',11010,1,7,"imagens/mcdonald/mc_ofertas/big_tasty_chicken_bacon.webp","McOferta Big Tasty Chicken Bacon","Frango empanado, bacon, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty, com acompanhamento e bebida.","R$35,90");
insert into prato values ('21912193404921',11011,1,7,"imagens/mcdonald/mc_ofertas/big_tasty.webp","McOferta Big Tasty","O maior hambúrguer de carne 100% bovina do mcdonald’s, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty, acompanhamento e bebida.","R$33,90");
insert into prato values ('21912193404921',11012,1,7,"imagens/mcdonald/mc_ofertas/chicken_supreme_crispy.webp","McOferta Chicken Supreme Crispy","Carne de frango empanado, molho delicioso, cebola crispy, tomate, alface fresquinha e queijo emental e pão integral com gergelim, acompanhamento e bebida.","R$29,90");

/*Mc Donald's McOfertas Classicas*/
insert into prato values ('21912193404921',11013,1,7,"imagens/mcdonald/mc_ofertas_classicas/big_mac.webp","McOferta Big Mac","Dois hambúrgueres, alface, queijo e molho especial, cebola e picles num pão com gergelim, acompanhamento e bebida.","R$28,90");
insert into prato values ('21912193404921',11014,1,7,"imagens/mcdonald/mc_ofertas_classicas/quarteirao_com_queijo.webp","McOferta Quarterão com Queijo","Um hambúrguer feito com pura carne bovina, envolvida por duas fatias de queijo temperado com ketchup, mostarda, cebola e picles, acompanhamento e bebida.","R$28,90");
insert into prato values ('21912193404921',11015,1,7,"imagens/mcdonald/mc_ofertas_classicas/cheddar_mcmelt.webp","McOferta Cheddar Mcmelt","Delicioso hambúrguer de carne bovina, queijo tipo cheddar derretido, cebola ao molho shoyu no pão escuro com gergelim,acompanhamento e bebida.","R$28,90");
insert into prato values ('21912193404921',11016,1,7,"imagens/mcdonald/mc_ofertas_classicas/mcnifico_bacon.webp","McOferta Mcnífico Bacon","Três saborosas fatias de bacon, cebola, hambúrguer de 120 gramas de carne bovina, queijo derretido, tomate e um trio de delícias: maionese, ketchup e mostarda, acompanhamento e bebida.","R$30,90");
insert into prato values ('21912193404921',11017,1,7,"imagens/mcdonald/mc_ofertas_classicas/mcchicken.webp","McOferta Mcchicken","Frango empanado e dourado com molho suave e cremoso, acompanhado de alface crocante num pão com gergelim, acompanhamento e bebida.","R$26,90");
insert into prato values ('21912193404921',11018,1,7,"imagens/mcdonald/mc_ofertas_classicas/chicken_mcnuggets.webp","McOferta Chicken McNuggets 10 unidades ","Os frangos empanados mais irresistíveis do mcdonald’s, são quatro opções de molhos (agridoce,barbecue,creamy rach ou caipira), acompanhamento e bebida.","R$26,90");


/*Mc Donald's Sanduíches de carne Bovina*/
insert into prato values ('21912193404921',11019,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_four.webp","Big Four","Feito com pão de Big Mac, pepperoni, cebola crispy, 4 carnes de regulares e uma saborosa maionese defumada.","R$27,90");
insert into prato values ('21912193404921',11020,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_beef_&_chicken.webp","Big Beef & chicken"," Carne e frango juntos? sim! Alem disso, vai queijo cheddar, maionese, cebola caramelizada, feito com pão de big.","R$27,90");
insert into prato values ('21912193404921',11021,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_malt.webp","Big Malt","Feito com pão de Big Mac integral, bacon, cebola crispy, duas carnes 4:1 e uma surpreendente mostarda de cerveja.","R$27,90");
insert into prato values ('21912193404921',11022,1,7,"imagens/mcdonald/sanduiches_carne_bovina/duplo_picanha.webp","Duplo Picanha","Dois deliciosos hambúrgueres de picanha, cebola crispy, tomate, mix de folhas e molho de picanha.","R$33,90");
insert into prato values ('21912193404921',11023,1,7,"imagens/mcdonald/sanduiches_carne_bovina/bacon_smokehouse.webp","Bacon smokehouse","Chegou a novidade do momento. pão de brioche, molho mostarda e mel, cebola empanada, 3 fatias de bacon, 2 deliciosos hambúrgueres, cebola caramelizada e um delicioso molho de bacon.","R$27,90");
insert into prato values ('21912193404921',11024,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_bourbon.webp","Big Bourbon","Feito com pão de Big Mac, bacon, cebola crispy, cheddar melt, duas carnes 4:1 e um delicioso molho barbecue sabor wishky.","R$27,90");
insert into prato values ('21912193404921',11025,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_fire.webp","Big Fire","Feito com pão de Big Mac integral, bacon, duas carnes 4:1, queijo emmental e um molho pimenta biquinho.","R$27,90");
insert into prato values ('21912193404921',11026,1,7,"imagens/mcdonald/sanduiches_carne_bovina/clubhouse.webp","ClubHouse","Dois hambúrgueres suculentos de carne 100% bovina, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche.","R$27,90");
insert into prato values ('21912193404921',11027,1,7,"imagens/mcdonald/sanduiches_carne_bovina/duplo_quarterao.webp","Duplo quarterao","Duplamente inigualável dois hambúrgueres, mostarda, ketchup, cebola e, claro, o delicioso queijo cheddar num pão com gergelim.","R$25,90");
insert into prato values ('21912193404921',11028,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_tasty.webp","Big Tasty","O maior hambúrguer de carne 100% bovina do mcdonald’s, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty.","R$24,90");
insert into prato values ('21912193404921',11029,1,7,"imagens/mcdonald/sanduiches_carne_bovina/big_mac.webp","Big Mac","Dois hambúrgueres, alface, queijo e molho especial, cebola e picles num pão com gergelim.","R$18,90");
insert into prato values ('21912193404921',11030,1,7,"imagens/mcdonald/sanduiches_carne_bovina/quarterao_com_queijo.webp","Quarterão com Queijo","Um hambúrguer feito com pura carne bovina, envolvida por duas fatias de queijo temperado com ketchup, mostarda, cebola e picles.","R$18,90");
insert into prato values ('21912193404921',11031,1,7,"imagens/mcdonald/sanduiches_carne_bovina/cheddar_mcmelt.webp","Cheddar Mcmelt","Delicioso hambúrguer de carne bovina, queijo tipo cheddar derretido, cebola ao molho shoyu no pão escuro com gergelim.","R$18,90");
insert into prato values ('21912193404921',11032,1,7,"imagens/mcdonald/sanduiches_carne_bovina/mcnifico_bacon.webp","Mcnífico Bacon","Três saborosas fatias de bacon, cebola, hambúrguer de 120 gramas de carne bovina, queijo derretido, tomate e um trio de delícias: maionese, ketchup e mostarda.","R$21,90");
insert into prato values ('21912193404921',11033,1,7,"imagens/mcdonald/sanduiches_carne_bovina/cheeseburger.webp","Cheeseburguer","Pão quentinho, hambúrguer de carne 100% bovina, queijo, cebola, picles com ketchup e mostarda.","R$7,50");
insert into prato values ('21912193404921',11034,1,7,"imagens/mcdonald/sanduiches_carne_bovina/hamburger.webp","Hambúrger","Delicioso hambúrguer de carne bovina, cebola e picles com ketchup e mostarda no pão tostado e quentinho.","R$6,50");


/*Mc Donald's Sanduíches de Frango*/
insert into prato values ('21912193404921',11035,1,7,"imagens/mcdonald/sanduiches_frango/big_tasty_chicken_bacon.webp","Big Tasty Chicken Bacon","Frango empanado, bacon, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty.","R$27,50");
insert into prato values ('21912193404921',11036,1,7,"imagens/mcdonald/sanduiches_frango/clubhouse_chicken.webp","ClubHouse Chicken","Filé de frango empanado, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche.","R$27,50");
insert into prato values ('21912193404921',11037,1,7,"imagens/mcdonald/sanduiches_frango/chicken_supreme_grill.webp","Chicken Supreme Grill ","Frango empanado e dourado com molho suave e cremoso, acompanhado de alface crocante num pão com gergelim.","R$19,90");
insert into prato values ('21912193404921',11038,1,7,"imagens/mcdonald/sanduiches_frango/chicken_supreme_crispy.webp","Chicken Supreme Crispy","Carne de frango empanado, molho delicioso, cebola crispy, tomate, alface fresquinha e queijo emental e pão integral com gergelim.","R$19,90");
insert into prato values ('21912193404921',11039,1,7,"imagens/mcdonald/sanduiches_frango/mcchicken.webp","Mcchicken","Frango empanado e dourado com molho suave e cremoso, acompanhado de alface crocante num pão com gergelim.","R$16,90");

/*Mc Donald's Acompanhamentos*/
insert into prato values ('21912193404921',11040,1,12,"imagens/mcdonald/acompanhamentos/mcfritas_grande.webp","Mcfritas Grande","Deliciosas batatas selecionadas, fritas, crocantes por fora, macias por dentro, douradas, irresistíveis, saborosas, famosas, e todos os outros adjetivos positivos que você quiser dar.","R$9,50");
insert into prato values ('21912193404921',11041,1,12,"imagens/mcdonald/acompanhamentos/mcfritas_media.png","Mcfritas Média","Deliciosas batatas selecionadas, fritas, crocantes por fora, macias por dentro, douradas, irresistíveis, saborosas, famosas, e todos os outros adjetivos positivos que você quiser dar.","R$8,50");
insert into prato values ('21912193404921',11042,1,12,"imagens/mcdonald/acompanhamentos/chicken_mcnuggets_peito_de_frango_10_unidades.webp","Chicken McNuggets peito de frango 10 unidades","Os frangos empanados mais irresistíveis do McDonald’s.","R$15,90");
insert into prato values ('21912193404921',11043,1,12,"imagens/mcdonald/acompanhamentos/chicken_mcnuggets_peito_de_frango_4_unidades.webp","Chicken McNuggets peito de frango 4 unidades","Os frangos empanados mais irresistíveis do McDonald’s.","R$9,50");
insert into prato values ('21912193404921',11044,1,12,"imagens/mcdonald/acompanhamentos/side_salad.webp","Side Salad","Levíssima salada com três tipos de folhas crocantes e tomate-caprese.","R$9,00");


/*Mc Donald's Mclanche feliz*/
insert into prato values ('21912193404921',11045,1,11,"imagens/mcdonald/mclanche_feliz/mclanche_feliz_cheeseburguer.webp","Mclanche Feliz Cheeseburguer","Você pode montar o seu McLanche Feliz cheeseburger com tomatinho ou McFritas como acompanhamento, uma refrescante bebida pequena e danoninho morango ou purê de maça.","R$17,40");
insert into prato values ('21912193404921',11046,1,11,"imagens/mcdonald/mclanche_feliz/mclanche_feliz_hamburguer.webp","McLanche Feliz Hambúrguer","Você pode montar o seu McLanche Feliz hambúrguer com tomatinho ou McFritas como acompanhamento, uma refrescante bebida pequena e danoninho morango ou purê de maça.","R$21,60");
insert into prato values ('21912193404921',11047,1,11,"imagens/mcdonald/mclanche_feliz/mclanche_feliz_chicken_mcnuggets.webp","McLanche Feliz Chicken McNuggets","Você pode montar o seu McLanche Feliz chicken McNuggets com tomatinho ou McFritas como acompanhamento, uma refrescante bebida pequena e danoninho morango ou purê de maça.","R$21,60");


/*Mc Donald's Sobremesas*/
insert into prato values ('21912193404921',11048,1,8,"imagens/mcdonald/sobremesas/mcflurry_kopenhagen_avela.webp","McFlurry Kopenhagen Avelã","Massa gelada, calda de chocolate, chocolate da Kopenhagen sabor avelã.","R$12,00");
insert into prato values ('21912193404921',11049,1,8,"imagens/mcdonald/sobremesas/mcflurry_ovomaltine_rocks.webp","McFlurry Ovomaltine Rocks","Massa gelada, calda de chocolate, Ovomaltine em pó e pedaços crocantes de Ovomaltine drageado.","R$12,00");
insert into prato values ('21912193404921',11050,1,8,"imagens/mcdonald/sobremesas/top_sundae_chocolate.webp","Top Sundae Chocolate","Uma delícia gelada de baunilha com cobertura de chocolate e uma deliciosa farofa de paçoca.","R$12,00");
insert into prato values ('21912193404921',11051,1,8,"imagens/mcdonald/sobremesas/top_sundae_caramelo.webp","Top Sundae Caramelo","Uma delícia gelada de baunilha com cobertura de caramelo e uma deliciosa farofa de paçoca.","R$12,00");
insert into prato values ('21912193404921',11052,1,8,"imagens/mcdonald/sobremesas/top_sundae_morango.webp","Top Sundae Morango","Uma delícia gelada de baunilha com cobertura de morango e uma deliciosa farofa de paçoca.","R$12,00");
insert into prato values ('21912193404921',11053,1,8,"imagens/mcdonald/sobremesas/sundae_chocolate.webp","Sundae Chocolate","Uma cremosa massa gelada de baunilha coberta com uma divina calda de chocolate.","R$6,90");
insert into prato values ('21912193404921',11054,1,8,"imagens/mcdonald/sobremesas/sundae_caramelo.webp","Sundae Caramelo","Uma cremosa massa gelada de baunilha coberta com uma divina calda de caramelo.","R$6,90");
insert into prato values ('21912193404921',11055,1,8,"imagens/mcdonald/sobremesas/sundae_morango.webp","Sundae Morango","Uma cremosa massa gelada de baunilha coberta com uma divina calda de morango.","R$6,90");
insert into prato values ('21912193404921',11056,1,8,"imagens/mcdonald/sobremesas/torta_banana.webp","Torta De Banana","Deliciosa torta de massa quentinha e crocante com recheio de banana.","R$5,50");
insert into prato values ('21912193404921',11057,1,8,"imagens/mcdonald/sobremesas/torta_maca.webp","Torta De Maçã","Deliciosa torta de massa quentinha e crocante com recheio de maçã.","R$5,50");
insert into prato values ('21912193404921',11058,1,8,"imagens/mcdonald/sobremesas/pure_maca.webp","Purê De Maçã","Delicioso Purê de Maçã 100% fruta.","R$6,50");
insert into prato values ('21912193404921',11059,1,8,"imagens/mcdonald/sobremesas/danoninho.webp","Danoninho","Agora o McLanche Feliz vem com danoninho, a deliciosa sobremesa de morango.","R$4,50");


/*Mc Donald's bebidas*/
insert into prato values ('21912193404921',11060,1,9,"imagens/mcdonald/bebidas/coca_cola_lata.webp","Coca-cola Lata","Refrigerante de Cola","R$7,90");
insert into prato values ('21912193404921',11061,1,9,"imagens/mcdonald/bebidas/fanta_guarana_lata.webp","Fanta Guaraná Lata","Refrigerante Sabor Guaraná","R$7,90");
insert into prato values ('21912193404921',11062,1,9,"imagens/mcdonald/bebidas/fanta_guarana_zero_lata.webp","Fanta Guaraná Zero Lata","Refrigerante Sabor Guaraná Zero açucar","R$7,90");
insert into prato values ('21912193404921',11063,1,9,"imagens/mcdonald/bebidas/fanta_laranja_lata.webp","Fanta Laranja Lata","Refrigerante sabor laranja","R$7,90");
insert into prato values ('21912193404921',11064,1,9,"imagens/mcdonald/bebidas/del_valle_maracuja_lata.webp","Del Valle Maracujá Lata","Néctar de fruta sabor Maracujá.","R$7,90");
insert into prato values ('21912193404921',11065,1,9,"imagens/mcdonald/bebidas/del_valle_uva_lata.webp","Del Valle Uva Lata","Néctar de fruta sabor Uva","R$7,90");


/*Salua Esfihas Espetos e grelhados*/
insert into prato values ('12136745334526',12001,1,2,"imagens/salua/espetos_grelhados/baby_beef.webp","Baby Beef","Suculento bife de miolo de Alcatra com 03 acompanhamentos.","R$26,00");
insert into prato values ('12136745334526',12002,1,2,"imagens/salua/espetos_grelhados/file_frango.webp","Filé de Frango","Filé de peito de frango grelhado com 03 acompanhamentos.","R$23,00");
insert into prato values ('12136745334526',12003,1,2,"imagens/salua/espetos_grelhados/calabresa.webp","Calabresa","Calabresa grelhada c/ 03 acompanhamentos.","R$20,00");
insert into prato values ('12136745334526',12004,1,2,"imagens/salua/espetos_grelhados/espeto_mignon_suino.webp","Espeto Mignon Suino","Espeto de filet mignon suino com 03 acompanhamentos.","R$20,00");
insert into prato values ('12136745334526',12005,1,2,"imagens/salua/espetos_grelhados/espeto_misto.webp","Espeto Misto","Espeto de carne, frango e calabresa grelhados com 03 acompanhamentos.","R$26,00");
insert into prato values ('12136745334526',12006,1,2,"imagens/salua/espetos_grelhados/espeto_mignon.webp","Espeto de Mignon","Espeto de filet mignon grelhado com 03 acompanhamentos.","R$33,00");


/*Salua Esfihas Pratos Especiais*/
insert into prato values ('12136745334526',12007,1,2,"imagens/salua/pratos_especiais/lasanha_sirio.webp","Lasanha De Pão Sírio","Deliciosa lasanha de pão sirio recheada com presunto, queijo, carne e bacon. coberta com molho de tomate e gratinada ao forno. Acompanha batata frita.","R$23,00");
insert into prato values ('12136745334526',12008,1,2,"imagens/salua/pratos_especiais/panqueca_frango.webp","Panqueca De Frango C/ Requeijão","Deliciosa panqueca de pão sirio recheada com frango e requeijão. Coberta com molho de tomate e gratinada ao forno. Acompanha batata frita.","R$23,00");
insert into prato values ('12136745334526',12009,1,2,"imagens/salua/pratos_especiais/panqueca_carne.webp","Panqueca De Carne","Deliciosa panqueca de pão sirio recheada com carne, azeitona e ovos cozidos. Coberta com molho de tomate e gratinada ao forno. Acompanha batata frita.","R$23,00");
insert into prato values ('12136745334526',12010,1,2,"imagens/salua/pratos_especiais/escondidinho_frango.webp","Escondidinho De Frango","Delicioso escondidinho de batata recheado com frango e requeijão. Gratinado ao forno. Acompanha arroz branco.","R$23,00");

/*Salua Beirutes*/
insert into prato values ('12136745334526',12011,1,7,"imagens/salua/beirutes/beirute_calabresa.webp","Beirute De Calabresa","Calabresa fatiada, queijo, alface, tomate, molho especial, e batatas fritas.","R$30,00");
insert into prato values ('12136745334526',12012,1,7,"imagens/salua/beirutes/beirute_galinha.webp","Beirute De Galinha Cremosa","Frango desfiado refogado com molho de tomate e requeijão cremos, ovo cozido, alface e batata frita.","R$26,00");
insert into prato values ('12136745334526',12013,1,7,"imagens/salua/beirutes/beirute_churrasco.webp","Beirute De Churrasco","Contra filé grelhado, queijo, alface, molho vinagrete e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12014,1,7,"imagens/salua/beirutes/beirute_file_frango.webp","Beirute De Filé De Frango","Filet de frango queijo alface tomate molho especial e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12015,1,7,"imagens/salua/beirutes/beirute_filet_mignon.webp","Beirute De Filet Mignon","Filet mignon queijo alface tomate molho especial e batatas fritas.","R$43,00");
insert into prato values ('12136745334526',12016,1,7,"imagens/salua/beirutes/beirute_frango_milho.webp","Beirute De Frango Com Milho E Requeijão","Frango cozido e desfiado com milho requeijão cremoso alface tomate e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12017,1,7,"imagens/salua/beirutes/beirute_frango_bacon.webp","Beirute De Frango & Bacon","Frango desfiado, queijo, bacon frito, alface, maionese e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12018,1,7,"imagens/salua/beirutes/beirute_presunto_queijo.webp","Beirute De Presunto E Queijo","Presunto queijo alface tomate molho especial e batatas fritas.","R$31,00");
insert into prato values ('12136745334526',12019,1,7,"imagens/salua/beirutes/beirute_roastbeef.webp","Beirute De Roastbeef","Carne assada fatiada presunto queijo alface tomate molho especial e batatas fritas.","R$40,00");
insert into prato values ('12136745334526',12020,1,7,"imagens/salua/beirutes/beirute_salua.webp","Beirute De Roastbeef Saluá","Carne assada fatiada mussarela de búfala tomate seco rúcula molho especial e batatas fritas.","R$42,00");
insert into prato values ('12136745334526',12021,1,7,"imagens/salua/beirutes/beirute_ceasar.webp","Beirute Ceasar","Tirinhas de Frango grelhado, mussarela de búfala, alface, tomate seco e molho especial.","R$25,00");
insert into prato values ('12136745334526',12022,1,7,"imagens/salua/beirutes/beirute_ligth.webp","Beirute Ligth","Frango desfiado cenoura ralada maionese alface e tomate.","R$28,00");
insert into prato values ('12136745334526',12023,1,7,"imagens/salua/beirutes/beirute_vegetariano.webp","Beirute Vegetariano","Mussarela de búfala, berinjela assada e tomate seco ao forno.","R$33,00");

/*Salua Esfihas Abertas*/
insert into prato values ('12136745334526',12024,1,5,"imagens/salua/esfihas_salgadas/alho.webp","Esfiha De Alho","Queijo tipo mussarela derretido com flocos de alho crocante por cima.","R$12,00");
insert into prato values ('12136745334526',12025,1,5,"imagens/salua/esfihas_salgadas/bacon.webp","Esfiha De Bacon","Queijo tipo mussarela derretido com cubinhos de bacon frito por cima.","R$12,00");
insert into prato values ('12136745334526',12026,1,5,"imagens/salua/esfihas_salgadas/beringela.webp","Esfiha De Beringela com mussarela de búfala","Berinjela em cubinhos assada com pimentão e cebola, coberta com mussarela de búfala derretida.","R$14,00");
insert into prato values ('12136745334526',12027,1,5,"imagens/salua/esfihas_salgadas/brasileira.webp","Esfiha Brasileira","Carne seca desfiada e refogada com cebola e salsa, coberta com mussarela e azeitonas pretas.","R$15,00");
insert into prato values ('12136745334526',12028,1,5,"imagens/salua/esfihas_salgadas/brocolis.webp","Esfiha De Brócolis","Brócolis ninja cozido coberto com flocos de alho crocante e mussarela derretida.","R$13,00");
insert into prato values ('12136745334526',12029,1,5,"imagens/salua/esfihas_salgadas/calabresa.webp","Esfiha De Calabresa","Esfiha aberta de calabresa moída.","R$10,00");
insert into prato values ('12136745334526',12030,1,5,"imagens/salua/esfihas_salgadas/calabresa_cheddar.webp","Esfiha De Calabresa Com Cheddar","Esfiha aberta de calabresa moída coberta com cheddar cremoso.","R$14,00");
insert into prato values ('12136745334526',12031,1,5,"imagens/salua/esfihas_salgadas/calabresa_queijo.webp","Esfiha De Calabresa Com Queijo","Esfiha de calabresa moída coberta com mussarela derretida.","R$13,00");
insert into prato values ('12136745334526',12032,1,5,"imagens/salua/esfihas_salgadas/calabresa_catupiry.webp","Esfiha De Calabresa Com Requeijão","Esfiha de calabresa moída coberta com requeijão cremoso.","R$13,00");
insert into prato values ('12136745334526',12033,1,5,"imagens/salua/esfihas_salgadas/carne.webp","Esfiha De Carne","Tradicional esfiha aberta de carne moída temperada com tomate cebola e condimentos sírios.","R$10,00");
insert into prato values ('12136745334526',12034,1,5,"imagens/salua/esfihas_salgadas/carne_cheddar.webp","Esfiha De Carne Com Cheddar","Esfiha aberta de carne com cheddar cremoso.","R$14,00");
insert into prato values ('12136745334526',12035,1,5,"imagens/salua/esfihas_salgadas/carne_seca.webp","Esfiha De Carne Seca Com Requeijão","Esfiha de carne seca desfiada e refogada com cebola e salsa coberta com requeijão cremoso.","R$15,00");
insert into prato values ('12136745334526',12036,1,5,"imagens/salua/esfihas_salgadas/dois_queijos.webp","Esfiha De Dois Queijos","Queijo tipo mussarela derretido coberta com requeijão cremoso.","R$13,00");
insert into prato values ('12136745334526',12037,1,5,"imagens/salua/esfihas_salgadas/frango_catupiry.webp","Esfiha De Frango Com Requeijão","Peito de frango cozido e desfiado refogado com cebola e salsa coberto com requeijão cremoso.","R$13,00");
insert into prato values ('12136745334526',12038,1,5,"imagens/salua/esfihas_salgadas/frango_milho.webp","Esfiha De Frango Com Milho E Requeijão","Peito de frango cozido e desfiado refogado com cebola e salsa e coberto com requeijão cremoso e milho.","R$14,00");
insert into prato values ('12136745334526',12039,1,5,"imagens/salua/esfihas_salgadas/marguerita.webp","Esfiha De Marguerita","Mussarela derretida, manjericão fresco, tomate cereja e parmesão gratinado.","R$13,00");
insert into prato values ('12136745334526',12040,1,5,"imagens/salua/esfihas_salgadas/jardineira.webp","Esfiha De Jardineira","Brócolis cozido, palmito em rodelas, cobertos com mussarela, tomate cereja e parmesão gratinado.","R$15,00");
insert into prato values ('12136745334526',12041,1,5,"imagens/salua/esfihas_salgadas/pepperoni.webp","Esfiha De Peperoni","Fatias de peperoni com cebola e azeitona cobertas com mussarela derretida.","R$15,00");
insert into prato values ('12136745334526',12042,1,5,"imagens/salua/esfihas_salgadas/palmito.webp","Esfiha De Palmito","Fatias de palmito de pupunha cobertos com mussarella derretida e orégano.","R$15,00");
insert into prato values ('12136745334526',12043,1,5,"imagens/salua/esfihas_salgadas/pizza.webp","Esfiha De Pizza","Presunto moído coberto com mussarela derretida tomate e orégano.","R$12,00");
insert into prato values ('12136745334526',12044,1,5,"imagens/salua/esfihas_salgadas/queijo.webp","Esfiha De Queijo","Queijo tipo mussarela derretido.","R$11,00");
insert into prato values ('12136745334526',12045,1,5,"imagens/salua/esfihas_salgadas/portuguesa.webp","Esfiha Portuguesa","Calabresa e presunto moídos mussarela cebola ervilha e ovos cozidos.","R$14,00");
insert into prato values ('12136745334526',12046,1,5,"imagens/salua/esfihas_salgadas/quatro_queijo.webp","Esfiha De Quatro Queijos","Queijo tipo mussarela com fatias de provolone coberto com requeijão cremoso e parmesão gratinado.","R$15,00");
insert into prato values ('12136745334526',12047,1,5,"imagens/salua/esfihas_salgadas/salua.webp","Esfiha Saluá","Mussarela de búfala derretida com tomate seco.","R$14,00");
insert into prato values ('12136745334526',12048,1,5,"imagens/salua/esfihas_salgadas/queijo_branco","Esfiha De Queijo Branco","Queijo branco fresco com uma pitada de orégano.","R$11,00");


/*Salua Esfihas Fechadas*/
insert into prato values ('12136745334526',12049,1,5,"imagens/salua/esfihas_fechadas/calabresa.webp","Esfiha Fechada De Calabresa Com Requeijão","Calabresa moída com requeijão cremoso.","R$12,00");            
insert into prato values ('12136745334526',12050,1,5,"imagens/salua/esfihas_fechadas/carne.webp","Esfiha Fechada De Carne","Carne moída assada com tomate e cebola picadinha.","R$12,00");
insert into prato values ('12136745334526',12051,1,5,"imagens/salua/esfihas_fechadas/frango.webp","Esfiha Fechada De Frango Com Requeijão","Peito de frango cozido e desfiado com requeijão cremoso.","R$12,00");
insert into prato values ('12136745334526',12052,1,5,"imagens/salua/esfihas_fechadas/pizza.webp","Esfiha Fechada De Pizza","Presunto moído mussarela derretida tomate e orégano","R$12,00");

/*Salua Esfihas Doces & Doce Sirio*/
insert into prato values ('12136745334526',12053,1,8,"imagens/salua/esfihas_doces_sirio/chocolate.webp","Esfiha De Chocolate","Chocolate derretido coberto com granulado e cobertura de chocolate.","R$13,00");
insert into prato values ('12136745334526',12054,1,8,"imagens/salua/esfihas_doces_sirio/chocolate_mm.jpeg","Esfiha De M&Ms","Chocolate derretido e coberto com confeitos de chocolate m&m's e cobertura de chocolate.","R$17,00"); 
insert into prato values ('12136745334526',12055,1,8,"imagens/salua/esfihas_doces_sirio/sonho.webp","Esfiha De Sonho De Valsa","Chocolate derretido e coberto com pedacinhos de bombom sonho de valsa e cobertura de chocolate.","R$16,00"); 
insert into prato values ('12136745334526',12056,1,8,"imagens/salua/esfihas_doces_sirio/doce_de_leite.webp","Esfiha De Doce De Leite Com Mini Churros - 6 Unidades","6 unidades de mini churros de doce de leite, acompanhados de uma esfiha de doce de leite, e salpicados com açúcar e canela.","R$17,00"); 
insert into prato values ('12136745334526',12057,1,8,"imagens/salua/esfihas_doces_sirio/doce.webp","Doce Sírio","Burma, faissali, folhados de castanha, bolinho de semolina e ninhos de nozes, pistache e geleia de damasco.","R$8,00"); 
           
/*Salua Salgados*/
insert into prato values ('12136745334526',12058,1,5,"imagens/salua/salgados/kibe.webp","Kibe Carne","Salgado feito de carne moída","R$10,00");
insert into prato values ('12136745334526',12059,1,5,"imagens/salua/salgados/kibe.webp","Kibe De Carne Com Requeijão","Salgado feito de carne moída e requeijão","R$10,00"); 

/*Salua Porções*/
insert into prato values ('12136745334526',12060,1,3,"imagens/salua/porcoes/esfiha.webp","Mini Esfiha - 12 Unidades","Carne, queijo ou calabresa.","R$30,00"); 
insert into prato values ('12136745334526',12061,1,3,"imagens/salua/porcoes/mini_kibe.webp","Mini Kibe - 12 unidades","Acompanham coalhada seca.","R$30,00"); 
insert into prato values ('12136745334526',12062,1,3,"imagens/salua/porcoes/frita.webp","Batata Frita - 250g","Batata frita crocante. Individual.","R$9,00"); 

/*Salua Especialidades árabes e michui*/
insert into prato values ('12136745334526',12063,1,2,"imagens/salua/especialidades/kafta.jpg","Kafta No Espeto","2 espetinhos de carne moída grelhados e temperados com condimentos sírios.","R$42,00"); 
insert into prato values ('12136745334526',12064,1,2,"imagens/salua/especialidades/kibe_cru.webp","Kibe Cru","Kibe de carne moída crua temperada com trigo azeite e condimentos sírios.","R$42,00"); 
insert into prato values ('12136745334526',12065,1,2,"imagens/salua/especialidades/mignon.webp","Espeto Michui De Filet Mignon","Michui filet mignom.","R$43,00"); 
insert into prato values ('12136745334526',12066,1,2,"imagens/salua/especialidades/misto.webp","Espeto Michui Misto","Cubinhos de carne, peito de frango e calabresa intercalados com cebola e pimentão grelhados.","R$40,00"); 

/*Salua Saladas arabes*/
insert into prato values ('12136745334526',12067,1,14,"imagens/salua/saladas/ceasar.webp","Salada Saluá Ceasar","Alface, americana, mussarela de búfala moída, tomate seco, torradinhas de pão sírio e molho especial Acompanha pão sírio.","R$24,00"); 
insert into prato values ('12136745334526',12068,1,14,"imagens/salua/saladas/tabule.webp","Tabule","Pepino, tomate, cebola, alface, hortelã, salsa e trigo. Acompanha pão sírio.","R$18,00"); 


/*Salua pasta arabes*/
insert into prato values ('12136745334526',12069,1,6,"imagens/salua/pasta/babaganuj.webp","Babaganuj","Pasta de berinjela temperada com azeite limão, alho, tahine e condimentos árabes. Acompanha pão sírio.","R$23,00"); 
insert into prato values ('12136745334526',12070,1,6,"","Coalhada Seca","Coalhada de leite sem soro temperada com azeite limão, alho, tahine e condimentos árabes. Acompanha pão sírio.","R$27,00"); 
insert into prato values ('12136745334526',12071,1,6,"imagens/salua/pasta/homus.webp","Homus","Pasta de grão de bico temperada com azeite, limão, tahine e condimentos árabes. Acompanha pão sírio.","R$23,00"); 

/*Salua Bebidas*/
insert into prato values ('12136745334526',12072,1,9,"","Água Mineral","Água mineral 500ml s/gás.","R$6,00"); 
insert into prato values ('12136745334526',12073,1,9,"","Aquarius Fresh Limão","Refrigerante de limão 500ml.","R$8,00");
insert into prato values ('12136745334526',12074,1,9,"","Cerveja Heineken","Cerveja lata heineken 350ml.","R$10,00");
insert into prato values ('12136745334526',12075,1,9,"","Del Valle","Suco Del Valle 290ml saobres:manga, maracujá, pêssego, uva e uva light.","R$23,00");
insert into prato values ('12136745334526',12076,1,9,"","Água tÔnica","Água tonificada lata 350ml.","R$8,00");
insert into prato values ('12136745334526',12077,1,9,"","Schweppes Citrus","Refrigerante citrus 350ml.","R$8,00");
insert into prato values ('12136745334526',12078,1,9,"","Refrigerante Lata 350 ml","Refrigerante lata:Coca-cola e Fanta Guaraná.","R$7,00");
insert into prato values ('12136745334526',12079,1,9,"","Chá Nestea","Chá Nestea 340ml sabor:limão.","R$8,00");

/*Nagasaki Ya entradas*/
insert into prato values ('69545560300155',13001,1,9,"imagens/Nagasaki _ya/entradas/missoshiru.webp","Missoshiru","Sopa de pasta de soja com tofu e cebolinha","R$8,00");
insert into prato values ('69545560300155',13002,1,9,"imagens/Nagasaki _ya/entradas/hot_especial_1.webp","Hot especial 1 (10 unidades )","Hossomaki de patê de salmão empanado coberto com creamcheese e cubo de salmão cru e tarê.","R$25,00");
insert into prato values ('69545560300155',13003,1,9,"imagens/Nagasaki _ya/entradas/hot_especial_2.webp","Hot especial 2 ( 10 unidades)","Hossomaki de patê de salmão empanado, coberto com creamcheese , couve crispy e tarê.","R$22,00");
insert into prato values ('69545560300155',13004,1,9,"imagens/Nagasaki _ya/entradas/sumono_simples_com_gergelim.webp","Sunomono simples com gergelim","Pepino fatiado agridoce em conserva copo 360 ml","R$15,00");
insert into prato values ('69545560300155',13005,1,9,"imagens/Nagasaki _ya/entradas/batata_file_mussarela.webp","Robata de file com mussarela","1 espetinho com 4 pedaços, com tare.","R$12,00");
insert into prato values ('69545560300155',13006,1,9,"imagens/Nagasaki _ya/entradas/mini_harumaki_de_queijo.webp","Mini harumaki de queijo","3 unidades","R$10,00");
insert into prato values ('69545560300155',13007,1,9,"imagens/Nagasaki _ya/entradas/gyoza_lombo_legume.webp","Gyoza de lombo e legumes","6 unidades","R$30,00");
insert into prato values ('69545560300155',13008,1,9,"imagens/Nagasaki _ya/entradas/gyoza_vegetariano.webp","Gyoza vegetariano","6 unidades","R$25,00");
insert into prato values ('69545560300155',13009,1,9,"imagens/Nagasaki _ya/entradas/shimeji_no_azeite.webp","Shimeji no azeite","Shimeji no azeite com shoyu copo 360 ml","R$26,00");



/*kanashiro entradas*/
insert into prato values ('98445038000191',14001,1,9,"imagens/kanashiro/entradas/tofu_temperado.webp","Tofu Temperado","Tofu, óleo de gergelim, katsuobushi, gengibre ralado, cebolete e tagarashi.","R$15,00");
insert into prato values ('98445038000191',14002,1,9,"imagens/kanashiro/entradas/sumono_rabanete.webp","Sunomono de rabanete","Fatias fininhas de rabanete temoerado.","R$15,00");
insert into prato values ('98445038000191',14003,1,9,"imagens/kanashiro/entradas/raiz_lotus.jpeg","Raiz de lótus","Crocante e sequinho","R$15,00");
insert into prato values ('98445038000191',14004,1,9,"imagens/kanashiro/entradas/edamane.webp","Edamane","Soja verde com flor de sal","R$18,00");
insert into prato values ('98445038000191',14005,1,9,"imagens/kanashiro/entradas/guioza.webp","Guioza","3 unidades","R$25,00");
insert into prato values ('98445038000191',14006,1,9,"imagens/kanashiro/entradas/polvo_empanado.webp","Polvo empanado","crocante por fora e macio por dentro","R$25,00");
insert into prato values ('98445038000191',14007,1,9,"imagens/kanashiro/entradas/shimeji.webp","Shimeji","Shimeji temperado","R$30,00");
insert into prato values ('98445038000191',14008,1,9,"imagens/kanashiro/entradas/kimpira_gobo.webp","Kimpira gobô","Raiz de bardana temperado","R$15,00");




/*kanashiro entradas*/
insert into prato values ('70348766554387',15001,1,9,"imagens/Okey-dokey/starters/nacho_supremo.webp","Nacho Supremo","Nachos com cobertura de chilli com carne, machacas (carne desfiada) ou frango desfiado, cheddar cremoso, azeitona preta, guacamole, sour cream e pico de gallo","R$43,90");
insert into prato values ('70348766554387',15002,1,9,"imagens/Okey-dokey/starters/tex_mex_nacho.webp","Tex-mex nacho","Nachos com cobertura de chilli com carne e cheddar cremoso.","R$39,90");
insert into prato values ('70348766554387',15003,1,9,"imagens/Okey-dokey/starters/nacho_libre.webp","Nacho Libre","Nachos crocantes com acompanhamento separado de molhos guacamole, sour cream e pico de gallo","R$36,90");
insert into prato values ('70348766554387',15004,1,9,"imagens/Okey-dokey/starters/chicken_fingers.webp","Chicken fingers - isca de frango estilo americano","Riquíssimo sassami de frango a milanesa. acompanham ranch dressing dip e barbecue sauce","R$39,90");
insert into prato values ('70348766554387',15005,1,9,"imagens/Okey-dokey/starters/bufalo_wings.webp","Bufalo wings - alitas picosas","Deliciosas asas de frango fritas banhadas em molho picante okey-dokey. acompanha ranch dressing dip","R$39,90");

/*cantina di lucca entradas*/
insert into prato values ('26549325558956',16001,1,9,"imagens/Cantina_di_lucca/pratos/brusquetta.webp","Brusquetta","Torrada coberta com queijo, tomates e salsa","R$27,00");
insert into prato values ('26549325558956',16002,1,9,"imagens/Cantina_di_lucca/pratos/talharim.webp","Talharim com Calabresa","Talharim com molho sugo e calabresa picada","R$82,00");
insert into prato values ('26549325558956',16003,1,9,"imagens/Cantina_di_lucca/pratos/supremo_frango_com_creme_de_mihlo.webp","Supremo de frango com creme de milho","Filet de peito de frango, grelhado ou milanesa, com creme de milho e arroz","R$77,00");
insert into prato values ('26549325558956',16004,1,9,"imagens/Cantina_di_lucca/pratos/perna_de_cabrito.jpg","Perna de cabrito","Pernil de cabrito assado com ervas, acompanha batatas coradas, brócolis ao alho e óleo e arroz branco","R$181,00");
insert into prato values ('26549325558956',16005,1,9,"imagens/Cantina_di_lucca/pratos/payard_com_talharim.webp","Payard com talharim aos 4 formagi","Filet mignon tipo escalope ao molho roti com parmesão ralado grosso acompanha talharim com molho 4 formagi (4 queijos)","R$165,00");




/*spoleto entradas*/
insert into prato values ('23248325558205',17001,1,9,"imagens/spoleto/massas/ravioli_frango.webp","Ravioli de frango","200g Ravioli recheado de frango + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17002,1,9,"imagens/spoleto/massas/ravioli_queijo_presunto.webp","Ravioli Queico e Presunto","200g ravioli recheado de queijo e presunto + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17003,1,9,"imagens/spoleto/massas/ravioli_carne.webp","Ravioli de Carne","200g Ravioli recheado de carne + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17004,1,9,"imagens/spoleto/massas/ravioli_ricota.webp","Ravioli de Ricota","200g Ravioli recheado de ricota + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17005,1,9,"imagens/spoleto/massas/ravioli_gorgonzola.webp","Raviole de Gorgonzola","200g Ravioli recheado de gorgonzola + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");



/*Cozinha do Roma entradas*/
insert into prato values ('50996645258098',18001,1,9,"imagens/cozinha_do_roma/marmita/bife_cavala.webp","Bife a Cavala","Arroz,feijão,fritas,ovo e salada","R$16,00");
insert into prato values ('50996645258098',18002,1,9,"imagens/cozinha_do_roma/marmita/parmegiana_carne.webp","A Parmegiana de Carne","Acompanhamentos: arroz ,batata frita ou souté , farofa e salada","R$20,00");
insert into prato values ('50996645258098',18003,1,9,"imagens/cozinha_do_roma/marmita/parmegiana_frango.webp","A Parmegiana de Frango","Acompanhamentos : arroz batata frita ou batata souté farofa e salada","R$18,00");
insert into prato values ('50996645258098',18004,1,9,"imagens/cozinha_do_roma/marmita/salada_fitnes.webp","Salada fitnes top 10 (10 itens)","Composta por 10 itens :alface, cenoura, tomate,ovo de codorna, agrião, cebola ,beterraba , azeitona, brócolis, milho ,batata doce e pepino.mais 1 proteína a sua escolha (frango ou bife grelhado no azeite )","R$20,00");
insert into prato values ('50996645258098',18005,1,9,"imagens/cozinha_do_roma/marmita/omelete_gourmet.webp","Omelete Gourmet","Arroz-feijão-fritas-salada _ opcional:(recheado com mussarela ,Catupiry ou cheddar)","R$16,00");



/*Seven Kings Os reis*/
insert into prato values ('32789896969632',19001,1,7,"imagens/seven_kings/reis/olaf.webp","Rei Olaf Vermundsson","Pão, hambúrguer de 180g, creme de provolone, bacon e pimenta jalapeño.","R$35,07");
insert into prato values ('32789896969632',19002,1,7,"imagens/seven_kings/reis/ragnar.webp","Rei Ragnar Lothbrok","Pão, hambúrguer de 180g, cream cheese, geleia de pimenta e bacon.","R$35,07");
insert into prato values ('32789896969632',19003,1,7,"imagens/seven_kings/reis/bruce.webp","Rei Robert De Bruce","Pão, hambúrguer de 180g, queijo cheddar e cebola caramelizada no molho bbq com whisky.","R$35,07");
insert into prato values ('32789896969632',19004,1,7,"imagens/seven_kings/reis/arthur.webp","Rei Arthur Pendragon","Pão, hambúrguer de 180g, creme de gorgonzola, farofa de bacon e rúcula.","R$35,07");
insert into prato values ('32789896969632',19005,1,7,"imagens/seven_kings/reis/jimmu.webp","Rei Jimmu","Pão, hambúrguer de 180g, queijo cheddar, cebola e shimeji caramelizada no shoyo.","R$35,07");
insert into prato values ('32789896969632',19006,1,7,"imagens/seven_kings/reis/ludwig.webp","Rei Ludwig Da Baviera","Pão, dois smashed burger, cheddar, bacon, maionese de bacon, pimentas jalapêno e barbecue.","R$40,07");



/*Seven Kings Os Pebleus*/
insert into prato values ('32789896969632',19007,1,7,"imagens/seven_kings/pebleus/cheese.webp","Cheese Burger 90gr","Pão, hambúrguer de 90g, maionese artesanal e queijo prato (ou cheddar).","R$18,07");
insert into prato values ('32789896969632',19008,1,7,"imagens/seven_kings/pebleus/hamburguer.webp","Hambúrguer","Pão, hambúrguer de 180g e maionese artesanal.","R$20,07");
insert into prato values ('32789896969632',19009,1,7,"imagens/seven_kings/pebleus/cheese.webp","Cheese Burger","Pão, hambúrguer de 180g, maionese artesanal e queijo prato (ou cheddar).","R$23,07");
insert into prato values ('32789896969632',19010,1,7,"imagens/seven_kings/pebleus/bacon.webp","Cheese Bacon","Pão, carne de 180g, queijo prato (ou cheddar), maionese artesanal e bacon.","R$27,07");
insert into prato values ('32789896969632',19011,1,7,"imagens/seven_kings/pebleus/salada.webp","Cheese Salada","Pão, carne de 180g, queijo prato (ou cheddar), maionese artesanal, alface lisa, tomate e cebola roxa.","R$27,07");

/*Seven Kings Refeição Real*/
insert into prato values ('32789896969632',19012,1,7,"imagens/seven_kings/refeicao/real.webp","Combo Real","Monte um combo com seu rei favorito com um mega desconto!","R$47,07");
insert into prato values ('32789896969632',19013,1,7,"imagens/seven_kings/refeicao/combo.webp","Combo cheese bacon","Cheese bacon + batata chips + refrigerante","R$37,07");
/*Seven Kings Escudeiros*/
insert into prato values ('32789896969632',19014,1,3,"","Porção De Candy Bacon","4 Fatias de bacon caramelizado.","R$16,07");
insert into prato values ('32789896969632',19015,1,3,"imagens/seven_kings/escudeiro/onion.webp","Onion Rings","Porção individual de anéis de cebola empanados feitos na casa.","R$20,07");
insert into prato values ('32789896969632',19016,1,3,"","Porção de Batata Chips","Batata Chips feitas na casa","R$15,07");
insert into prato values ('32789896969632',19017,1,3,"imagens/seven_kings/escudeiro/bitter.webp","Bitterballen","Porção de 6 unidades de bolinhos de carne empanados e fritos, acompanhados de geleia de pimenta da casa.","R$22,07");

/*Seven Kings Escudeiros veggie*/
insert into prato values ('32789896969632',19018,1,3,"","Bolinho De Shimeji","Bolinho veggie com massa de coxinha e recheado de shimeji salteado.","R$22,07");
insert into prato values ('32789896969632',19019,1,3,"","Falafel","Bolinho de grão de bico ao estilo arabe.","R$22,07");

/*Seven Kings Bebidas*/
insert into prato values ('32789896969632',19020,1,9,"","Água 500ml","S/gás ou C/gás","R$6,07");
insert into prato values ('32789896969632',19021,1,9,"","Refrigerante lata 350ml","Sabores:Fanta uva,Schweppes citrus,Sprite,Fanta Guaraná,Coca cola zero e Coca cola","R$7,07");
insert into prato values ('32789896969632',19022,1,9,"","Sol","350ml","R$9,07");
insert into prato values ('32789896969632',19023,1,9,"","Heineken","343ml","R$9,07");

/*Seven Kings Sobremesa*/
insert into prato values ('32789896969632',19024,1,8,"imagens/seven_kings/sobremesa/cooki.webp","Cookiempada","Empada com massa de cookie recheada.","R$13,07");
insert into prato values ('32789896969632',19025,1,8,"","Pavê de Brownie","Pavê de brownie com mousse de diversos sabores","R$12,07");


/*Iphome salgados*/
insert into prato values ('98663233654044',20001,1,9,"imagens/iphome/mini_salgados/cone_p_12_unidades.webp","Cone p (12 unid.)","Escolha até 3 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$4,50");
insert into prato values ('98663233654044',20002,1,9,"imagens/iphome/mini_salgados/cone_m_20_unidades.webp","Cone m (20 unid.)","Escolha até 4 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$7,00");
insert into prato values ('98663233654044',20003,1,9,"imagens/iphome/mini_salgados/50tinha.webp","50tinha","Escolha até 5 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$13,00");
insert into prato values ('98663233654044',20004,1,9,"imagens/iphome/mini_salgados/cento_na_caixa.webp","Cento na caixa","Escolha até 5 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$26,00");


/*Iphome minichurros*/
insert into prato values ('98663233654044',20005,1,9,"imagens/iphome/mini_churros/cone_p_12_unidades.webp","Cone p (12 unid.)","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$4,50");
insert into prato values ('98663233654044',20006,1,9,"imagens/iphome/mini_churros/cone_m_20_unidades.webp","Cone m (20 unid.)","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$7,00");
insert into prato values ('98663233654044',20007,1,9,"imagens/iphome/mini_churros/50tinha.webp","50tinha","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$13,00");
insert into prato values ('98663233654044',20008,1,9,"imagens/iphome/mini_churros/cento_na_caixa.webp","Cento na caixa","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$26,00");

/*Churrascaria O Custelão minichurros*/
insert into prato values ('60334456098530',21005,1,9,"imagens/o_costelao/mini_churros/cone_p_12_unidades.webp","Cone p (12 unid.)","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$4,50");
insert into prato values ('60334456098530',21006,1,9,"imagens/o_costelao/mini_churros/cone_m_20_unidades.webp","Cone m (20 unid.)","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$7,00");
insert into prato values ('60334456098530',21007,1,9,"imagens/o_costelao/mini_churros/50tinha.webp","50tinha","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$13,00");
insert into prato values ('60334456098530',21008,1,9,"imagens/o_costelao/mini_churros/cento_na_caixa.webp","Cento na caixa","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$26,00");



/*cafe 87 cafes e capuccino*/
insert into prato values ('56324591446635',22001,1,10,"imagens/cafe_87/cafes_e_cappucinos/cafe_coador.webp","Café de Coador","60 ml de café passado em coador de pano","R$2,50");
insert into prato values ('56324591446635',22002,1,10,"imagens/cafe_87/cafes_e_cappucinos/cafe_expresso.webp","Café Expresso","75ml","R$3,00");
insert into prato values ('56324591446635',22003,1,10,"imagens/cafe_87/cafes_e_cappucinos/capuccino_cremoso.webp","Capuccino Cremoso","120ml de cappuccino já adoçado.","R$7,00");


/*cafe 87 lanches*/
insert into prato values ('56324591446635',22004,1,7,"imagens/cafe_87/lanches/x_salada.webp","X Salada","Pão de hambúrguer, hambúrguer, alface, tomate, queijo e presunto","R$10,00");
insert into prato values ('56324591446635',22005,1,7,"imagens/cafe_87/lanches/completao.webp","Completão","Pão de hambúrguer, alface, tomate, hambúrguer, queijo mussarela, presunto, bacon e ovo .","R$13,00");
insert into prato values ('56324591446635',22006,1,7,"imagens/cafe_87/lanches/omelete.webp","Omelete","3 ovos com recheio a escolher: Bacon, Peito de peru, Queijo branco, Presunto, Mussarela","R$12,00");



select r.nm_restaurante, c.nm_categoria, p.ds_ingredientes_prato, p.nm_prato from prato p join restaurante r on (p.cd_cnpj_restaurante = r.cd_cnpj_restaurante)
inner join categoria c on (r.cd_categoria = c.cd_categoria)
where (p.nm_prato like '%temaki%' or p.ds_ingredientes_prato like '%temaki%' or r.nm_restaurante like '%temaki%');
 
 



