DROP SCHEMA IF EXISTS pickno16_pckDB;
CREATE SCHEMA pickno16_pckDB;
USE pickno16_pckDB;

create table cliente(
cd_cpf_cliente varchar(11) not null,
nm_cliente text not null,
cd_senha_cliente varchar(255) not null,
nm_email_cliente varchar(50) not null,
cd_img_cliente longtext,
qt_pontos int,
primary key cliente (cd_cpf_cliente)
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
cd_latitude varchar  (14) null,
cd_longitude varchar (14) null,
primary key restaurante (cd_cnpj_restaurante),
foreign key restaurante_categoria (cd_categoria) references categoria (cd_categoria)
);

create table tipo_prato(
cd_tipo_prato int not null,
nm_tipo_prato text not null,
cd_cnpj_restaurante varchar(14) not null,
primary key tipo_prato (cd_tipo_prato),
foreign key tipo_prato_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
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
primary key adm_restaurante (nm_email_restaurante),
foreign key adm_restaurante_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);


create table dia_semana( 
cd_dia_semana varchar (1),
nm_dia_semana varchar (7) not null,
primary key dia_semana (cd_dia_semana)
);

create table horario_funcionamento( 
cd_dia_semana varchar (1) not null,
hr_abertura time  not null,
hr_fechamento_dia_funcionamento time not null,
cd_cnpj_restaurante varchar(14) not null,
ic_aberto bool,
foreign key horario_funcionamento_dia_semana (cd_dia_semana) references dia_semana (cd_dia_semana),
foreign key horario_funcionamento_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
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

create table resgate_prato(
cd_cpf_cliente varchar(16) not null,
cd_prato char(8) not null,
cd_cnpj_restaurante varchar(16) not null,
cd_cupom varchar(8) not null,
dt_resgate datetime not null,
dt_validade datetime not null,
primary key resgate_prato (cd_cupom),
foreign key resgate_prato_prato (cd_prato) references prato (cd_prato),
foreign key resgate_prato_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente),
foreign key resgate_prato_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);

create table cupom(
cd_cpf_cliente varchar(16) not null,
cd_recompensa int not null,
cd_cnpj_restaurante varchar(14) not null,
cd_cupom varchar(8) not null,
dt_resgate datetime,
dt_validade datetime,
cd_situacao int,
primary key cupom (cd_cupom),
foreign key cupom_recompensa (cd_recompensa) references recompensas (cd_recompensa),
foreign key cupom_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente),
foreign key cupom_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);


create table cupom_usado (
cd_cpf_cliente varchar(16) not null,
cd_cupom varchar(8) not null,
cd_cnpj_restaurante varchar(14) not null,
dt_uso_cupom datetime,
foreign key cupom_usado_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente),
foreign key cupom_usado_cupom (cd_cupom) references cupom (cd_cupom),
foreign key cupom_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);

create table lugares_visitados(
cd_historico int auto_increment not null,
cd_cpf_cliente varchar(11) not null,
cd_cnpj_restaurante varchar(14) not null,
dt_visita datetime not null,
vl_compra int,
vl_ponto double,
primary key lugares_visitados (cd_historico),
foreign key lugares_visitados_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente),
foreign key lugares_visitados_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante)
);

create table lugares_favoritos(
cd_cnpj_restaurante varchar(16) not null,
cd_cpf_cliente varchar(11) not null,
foreign key lugares_favoritos_restaurante (cd_cnpj_restaurante) references restaurante (cd_cnpj_restaurante),
foreign key lugares_favoritos_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente)
);

create table trocas_efetuadas(
qt_trocas int,
cd_cpf_cliente varchar(11) not null,
foreign key trocas_efetuadas_cliente (cd_cpf_cliente) references cliente (cd_cpf_cliente)
);

/*Cliente*/
insert into cliente values ("45581469814","Thiago Amaro",md5('admin123'),"thiago.amaro.r@gmail.com","imagens/piccliente/3.jpg",3000);
insert into cliente values ("40781797896","Vinicius Costa",md5('admin123'),"vinicns91@gmail.com","imagens/piccliente/4.jpeg",3000);
insert into cliente values ("47925972858","Gabriel Costa",md5('admin123'),"gabriel.cns00@gmail.com","imagens/piccliente/1.jpeg",3000);
insert into cliente values ("47298410857","Luca Pedro",md5('admin123'),"lucadeveloperpk@gmail.com","imagens/piccliente/2.jpeg",3000);
insert into cliente values ("39185491861","Yuri Flausino",md5('admin123'),"yuriflausino14@gmail.com","imagens/piccliente/5.jpeg",3000);



/*Categoria*/
insert into categoria values (1,"Mexicana");
insert into categoria values (2,"Churrascaria");
insert into categoria values (3,"Árabe");
insert into categoria values (4,"Cafeteria");
insert into categoria values (5,"Pizzaria");
insert into categoria values (6,"Fast Food");
insert into categoria values (7,"Hamburgueria & Lanchonete");
insert into categoria values (8,"Chinesa");
insert into categoria values (9,"Japonesa");
insert into categoria values (10,"Italiana");
insert into categoria values (11,"Pastelaria");
insert into categoria values (12,"Sorveteria");
insert into categoria values (13,"Creperia");
insert into categoria values (14,"Doces & Bolos");
insert into categoria values (15,"Frutos do Mar");
insert into categoria values (16,"Saudável");
insert into categoria values (17,"Vegetariana");
insert into categoria values (18,"Açai");
insert into categoria values (19,"Brasileira");



/*Restaurantes*/
insert into restaurante values ("imagens/ragazzo/logragazzo.png",'60746948510820','1333555443',"Ragazzo",10,"-23.961878","-46.332258");/*1*/
insert into restaurante values ("imagens/china_in_box/log_china.jpg",'00517012000198','1333467683',"China In Box",8,"-23.964697","-46.330218");/*2*/
insert into restaurante values ("imagens/big_x_picanha/logbigxpicanha.webp",'17686110000151','1333675443',"Big X Picanha",7,"-23.958158","-46.331896");/*3*/
insert into restaurante values ("imagens/croasonho/logo_croasonho.webp",'70543238876843','1333098743',"Croasonho",11,"-23.968021","-46.330146");/*4*/
insert into restaurante values ("imagens/tio_sam_japa_food/logo_tio_sam.webp",'67594639571239','1333598453',"Tio Sam Japa Food",9,"-23.965829","-46.388459");/*5*/
insert into restaurante values ("imagens/seu_temaki/logo_seutemaki.webp",'98450900034563','1333930244',"Seu Temaki",9,"-23.948272","-46.3315722");/*6*/
insert into restaurante values ("imagens/banzai/logo_ban.webp",'82300081236891','1332489630',"Banzai",9,"-23.96086","-46.3266267");/*7*/
insert into restaurante values ("imagens/quiosque_burgman/logo_burgman.webp",'62315943587966','1332659879',"Burgman",10,"23.9890543","-46.3017353");/*8*/
insert into restaurante values ("imagens/oakberry/logo_oakberry.png",'40879632585865','1332322552',"Oakberry",18,"-23.9687518","-46.3348945");/*9*/
insert into restaurante values ("imagens/brasileirinho/logo_brasileirinho.png",'65662348978806','1332705630',"Brasileirinho",19,"-23.97010225","-46.31287158");/*10*/
insert into restaurante values ("imagens/mcdonald/logo_mcdonald.png",'21912193404921','1332066782',"Mc Donald's",6,"-23.98094453","-46.31162971");/*11*/
insert into restaurante values ("imagens/salua/logo_salua.webp",'12136745334526','1333456238',"Saluá",3,"-23.96813173","-46.31953955");/*12*/
insert into restaurante values ("imagens/nagasaki_ya/logo_nagasaki.webp",'69545560300155','1332300979',"Nagasaki Ya",9,"-23.96525921","-46.3288039");/*13*/
insert into restaurante values ("imagens/kanashiro/logo_kanashiro.webp",'98445038000191','1332336556',"kanashiro",9,"-23.96788173","-46.32557988");/*14*/
insert into restaurante values ("imagens/santa_arena/logo_santa_arena.webp",'70348766554387','1332998782',"Santa Arena Rest e Pizzaria",19,"-23.9591867","-46.3161891");/*15*/
insert into restaurante values ("imagens/cantina_di_lucca/logdilucca.png",'26549325558956','1332730782',"Cantina Di Lucca",10,"-23.9644173","-46.3335327");/*16*/
insert into restaurante values ("imagens/spoleto/logo_spoleto.webp",'23248325558205','1332965782',"Spoleto",10,"-23.9468023","-46.3353033");/*17*/
insert into restaurante values ("imagens/cozinha_do_roma/logo_cozinha_roma.webp",'50996645258098','1332963022',"Cozinha Do Roma",19,"-23.9555885","-46.4144769");/*18*/
insert into restaurante values ("imagens/seven_kings/logo_seven_kings.webp",'32789896969632','1332973222',"Seven Kings",7,"-23.9649056","-46.3244236");/*19*/
insert into restaurante values ("imagens/iphome/logo_iphome.webp",'98663233654044','1332528982',"Iphome",10,"-23.9531578","-46.3378229");/*20*/
insert into restaurante values ("imagens/o_costelao/logo_o_costelao.webp",'60334456098530','1332528982',"Churrascaria O Custelão",2,"-23.9466721","-46.3372687");/*21*/
insert into restaurante values ("imagens/cafe_87/logo_cafe87.webp",'56324591446635','1332118982',"Café 87",4,"","");/*22*/
insert into restaurante values ("imagens/taco_bell/logo_taco_bell.webp",'35546123998702','1332325682',"Taco Bell Praiamar",1,"","");/*23*/
insert into restaurante values ("imagens/taquitos_beer/logo_taquitos.webp",'20365987889633','1332752682',"Taquitos Beer",1,"","");/*24*/
insert into restaurante values ("imagens/dboa_mexico/logo_dboa_mexico.webp",'12503069878892','1332753022',"D'Boa Mexico",1,"","");/*25*/
insert into restaurante values ("imagens/guadalupe/logo_guadalupe.webp",'60322256698770','1332443044',"Guadalupe",1,"","");/*26*/
insert into restaurante values ("imagens/arriba_maria/logo_arriba_maria.webp",'23366909788850','1332033215',"Arriba Maria",1,"","");/*27*/
insert into restaurante values ("imagens/familia_santos/logo_familia_santos.webp",'12255889999633','1332033215',"Família Santos Churrascaria",2,"","");/*28*/
insert into restaurante values ("imagens/himalaia_fit/logo_himalaia.webp",'39560145672313','1332528982',"Himalai Fit",16,"","");/*29*/
insert into restaurante values ("imagens/patroni_santos/logo_patroni_santos.webp",'21556478987412','1332965982',"Patroni Pizzaria",5,"-23.9767072","-46.3104656");/*30*/
insert into restaurante values ("imagens/pizza_hut_santos/logo_pizza_hut_santos.webp",'36554770089987','1332023682',"Pizza Hut",5,"-23.9702869","-46.3202557");/*31*/
insert into restaurante values ("imagens/casa_nova_pizzaria/logo_casa_nova_pizzaria.webp",'50633214477787','1332055892',"Casa Nova Pizzaria",5,"-23.9421039","-46.3828852");/*32*/
insert into restaurante values ("imagens/florença_forneria/logo_florença_forneria.webp",'64808098785322','1332052502',"Florença Forneria",5,"-23.9836574","-46.3010805");/*33*/
insert into restaurante values ("imagens/pizzaria_vila_dy_napolli/logo_pizzaria_vila_dy_napolli.png",'40566932201478','1332014502'," Pizzaria Vila dy Napolli",5,"-23.9633714","-46.3128088");/*34*/
insert into restaurante values ("imagens/don_correa_pizzaria/logo_don_correa_pizzaria.webp",'32255569874125','1332162502',"Don Corrêa Pizzaria",5,"-23.9578188","-46.3389915");/*35*/
insert into restaurante values ("imagens/pizza_madre/logo_pizza_madre.webp",'36699878521002','1332165722',"Pizza Madre",5,"-23.9526338","-46.3466323");/*36*/
insert into restaurante values ("imagens/nonna_carmello_pizzaria/logo_nonna_carmello_pizzaria.webp",'20336558940102','1332162322',"Nonna Carmello Pizzaria",5,"-23.9615386","-46.3375989");/*37*/
insert into restaurante values ("imagens/baviera/logo_Baviera.webp",'50644100236502','1332164092',"Baviera",5,"-23.9740028","-46.3154742");/*38*/
insert into restaurante values ("imagens/tomato_forneria/logo_tomato_forneria.webp",'40005698632573','1332002365',"Tomato Forneria",5,"-23.96708","-46.31441");/*39*/
insert into restaurante values ("imagens/rizzo_italian/logo_rizzo_italian.webp",'50069878203657','1332003205',"Rizzo Italian Gourmet",10,"-23.9777966","-46.3090035");/*40*/
insert into restaurante values ("imagens/massas_veneza/logo_massas_veneza.webp",'90878999650024','1332357785',"Massas Veneza",10,"-23.9649059","-46.3207834");/*41*/
insert into restaurante values ("imagens/liliana_pasta/logo_liliana_pasta.webp",'20588789000001','1332350251',"Liliana Pasta & Pizza",10,"-23.976698","-46.310744");/*42*/
insert into restaurante values ("imagens/beduino/logo_beduino.webp",'10056900877453','1332357213',"Beduino",3,"-23.9647735","46.3328144");/*43*/
insert into restaurante values ("imagens/salaam_shawarma/logo_salaam_shawarma.webp",'15047362149878','1332302313',"Salaam Shawarma",3,"-23.965867","-46.33566");/*44*/
insert into restaurante values ("imagens/burgolandia/logo_burgolandia.webp",'78350125697410','1332309335',"Burgolandia ",7,"-23.968102","-46.378091");/*45*/
insert into restaurante values ("imagens/salt_hamburgueria/logo_salt_hamburgueria.webp",'30021480097563','1144853104',"Salt Hamburgueria ",7,"-23.4056852","-46.6380861");/*46*/
insert into restaurante values ("imagens/buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp",'36000457986321','1332002505',"Buddy's Bar Hamburgueria ",7,"-23.9889296","-46.3004032");/*47*/
insert into restaurante values ("imagens/seiko_temakeria/logo_seiko_temakeria.webp",'50088779863014','1332365470',"Seiko Temakeria ",9,"-23.9660045","-46.33486");/*48*/
insert into restaurante values ("imagens/hoshi_temaki_poke/logo_hoshi_temaki_poke.webp",'20068796324578','1332366578',"Hoshi Temaki & Poke ",9,"-23.9688815","-46.3323968");/*49*/
insert into restaurante values ("imagens/kampay/logo_kampay.webp",'40320069872344','1332398778',"Kampay ",9,"-23.9718359","-46.3076334");/*50*/
insert into restaurante values ("imagens/seu_miyagi/logo_seu_miyagi.webp",'60098753214598','1332032178',"Seu Miyagi Sushi ",9,"-23.9648971","-46.3433136");/*51*/
insert into restaurante values ("imagens/pastel_trevo_bertioga_gonzaga/logo_Pastel_trevo_bertioga_gonzaga.webp",'40036598752014','1333569874',"Pastel Trevo Bertioga Gonzaga ",11,"-23.9649847","-46.332159");/*52*/
insert into restaurante values ("imagens/vivenda_do_camarao/logo_vivenda_do_camarao.webp",'98000054621357','1332300697',"Vivenda do Camarão",15,"-23.976698","-46.310744");/*53*/
insert into restaurante values ("imagens/peixe_na_brasa/logo_peixe_na_brasa.webp",'70063254789602','1332002588',"Peixe na Brasa",15,"-23.9682463","-46.319618");/*54*/
insert into restaurante values ("imagens/master_veggie/logo_master_veggie.webp",'64500008796321','1332075332',"Master Veggie",17,"","");/*55*/
insert into restaurante values ("imagens/desfrutti/logo_desfrutti.webp",'12340000078654','1332123456',"Desfrutti",16,"-23.976698","-46.310744");/*56*/
insert into restaurante values ("imagens/ye/logo_ye.webp",'40788865200002','1332112578',"Yê",16,"-23.9858241","-46.2999547");/*57*/
insert into restaurante values ("imagens/light_Food_Way/logo_Light_Food_Way.webp",'23601478954223','1332023346',"Light Food Way",16,"-23.961065","-46.32712");/*58*/
insert into restaurante values ("imagens/soutu_Saudável/logo_Soutu_Saudável.webp",'13022200007567','1332645782',"Soutu Saudável",16,"","");/*59*/
insert into restaurante values ("imagens/maria_acai/logo_maria_acai.webp",'20006578880005','1332006782',"Maria Açai",18,"-23.9652113","-46.3211");/*60*/
insert into restaurante values ("imagens/super_acai/logo_super_acai.webp",'15478899660004','1332000014',"Super Açai",18,"","");/*61*/
insert into restaurante values ("imagens/zabari/logo_zabari.webp",'13567895412566','1332600897',"Zabari",19,"-23.948393","-46.328837");/*62*/
insert into restaurante values ("imagens/creperia_da_praia/logo_creperia_da_praia.webp",'23650004789564','1332602197',"Creperia da Praia",13,"-23.9702478","-46.3294796");/*63*/
insert into restaurante values ("imagens/pastel_da_erika/logo_pastel_da_erika.webp",'75320000478967','1332987507',"Pastel da Erika",11,"-23.9721628","-46.3255088");/*64*/
insert into restaurante values ("imagens/yoi_nami/logo_yoi_nami.webp",'85200000365789','1332302507',"Yoi Nami",11,"-23.9569119","-46.3281315");/*65*/
insert into restaurante values ("imagens/amor_aos_pedacos/logo_amor_aos_pedacos.webp",'90006478954231','1332003258',"Amor aos Pedaços",14,"-23.976962","-46.309985");/*66*/
insert into restaurante values ("imagens/vem_la_da_roca/logo_vem_la_da_roca.webp",'60987000065478','1332000257',"Vem la da Roça",19,"-23.964919","-46.321754");/*67*/
insert into restaurante values ("imagens/capitao_grill/logo_capitao_grill.webp",'75620003214578','1332098257',"Capitão Grill",19,"-23.9485201","-46.3294365");/*68*/
insert into restaurante values ("imagens/bolo_da_madre/logo_bolo_da_madre.webp",'56478921305478','1332362100',"Bolo da Madre",14,"-23.9753185","-46.314076");/*69*/
insert into restaurante values ("imagens/grife_dos_brigadeiros/logo_grife_dos_brigadeiros.webp",'55021230014785','1332366580',"Grife dos Brigadeiros",14,"-23.968402","-46.312876");/*70*/
insert into restaurante values ("imagens/conrado_brigaderia/logo_conrado_brigaderia.webp",'32500097896541','1332687780',"Conrado Brigaderia",14,"-23.9757079","-46.3014331");/*71*/
insert into restaurante values ("imagens/lig_lig/logo_lig_lig.webp",'12035789451523','1332602530',"Lig-Lig",8,"-23.961578","-46.321657");/*72*/
insert into restaurante values ("imagens/china_gourmet/logo_china_gourmet.webp",'23600087544423','1332306530',"China Gourmet",8,"-23.9694558","-46.3860851");/*73*/
insert into restaurante values ("imagens/sucos_mel/logo_sucos_mel.webp",'50400098745632','1332337840',"Mel Sucos e Lanches",10,"-23.9335125","-46.3276638");/*74*/
insert into restaurante values ("imagens/sabor_da_praca/logo_sabor_da_praca.webp",'34500087954121','1332024710',"Sabor da Praça",10,"-23.9729273","-46.3025482");/*75*/
insert into restaurante values ("imagens/delicias_&_cia/logo_delicias_&_cia.webp",'62145789656423','1332324570',"Delicias & Cia",14,"","");/*76*/
insert into restaurante values ("imagens/shake_burguer/logo_shake_burger.webp",'78945695123578','1332548975',"Shake Burger",7,"-23.9577086","-46.3252751");/*77*/
insert into restaurante values ("imagens/burgui_food/logo_burgui.webp",'82395784561856','1332852951',"Burgui Food",7,"-23.9719163","-46.3099836");/*78*/
insert into restaurante values ("imagens/bacio_sorveteria/logo_bacio.webp",'89632574188956','1332748596',"Bacio Di Latte",12,"-23.9769086","-46.3104345");/*79*/
insert into restaurante values ("imagens/bamba_acai/logo_bamba.webp",'78945789641231','1332759625',"Bamba Açai",18,"-23.9723509","-46.3240991");/*80*/  
insert into restaurante values ("imagens/aloha_poke/logo_aloha.webp",'71945879641237','1332456789',"Aloha Poke Beer",9,"-23.9844376","-46.3000523");/*81*/
insert into restaurante values ("imagens/dominos_pizza/logo_dominos.webp",'47945789648537','1332412563',"Domino's Pizza",5,"-23.9739124","-46.3156235");/*82*/  
insert into restaurante values ("imagens/sabores_do_mar/logo_mar.webp",'20145789625237','1332365214',"Sabores do Mar",16,"-23.9765488","-46.3103719");/*83*/  
insert into restaurante values ("imagens/burguer_company/logo_company.webp",'38945784741237','1332894576',"Burger Company",7,"-23.9660648","-46.3300752");/*84*/  
insert into restaurante values ("imagens/mordidela/logo_mordidela.webp",'75845786641237','1332010232',"Mordidela",7,"-23.9700777","-46.3103127");/*85*/  
insert into restaurante values ("imagens/precious/logo_precious.webp",'96445781441237','1332965874',"Precious Burguer",7,"-23.9675146","-46.3140182");/*86*/  
insert into restaurante values ("imagens/esfiharia_santista/logo_esfiharia_santista.webp",'65445788941237','1332345612',"Esfiharia Santista 2",3,"-23.9714879","-46.3084412");/*87*/  
insert into restaurante values ("imagens/yakissoba_pezao/logo_yakissoba_pezao.webp",'35845710641237','1332912358',"Yakisoba do Pezão",8,"-23.9589597","-46.3887743");/*88*/  
insert into restaurante values ("imagens/vitshop/logo_vitshop.webp",'71045736641237','1332658941',"Vitshop",16,"-23.9643082","-46.3276304");/*89*/  
insert into restaurante values ("imagens/emporio_granola/logo_emporio_granola.webp",'98685789641237','1332665588',"Empório da Granola",17,"-23.9667913","-46.3381648");/*90*/  
insert into restaurante values ("imagens/capim_limao/logo_capim_limao.webp",'45789110641237','1332326859',"Capim Limao",17,"-23.9462186","-46.3313842");/*91*/  
insert into restaurante values ("imagens/rota_nordestina/logo_rota_nordestina.webp",'84725789641237','1332754896',"Restaurante Rota Nordestina",19,"-23.9888902","-46.3005169");/*92*/  
insert into restaurante values ("imagens/giraffas/logo_giraffas.webp",'99945789641251','1332102587',"Giraffas",19,"-23.9766974","-46.3107446");/*93*/  
insert into restaurante values ("imagens/pedra_baiana/logo_pedra_baiana.webp",'10235789641542','1332963258',"Pedra Baiana",19,"-23.9718963","-46.3068366");/*94*/  
insert into restaurante values ("imagens/yakissoba_brasil/logo_yakissoba_brasil.webp",'98655789641987','1332789582',"Yakissoba Brasil",8,"-23.1829666","-46.9018739");/*95*/  
insert into restaurante values ("imagens/stella_gourmet/logo_stella_gourmet.webp",'56545789641285','1332986574',"Stella's Gourmet",18,"","");/*96*/  
insert into restaurante values ("imagens/baixada_Fit/logo_baixada_Fit.webp",'15984578964123','1332742096',"Baixada Fit",16,"","");/*97*/ 
insert into restaurante values ("imagens/monkey_st/logo_monkey_st.webp",'58545789647485','1332451923',"Monkey St.",7,"","");/*98*/  
insert into restaurante values ("imagens/artesanal_burger/logo_artesanal_burger.webp",'23245789625237','1332754931',"Artesanal X Burger",7,"-23.962942","-46.3238481");/*99*/  
insert into restaurante values ("imagens/seu_burger/logo_seu_burger.webp",'45855789641275','1332148596',"Seu Burger",7,"","");/*100*/     


/*Dias Semana*/

insert into dia_semana values (1,"Domingo");
insert into dia_semana values (2,"Segunda");
insert into dia_semana values (3,"Terça");
insert into dia_semana values (4,"Quarta");
insert into dia_semana values (5,"Quinta");
insert into dia_semana values (6,"Sexta");
insert into dia_semana values (7,"Sábado");


/*adm restaurante*/
insert into adm_restaurante values ("ragazzo@ragazzo.com",'60746948510820',md5('admin123'),"São Paulo","Santos",'11060000', "Av Ana Costa, 437", "Gonzaga","","Marcelo Fernandes",'40787678995');
insert into adm_restaurante values ("china_in_box@china.com",'00517012000198',md5('admin123'),"São Paulo","Santos",'11060470', "Rua Dr Tolentino Filgueiras, 54", "Gonzaga","","Hamilton Tavares",'55517489778');
insert into adm_restaurante values ("big_x_picanha@big.com",'17686110000151',md5('admin123'),"São Paulo","Santos",'11060000', "Av Ana Costa, 318", "Campo Grande","Loja 3","Armindo Silva",'15900699862');
insert into adm_restaurante values ("croasonho@croasonho.com",'70543238876843',md5('admin123'),"São Paulo","Santos",'11055200', "Rua Dr Galeão Carvalhal, 15", "Gonzaga","","Mario Algusto",'40787678995');
insert into adm_restaurante values ("tiosamt@tiosam.com",'67594639571239',md5('admin123'),"São Paulo","São Vicenete",'11310070', "Rua Jacob Emmerich, 788", "Centro","","Fabiana Freitas",'13452678667');
insert into adm_restaurante values ("seutemaki@seutemaki.com",'98450900034563',md5('admin123'),"São Paulo","Santos",'11060000',"Av Ana Costa, 108", "Vila Matias","","Danilo Gentil",'1713212139');
insert into adm_restaurante values ("banzai@banzai.com",'82300081236891',md5('admin123'),"São Paulo","Santos",'11050101',"R. Goiás, 26 ", "Boqueirão","","Josefa dos Remedios",'19478821322');
insert into adm_restaurante values ("quiosqueburgman@quiosqueburgman.com",'62315943587966',md5('admin123'),"São Paulo","Santos",'11030380',"Av. Rei Alberto I, 280 ","Ponta da Praia","","Maicon Rissi",'10598761322');
insert into adm_restaurante values ("oakberry@oakberry.com",'40879632585865',md5('admin123'),"São Paulo","Santos",' 11060002',"Av. Ana Costa, 549","Gonzaga","","Maicon Rissi",'25663215987');
insert into adm_restaurante values ("contato@brasileirinho.com",'65662348978806',md5('admin123'),"São Paulo","Santos",'11040111',"Rua Oswaldo Cochrane, 233 ","Gonzaga","A","João Amaro",'40987563214');
insert into adm_restaurante values ("contato@mcdonalds.pontadapraia.com",'21912193404921',md5('admin123'),"São Paulo","Santos",'11045401',"Av. Bartolomeu de Gusmão, 108 ","Aparecida","","João Ortega",'40532147896');
insert into adm_restaurante values ("contato@salua.com",'12136745334526',md5('admin123'),"São Paulo","Santos",'11045201',"Av. Siqueira Campos, 559","Embaré","","João Ortega",'40987456321');
insert into adm_restaurante values ("contato@nagasaki_ya.com",'69545560300155',md5('admin123'),"São Paulo","Santos",'11055000'," Av. Washington Luiz, 476","Gonzaga","","Marconi Porulinni",'60787896541');
insert into adm_restaurante values ("contato@kanashiro.com",'98445038000191',md5('admin123'),"São Paulo","Santos",'11055150',"R. Valdomiro Silveira, 24","Boqueirão","","Ricardo Martinelli",'32589987452');
insert into adm_restaurante values ("contato@santa_arena.com",'70348766554387',md5('admin123'),"São Paulo","Santos",'11013550',"R. Vinte e Oito de Setembro, 278","Macuco","","Oswaldo de Carvalho",'40784563321');
insert into adm_restaurante values ("contato@cantinadilucca.com",'26549325558956',md5('admin123'),"São Paulo","Santos",'11060471', "Rua Dr Tolentino Filgueiras, 80", "Gonzaga","","Wesley Salteira",'40787462351');
insert into adm_restaurante values ("contato@spoleto.com",'23248325558205',md5('admin123'),"São Paulo","Santos",'11075001', "Av. Senador Pinheiro Machado, 135", "Vila Matias","","Mario Ribeiro",'40563222018');
insert into adm_restaurante values ("contato@cozinhadoroma.com",'50996645258098',md5('admin123'),"São Paulo","São Vicente",'11340330', "R. Raul Serapião Barroso, 593", "Esplanada dos Barreiros","","Betina Franco",'40568598653');
insert into adm_restaurante values ("contato@sevenkings.com",'32789896969632',md5('admin123'),"São Paulo","Santos ",'11045120', "R. Dr. Lobo Viana, 22 ", "Boqueirão","","Vinicius Costa",'15801698861');
insert into adm_restaurante values ("contato@iphome.com",'98663233654044',md5('admin123'),"São Paulo","Santos ",'11075340', "R. Rio de Janeiro, 113", "Vila Belmiro","","Donato Netto",'12585858987');
insert into adm_restaurante values ("contato@ocostelao.com",'60334456098530',md5('admin123'),"São Paulo","Santos ",'11075001', "Av. Senador Pinheiro Machado, 129", "Vila Belmiro","","Guilherme Augusto",'12585859458');
insert into adm_restaurante values ("contato@patroni_santos.com",'21556478987412',md5('admin123'),"São Paulo","Santos ",'11025202', "R. Alexandre Martins, 80", "Aparecida ","Praiamar Shopping"," Santiago Anlo",'11203465981');
insert into adm_restaurante values ("contato@pizza_hut_santos.com",'36554770089987',md5('admin123'),"São Paulo","Santos ",'11045200', "Av. Siqueira Campos, 606", "Gonzaga ",""," Marconi Lotenzo",'65325897871');
insert into adm_restaurante values ("contato@casa_nova_pizzaria.com",'50633214477787',md5('admin123'),"São Paulo","Santos ",'11088180', "R. Vereador Álvaro Guimarães, 227", "Radio Clube ","","Fernando Rovenni",'10354679845');
insert into adm_restaurante values ("contato@florença_forneria.com",'64808098785322',md5('admin123'),"São Paulo","Santos ",'11030351', "Av. Dino Bueno, 70", "Ponta da Praia ","","Maycon Rizzi",'15784601243');
insert into adm_restaurante values ("contato@pizzaria_vila_dy_napolli.com",'40566932201478',md5('admin123'),"São Paulo","Santos ",'11015220', " R. Conselheiro João Alfredo, 376", "Macuco","","Luana Pavinni",'10547896321');
insert into adm_restaurante values ("contato@don_correa_pizzaria.com",'32255569874125',md5('admin123'),"São Paulo","Santos ",'11075700', "Rua Visconde de Cairu, 137", "Campo Grande","","Marcia Guedes",'10987996571');
insert into adm_restaurante values ("contato@pizza_madre.com",'36699878521002',md5('admin123'),"São Paulo","Santos ",'11070150', "R. Nove de Julho, 55", "Marapé","","Mauricio Londrinni",'40896547221');
insert into adm_restaurante values ("contato@nonna_carmello_pizzaria.com",'20336558940102',md5('admin123'),"São Paulo","Santos ",'11065401', "Av. Gen. Francisco Glicério, 369", "Gonzaga","","Mauricio Londrinni",'40896547221');
insert into adm_restaurante values ("contato@Baviera.com",'50644100236502',md5('admin123'),"São Paulo","Santos ",'11040050', "R. Conselheiro Ribas, 538", "Embaré","","Andreia Bandero",'40789632201');
insert into adm_restaurante values ("contato@tomato_forneria.com",'40005698632573',md5('admin123'),"São Paulo","Santos ",'11015210', "Av. Sen. Dantas, 436", "Embaré","C","Maria Santana Ferraz",'40986574321');
insert into adm_restaurante values ("contato@rizzo_italian.com",'50069878203657',md5('admin123'),"São Paulo","Santos ",'11035260', "R. Guaiaó, 41", "Aparecida","Praiamar Shopping Loja 117","Donato Netto",'12585858987');
insert into adm_restaurante values ("contato@massas_veneza.com",'90878999650024',md5('admin123'),"São Paulo","Santos ",'11045101', " R. Oswaldo Cruz, 319", "Boqueirão","Loja 180","João Ortega",'40987456321');
insert into adm_restaurante values ("contato@liliana_pasta_praiamar.com",'20588789000001',md5('admin123'),"São Paulo","Santos ",'11025905', " R. Alexandre Martins, 80", "Aparecida","Loja 227A","João Ortega",'40987456321');
insert into adm_restaurante values ("contato@beduino.com",'10056900877453',md5('admin123'),"São Paulo","Santos ",'11060002', " Av. Ana Costa, 466", "Gonzaga","","Felipe Partilonni",'46322155941');
insert into adm_restaurante values ("contato@salaam_shawarma.com",'15047362149878',md5('admin123'),"São Paulo","Santos ",'11065101', " R. Euclides da Cunha, 63", "Pompéia","","João Amancio Rodrigues",'10234657987');
insert into adm_restaurante values ("contato@burgolandia.com",'78350125697410',md5('admin123'),"São Paulo","São Vicente ",'11320060', " R. Amador Bueno da Ribeira, 49", "Centro","","Luiz Roberto Alvarez dos Santos",'40032156987');
insert into adm_restaurante values ("contato@salt_hamburgueria.com",'30021480097563',md5('admin123'),"São Paulo","Mairiporã",'07600000', " Av. Serra da Cantareira, 11", "Alpes da Cantareira","","Fernando Nogueira dos Santos",'40021236578');
insert into adm_restaurante values ("contato@buddys_bar.com",'36000457986321',md5('admin123'),"São Paulo","Santos",'11030380', "  R. Rei Alberto, 434", " Ponta da Praia","","Marcelo Luiz da Silva",'40021366587');
insert into adm_restaurante values ("contato@seiko_temakeria.com",'50088779863014',md5('admin123'),"São Paulo","Santos",'11065100', "  R. Euclides da Cunha, s/n", "Gonzaga","","Ricardo Luiz Roberval",'40787896541');
insert into adm_restaurante values ("contato@hoshi_temaki_poke.com",'20068796324578',md5('admin123'),"São Paulo","Santos",'11060003', "  Av. Ana Costa, 549", "Gonzaga","Shopping Parque Balneário loja 42","Antonio Marconi",'40632158887');
insert into adm_restaurante values ("contato@kampay.com",'40320069872344',md5('admin123'),"São Paulo","Santos",'11025001', "  Av. Doutor Pedro Lessa, 1662", "Ponta da Praia","","Luciano Riconddi",'41124565897');
insert into adm_restaurante values ("contato@seu_miyagi.com",'60098753214598',md5('admin123'),"São Paulo","Santos",'11065101', " R. Euclides da Cunha, 262", "Pompéia","","Mariana Lacerda",'40098789654');
insert into adm_restaurante values ("contato@pastel_trevo_gonzaga.com",'40036598752014',md5('admin123'),"São Paulo","Santos",'11060001', " Av. Ana Costa, 465", "Gonzaga","","Robert Fagundes",'40005462788');
insert into adm_restaurante values ("contato@vivenda_do_camarao.com",'98000054621357',md5('admin123'),"São Paulo","Santos",'11025905', " R. Alexandre Martins, 80", "Aparecida","Praiamar Shopping Loja 236","Carlos Marques",'49874521357');
insert into adm_restaurante values ("contato@peixe_na_brasa.com",'70063254789602',md5('admin123'),"São Paulo","Santos",'11045201', " Av. Siqueira Campos, 561", "Embaré","","Marconi Leandro Jacinto",'70896321441');
insert into adm_restaurante values ("contato@desfrutti.com",'12340000078654',md5('admin123'),"São Paulo","Santos",'11025905', " R. Alexandre Martins, 80 ", "Aparecida","Praiamar Shopping Loja 227 ","Victor Amaral dos Santos",'70845312455');
insert into adm_restaurante values ("contato@ye.com",'40788865200002',md5('admin123'),"São Paulo","Santos",'11030250', " Av. Gen. San Martin, 152 ", "Ponta da Praia","","Viviane Lucatti Antinni",'40899965231');
insert into adm_restaurante values ("contato@light_food_way.com",'23601478954223',md5('admin123'),"São Paulo","Santos",'11050100', " R. Goiás, 105 ", "Boqueirão","","Andressa Borght Noronha",'43021569987');
insert into adm_restaurante values ("contato@maria_acai.com",'20006578880005',md5('admin123'),"São Paulo","Santos",'11045905', "R. Oswaldo Cruz, 319 ", "Boqueirão","loja 120","Luciana Gimenez ",'70896522201');
insert into adm_restaurante values ("contato@zabari.com",'13567895412566',md5('admin123'),"São Paulo","Santos",'11015450', "R. Almeida de Morais, 134 ", "Vila Matias","","Lucas Pedroso Randonii ",'40087774521');
insert into adm_restaurante values ("contato@creperia_da_praia.com",'23650004789564',md5('admin123'),"São Paulo","Santos",'11055000', "Av. Washington Luiz, 570 / 572 ", "Gonzaga","","Levi Ramon Antunes ",'40032547412');
insert into adm_restaurante values ("contato@logo_pastel_da_erika.com",'75320000478967',md5('admin123'),"São Paulo","Santos",'11045501', "Av. Vicente de Carvalho, 92 ", "Gonzaga","","Thiago Leandro Justo ",'40111778787');
insert into adm_restaurante values ("contato@yoi_nami.com",'85200000365789',md5('admin123'),"São Paulo","Santos",'11050250', "R. Barão de Paranapiacaba, 169", "Encruzilhada","","Luana Martins ",'40878965477');
insert into adm_restaurante values ("contato@amor_aos_pedacos.com",'90006478954231',md5('admin123'),"São Paulo","Santos",'11025200', "R. Alexandre Martins, 80", "Ponta da Praia","","Roberta Fernandes Martins ",'40054789622');
insert into adm_restaurante values ("contato@vem_la_da_roca.com",'60987000065478',md5('admin123'),"São Paulo","Santos",'11045100', "R. Oswaldo Cruz, 322", "Boqueirão","A","Roberta Fernandes Martins ",'40321649875');
insert into adm_restaurante values ("contato@capitao_grill.com",'75620003214578',md5('admin123'),"São Paulo","Santos",'11050320', "R. Júlio Conceição, 166", "Vila Matias","","Lincon Praxedes   ",'40532156998');
insert into adm_restaurante values ("contato@bolo_da_madre.com",'56478921305478',md5('admin123'),"São Paulo","Santos",'11040050', "R. Conselheiro Ribas, 345", "Embaré","","Rubens Polere   ",'47756321447');
insert into adm_restaurante values ("contato@grife_dos_brigadeiros.com",'55021230014785',md5('admin123'),"São Paulo","Santos",'11025002', "Avenida Doutor Pedro Lessa, 2316", "Embaré","","Rosiana Lourival da Silva",'42236578941');
insert into adm_restaurante values ("contato@conrado_brigaderia.com",'32500097896541',md5('admin123'),"São Paulo","Santos",'11015410', "R. Comendador Alfaia Rodrigues, 514", "Aparecida","","Maximiliano Rodrigues",'45600687804');
insert into adm_restaurante values ("contato@lig_lig.com",'12035789451523',md5('admin123'),"São Paulo","Santos",'11045100', "R. Oswaldo Cruz, 200", "Boqueirão","","Matheus Alonso",'40778797655');
insert into adm_restaurante values ("contato@china_gourmet.com",'23600087544423',md5('admin123'),"São Paulo","São Vicente",'11310040', "Rua Padre Anchieta, 49", "Centro","","Alice Romanova",'40021212359');
insert into adm_restaurante values ("contato@sucos_mel.com",'50400098745632',md5('admin123'),"São Paulo","Santos",'11010050', "R. Augusto Severo, 23", "Centro","","Andressa Malvão",'45669808712');
insert into adm_restaurante values ("contato@sabor_da_praca.com",'34500087954121',md5('admin123'),"São Paulo","Santos",'11025025', "Praça Nossa Sra S/N", "Aparecida","","Lilian Robertina ",'45041147898');
insert into adm_restaurante values ("contato@shake_burguer.com",'78945695123578',md5('admin123'),"São Paulo","Santos",'11065401', "Av. Gen. Francisco Glicério, 55", "Gonzaga","","Melissa Couto ",'41470565471');
insert into adm_restaurante values ("contato@burgui_food.com",'82395784561856',md5('admin123'),"São Paulo","Santos",'11040002', "Av. Alm. Cochrane, 190", "Embaré","","Wesley Santana",'46589712032');
insert into adm_restaurante values ("contato@bacio_sorveteria.com",'89632574188956',md5('admin123'),"São Paulo","Santos",'11025905', "R. Alexandre Martins, 80", "Aparecida","108"," Lucia Marques",'46325988754');
insert into adm_restaurante values ("contato@bamba_acai.com",'78945789641231',md5('admin123'),"São Paulo","Santos",'11045003', "Av. Conselheiro Nébias, 869", "Paquetá","108"," Roberta Manzonni",'42369875021');
insert into adm_restaurante values ("contato@aloha_poke.com",'71945879641237',md5('admin123'),"São Paulo","Santos",'11030250', "Av. Gen. San Martin, 120", "Ponta da Praia",""," Mariana Lorenzzo",'40365897230');
insert into adm_restaurante values ("contato@dominos_pizza.com",'47945789648537',md5('admin123'),"São Paulo","Santos",'11040050', "R. Conselheiro Ribas, 556", "Embaré",""," Mariana Lorenzzo",'40365897230');
insert into adm_restaurante values ("contato@sabores_do_mar.com",'20145789625237',md5('admin123'),"São Paulo","Santos",'11025202', "R. Alexandre Martins, 80", "Aparecida","Praiamar Shopping"," Roberta Bianchzzo",'40556887962');
insert into adm_restaurante values ("contato@burguer_company.com",'38945784741237',md5('admin123'),"São Paulo","Santos",'11055051', "R. Azevedo Sodré, 114", "Gonzaga"," ","Marcos Paulo Ferreira",'47889960578');
insert into adm_restaurante values ("contato@mordidela.com",'75845786641237',md5('admin123'),"São Paulo","Santos",'11025140', "Av. Doutor Pedro Lessa, 1980", "Embaré","Loja 07","Lorenzo Ferraz",'40896532214');
insert into adm_restaurante values ("contato@precious_burguer.com",'96445781441237',md5('admin123'),"São Paulo","Santos",'11040141', "R. Benjamin Constant, 226", "Embaré","","Guilherme Piavinni",'48778963200');
insert into adm_restaurante values ("contato@esfiharia_santista.com",'65445788941237',md5('admin123'),"São Paulo","Santos",'11025002', "Av. Doutor Pedro Lessa, 1754 ", "Aparecida","","Ana Paula Santana",'40889654230');
insert into adm_restaurante values ("contato@yakissoba_pezao.com",'35845710641237',md5('admin123'),"São Paulo","São Vicente",'11390330', " R. Piquerobi, 21", "Catiapoã","","João Pedro Anarquino",'40889966324');
insert into adm_restaurante values ("contato@vitshop.com",'71045736641237',md5('admin123'),"São Paulo","Santos",'11060001', " R. Mato Grosso, 418", "Boqueirão","","Alex Manzonni",'45088654136');
insert into adm_restaurante values ("contato@emporio_granola.com",'98685789641237',md5('admin123'),"São Paulo","Santos",'11060300', " Av. Mal. Floriano Peixoto, 152", "Gonzaga","","Gabriel Lorenzo Antunez",'40087965523');
insert into adm_restaurante values ("contato@capim_limao.com",'45789110641237',md5('admin123'),"São Paulo","Santos",'11075250', " R. Pres. Prudente de Moraes, 63", "Vila Matias","","Carlos Alberto Noronha",'45633028975');
insert into adm_restaurante values ("contato@rota_nordestina.com",'84725789641237',md5('admin123'),"São Paulo","Santos",'11030301', " Av. dos Bancários, 151", "Ponta da Praia","","Antonio Longhinni",'40236598753');
insert into adm_restaurante values ("contato@giraffas.com",'99945789641251',md5('admin123'),"São Paulo","Santos",'11025905', " R. Alexandre Martins, 80", "Aparecida","Praiamar Shopping Loja 240","Sandro Rocha Alvarez",'46302897833');
insert into adm_restaurante values ("contato@pedra_baiana.com",'10235789641542',md5('admin123'),"São Paulo","Santos",'11025202', " R. Alexandre Martins, 225", "Aparecida","","Andressa Rossival ",'48796532002');
insert into adm_restaurante values ("contato@yakissoba_brasil.com",'98655789641987',md5('admin123'),"São Paulo","Jundiaí",'13209700', " R. Colégio Florence, 169", "Jardim Primavera","","Luciana Matarazzo ",'49652202578');
insert into adm_restaurante values ("contato@artesanal_burger.com",'23245789625237',md5('admin123'),"São Paulo","Santos",'11050060', " R. Machado de Assis, 48", "Boqueirão","","Heitor Martins dos Santos ",'47898989632');

                                                                                                                                        



/*Horario Ragazzo 01*/
insert into horario_funcionamento values (1,"10:00","22:00",'60746948510820',1);
insert into horario_funcionamento values (2,"10:00","22:00",'60746948510820',1);
insert into horario_funcionamento values (3,"10:00","22:00",'60746948510820',1);
insert into horario_funcionamento values (4,"10:00","22:00",'60746948510820',1);
insert into horario_funcionamento values (5,"10:00","22:00",'60746948510820',1);
insert into horario_funcionamento values (6,"10:00","22:00",'60746948510820',1);
insert into horario_funcionamento values (7,"10:00","22:00",'60746948510820',1);


/*Tipo Prato Ragazzo*/
insert into tipo_prato values (1,"Salgados",'60746948510820');
insert into tipo_prato values (2,"Massas",'60746948510820');
insert into tipo_prato values (3,"Lanches",'60746948510820');
insert into tipo_prato values (4,"Pizzas",'60746948510820');
insert into tipo_prato values (5,"Pratos",'60746948510820');
insert into tipo_prato values (6,"Saladas",'60746948510820');
insert into tipo_prato values (7,"Sobremesas",'60746948510820');
insert into tipo_prato values (8,"Bebidas",'60746948510820');



/*prato*/
/*Ragazzo Pizzas*/
insert into prato values ('60746948510820',1001,1,4,"imagens/ragazzo/pizzas/pizza_portuguesa.png","Portuguesa","Mussarela, Presunto, Ovo Cozido, Ervilha, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$32,90");
insert into prato values ('60746948510820',1002,1,4,"imagens/ragazzo/pizzas/pizza_4_queijo.png","4 Queijos","Mussarela, Provolone, Gorgonzola, Cremely, Oregano, Molho de Tomate e Azeitonas.","R$36,90");
insert into prato values ('60746948510820',1003,1,4,"imagens/ragazzo/pizzas/pizza_mussarela.png","Mussarela","Mussarela, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('60746948510820',1004,1,4,"imagens/ragazzo/pizzas/pizza_calabresa.png","Calabresa","Rodelas de Calabresa, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('60746948510820',1005,1,4,"imagens/ragazzo/pizzas/pizza_margueita_speciale.png","Marguerita Speciale","Molho de Tomate, Mussarela, Tomate Cereja, Manjericão e Azeitonas Pretas.","R$36,90");
insert into prato values ('60746948510820',1006,1,4,"imagens/ragazzo/pizzas/pizza_a_moda_da_casa.png","Moda da Casa","Mussarela, Rodelas de Calabresa, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('60746948510820',1007,1,4,"imagens/ragazzo/pizzas/pizza_meia_margueita_speciale_meia_portuguesa.png","1/2 Marguerita Speciale 1/2 Portuguesa","Molho de Tomate, Mussarela, Tomate Cereja, Manjericão e Azeitonas Pretas, Mussarela, Presunto, Ovo Cozido, Ervilha, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$34,90");
insert into prato values ('60746948510820',1008,1,4,"imagens/ragazzo/pizzas/pizza_meia_margueita_speciale_meia_4_queijo.png","1/2 Marguerita Speciale 1/2 4 Queijos","Molho de Tomate, Mussarela, Tomate Cereja, Manjericão e Azeitonas Pretas, Mussarela, Provolone, Gorgonzola, Cremely, Oregano, Molho de Tomate e Azeitonas.","R$36,90");
insert into prato values ('60746948510820',1009,1,4,"imagens/ragazzo/pizzas/pizza_meia_brocolis_com_philadelphia_meia_peperoni_premiato.png","1/2 Brocolis com Philadelphia 1/2 Pepperoni Premiato ","Brocolis Frescos com Alho Frito, Bacon, Parmesão, Mussarela Premium, e Azeitonas, Tudo Coberto com Philadelphia, Molho de Tomate, Pepperoni Fatiado, Mussarela, Azeitonas Pretas e Queijo Philadelphia.","R$36,90");


/*Ragazzo Salgados*/
insert into prato values ('60746948510820',1010,1,1,"imagens/ragazzo/salgados/big_croc.png","Big Croc","Maior E Com Mais Recheio, Creme De Frango Temperado E Cremely.","R$3,90");
insert into prato values ('60746948510820',1011,1,1,"imagens/ragazzo/salgados/combo_crocantoso.png","Combo Crocantoso","15 Coxinhas De Qualquer Sabor.","R$27,90");
insert into prato values ('60746948510820',1012,1,1,"imagens/ragazzo/salgados/coxinha_frango_com_cremily.png","Coxinha De Frango com Cremely","Massa Crocante Por Fora E Cremosa Por Dentro Recheada Com Creme De Frango Temperado E Cremely.","R$1,98");
insert into prato values ('60746948510820',1013,1,1,"imagens/ragazzo/salgados/coxinha_bacon_chedar.png","Coxinha De Bacon com Chedar","Recheada Com Cheddar e Bacon Picado.","2,38");
insert into prato values ('60746948510820',1014,1,1,"imagens/ragazzo/salgados/coxinha_calabresa.png","Coxinha De Calabresa","Massa Crocante Por Fora E Cremosa Por Dentro Recheada Com Pedaços De Calabresa.","R$1,98");
insert into prato values ('60746948510820',1015,1,1,"imagens/ragazzo/salgados/coxinha_catupiry_com_bacon.png","Coxinha De Catupiry Com Bacon","Recheada Com Catupiry Com Bacon.","R$2,38");
insert into prato values ('60746948510820',1016,1,1,"imagens/ragazzo/salgados/coxinha_4_queijo.png","Coxinha De 4 Queijos","Recheada Com Mussarela, Provolone, Gorgonzola E Cremely.","R$2,38");
insert into prato values ('60746948510820',1017,1,1,"imagens/ragazzo/salgados/fogazza_mussarela.png","Fogazza De Mussarela","Massa Sequinha Recheada Com Mussarela E Pedaços De Tomates.","R$4,20");
insert into prato values ('60746948510820',1018,1,1,"imagens/ragazzo/salgados/fogazza_calabresa.png","Fogazza De Calabresa","Massa Sequinha Recheada Com Pedaços De Calabresa.","R$4,20");


/*Ragazzo Massas*/
insert into prato values ('60746948510820',1019,1,2,"imagens/ragazzo/massas/nhoque_sugo.png","Nhoque Ao Sugo","Massa Feita Com Batata E Coberta Por Molho Feito Com Tomates Frescos.","R$8,90");
insert into prato values ('60746948510820',1020,1,2,"imagens/ragazzo/massas/nhoque_bolonhesa.png","Nhoque Ao Molho Bolonhesa","Massa Feita Com Batata E Coberta Por Molho Feito Com Tomates E Carne Moída.","R$11,90");
insert into prato values ('60746948510820',1021,1,2,"imagens/ragazzo/massas/nhoque_recheado_com_queijo_ao_sugo.png","Nhoque Recheado Com Queijo Ao Sugo","Massa Recheada Com Queijo E Coberta Por Molho Feito Com Tomates Frescos.","R$14,90");
insert into prato values ('60746948510820',1022,1,2,"imagens/ragazzo/massas/nhoque_recheado_com_queijo_a_bolonhesa.png","Nhoque Recheado Com Queijo A Bolonhesa","Massa Recheada Com Queijo E Coberta Por Molho Feito Com Tomates E Carne Moída.","R$17,90");
insert into prato values ('60746948510820',1023,1,2,"imagens/ragazzo/massas/nhoque_recheado_com_queijo_a_4_queijo.png","Nhoque Com Molho 4 Queijos","Massa Feita Com Batata E Coberta Por Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$11,90");
insert into prato values ('60746948510820',1024,1,2,"imagens/ragazzo/massas/nhoque_4_queijo.png","Nhoque Com Molho 4 Queijos","Massa Feita Com Batata E Coberta Por Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$11,90");
insert into prato values ('60746948510820',1025,1,2,"imagens/ragazzo/massas/raviole_mussarela_com_molho_calabresa_e_bacon.png","Raviole De Mussarela Com Molho De Calabresa E Bacon","Raviole De Mussarela Coberto Com Molho De Calabresa E Pedaços De Bacon.","R$21,90");
insert into prato values ('60746948510820',1026,1,2,"imagens/ragazzo/massas/fettuccine_sugo.png","Fettuccine Ao Sugo","Tirinhas De Massa Fresca Com Molho Feito Com Tomates E Especiarias.","R$8,90");
insert into prato values ('60746948510820',1027,1,2,"imagens/ragazzo/massas/fettuccine_4_queijo.png","Fettuccine Com Molho 4 Queijos","Tirinhas De Massa Fresca Coberta Pelo Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone.","R$11,90");
insert into prato values ('60746948510820',1028,1,2,"imagens/ragazzo/massas/fettuccine_bolonhesa.png","Fettuccine A Bolonhesa","Tirinhas De Massa Fresca Com Molho Feito Com Carne Moida E Tomates Frescos.","R$11,90");
insert into prato values ('60746948510820',1029,1,2,"imagens/ragazzo/massas/espaguete_4_queijo.png","Espaguete Com Molho 4 Queijos","Massa Coberta Pelo Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$11,90");
insert into prato values ('60746948510820',1030,1,2,"imagens/ragazzo/massas/espaguete_almondega_sg.png","Espaguete Com Almondega Sg","Massa Com Almondegas Coberta Por Molho Feito De Tomates Frescos.","R$17,50");
insert into prato values ('60746948510820',1031,1,2,"imagens/ragazzo/massas/lasanha_bolonhesa.png","Lasanha Bolonhesa","Massa Recheada Com Mussarela, Presunto E Coberta Com Molho De Tomate.","R$21,90");
insert into prato values ('60746948510820',1032,1,2,"imagens/ragazzo/massas/lasanha_vegetariana.png","Lasanha Vegetariana","Massa Verde Recheada Com Seleta De Legumesedaços E Coberta Com Molho Ao Sugo.","R$21,90");
insert into prato values ('60746948510820',1033,1,2,"imagens/ragazzo/massas/lasanha_4_queijo.png","Lasanha 4 Queijos","Massa Recheada Com Mussarela, Presunto E Coberta Com Molho 4 Queijos Feito Com Cremely, Gorgonzola, Parmesão e Provolone .","R$21,90");




/*Ragazzo Pratos Principais*/
insert into prato values ('60746948510820',1034,1,5,"imagens/ragazzo/massas/file_a_parmegiana_com_penne.png","Filé A Parmegiana Com Penne","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$38,90");
insert into prato values ('60746948510820',1035,1,5,"imagens/ragazzo/massas/file_mignom_com_penne.png","Filé Mignom Com Penne","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$36,90");
insert into prato values ('60746948510820',1036,1,5,"imagens/ragazzo/pratos/polenta_com_molho_calabresa_com_bacon.png","Polenta Com Molho Calabresa Com Bacom","Coberto Com Molho De Calabresa E Pedaços De Bacon.","R$38,90");
insert into prato values ('60746948510820',1037,1,5,"imagens/ragazzo/pratos/file_de_frango_grelhado.png","Filé De Frango Grelhado","Filé de frango deliciosamente grelhado e temperado na medida certa.","R$10,90");
insert into prato values ('60746948510820',1038,1,5,"imagens/ragazzo/pratos/file_de_frango_a_parmegiana_com_arroz.png","Filé De Frango Á Parmegiana Com Arroz","Filé de frango empanado coberto com mussarela e molho de tomates. acompanha arroz branco.","R$26,90");
insert into prato values ('60746948510820',1039,1,5,"imagens/ragazzo/pratos/risoto_camarao.png","Risoto De Camarão","Um risoto cremosíssimo preparado com camarões fresquinhos.","R$25,90");
insert into prato values ('60746948510820',1040,1,5,"imagens/ragazzo/pratos/file_grelhado_com_fritas_e_arroz_branco.png","Filé Grelhado Com Fritas E Arroz Branco","Filé Mignom grelhado com batata-frita e arroz branco soltinho.","R$38,90");
insert into prato values ('60746948510820',1041,1,5,"imagens/ragazzo/pratos/file_de_frango_grelhado_com_arroz_e_fritas.png","Filé De Frango Grelhado Arroz Branco E Fritas","Filé de frango grelhado com batata-frita e arroz branco soltinho.","R$19,50");
insert into prato values ('60746948510820',1042,1,5,"imagens/ragazzo/pratos/file_de_frango_a_parmegiana_com_penne.png","Filé De Frango A Parmegiana Com Penne","Filé de frango empanado coberto com mussarela e molho de tomates. Acompanha massa.","R$26,90");
insert into prato values ('60746948510820',1043,1,5,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Risoto Funghi Secci","Um risoto cremosíssimo preparado com cogumélo funghi secchi.","R$22,90");


/*Ragazzo Saladas*/
insert into prato values ('60746948510820',1044,1,6,"imagens/ragazzo/saladas/salada_ceasar.png","Salada Ceasar","Apenas com ingredientes selecionados e fresquinhos, nossa salada caesar é feita com alface americana, frango desfiado temperado, mussarela ralada, croutons e bacon para dar um toque especial do ragazzo. acompanha molho caesar.","R$16,90");
insert into prato values ('60746948510820',1045,1,6,"imagens/ragazzo/saladas/salada_ceasar_de_camarao.png","Salada Ceasar com Camarão","Apenas com ingredientes selecionados e fresquinhos, nossa salada caesar é feita com alface americana, frango desfiado temperado, mussarela ralada,croutons, camarões cozidos e bacon para dar um toque especial do ragazzo. acompanha molho caesar.","R$22,90");


/*Ragazzo Lanches*/
insert into prato values ('60746948510820',1046,1,3,"imagens/ragazzo/lanches/chicken_crispy_file.png","Chicken Crispy File","Chicken crispy filé é um sanduíche muito bem recheado com peito de frango de verdade empanado, alface, tomate e temperado com maionese especial e cremely.","R$12,90");
insert into prato values ('60746948510820',1047,1,3,"imagens/ragazzo/lanches/panino_de_file_de_frango.png","Panino de File de Frango","Pão ciabatta, filé de frango grelhado, molho especial, queijo prato, azeitona, tomate, maionese e rúcula.","R$22,90");
insert into prato values ('60746948510820',1048,1,3,"imagens/ragazzo/lanches/panino_de_peito_de_peru.png","Panino de Peito de Peru","Pão ciabatta, peito de peru, ovo frito, queijo prato, cremely, alface, tomate e maionese.","R$22,90");
insert into prato values ('60746948510820',1049,1,3,"imagens/ragazzo/lanches/quadraburguer.png","Quadraburguer","Panino crocante recheado com ovo quadrado, hambúrguer quadrado com toque de churrasco*, queijos prato e cheddar, cremely, ketchup e mostarda, alface, tomate, maionese e molho especial. Vai","R$26,90");
insert into prato values ('60746948510820',1050,1,3,"imagens/ragazzo/lanches/quadraburguer_picanha_chedar_bacon.png","Quadraburguer Picanha Chedar Bacon","Panino crocante recheado com ovo quadrado, hambúrguer quadrado com toque de churrasco*, bacon fatiado, queijos prato e cheddar, alface, tomate e maionese. Faz uma selfie antes!","R$26,90");

/*Ragazzo Sobremesas*/
insert into prato values ('60746948510820',1051,1,7,"imagens/ragazzo/sobremesas/churros_de_doce_de_leite.png","Minichurros de Doce de Leite","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$1,98");
insert into prato values ('60746948510820',1052,1,7,"imagens/ragazzo/sobremesas/minichurros_chocolate_com_avela.png","Minichurros de Chocolate com Avelã","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$1,98");
insert into prato values ('60746948510820',1053,1,7,"imagens/ragazzo/sobremesas/minichurros_de_goiabada.png","Minichurros de Goiabada","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$1,98");
insert into prato values ('60746948510820',1054,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_chocolate_com_amendoas.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1055,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_coco.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1056,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_doce_de_leite.png","Sorvete Artesanal 1L","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$22,90");
insert into prato values ('60746948510820',1057,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_flocos.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1058,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_frutas_vermelhas.png","Sorvete Artesanal 1L","Filé Mignom Coberto Com Mussarela E Molho Ao Sugo. Acompanha Penne.","R$22,90");
insert into prato values ('60746948510820',1059,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_limao_siciliano.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1060,1,7,"imagens/ragazzo/sobremesas/sorvete_artesanal_morango_com_pedacos.png","Sorvete Artesanal 1L","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$22,90");
insert into prato values ('60746948510820',1061,1,7,"imagens/ragazzo/sobremesas/tacai.png","Taça de Açai","Filé Mignom Grelhado Na Brasa Com Penne Feito Com Massa Fresquinha E Molho Especial.","R$19,90");


/*Ragazzo Bebidas*/
insert into prato values ('60746948510820',1062,1,8,"imagens/ragazzo/bebidas/coca_cola_2L.png","Coca Cola 2L","Refrigerante gelado, perfeito para a galera e para a família inteira.","R$11,90");
insert into prato values ('60746948510820',1063,1,8,"imagens/ragazzo/bebidas/coca_cola_zero_2L.png","Coca Cola Zero 2L","Refrigerante gelado, perfeito para a galera e para a família inteira.","R$11,90");
insert into prato values ('60746948510820',1064,1,8,"imagens/ragazzo/bebidas/guarana_kuat_2L.png","Guarana Kuat 2L","Refrigerante gelado, perfeito para a galera e para a família inteira.","R$11,90");
insert into prato values ('60746948510820',1065,1,8,"imagens/ragazzo/bebidas/coca_cola_lata.png","Coca Cola Lata","Refrigerante gelado, perfeito para você.","R$8,90");
insert into prato values ('60746948510820',1066,1,8,"imagens/ragazzo/bebidas/coca_cola_zero_lata.png","Coca Cola Zero Lata","Refrigerante gelado, perfeito para você.","R$8,90");
insert into prato values ('60746948510820',1067,1,8,"imagens/ragazzo/bebidas/guarana_kuat_lata.png","Guaraná Kuat Lata","Refrigerante gelado, perfeito para você.","R$8,90");
insert into prato values ('60746948510820',1068,1,8,"imagens/ragazzo/bebidas/suco_abacaxi_500ml.png","Suco Abacaxi 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1069,1,8,"imagens/ragazzo/bebidas/suco_abacaxi_com_hortela_500ml.png","Suco Abacaxi com hortelã 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$10,90");
insert into prato values ('60746948510820',1070,1,8,"imagens/ragazzo/bebidas/suco_goiaba_500ml.png","Suco Goiaba 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1071,1,8,"imagens/ragazzo/bebidas/suco_laranja_500ml.png","Suco Laranja 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1072,1,8,"imagens/ragazzo/bebidas/suco_laranja_com_mamao_500ml.png","Suco Laranja com Mamão 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$10,90");
insert into prato values ('60746948510820',1073,1,8,"imagens/ragazzo/bebidas/suco_limao_500ml.png","Suco Limao 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1074,1,8,"imagens/ragazzo/bebidas/suco_manga_500ml.png","Suco Manga 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1075,1,8,"imagens/ragazzo/bebidas/suco_maracuja_500ml.png","Suco Maracujá 500m","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1076,1,8,"imagens/ragazzo/bebidas/suco_morango_500ml.png","Suco Morango 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1077,1,8,"imagens/ragazzo/bebidas/suco_uva_500ml.png","Suco Uva 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1078,1,8,"imagens/ragazzo/bebidas/suco_natureba_acai_500ml.png","Suco Natureba Acai 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1079,1,8,"imagens/ragazzo/bebidas/suco_natureba_amora_500ml.png","Suco Natureba Amora 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1080,1,8,"imagens/ragazzo/bebidas/suco_natureba_blueberry_500ml.png","Suco Natureba Blueberry 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1081,1,8,"imagens/ragazzo/bebidas/suco_natureba_framboesa_500ml.png","Suco Natureba Framboesa 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");
insert into prato values ('60746948510820',1082,1,8,"imagens/ragazzo/bebidas/suco_natureba_verde_detox_500ml.png","Suco Natureba Verde Detox 500ml","Suco natural de fruta, feito com frutas frescas e selecionadas. Compre 500ml, leve 1L.","R$13,90");



/*Forma Pagamento*/
	/*Ragazzo*/
	insert into forma_pagamento values ('60746948510820',1001,"Cartão de Crédito");
	insert into forma_pagamento values ('60746948510820',1002,"Cartão de Débito");
	insert into forma_pagamento values ('60746948510820',1003,"Dinheiro");
	insert into forma_pagamento values ('60746948510820',1004,"Sodexo");
	insert into forma_pagamento values ('60746948510820',1005,"Ticket");

/*Recompensas*/
insert into recompensas values ('60746948510820',1001,"imagens/ragazzo/promocoes_ponto/portuguesa_cocalata.jpg","Combo PP","Pizza Portuguesa Grande + Lata de Coca Cola ou Coca Cola Zero",385);
insert into recompensas values ('60746948510820',1002,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('60746948510820',1003,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('60746948510820',1004,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('60746948510820',1005,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('60746948510820',1006,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('60746948510820',1007,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('60746948510820',1008,"imagens/ragazzo/pratos/risoto_funghi_secci.png","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);




/*Horario China In Box*/


insert into horario_funcionamento values (1,"10:00","23:30",'00517012000198',1);
insert into horario_funcionamento values (2,"10:00","23:30",'00517012000198',1);
insert into horario_funcionamento values (3,"10:00","23:30",'00517012000198',1);
insert into horario_funcionamento values (4,"10:00","23:30",'00517012000198',1);
insert into horario_funcionamento values (5,"10:00","23:30",'00517012000198',1);
insert into horario_funcionamento values (6,"10:00","23:30",'00517012000198',1);
insert into horario_funcionamento values (7,"10:00","23:30",'00517012000198',1);


/*Tipo Prato China In Box*/
insert into tipo_prato values (9,"Macarão Oriental",'00517012000198');
insert into tipo_prato values (10,"Hotroll's",'00517012000198');
insert into tipo_prato values (11,"China Bowl",'00517012000198');
insert into tipo_prato values (12,"China Mix",'00517012000198');
insert into tipo_prato values (13,"Yakissobas",'00517012000198');
insert into tipo_prato values (14,"Carnes",'00517012000198');
insert into tipo_prato values (15,"Frangos",'00517012000198');
insert into tipo_prato values (16,"Camarão & Lombo",'00517012000198');
insert into tipo_prato values (17,"Entradas",'00517012000198');
insert into tipo_prato values (18,"Sobremesas",'00517012000198');
insert into tipo_prato values (19,"Bebidas",'00517012000198');


/*prato*/
/*China In Box Macarão Oriental*/
insert into prato values ('00517012000198',2001,1,9,"imagens/china_in_box/macarao_oriental/macarao_oriental_taiwan.png","Macarrão Oriental Taiwan","Macarrão Com Molho À Base De Shoyo Coberto Com Pedaços De Frango Crispy Ou Lombo Crispy E Cebolinha Picada.","R$16,90");
insert into prato values ('00517012000198',2002,1,9,"imagens/china_in_box/macarao_oriental/macarao_oriental_xian.png","Macarrão Oriental Xian","Macarrão Com Molho À Base De Shoyo Cubos De Frango E Legumes.","R$17,90");

/*China In Box Hotroll's*/
insert into prato values ('00517012000198',2003,1,10,"imagens/china_in_box/hot_roll/hot_roll_salmao_grelhado.png","Hotroll Salmão Grelhado(3 Unidades)","Enrolado Empanado Com Salmão Grelhado, Cream Chese, Cebolinha E Molho Tarê.","R$7,90");
insert into prato values ('00517012000198',2004,1,10,"imagens/china_in_box/hot_roll/hot_roll_salmao_grelhado.png","Hotroll Salmão Grelhado(6 Unidades)","Enrolado Empanado Com Salmão Grelhado, Cream Chese, Cebolinha E Molho Tarê.","R$13,50");

/*China In Box China Bowl*/
insert into prato values ('00517012000198',2005,1,11,"imagens/china_in_box/china_bowl/china_bowl_camarao.png","China Bowl Camarão","Yakimeshi Com Camarão E Legumes Ao Molho De Soja.","R$33,90");
insert into prato values ('00517012000198',2006,1,11,"imagens/china_in_box/china_bowl/china_bowl_carne.png","China Bowl Carne","Yakimeshi Com Carne Fatiada, Cebola E Pimentão Ao Molho De Soja.","R$25,90");
insert into prato values ('00517012000198',2007,1,11,"imagens/china_in_box/china_bowl/china_bowl_frango.png","China Bowl Frango","Yakimeshi Com Frango, Cenoura E Cebolinha Ao Molho De Soja.","R$24,90");
insert into prato values ('00517012000198',2008,1,11,"imagens/china_in_box/china_bowl/china_bowl_frango_crispy.png","China Bowl Frango Crispy","Yakimeshi E Pedaços De Frango Empanado Com Farinha Crocante Salpicado Com Cebolinha E Molho Oriental.","R$20,90");

/*China In Box China Mix*/
insert into prato values ('00517012000198',2009,1,12,"imagens/china_in_box/china_mix/china_mix_carne_com_batata_imperial.png","Mix Carne Com Batata Imperial","Carne Com Batata + Nosso Tradicional Yakimeshi + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$35,90");
insert into prato values ('00517012000198',2010,1,12,"imagens/china_in_box/china_mix/china_mix_carne_com_legumes.png","Mix Carne Com Legumes","Carne Com Legumes + Nosso Tradicional Yakimeshi + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$35,90");
insert into prato values ('00517012000198',2011,1,12,"imagens/china_in_box/china_mix/china_mix_frango_oriental_karaague.png","Mix Frango Oriental Karaague","Frango Crocante Temparado à Moda Oriental Temparado Com Gengibre, Empanado E Frito + Yakissoba De Vegetariano+ Tradicional E Delicioso Rolinho Primavera Ou De Queijo + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$34,50");
insert into prato values ('00517012000198',2012,1,12,"imagens/china_in_box/china_mix/china_mix_frango_xadrez.png","Mix Frango Xadrez","Frango Xadrez + Nosso Tradicional Yakimeshi + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$34,50");
insert into prato values ('00517012000198',2013,1,12,"imagens/china_in_box/china_mix/china_mix_yakissoba_classico.png","Mix Yakissoba Clássico","Yakissoba + Tradicional E Delicioso Rolinho Primavera + Frango Empanado Sequinho E Crocante + Salada China(Alface,Rúcula E Cenoura Temperadas Ao Molho Italiano).","R$34,50");




/*China In Box Yakissobas*/
insert into prato values ('00517012000198',2014,1,13,"imagens/china_in_box/yakissoba/yakissoba_classico_grande.png","Yakissoba Clássico","Mussarela, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('00517012000198',2015,1,13,"imagens/china_in_box/yakissoba/yakissoba_de_camarao_grande.png","Yakissoba De Camarão","Rodelas de Calabresa, Cebola, Oregano, Molho de Tomate e Azeitonas.","R$31,90");
insert into prato values ('00517012000198',2016,1,13,"imagens/china_in_box/yakissoba/yakissoba_de_carne_grande.png","Yakissoba De Carne","Nosso tradicional macarrão com carne, legumes e champignons.","R$34,50");
insert into prato values ('00517012000198',2017,1,13,"imagens/china_in_box/yakissoba/yakissoba_especial_grande.png","Yakissoba Especial","A Mistura Perfeita Do Nosso Clássico Yakissoba De Carne, Frango E Camarão Com Legumes Frescos E Champignons..","R$46,50");



/*China In Box Carnes*/
insert into prato values ('00517012000198',2018,1,14,"imagens/china_in_box/carne/carne_com_batata_imperial_pequeno.png","Carne Com Batata Imperial Pequeno","Carne fatiada com batata e cebolinha, temperadas ao molho de soja.","R$45,50");
insert into prato values ('00517012000198',2019,1,14,"imagens/china_in_box/carne/carne_com_batata_imperial_grande.png","Carne Com Batata Imperial Grande","Carne fatiada com batata e cebolinha, temperadas ao molho de soja.","R$62,90");
insert into prato values ('00517012000198',2020,1,14,"imagens/china_in_box/carne/carne_com_batata_imperial_executivo_pequeno.png","Carne Com Batata Imperial Executivo Pequeno","Carne fatiada com batata e cebolinha, temperadas ao molho de soja. acompanha yakimeshi.","R$36,50");
insert into prato values ('00517012000198',2021,1,14,"imagens/china_in_box/carne/carne_com_batata_imperial_executivo_grande.png","Carne Com Batata Imperial Executivo Grande","Carne fatiada com batata e cebolinha, temperadas ao molho de soja. acompanha yakimeshi.","R$47,50");
insert into prato values ('00517012000198',2022,1,14,"imagens/china_in_box/carne/carne_com_cebola_pequeno.png","Carne Com Cebola Pequeno","Carne fatiada com cebola temperada ao molho de soja.","R$45,50");
insert into prato values ('00517012000198',2023,1,14,"imagens/china_in_box/carne/carne_com_cebola_grande.png","Carne Com Cebola Grande","Carne fatiada com cebola temperada ao molho de soja.","R$62,90");
insert into prato values ('00517012000198',2024,1,14,"imagens/china_in_box/carne/carne_com_cebola_executivo_pequeno.png","Carne Com Cebola Executivo Pequeno","Carne fatiada com cebola temperada ao molho de soja. acompanha yakimeshi. acompanha yakimeshi.","R$47,50");
insert into prato values ('00517012000198',2025,1,14,"imagens/china_in_box/carne/carne_com_cebola_executivo_grande.png","Carne Com Cebola Executivo Grande","Carne fatiada com cebola temperada ao molho de soja. acompanha yakimeshi..","R$1,98");
insert into prato values ('00517012000198',2026,1,14,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_pequeno.png","Carne com legumes chop suey Pequeno","Carne fatiada com legumes temperados ao molho de soja.","R$43,50");
insert into prato values ('00517012000198',2027,1,14,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_grande.png","Carne com legumes chop suey Grande","Carne fatiada com legumes temperados ao molho de soja.","R$59,90");
insert into prato values ('00517012000198',2028,1,14,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_executivo_pequeno.png","Carne com legumes chop suey Executivo Pequeno","Carne fatiada com legumes temperados ao molho de soja. acompanha yakimeshi.","R$34,50");
insert into prato values ('00517012000198',2029,1,14,"imagens/china_in_box/carne/carne_com_legumes_chop_suey_executivo_grande.png","Carne com legumes chop suey Executivo Grande","Carne fatiada com legumes temperados ao molho de soja. acompanha yakimeshi.","R$44,90");


/*China In Box Frangos*/
insert into prato values ('00517012000198',2030,1,15,"imagens/china_in_box/frango/frango_agridoce_pequeno.png","Frango Agridoce Pequeno","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão.","R$35,50");
insert into prato values ('00517012000198',2031,1,15,"imagens/china_in_box/frango/frango_agridoce_grande.png","Frango Agridoce Grande","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão.","R$49,50");
insert into prato values ('00517012000198',2032,1,15,"imagens/china_in_box/frango/frango_agridoce_executivo_pequeno.png","Frango Agridoce Executivo Pequeno","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$28,90");
insert into prato values ('00517012000198',2033,1,15,"imagens/china_in_box/frango/frango_agridoce_executivo_grande.png","Frango Agridoce Executivo Grande","Combinação irresistível e saborosa de cubos de peito de frango empanados, acompanhados do nosso molho agridoce com abacaxi, cebola e pimentão. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$37,90");
insert into prato values ('00517012000198',2034,1,15,"imagens/china_in_box/frango/frango_oriental_karaague.png","Frango Oriental Karaague Pequeno","Pedaços de frango empanados e temperados à moda oriental com gengibre.","R$38,50");
insert into prato values ('00517012000198',2035,1,15,"imagens/china_in_box/frango/frango_oriental_karaague.png","Frango Oriental Karaague Grande","Pedaços de frango empanados e temperados à moda oriental com gengibre.","R$53,90");
insert into prato values ('00517012000198',2036,1,15,"imagens/china_in_box/frango/frango_oriental_karaague_executivo.png","Frango Oriental Karaague Executivo Pequeno","Pedaços de frango empanados e temperados à moda oriental com gengibre. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$31,90");
insert into prato values ('00517012000198',2037,1,15,"imagens/china_in_box/frango/frango_oriental_karaague_executivo.png","Frango Oriental Karaague Executivo Grande","Pedaços de frango empanados e temperados à moda oriental com gengibre. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$41,50");
insert into prato values ('00517012000198',2038,1,15,"imagens/china_in_box/frango/frango_xadrez_pequeno.png","Frango Xadrez Pequeno","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu.","R$38,50");
insert into prato values ('00517012000198',2039,1,15,"imagens/china_in_box/frango/frango_xadrez_grande.png","Frango Xadrez Grande","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu.","R$53,90");
insert into prato values ('00517012000198',2040,1,15,"imagens/china_in_box/frango/frango_xadrez_executivo_pequeno.png","Frango Xadrez Executivo Pequeno","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$31,90");
insert into prato values ('00517012000198',2041,1,15,"imagens/china_in_box/frango/frango_xadrez_executivo_grande.png","Frango Xadrez Executivo Grande","Generosos cubos de peito de frango com cebola, pimentão e amendoim, servidos com nosso molho exclusivo à base de shoyu. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$41,50");
insert into prato values ('00517012000198',2042,1,15,"imagens/china_in_box/frango/frango_crispy_pequeno.png","Frango Crispy Pequeno","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$35,51");
insert into prato values ('00517012000198',2043,1,15,"imagens/china_in_box/frango/frango_crispy_grande.png","Frango Crispy Grande","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$49,91");
insert into prato values ('00517012000198',2044,1,15,"imagens/china_in_box/frango/frango_crispy_executivo_pequeno.png","Frango Crispy Executivo Pequeno","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$29,51");
insert into prato values ('00517012000198',2045,1,15,"imagens/china_in_box/frango/frango_crispy_executivo_grande.png","Frango Crispy Executivo Grande","Pedaços de frango com uma casquinha de farinha crocante. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Tradicional arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$37,91");
insert into prato values ('00517012000198',2046,1,15,"imagens/china_in_box/frango/frango_empanado_pequeno.png","Frango Empanado Pequeno","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$35,51");
insert into prato values ('00517012000198',2047,1,15,"imagens/china_in_box/frango/frango_empanado_grande.png","Frango Empanado Grande","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli.","R$49,91");
insert into prato values ('00517012000198',2048,1,15,"imagens/china_in_box/frango/frango_empanado_executivo_pequeno.png","Frango Empanado Executivo Pequeno","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha..","R$29,51");
insert into prato values ('00517012000198',2049,1,15,"imagens/china_in_box/frango/frango_empanado_executivo_grande.png","Frango Empanado Executivo Grande","Cubinhos de peito de frango cobertos por uma massinha, dourados e temperados com alho e cebolinha. O molho é você quem escolhe: agridoce, tarê ou sweet chilli. Arroz soltinho refogado com flocos de ovos, pedacinhos de cenoura, apresuntado e cebolinha.","R$37,91");


/*China In Box Camarão & Lombo*/
insert into prato values ('00517012000198',2050,1,16,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_pequeno.png","Lombo crispy Pequeno","Pedaços de lombo crispy com cebolinha.","R$35,50");
insert into prato values ('00517012000198',2051,1,16,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_grande.png","Lombo crispy Grande","Pedaços de lombo crispy com cebolinha.","R$49,90");
insert into prato values ('00517012000198',2052,1,16,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_executivo_pequeno.png","Lombo crispy Executivo Pequeno","Pedaços de lombo crispy com cebolinha. Acompanha Yakimeshi.","R$29,50");
insert into prato values ('00517012000198',2053,1,16,"imagens/china_in_box/camarao_&_lombo/lombo_crispy_executivo_grande.png","Lombo crispy Executivo Grande","Pedaços de lombo crispy com cebolinha. Acompanha Yakimeshi.","R$37,90");
insert into prato values ('00517012000198',2054,1,16,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_pequeno.png","Camarão Ao Molho Apimentado Pequeno","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante.","R$67,80");
insert into prato values ('00517012000198',2055,1,16,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_grande.png","Camarão Ao Molho Apimentado Grande","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante.","R$94,20");
insert into prato values ('00517012000198',2056,1,16,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_executivo_pequeno.png","Camarão Ao Molho Apimentado Executivo Pequeno","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante. acompanha yakimeshi.","R$55,50");
insert into prato values ('00517012000198',2057,1,16,"imagens/china_in_box/camarao_&_lombo/camarao_ao_molho_apimentado_executivo_grande.png","Camarão Ao Molho Apimentado Executivo Grande","Clássica e deliciosa mistura de camarões, cebola e champignons com nosso molho exclusivo à base de shoyu levemente picante. acompanha yakimeshi.","R$71,20");

/*China In Box Entradas*/
insert into prato values ('00517012000198',2058,1,17,"imagens/china_in_box/entradas/batata_frita.png","Batata Frita","Deliciosa batata frita crocante (230g).","R$14,90");
insert into prato values ('00517012000198',2059,1,17,"imagens/china_in_box/entradas/camarao_empanado.png","Camarão Empanado (10 Unidades)","Camarão empanado e sequinho. Acompanha molho agridoce.","R$35,10");
insert into prato values ('00517012000198',2060,1,17,"imagens/china_in_box/entradas/gyoza.png","Gyoza","Massa fina recheada com carne temperado com gengibre.","R$23,90");
insert into prato values ('00517012000198',2061,1,17,"imagens/china_in_box/entradas/pao_chines.png","Pão Chinês (3 Unidades)","Pão macio e fofinho recheado de frango e legumes.","R$12,90");
insert into prato values ('00517012000198',2062,1,17,"imagens/china_in_box/entradas/rolinho_de_camarao_cremoso.png","Rolinho De Camarão Cremoso (2 Unidades)","Massa fina recheada com camarão, requeijão cremoso e cebolinha picada. Acompanha molho agridoce.","R$19,40");
insert into prato values ('00517012000198',2063,1,17,"imagens/china_in_box/entradas/rolinho_de_frango_com_requeijao.png","Rolinho De Frango Com Requeijão (2 Unidades)","Massa fina recheada com frango, cenoura, requeijão cremoso e cebolinha picada. Acompanha molho agridoce","R$10,80");
insert into prato values ('00517012000198',2064,1,17,"imagens/china_in_box/entradas/rolinho_de_queijo.png","Rolinho De Queijo (2 Unidades)","Massa fina recheada com mussarela. Acompanha molho agridoce.","R$10,80");
insert into prato values ('00517012000198',2065,1,17,"imagens/china_in_box/entradas/rolinho_primavera.png","Rolinho Primavera (2 Unidades)","Massa fina recheada com carne, repolho e cenoura. Acompanha molho agridoce.","R$10,40");
insert into prato values ('00517012000198',2066,1,17,"imagens/china_in_box/entradas/rolinho_vegetariano.png","Rolinho Vegetariano (2 Unidades)","Nossa tradicional receita de massa fina recheada com repolho e cenoura. Para acompanhar, molho agridoce.","R$10,40");
insert into prato values ('00517012000198',2067,1,17,"imagens/china_in_box/entradas/salada_china_in_box.png","Salada CIB Camarão","Camarão, Alface, Rúcula, Cenoura Desfiada, Palmito Pupunha E Azeitonas Pretas.","R$30,20");
insert into prato values ('00517012000198',2068,1,17,"imagens/china_in_box/entradas/salada_china_in_box.png","Salada CIB Frango","Frango, Alface, Rúcula, Cenoura Desfiada, Palmito Pupunha E Azeitonas Pretas.","R$21,50");

/*China In Box Sobremesas*/
insert into prato values ('00517012000198',2069,1,18,"imagens/china_in_box/sobremesas/banana_caramelada.png","Banana Caramelada (4 Unidades)","Pedaços de banana empanados e caramelados, salpicados com gergelim.","R$12,90");
insert into prato values ('00517012000198',2070,1,18,"imagens/china_in_box/sobremesas/rolinho_romeu_&_julieta.png","Rolinho Romeu E Julieta (2 Unidades)","Massa fina recheada com mussarela e goiabada coberta com canela e açúcar.","R$10,40");
insert into prato values ('00517012000198',2071,1,18,"imagens/china_in_box/sobremesas/rolinho_de_banana_com_chocolate.png","Rolinho Banana Com Chocolate (2 Unidades)","Massa fina recheada com banana e chocolate, coberta com canela e açúcar.","R$10,40");

/*China In Box Bebidas*/
insert into prato values ('00517012000198',2072,1,19,"imagens/china_in_box/bebidas/sucos.png","Suco Del Valle lata 290ml","Sabores: Maracujá, Pessego, Manga E Uva.","R$6,50");
insert into prato values ('00517012000198',2073,1,19,"imagens/china_in_box/bebidas/chas.png","Cha ice tea fuze 300ml","Sabores: Limão E Pessego.","R$6,90");
insert into prato values ('00517012000198',2074,1,19,"imagens/china_in_box/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$6,90");
insert into prato values ('00517012000198',2075,1,19,"imagens/china_in_box/bebidas/refrigerantes_2l.jpg","Refrigerante 2l","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$11,50");
insert into prato values ('00517012000198',2076,1,19,"imagens/china_in_box/bebidas/agua_gas.jpg","Agua C/gás 350 ml","Agua Mineral Com Gás.","R$4,60");
insert into prato values ('00517012000198',2077,1,19,"imagens/china_in_box/bebidas/agua.jpg","Agua S/gás 350 ml","Agua Mineral Sem Gás.","R$4,90");


/*Forma Pagamento*/
	/*China In Box*/
	insert into forma_pagamento values ('00517012000198',2001,"Cartão de Crédito");
	insert into forma_pagamento values ('00517012000198',2002,"Cartão de Débito");
	insert into forma_pagamento values ('00517012000198',2003,"Dinheiro");
	insert into forma_pagamento values ('00517012000198',2004,"Sodexo");
	insert into forma_pagamento values ('00517012000198',2005,"Ticket");

/*Recompensas*/
insert into recompensas values ('00517012000198',2001,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2002,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2003,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2004,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2005,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2006,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('00517012000198',2007,"imagens/china_in_box/promocoes_ponto/yakissoba_especial_grande.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);



/*Horario Big X Picanha*/


insert into horario_funcionamento values (1,"10:00","22:00",'17686110000151',1);
insert into horario_funcionamento values (2,"10:00","22:00",'17686110000151',1);
insert into horario_funcionamento values (3,"10:00","22:00",'17686110000151',1);
insert into horario_funcionamento values (4,"10:00","22:00",'17686110000151',1);
insert into horario_funcionamento values (5,"10:00","22:00",'17686110000151',1);
insert into horario_funcionamento values (6,"10:00","22:00",'17686110000151',1);
insert into horario_funcionamento values (7,"10:00","22:00",'17686110000151',1);


/*Tipo Prato Big X Picanha*/
insert into tipo_prato values (20,"Lanches",'17686110000151');

/*prato*/
/*Big X Picanha Burguers*/
insert into prato values ('17686110000151',3001,1,20,"imagens/big_x_picanha/lanches/picanha_salada_burguer.webp","Picanha Salada Burguer","Hambúrguer de picanha 200g, queijo prato, maionese da casa, alface e tomate e pão brioche.","R$21,90");
insert into prato values ('17686110000151',3002,1,20,"imagens/big_x_picanha/lanches/picanha_cheddar_burguer.webp","Picanha Cheddar Burguer","Hambúrguer de picanha 200g, cheddar, cebola caramelizada, maionese da casa e pão brioche.","R$22,90");
insert into prato values ('17686110000151',3003,1,20,"imagens/big_x_picanha/lanches/cheddar_barbecue.webp","Cheddar Barbecue","Hambúrguer de picanha 200g, cheddar, bacon, cebola caramelizada, molho barbecue e pão brioche.","R$26,90");
insert into prato values ('17686110000151',3004,1,20,"imagens/big_x_picanha/lanches/monstro_burguer.webp","Monstro Burguer","Hambúrguer de picanha 200g, queijo cheddar, bacon, picles, cebola roxa, alface, tomate, maionese da casa e pão brioche.","R$26,90");
insert into prato values ('17686110000151',3005,1,20,"imagens/big_x_picanha/lanches/picanha_onion_rings.webp","Picanha Onion Rings","Hambúrguer de picanha 200g, cheddar, cebola empanada, bacon, molho bxp e pão brioche.","R$26,90");
insert into prato values ('17686110000151',3006,1,20,"imagens/big_x_picanha/lanches/picanha_salada_egg_bacon.webp","Picanha Salada Egg Bacon","Hamburguer de picanha 200 g, ovo,bacon,queijo prato,maionese da casa,alface,tomate e pão com gergelim.","R$26,90");
insert into prato values ('17686110000151',3007,1,20,"imagens/big_x_picanha/lanches/hamburguer_de_salmao.webp","Hamburguer De Salmão","Hamburguer de salmão,queijo mussarela,maionese da casa,alface,tomate e pão brioche","R$24,90");
insert into prato values ('17686110000151',3008,1,20,"imagens/big_x_picanha/lanches/big_x_frango_catupiry.webp","Big X Frango Ao Catupiry","Frango filetado, queijo Catupiry, mussarela, maionese da casa e pão com gergelim.","R$23,90");


/*Forma Pagamento*/
	/*Big X Picanha*/
	insert into forma_pagamento values ('17686110000151',3001,"Cartão de Crédito");
	insert into forma_pagamento values ('17686110000151',3002,"Cartão de Débito");
	insert into forma_pagamento values ('17686110000151',3003,"Dinheiro");
	insert into forma_pagamento values ('17686110000151',3004,"Sodexo");
	insert into forma_pagamento values ('17686110000151',3005,"Ticket");

/*Recompensas*/
insert into recompensas values ('17686110000151',3001,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('17686110000151',3002,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('17686110000151',3003,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('17686110000151',3004,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('17686110000151',3005,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('17686110000151',3006,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('17686110000151',3007,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('17686110000151',3008,"imagens/big_x_picanha/promocoes_ponto/risoto_funghi_secci.png","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);






/*Horario Croasonho*/


insert into horario_funcionamento values (1,"10:00","22:00",'70543238876843',1);
insert into horario_funcionamento values (2,"10:00","22:00",'70543238876843',1);
insert into horario_funcionamento values (3,"10:00","22:00",'70543238876843',1);
insert into horario_funcionamento values (4,"10:00","22:00",'70543238876843',1);
insert into horario_funcionamento values (5,"10:00","22:00",'70543238876843',1);
insert into horario_funcionamento values (6,"10:00","22:00",'70543238876843',1);
insert into horario_funcionamento values (7,"10:00","22:00",'70543238876843',1);

/*Tipo Prato Croasonho*/
insert into tipo_prato values (21,"Croasonhos salgados",'70543238876843');


/*Croasonhos salgados*/
insert into prato values ('70543238876843',4001,1,21,"imagens/croasonho/croasonhos_salgados/croaburger_classico.webp","Croaburger Classico","Molho parmesão, hambúrguer de carne, queijo cheddar, tomate, alface americana e batata chips.","R$16,90");
insert into prato values ('70543238876843',4002,1,21,"imagens/croasonho/croasonhos_salgados/croaburger_barbecue.webp","Croaburger Barbecue","Molho BBQ, hambúrguer de carne, queijo cheddar, anéis de cebola, bacon, tomate, alface americana e batata chips.","R$18,90");
insert into prato values ('70543238876843',4003,1,21,"imagens/croasonho/croasonhos_salgados/brocolis_requeijao_mussarela.webp","Brócolis, Requeijão e Mussarela","Brócolis, Requeijão, toque de Noz Moscada e Queijo Mussarela.","R$14,90");
insert into prato values ('70543238876843',4004,1,21,"imagens/croasonho/croasonhos_salgados/carne_de_panela.webp","Carne de Panela","Carne de Panela desfiada e Queijo Mussarela.","R$14,90");
insert into prato values ('70543238876843',4005,1,21,"imagens/croasonho/croasonhos_salgados/churrasco.webp","Churrasco","Assado de Vazio/Fraldinha com Cebola, Provolone e Mussarela.","R$16,50");
insert into prato values ('70543238876843',4006,1,21,"imagens/croasonho/croasonhos_salgados/estrogonofe_de_carne.webp","Estrogonofe de Carne","Estrogonofe de Carne e Champignon.","R$14,90");
insert into prato values ('70543238876843',4007,1,21,"imagens/croasonho/croasonhos_salgados/iscas_de_carne_5_queijos.webp","Iscas de Carne com 5 Queijos","Iscas de Carne com Queijos Mussarela, Prato, Provolone, Gorgonzola e Parmesão.","R$17,50");
insert into prato values ('70543238876843',4008,1,21,"imagens/croasonho/croasonhos_salgados/iscas_de_carne_cheddar.webp","Iscas de Carne e Queijo Cheddar","Iscas de Carne e Queijo Cheddar.","R$17,50");
insert into prato values ('70543238876843',4009,1,21,"imagens/croasonho/croasonhos_salgados/iscas_de_carne_requeijao_mussarela.webp","Iscas de Carne Requeijão e Mussarela","Iscas de Carne, Requeijão e Queijo Mussarela.","R$17,50");
insert into prato values ('70543238876843',4010,1,21,"imagens/croasonho/croasonhos_salgados/frango_com_5_queijos.webp","Frango com 5 Queijos","Peito de Frango em cubos, Palmito e Rucula com Queijos Mussarela, Prato, Provolone, Gorgonzola e Parmesão.","R$14,90");
insert into prato values ('70543238876843',4011,1,21,"imagens/croasonho/croasonhos_salgados/frango_creamcheese_bacon.webp","Frango com Cream Cheese e Bacon","Peito de Frango em cubos de frango, Cream Cheese, Bacon, Alface e Tomate.","R$15,50");
insert into prato values ('70543238876843',4012,1,21,"imagens/croasonho/croasonhos_salgados/frango_com_queijo_cremoso.webp","Frango com Queijo Cremoso","Peito de Frango Desfiado, Molho de Tomate e Queijo Cremoso.","R$14,90");
insert into prato values ('70543238876843',4013,1,21,"imagens/croasonho/croasonhos_salgados/peito_de_peru_com-requeija_e_mussarela.webp","Peito de Peru com Requeijão e Mussarela","Peito de Peru, Requeijão e Queijo Mussarela.","R$15,50");
insert into prato values ('70543238876843',4014,1,21,"imagens/croasonho/croasonhos_salgados/portuguesa.webp","Portuguesa","Presunto, Queijo Mussarela, Cebola, Tomate, Azeitona e Orégano.","R$15,50");
insert into prato values ('70543238876843',4015,1,21,"imagens/croasonho/croasonhos_salgados/presunto_queijo.webp","Presunto e Queijo","Presunto e Queijo Mussarela.","R$13,90");
insert into prato values ('70543238876843',4016,1,21,"imagens/croasonho/croasonhos_salgados/tomate_seco_mussarela_rucula.webp","Tomate Seco Mussarela e Rúcula","Tomate Seco, Queijo Mussarela, Rúcula e Orégano.","R$14,90");
insert into prato values ('70543238876843',4017,1,21,"imagens/croasonho/croasonhos_salgados/calabresa_com_mussarela.webp","Calabresa com Mussarela","Croasonho recheado com calabresa fatiada acebolada e queijo mussarela.","R$13,90");


/*Forma Pagamento*/
	/*Croasonhos*/
	insert into forma_pagamento values ('70543238876843',4001,"Cartão de Crédito");
	insert into forma_pagamento values ('70543238876843',4002,"Cartão de Débito");
	insert into forma_pagamento values ('70543238876843',4003,"Dinheiro");
	insert into forma_pagamento values ('70543238876843',4004,"Sodexo");
	insert into forma_pagamento values ('70543238876843',4005,"Ticket");

/*Recompensas*/
insert into recompensas values ('70543238876843',4001,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('70543238876843',4002,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('70543238876843',4003,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('70543238876843',4004,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('70543238876843',4005,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('70543238876843',4006,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('70543238876843',4007,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('70543238876843',4008,"imagens/croasonho/promocoes_ponto/risoto_funghi_secci.png","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*Horario Tio Sam*/


insert into horario_funcionamento values (1,"14:00","23:00",'67594639571239',1);
insert into horario_funcionamento values (2,"14:00","23:00",'67594639571239',1);
insert into horario_funcionamento values (3,"14:00","23:00",'67594639571239',1);
insert into horario_funcionamento values (4,"14:00","23:00",'67594639571239',1);
insert into horario_funcionamento values (5,"14:00","23:00",'67594639571239',1);
insert into horario_funcionamento values (6,"14:00","23:00",'67594639571239',1);
insert into horario_funcionamento values (7,"14:00","23:00",'67594639571239',1);


/*Tipo Prato Tio Sam Japa Food*/
insert into tipo_prato values (22,"Combos",'67594639571239');
insert into tipo_prato values (23,"Entradas",'67594639571239');
insert into tipo_prato values (24,"Porções",'67594639571239');
insert into tipo_prato values (25,"Bolota Sam",'67594639571239');
insert into tipo_prato values (26,"Combinados",'67594639571239');
insert into tipo_prato values (27,"Temakis",'67594639571239');
insert into tipo_prato values (28,"Yakissoba",'67594639571239');
insert into tipo_prato values (29,"Hot Rolls",'67594639571239');
insert into tipo_prato values (30,"Sobremesas",'67594639571239');
insert into tipo_prato values (31,"Bebidas",'67594639571239');

/*prato*/
/*Tio Sam Japa Food Combos*/
insert into prato values ('67594639571239',5001,1,22,"imagens/tio_sam_japa_food/combos/3_hot_roll.webp","3 Hot Rolls","3 hot roll (30 cortes) sabores: Filadelfia, Grelhado, kani, Grelhado Com Barbecue.","R$39,90");
insert into prato values ('67594639571239',5002,1,22,"imagens/tio_sam_japa_food/combos/2_temakis_1_hot_holl.webp","Combo: 2 temakis + 1 hot roll","Temaki Escolha 2 opções: Filadelfia, Grelhado, Shimeji, kani, California, Grelhado Com Barbecue. Hot roll Escolha 1 opção: Filadelfia, Grelhado, Grelhado Com Barbecue.","R$39,90");
insert into prato values ('67594639571239',5003,1,22,"imagens/tio_sam_japa_food/combos/2_temakis_grelhados_2_hot_roll.webp","2 temakis grelhados + 2 hot roll","Temaki Grelhado. Hot roll Escolha 2 opção: Filadelfia, Grelhado, Grelhado Com Barbecue.","R$54,90");
insert into prato values ('67594639571239',5004,1,22,"imagens/tio_sam_japa_food/combos/2_temakis_filadelfia_2_hot_roll_salmao.webp","2 temakis filadélfia + 2 hot roll salmão","2 Deliciosos temakis Filadelfia acompanhados de 2 hot rolls de salmão fresquinho.","R$54,90");
insert into prato values ('67594639571239',5005,1,22,"imagens/tio_sam_japa_food/combos/4_temakis.webp","4 temakis","Temaki Escolha 2 opções: Filadelfia, Grelhado, Shimeji, kani, California, Grelhado Com Barbecue.","R$55,90");
insert into prato values ('67594639571239',5006,1,22,"imagens/tio_sam_japa_food/combos/2_yakissoba_2hot_roll_salmao.webp","2 yakissoba + 2 hot roll salmão","Yakissoba de Carne, Frango ou Misto acompanhados de 2 hot rolls de salmão fresquinho.","R$54,90");
insert into prato values ('67594639571239',5007,1,22,"imagens/tio_sam_japa_food/combos/i_want_you.webp","Combo: i want you","2 hot grelhados + 8 unidades hossomaki grelhado + 8 unidades de uramaki grelhado + 2 temakis grelhados.","R$79,90");
insert into prato values ('67594639571239',5008,1,22,"imagens/tio_sam_japa_food/combos/1_temaki_8_hossomaki+8_uramaki.jpg","1 temaki + hossomaki (8 unidades) + uramaki (8 unidades)","Temaki Filadelfia, Grelhado,Hossomaki de salmão ou salmão grelhado, Uramaki Filadelfia, Grelhado ou California.","R$42,90");

/*Tio Sam Japa Food Entradas*/
insert into prato values ('67594639571239',5009,1,23,"imagens/tio_sam_japa_food/entradas/lula_na_manteiga.webp","Lula na manteiga","150g de lula na manteiga com shoyo.","R$12,00");
insert into prato values ('67594639571239',5010,1,23,"imagens/tio_sam_japa_food/entradas/lula_a_dore.webp","Lula à dorê","150g de lula empanada na farinha panko.","R$15,00");
insert into prato values ('67594639571239',5011,1,23,"imagens/tio_sam_japa_food/entradas/2_niguiri_de_kani.jpg","2 niguiri de kani","Niguiri feito com arroz e kani fresquinho.","R$6,99");
insert into prato values ('67594639571239',5012,1,23,"imagens/tio_sam_japa_food/entradas/2_niguiri_skin.webp","2 niguiri skin","Niguiri feito com arroz e pele de salmão grelhada.","R$4,99");
insert into prato values ('67594639571239',5013,1,23,"imagens/tio_sam_japa_food/entradas/carpaccio_de_salmao.jpg","Carpaccio de salmão","10 cortes de carpaccio de salmão ao molho ponzu.","R$23,00");
insert into prato values ('67594639571239',5014,1,23,"imagens/tio_sam_japa_food/entradas/enroladinho_sam.webp","Enroladinho sam","Enroladinho de salmão grelhado com cream cheese e cebolinha frito.","R$9,99");
insert into prato values ('67594639571239',5015,1,23,"imagens/tio_sam_japa_food/entradas/teppan_de_salmao.webp","Teppan de salmão","Teppan de salmão com cenoura, repolho e brocolis.","R$20,00");
insert into prato values ('67594639571239',5016,1,23,"imagens/tio_sam_japa_food/entradas/dupla_de_harumaki_de_queijo.webp","Dupla de Harumaki de queijo","Harumaki crocate recheado com queijo que derrete na boca.","R$10,00");
insert into prato values ('67594639571239',5017,1,23,"imagens/tio_sam_japa_food/entradas/ceviche.webp","Ceviche","Ceviche de salmão com peixe branco, cebola roxa e pepino marinado com molho ponzo.","R$15,00");
insert into prato values ('67594639571239',5018,1,23,"imagens/tio_sam_japa_food/entradas/8_esferas_de_salmao.jpg","8 Esferas de salmão","Esferas de salmão empanada no Doritos.","R$17,90");
insert into prato values ('67594639571239',5019,1,23,"imagens/tio_sam_japa_food/entradas/sunomono.webp","Sunomono","100g.","R$9,99");
insert into prato values ('67594639571239',5020,1,23,"imagens/tio_sam_japa_food/entradas/2_niguiri_de_salmao_fresco.webp","2 Niguiri de salmão fresco","Niguiri feito com arroz e salmão fresquinho.","R$7,90");
insert into prato values ('67594639571239',5021,1,23,"imagens/tio_sam_japa_food/entradas/2_joy_de_salmao_fresco.webp","2 Joy de salmão fresco","Joy feito com salmão fresquinho e temperado com cebolhinha picada.","R$10,90");

/*Tio Sam Japa Food Porções*/
insert into prato values ('67594639571239',5022,1,24,"imagens/tio_sam_japa_food/porcoes/porcao_suprema_de_fritas_e_onions_com_cheddar_vulcanico_de_casa_pequena.webp","Porção suprema de fritas e onions com cheddar vulcânico da casa PEQUENA","Serve 2 pessoas.","R$24,90");
insert into prato values ('67594639571239',5023,1,24,"imagens/tio_sam_japa_food/porcoes/porcao_suprema_de_fritas_e_onions_com_cheddar_vulcanico_de_casa_grande.webp","Porção suprema de fritas e onions com cheddar vulcânico da casa GRANDE","Porção serve de 4 a 5 pessoas.","R$49,90");
insert into prato values ('67594639571239',5024,1,24,"imagens/tio_sam_japa_food/porcoes/onion_rings.webp","Onion Rings","Cebola Empanada Frita, Crocante por fora e macia por dentro.","R$22,99");

/*Tio Sam Japa Food Bolota Sam*/
insert into prato values ('67594639571239',5025,1,25,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_filadelfia.webp","Bolota de salmão filadélfia","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5026,1,25,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_grelhado.webp","Bolota de salmão Grelhado","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5027,1,25,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");

/*Tio Sam Japa Food Combinados*/
insert into prato values ('67594639571239',5028,1,26,"imagens/tio_sam_japa_food/combinados/combinado_grelhado_selado_34_peças.webp","Combinado Grelhado/Selado (34 peças)","4 URAMAKI GRELHADO + 4 HOSSOMAKI GRELHADO + 4 NIGUIRI DE SALMÃO SELADO + 4 JOY SELADO + 10 SASHIMI DE SALMÃO SELADO + 4 URAMAKI GRELHADO COM CEBOLA CRISP + 4 URAMAI SKIN.","R$55,90");
insert into prato values ('67594639571239',5029,1,26,"imagens/tio_sam_japa_food/combinados/combinado_variado_43_peças.webp","Combinado Variado (43 peças)","4 URAMAKI DE PATÊ DE SALMÃO + 4 URAMAKI SKIN + 3 NIGUIRI SKIN + 4 HOSSOMAKI GRELHADO + 2 NIGUIRI DE SALMÃO + 2 NIGUIRI PHILADELPHIA + 4 URAMAKI PHILADELFIA + 2 JOY DE MORANGO + 2 JOY DE MARACUJÁ + 2 JOY DE SALMÃO + 10 SASHIMI DE SALMÃO + 4 HOSSOMAKI DE SALMÃO.","R$89,99");
insert into prato values ('67594639571239',5030,1,26,"imagens/tio_sam_japa_food/combinados/sashimi_20_cortes.jpg","Sashimi 20 Cortes","20 Fatias de Sashimi feito com salmão fresquinho.","R$39,00");
insert into prato values ('67594639571239',5031,1,26,"imagens/tio_sam_japa_food/combinados/sashimi_10_cortes.webp","Sashimi 10 cortes","10 Fatias de Sashimi feito com salmão fresquinho.","R$23,00");
insert into prato values ('67594639571239',5032,1,26,"imagens/tio_sam_japa_food/combinados/combinado_individual_13_peças.webp","Combinado individual (13 peças)","2 joy de salmão + 2 niguiri de salmão + 5 sashimi + 2 uramaki de salmão + 2 hossomaki de salmão.","R$29,99");
insert into prato values ('67594639571239',5033,1,26,"imagens/tio_sam_japa_food/combinados/combinado_1_26_peças.webp","Combinado 1 (26 peças)","4 uramaki (sabor da sua escolha) + 4 joy de salmão fresco + 4 niguiri salmão fresco + 4 hossomaki (sabor da sua escolha) + 10 sashimi de salmão fresco.","R$49,90");
insert into prato values ('67594639571239',5034,1,26,"imagens/tio_sam_japa_food/combinados/combinado_sushi_premium_17_peças.jpg","Combinado sushi premium (17 peças)","5 hot roll de salmão + 3 niguiri + 3 joy + 3 hossomaki de salmão + 3 uramaki de salmão.","R$39,90");
insert into prato values ('67594639571239',5035,1,26,"imagens/tio_sam_japa_food/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","6 sashimis + 3 Niguiri + 4 Uramaki + 4 Hossomaki + 2 Joy Tradicional + 2 Joy com Calda de Maracujá.","R$42,90");

/*Tio Sam Japa Food Temakis*/
/*
insert into prato values ('67594639571239',5036,1,27,"imagens/tio_sam_japa_food/combinados/combinado_grelhado_selado_34_peças.webp","Combinado Grelhado/Selado (34 peças)","4 URAMAKI GRELHADO + 4 HOSSOMAKI GRELHADO + 4 NIGUIRI DE SALMÃO SELADO + 4 JOY SELADO + 10 SASHIMI DE SALMÃO SELADO + 4 URAMAKI GRELHADO COM CEBOLA CRISP + 4 URAMAI SKIN..","R$55,90");
insert into prato values ('67594639571239',5037,1,27,"imagens/tio_sam_japa_food/combinados/combinado_variado_43_peças.webp","Combinado Variado (43 peças)","4 URAMAKI DE PATÊ DE SALMÃO + 4 URAMAKI SKIN + 3 NIGUIRI SKIN + 4 HOSSOMAKI GRELHADO + 2 NIGUIRI DE SALMÃO + 2 NIGUIRI PHILADELPHIA + 4 URAMAKI PHILADELFIA + 2 JOY DE MORANGO + 2 JOY DE MARACUJÁ + 2 JOY DE SALMÃO + 10 SASHIMI DE SALMÃO + 4 HOSSOMAKI DE SALMÃO.","R$89,99");
insert into prato values ('67594639571239',5038,1,27,"imagens/tio_sam_japa_food/combinados/sashimi_20_cortes.jpg","Sashimi 20 Cortes","20 Fatias de Sashimi feito com salmão fresquinho.","R$39,00");
insert into prato values ('67594639571239',5039,1,27,"imagens/tio_sam_japa_food/combinados/sashimi_10_cortes.webp","Sashimi 10 cortes","10 Fatias de Sashimi feito com salmão fresquinho.","R$23,00");
insert into prato values ('67594639571239',5040,1,27,"imagens/tio_sam_japa_food/combinados/combinado_individual_13_peças.webp","Combinado individual (13 peças)","2 joy de salmão + 2 niguiri de salmão + 5 sashimi + 2 uramaki de salmão + 2 hossomaki de salmão.","R$29,99");
insert into prato values ('67594639571239',5041,1,27,"imagens/tio_sam_japa_food/combinados/combinado_1_26_peças.webp","Combinado 1 (26 peças)","4 uramaki (sabor da sua escolha) + 4 joy de salmão fresco + 4 niguiri salmão fresco + 4 hossomaki (sabor da sua escolha) + 10 sashimi de salmão fresco.","R$49,90");
insert into prato values ('67594639571239',5042,1,27,"imagens/tio_sam_japa_food/combinados/combinado_sushi_premium_17_peças.jpg","Combinado sushi premium (17 peças)","5 hot roll de salmão + 3 niguiri + 3 joy + 3 hossomaki de salmão + 3 uramaki de salmão.","R$39,90");
insert into prato values ('67594639571239',5043,1,27,"imagens/tio_sam_japa_food/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","6 sashimis + 3 Niguiri + 4 Uramaki + 4 Hossomaki + 2 Joy Tradicional + 2 Joy com Calda de Maracujá.","R$42,90");
insert into prato values ('67594639571239',5044,1,27,"imagens/tio_sam_japa_food/combinados/sashimi_20_cortes.jpg","Sashimi 20 Cortes","20 Fatias de Sashimi feito com salmão fresquinho.","R$39,00");
insert into prato values ('67594639571239',5045,1,27,"imagens/tio_sam_japa_food/combinados/sashimi_10_cortes.webp","Sashimi 10 cortes","10 Fatias de Sashimi feito com salmão fresquinho.","R$23,00");
insert into prato values ('67594639571239',5046,1,27,"imagens/tio_sam_japa_food/combinados/combinado_individual_13_peças.webp","Combinado individual (13 peças)","2 joy de salmão + 2 niguiri de salmão + 5 sashimi + 2 uramaki de salmão + 2 hossomaki de salmão.","R$29,99");
insert into prato values ('67594639571239',5047,1,27,"imagens/tio_sam_japa_food/combinados/combinado_1_26_peças.webp","Combinado 1 (26 peças)","4 uramaki (sabor da sua escolha) + 4 joy de salmão fresco + 4 niguiri salmão fresco + 4 hossomaki (sabor da sua escolha) + 10 sashimi de salmão fresco.","R$49,90");
insert into prato values ('67594639571239',5048,1,27,"imagens/tio_sam_japa_food/combinados/combinado_sushi_premium_17_peças.jpg","Combinado sushi premium (17 peças)","5 hot roll de salmão + 3 niguiri + 3 joy + 3 hossomaki de salmão + 3 uramaki de salmão.","R$39,90");
insert into prato values ('67594639571239',5049,1,27,"imagens/tio_sam_japa_food/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","6 sashimis + 3 Niguiri + 4 Uramaki + 4 Hossomaki + 2 Joy Tradicional + 2 Joy com Calda de Maracujá.","R$42,90");
*/

/*Tio Sam Japa Food Yakissoba*/
/*
insert into prato values ('67594639571239',5050,1,28,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_filadelfia.webp","Bolota de salmão filadélfia","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5051,1,28,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_grelhado.webp","Bolota de salmão Grelhado","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5052,1,28,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5053,1,28,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
*/

/*Tio Sam Japa Food Hot Rolls*/
/*
insert into prato values ('67594639571239',5054,1,29,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_filadelfia.webp","Bolota de salmão filadélfia","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5055,1,29,"imagens/tio_sam_japa_food/bolota_sam/bolota_de_salmao_grelhado.webp","Bolota de salmão Grelhado","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com salmão fresco, cream cheesee, cebolinha e finalizado com tarê por cima.","R$19,99");
insert into prato values ('67594639571239',5056,1,29,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5057,1,29,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5058,1,29,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
insert into prato values ('67594639571239',5059,1,29,"imagens/tio_sam_japa_food/bolota_sam/bolota_tasty.webp","Bolota Tasty","Bolota de arroz empanado e frito com uma casquinha crocante e recheado com hamburguer de salmão grelhado, cream cheesee, cebolinha e finalizado com molho tasty.","R$26,90");
*/



/*Tio Sam Japa Food Sobremesas*/

insert into prato values ('67594639571239',5060,1,30,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_chocolate_de_avela.webp","Dupla de Harumaki de chocolate de avelã","Delicioso Harumaki coberto com chocolate e com recheio de avelã.","R$10,00");
insert into prato values ('67594639571239',5061,1,30,"imagens/tio_sam_japa_food/sobremesas/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Dupla de Harumaki de Banana com canela e chocolate","Delicioso Harumaki recheado com banana,canela e chocolate.","R$12,00");

/*Tio Sam Japa Food Bebidas*/
insert into prato values ('67594639571239',5062,1,31,"imagens/tio_sam_japa_food/bebidas/sucos.png","Suco Del Valle lata 290ml","Sabores: Maracujá, Pessego, Manga E Uva.","R$6,50");
insert into prato values ('67594639571239',5063,1,31,"imagens/tio_sam_japa_food/bebidas/chas.png","Cha ice tea fuze 300ml","Sabores: Limão E Pessego.","R$6,90");
insert into prato values ('67594639571239',5064,1,31,"imagens/tio_sam_japa_food/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$6,90");
insert into prato values ('67594639571239',5065,1,31,"imagens/tio_sam_japa_food/bebidas/refrigerantes_2l.jpg","Refrigerante 2l","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$11,50");
insert into prato values ('67594639571239',5066,1,31,"imagens/tio_sam_japa_food/bebidas/agua_gas.jpg","Agua C/gás 350 ml","Agua Mineral Com Gás.","R$4,60");
insert into prato values ('67594639571239',5067,1,31,"imagens/tio_sam_japa_food/bebidas/agua.jpg","Agua S/gás 350 ml","Agua Mineral Sem Gás.","R$4,90");






/*Forma Pagamento*/
	/*Tio Sam Japa Food*/
	insert into forma_pagamento values ('67594639571239',5001,"Cartão de Crédito");
	insert into forma_pagamento values ('67594639571239',5002,"Cartão de Débito");
	insert into forma_pagamento values ('67594639571239',5003,"Dinheiro");
	insert into forma_pagamento values ('67594639571239',5004,"Sodexo");
	insert into forma_pagamento values ('67594639571239',5005,"Ticket");


/*Recompensas*/
insert into recompensas values ('67594639571239',5001,"imagens/tio_sam_japa_food/promocoes_ponto/agua.jpg","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('67594639571239',5002,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('67594639571239',5003,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('67594639571239',5004,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('67594639571239',5005,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('67594639571239',5006,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('67594639571239',5007,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('67594639571239',5008,"imagens/tio_sam_japa_food/promocoes_ponto/dupla_de_harumaki_de_banana_com_canela_chocolate.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*Horario Seu Temaki*/


insert into horario_funcionamento values (1,"14:00","23:00",'98450900034563',1);
insert into horario_funcionamento values (2,"14:00","23:00",'98450900034563',1);
insert into horario_funcionamento values (3,"14:00","23:00",'98450900034563',1);
insert into horario_funcionamento values (4,"14:00","23:00",'98450900034563',1);
insert into horario_funcionamento values (5,"14:00","23:00",'98450900034563',1);
insert into horario_funcionamento values (6,"14:00","23:00",'98450900034563',1);
insert into horario_funcionamento values (7,"14:00","23:00",'98450900034563',1);


/*Tipo Prato Seu Temaki*/
insert into tipo_prato values (32,"Entradas",'98450900034563');
insert into tipo_prato values (33,"Temakis",'98450900034563');
insert into tipo_prato values (34,"Hot",'98450900034563');
insert into tipo_prato values (35,"Hot Roll",'98450900034563');
insert into tipo_prato values (36,"Hossomaki",'98450900034563');
insert into tipo_prato values (37,"Uramaki",'98450900034563');
insert into tipo_prato values (38,"Sashimi",'98450900034563');
insert into tipo_prato values (39,"Combinados",'98450900034563');
insert into tipo_prato values (40,"Doces",'98450900034563');
insert into tipo_prato values (41,"Bebidas",'98450900034563');


/*prato*/
/*Seu Temaki Entradas*/
insert into prato values ('98450900034563',6001,1,32,"imagens/seu_temaki/entradas/joy_maracuja.webp","Joy de maracuja 4 unid","Bolinho de arroz, envolto por uma fatia fina de salmão, coberto com cream cheese e finalizado com nossa calda de maracuja.","R$16,90");
insert into prato values ('98450900034563',6002,1,32,"imagens/seu_temaki/entradas/joy_salmao.webp","Joy Salmão 4unid","bolinho de arroz, envolto por uma fatia fina de salmão, e coberto com salmão picado misturado com cream cheese e cebolinha.","R$21,90");
insert into prato values ('98450900034563',6003,1,32,"imagens/seu_temaki/entradas/ceviche_salmao.webp","Ceviche de salmão","Ceviche é um prato com salmão cru em cubos marinado em suco cítrico, ingredientes obrigatórios são a cebola roxa, pimentão, cebolinha, em leve toque de pimenta.","R$26,90");
insert into prato values ('98450900034563',6004,1,32,"imagens/seu_temaki/entradas/niguiri_salmao.webp","Niguiri Salmão 4und.","Niguiri feito com arroz e salmão fresco.","R$19,90");
insert into prato values ('98450900034563',6005,1,32,"imagens/seu_temaki/entradas/carpaccio_salmao.webp","Carpaccio de salmão 12 cortes","Laminas finas de salmão, levemente marinado no limão, finalizado no azeite e no shoyu.","R$26,90");


/*Seu Temaki Temakis*/
insert into prato values ('98450900034563',6006,1,33,"imagens/seu_temaki/temaki/temaki_salmao_grelhado.webp","Temaki salmão grelhado","Alga, arroz, Salmão grelhado, cream cheese e molho tarê e gergelim (Acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6007,1,33,"imagens/seu_temaki/temaki/temaki_salmao_completo.webp","Temaki salmão completo","Alga, arroz, Salmão, cream cheese, cebolinha e gergelim (acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6008,1,33,"imagens/seu_temaki/temaki/temaki_salmao_simples.webp","Temaki salmão simples","Alga, arroz, Salmão, cebolinha e gergelim (acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6009,1,33,"imagens/seu_temaki/temaki/temaki_skin.webp","Temaki skin","Alga, arroz, Pele de salmão frita, cream cheese, molho tarê e gergelim (Acompanha 1 sache de shoyu).","R$12,90");
insert into prato values ('98450900034563',6010,1,33,"imagens/seu_temaki/temaki/temaki_hot.webp","Temaki hot","Temaki todo empanado, recheio arroz, salmão, cream cheese e molho tarê (Acompanha 1 sache de shoyu).","R$18,90");
insert into prato values ('98450900034563',6011,1,33,"imagens/seu_temaki/temaki/temaki_chillimaki.webp","Temaki chillimaki (picante)","Alga, Arroz, Mistura de salmão cru, doritos, cream cheese e pimenta sriracha (Acompanha 1 sache de shoyu).","R$17,90");
insert into prato values ('98450900034563',6012,1,33,"imagens/seu_temaki/temaki/temaki_salmao_doritos.webp","Temaki salmão doritos","Alga, arroz, Salmão cru, cream cheese, cebolinha e doritos (Acompanha 1 sache de shoyu).","R$16,90");
insert into prato values ('98450900034563',6013,1,33,"imagens/seu_temaki/temaki/temaki_shimeji.webp","Temaki shimeji","Alga, arroz, Shimeji, cream cheese, cebolinha e gergelim (Acompanha 1 sache de shoyu).","R$16,90");


/*Seu Temaki Hot*/
insert into prato values ('98450900034563',6014,1,34,"imagens/seu_temaki/hot/shime_na_manteiga.webp","Shimeji na manteiga","Cogumelo salteado na manteiga, finalizado com cebolinha e gergelim.","R$17,90");
insert into prato values ('98450900034563',6015,1,34,"imagens/seu_temaki/hot/harumaki_legumes.webp","Harumaki legumes.","Delicioso harumaki feito com legumes frescos.","R$12,90");


/*Seu Temaki Hot Roll*/
insert into prato values ('98450900034563',6017,1,35,"imagens/seu_temaki/hot_rolls/hot_roll.webp","Hot Roll Salmão","Salmão, arroz, cebolinha, cream cheese, molho tare e gergelim /12 unidades.","R$18,90");
insert into prato values ('98450900034563',6018,1,35,"imagens/seu_temaki/hot_rolls/hot_roll_doritos.webp","Hot Roll Doritos","Salmão, arroz, cream cheese, Doritos e molho tare 1 unidades.","R$19,90");
insert into prato values ('98450900034563',6019,1,35,"imagens/seu_temaki/hot_rolls/hot_roll_crispy.webp","Hot Roll Crispy","Salmão, arroz, cream cheese, couve frita e molho tare 10 unidades.","R$19,90");


/*Seu Temaki Hossomaki*/
insert into prato values ('98450900034563',6020,1,36,"imagens/seu_temaki/hossomaki/hossomaki_pepino.webp","Hossomaki Pepino","Enrolado, arroz e pepino (Acompanha 1 sache de shoyu e 1 hashi).","R$12,90");
insert into prato values ('98450900034563',6021,1,36,"imagens/seu_temaki/hossomaki/hossomaki_salmao.webp","Hossomaki Salmão","Enrolado, arroz e salmão 10 un (Acompanha 1 sache de shoyu e 1 hashi).","R$15,90");


/*Seu Temaki Uramaki*/
insert into prato values ('98450900034563',6022,1,37,"imagens/seu_temaki/uramaki/uramaki_philadelphia.webp","Uramaki Philadelphia 10 unid","Ele possui o arroz por fora do nori, envolto de uma fina camada de salmão, que por sua vez enrola o recheio no centro com salmão e cream cheese, ( Acompanha 1 shoyu e 1 hashi ).","R$22,90");
insert into prato values ('98450900034563',6023,1,37,"imagens/seu_temaki/uramaki/uramaki_salmao_grelhado.webp","Uramaki Salmão Grelhado 10 und","Ele possui o arroz por fora do nori, que por sua vez enrola o recheio no centro com salmão grelhado e cream cheese, e finalizado com molho tarê ( Acompanha 1 shoyu e 1 hashi ).","R$19,90");



/*Seu Temaki Sashimi*/
insert into prato values ('98450900034563',6024,1,38,"imagens/seu_temaki/sashimi/sashimi_salmao_10_fatias.webp","Sashimi salmão 10 fatias","10 fatias de salmão fresquinho.","R$35,00");
insert into prato values ('98450900034563',6025,1,38,"imagens/seu_temaki/sashimi/sashimi_salmao_20_fatias.webp","Sashimi salmão 20 fatias","20 fatias de salmão fresquinho.","R$60,00");


/*Seu Temaki Combinados*/
insert into prato values ('98450900034563',6026,1,39,"imagens/seu_temaki/combinados/combinado_1_14_peças.webp","Combinado 1 - 14 peças","4 hossomaki pepino, 4 hossomaki salmão, 4 uramaki Philadelphia e 2 niguiris (acompanha 3 saches de shoyus + 2 hashis).","R$27,90");
insert into prato values ('98450900034563',6027,1,39,"imagens/seu_temaki/combinados/combinado_2_21_peças.webp","Combinado 2 (21 peças)","4 hossomaki pepino, 4 hossomaki salmão, 4 uramaki califórnia, 4 uramaki patê salmão e 5 sashimi salmão (acompanha 3 saches de shoyus + 2 hashis).","R$42,90");
insert into prato values ('98450900034563',6028,1,39,"imagens/seu_temaki/combinados/combinado_3_31_peças.webp","Combinado 3 - 31 peças","4 hossomaki pepino, 4 hossomaki salmão, 4 uramaki califórnia, 2 joy, 4 uramaki patê salmão, 4 uramaki Philadelphia, 2 niguiris e 7 sashimi salmão (acompanha 4 saches de shoyus + 2 hashis).","R$65,90");
insert into prato values ('98450900034563',6029,1,39,"imagens/seu_temaki/combinados/combinado_salmao.webp","Combinado de salmão - 17 peças","4 hossomaki salmão, 5 sashimi salmão, 4 uramaki philadelphia e 4 niguiris.","R$39,90");


/*Seu Temaki Doces*/
insert into prato values ('98450900034563',6030,1,40,"imagens/seu_temaki/doces/harumaki_romeu_e_julieta.webp","Harumaki romeu e julieta","Delicioso harumaki feito comqueijo e goiabada.","R$13,90");
insert into prato values ('98450900034563',6031,1,40,"imagens/seu_temaki/doces/harumaki_banana_com_chocolate.webp","Harumaki banana com chocolate","Delicioso harumaki feito com chocolate ao leite e banana fresquinha.","R$13,90");


/*Seu Temaki Bebidas*/
insert into prato values ('98450900034563',6032,1,41,"imagens/seu_temaki/bebidas/sucos.png","Suco Del Valle lata 290ml","Sabores: Maracujá, Pessego, Manga E Uva.","R$6,90");
insert into prato values ('98450900034563',6034,1,41,"imagens/seu_temaki/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$5,90");
insert into prato values ('98450900034563',6035,1,41,"imagens/seu_temaki/bebidas/refrigerantes_2l.jpg","Refrigerante 2l","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$12,00");

/*Forma Pagamento*/
	/*Seu Temaki*/
	insert into forma_pagamento values ('98450900034563',6001,"Cartão de Crédito");
	insert into forma_pagamento values ('98450900034563',6002,"Cartão de Débito");
	insert into forma_pagamento values ('98450900034563',6003,"Dinheiro");
	insert into forma_pagamento values ('98450900034563',6004,"Sodexo");
	insert into forma_pagamento values ('98450900034563',6005,"Ticket");



/*Recompensas*/
insert into recompensas values ('98450900034563',6001,"imagens/seu_temaki/promocoes_ponto/combinado_1_14_peças.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('98450900034563',6002,"imagens/seu_temaki/promocoes_ponto/uramaki_philadelphia.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('98450900034563',6003,"imagens/seu_temaki/promocoes_ponto/temaki_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('98450900034563',6004,"imagens/seu_temaki/promocoes_ponto/temaki_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('98450900034563',6005,"imagens/seu_temaki/promocoes_ponto/temaki_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('98450900034563',6006,"imagens/seu_temaki/promocoes_ponto/temaki_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('98450900034563',6007,"imagens/seu_temaki/promocoes_ponto/temaki_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('98450900034563',6008,"imagens/seu_temaki/promocoes_ponto/temaki_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*Horario Banzai*/ /*abre duas vezes*/


insert into horario_funcionamento values (1,"14:00","23:00",'82300081236891',1);
insert into horario_funcionamento values (2,"14:00","23:00",'82300081236891',1);
insert into horario_funcionamento values (3,"14:00","23:00",'82300081236891',1);
insert into horario_funcionamento values (4,"14:00","23:00",'82300081236891',1);
insert into horario_funcionamento values (5,"14:00","23:00",'82300081236891',1);
insert into horario_funcionamento values (6,"14:00","23:00",'82300081236891',1);
insert into horario_funcionamento values (7,"14:00","23:00",'82300081236891',1);



/*Tipo Prato Seu Temaki*/
insert into tipo_prato values (42,"Temakis",'82300081236891');
insert into tipo_prato values (43,"Bebidas",'82300081236891');


/*Banzai Temakis*/
insert into prato values ('82300081236891',7001,1,42,"imagens/banzai/temaki_salmao/temaki_salmao_simples.webp","Temaki Salmão Simples","Cerveja alemã feita de trigo.","R$16,00");
insert into prato values ('82300081236891',7002,1,42,"imagens/banzai/temaki_salmao/temaki_salmao_com_cebolinha.webp","Temaki de Salmão com Cebolinha","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$16,00");
insert into prato values ('82300081236891',7003,1,42,"imagens/banzai/temaki_salmao/temaki_salmao_completo.webp","Temaki Salmão Completo","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$16,50");
insert into prato values ('82300081236891',7004,1,42,"imagens/banzai/temaki_salmao/temaki_philadelphia.webp"," Temaki Philadelphia","Sabor Laranjá e Maracujá.","R$17,50");
insert into prato values ('82300081236891',7005,1,42,"imagens/banzai/temaki_salmao/salmao_skin.webp","Salmão Skin","/bebida Fermentada a base de arroz.","R$13,50");
insert into prato values ('82300081236891',7006,1,42,"imagens/banzai/temaki_salmao/temaki_salmao_com_shimeji.webp","Temaki Salmão com Shimeji","/Agua Mineral.","R$17,00");




/*Banzai Bebidas*/
insert into prato values ('82300081236891',7032,1,43,"imagens/banzai/bebidas/cerveja_erdinger_weib_bier.webp","Cerveja erdinger weib bier 500 ml","Cerveja alemã feita de trigo.","R$20,00");
insert into prato values ('82300081236891',7034,1,43,"imagens/banzai/bebidas/refrigerante_600_ml.webp","Refrigerante 600ml","Coca Cola, Coca Cola Zero, Fanta Laranja, Schweppes Citrus, Kuat, kuat Zero, Tonica Antartica E Sprite.","R$5,90");
insert into prato values ('82300081236891',7035,1,43,"imagens/banzai/bebidas/refrigerantes_lata.jpg","Refrigerante lata","Coca Cola, Coca Cola Zero, Fanta Laranja, Kuat, kuat Zero.","R$12,00");
insert into prato values ('82300081236891',7036,1,43,"imagens/banzai/bebidas/suco_naturacitrus.webp","suco naturacitrus","Sabor Laranjá e Maracujá.","R$7,50");
insert into prato values ('82300081236891',7037,1,43,"imagens/banzai/bebidas/saque_azuma_kirin.webp","garrafa de Saquê azuma kirin","/bebida Fermentada a base de arroz.","R$45,00");
insert into prato values ('82300081236891',7038,1,43,"imagens/banzai/bebidas/agua.jpg","Agua","/Agua Mineral.","R$45,00");


/*Recompensas*/
insert into recompensas values ('82300081236891',7001,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('82300081236891',7002,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('82300081236891',7003,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('82300081236891',7004,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('82300081236891',7005,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('82300081236891',7006,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('82300081236891',7007,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('82300081236891',7008,"imagens/banzai/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*Horario Quiosque Burgman*/


insert into horario_funcionamento values (1,"00:00","23:59",'62315943587966',1);
insert into horario_funcionamento values (2,"00:00","23:59",'62315943587966',1);
insert into horario_funcionamento values (3,"00:00","23:59",'62315943587966',1);
insert into horario_funcionamento values (4,"00:00","23:59",'62315943587966',1);
insert into horario_funcionamento values (5,"00:00","23:59",'62315943587966',1);
insert into horario_funcionamento values (6,"00:00","23:59",'62315943587966',1);
insert into horario_funcionamento values (7,"00:00","23:59",'62315943587966',1);



/*Tipo Prato Quiosque Burgman*/
insert into tipo_prato values (44,"Lanches",'62315943587966');
insert into tipo_prato values (45,"Bebidas",'62315943587966');


/*prato*/
/*Quiosque Burgman lanches*/
insert into prato values ('62315943587966',8001,1,44,"imagens/quiosque_burgman/lanches/hamburgman.webp","Hamburgman","Hamburguer artesanal de 200g de carne, maionese verde, rúcula, mussarela gratinada e bacon.","R$33,00");
insert into prato values ('62315943587966',8002,1,44,"imagens/quiosque_burgman/lanches/vegetariano.webp","Vegetariano","Hamburguer artesanal de soja defumado sabor calabresa de 160g, pão com gergelim, maionese verde, mussarela, rúcula e Doritos.","R$37,00");
insert into prato values ('62315943587966',8003,1,44,"imagens/quiosque_burgman/lanches/vegano.webp","Vegano","Hamburguer artesanal de cenoura 160g, pão com gergelim, maionese verde sem ovo, queijo de mandioca, rúcula e Doritos.","R$37,00");
insert into prato values ('62315943587966',8004,1,44,"imagens/quiosque_burgman/lanches/fishn_fries.webp","Fishn'fries"," Peixe com crosta crocante e fritas.","R$46,00");
insert into prato values ('62315943587966',8005,1,44,"imagens/quiosque_burgman/lanches/isca_a_parmegiana.webp","Isca a parmegiana","Carne empanada, mussarela gratinada, molho de tomate e fritas.","R$49,00");
insert into prato values ('62315943587966',8006,1,44,"imagens/quiosque_burgman/lanches/bufalo_wings.jpg","Búfalo wings","Asinha de frango apimentada com fritas.","R$42,00");
insert into prato values ('62315943587966',8007,1,44,"imagens/quiosque_burgman/lanches/onion_rings.webp","Onion rings","Acompanha molho barbecue.","R$35,00");
insert into prato values ('62315943587966',8008,1,44,"imagens/quiosque_burgman/lanches/batata.jpg","Batata"," 3 queijos, gratinadas c/ bacon e alho.","R$41,00");
insert into prato values ('62315943587966',8009,1,44,"imagens/quiosque_burgman/lanches/batata_rustica.webp","Batata Rústica","Acompanha molho especial.","R$37,00");


/*Quiosque Burgman bebidas*/
insert into prato values ('62315943587966',8010,1,45,"imagens/quiosque_burgman/bebidas/refrigerantes_lata.jpg","Refrigerante Lata","350ml - coca cola / coca cola zero / Fanta guarana.","R$6,00");
insert into prato values ('62315943587966',8011,1,45,"imagens/quiosque_burgman/bebidas/sucos.png","Suco Del Valle","300ml.","R$7,00");
insert into prato values ('62315943587966',8012,1,45,"imagens/quiosque_burgman/bebidas/agua_mineral_500ml.webp","Agua Mineral 500ml","Com gás ou sem gás.","R$6,00");



/*Recompensas*/
insert into recompensas values ('62315943587966',8001,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('62315943587966',8002,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('62315943587966',8003,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('62315943587966',8004,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('62315943587966',8005,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('62315943587966',8006,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('62315943587966',8007,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('62315943587966',8008,"imagens/quiosque_burgman/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*Horario Oakberry*/


insert into horario_funcionamento values (1,"15:00","21:00",'40879632585865',1);
insert into horario_funcionamento values (2,"10:00","22:00",'40879632585865',1);
insert into horario_funcionamento values (3,"10:00","22:00",'40879632585865',1);
insert into horario_funcionamento values (4,"10:00","22:00",'40879632585865',1);
insert into horario_funcionamento values (5,"10:00","22:00",'40879632585865',1);
insert into horario_funcionamento values (6,"10:00","22:00",'40879632585865',1);
insert into horario_funcionamento values (7,"10:00","22:00",'40879632585865',1);


/*Tipo Prato Oakberry*/
insert into tipo_prato values (46,"Bowls",'40879632585865');
insert into tipo_prato values (47,"Smoothie",'40879632585865');



/*Oakberry Bowl*/
insert into prato values ('40879632585865',9001,1,46,"imagens/oakberry/bowl/the_oak_bowl_720ml.webp","The oak bowl (720ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$27,90");
insert into prato values ('40879632585865',9002,1,46,"imagens/oakberry/bowl/works_bowl_500ml.webp","Works bowl (500ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$21,90");
insert into prato values ('40879632585865',9003,1,46,"imagens/oakberry/bowl/classic_bowl_350ml.webp","Classic bowl (350ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$14,90");


/*Oakberry Smoothie*/
insert into prato values ('40879632585865',9004,1,47,"imagens/oakberry/smoothie/smoothie_the_oak_720ml.webp","Smoothie the oak (720ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$21,90");
insert into prato values ('40879632585865',9005,1,47,"imagens/oakberry/smoothie/smoothie_works_500ml.webp","Smoothie works (500ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$17,90");
insert into prato values ('40879632585865',9006,1,47,"imagens/oakberry/smoothie/smoothie_classic_350ml.webp","Smoothie classic (350ml)","O processo realizado pela oakberry garante o máximo de nutrientes e vitaminas. Nosso açaí é fonte natural de antioxidantes, fibras, ferro, ômega 6 e 9 e vitamina c.","R$11,90");



/*Recompensas*/
insert into recompensas values ('40879632585865',9001,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('40879632585865',9002,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('40879632585865',9003,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('40879632585865',9004,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('40879632585865',9005,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('40879632585865',9006,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('40879632585865',9007,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('40879632585865',9008,"imagens/oakberry/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*Horario brasileirinho*/


insert into horario_funcionamento values (1,"11:00","16:00",'65662348978806',1);
insert into horario_funcionamento values (2,"10:30","15:30",'65662348978806',1);
insert into horario_funcionamento values (3,"10:30","15:30",'65662348978806',1);
insert into horario_funcionamento values (4,"10:30","15:30",'65662348978806',1);
insert into horario_funcionamento values (5,"10:30","15:30",'65662348978806',1);
insert into horario_funcionamento values (6,"10:30","15:30",'65662348978806',1);
insert into horario_funcionamento values (7,"11:00","16:00",'65662348978806',1);



/*Tipo Prato brasileirinho*/
insert into tipo_prato values (48,"Veganíssimos",'65662348978806');
insert into tipo_prato values (49,"Comida Típica Brasileira",'65662348978806');




/*brasileirinho Veganíssimos*/
insert into prato values ('65662348978806',10001,1,48,"imagens/brasileirinho/veganissimos/mexidinho_vegano.webp","Mexidinho vegano","Arroz, proteína de soja, tomate, milho verde, azeitona e cheiro verde.","R$22,99");
insert into prato values ('65662348978806',10002,1,48,"imagens/brasileirinho/veganissimos/nhoque_vegano_de_batata_doce.webp","Nhoque vegano de batata doce","Massa tipo nhoque de batata doce, proteína de soja, molho de tomate e creme de soja.","R$23,99");


/*brasileirinho Comida típica brasileira*/
insert into prato values ('65662348978806',10003,1,49,"imagens/brasileirinho/comida_tipica_brasileira/arroz_carreteiro.png","Arroz carreteiro","Arroz, carne seca, tomate, cebola, alho e cheiro verde e calabresa.","R$19,99");
insert into prato values ('65662348978806',10004,1,49,"imagens/brasileirinho/comida_tipica_brasileira/baiao_de_dois.png","Baião de Dois","Arroz, feijão de corda, carne seca, tomate, cebola, alho, calabresa e bacon.","R$21,99");
insert into prato values ('65662348978806',10005,1,49,"imagens/brasileirinho/comida_tipica_brasileira/brasileirinho.png","Brasileirinho","Arroz, feijão, carne bovina, tomate, cebola ovo, alho e cheiro verde.","R$20,99");
insert into prato values ('65662348978806',10006,1,49,"imagens/brasileirinho/comida_tipica_brasileira/do_chefe.png","Do Chéfe","Arroz, carne moida, azeitona verde, tomate, ovo, alho e molho de tomate.","R$19,99");
insert into prato values ('65662348978806',10007,1,49,"imagens/brasileirinho/comida_tipica_brasileira/estrogonofe_frango.png","Estrogonofe de frango","Arroz, frango, molho branco, champignon, ketchup, mostarda e alho. Acompanha batata palha.","R$19,99");
insert into prato values ('65662348978806',10008,1,49,"imagens/brasileirinho/comida_tipica_brasileira/feijao_tropeiro.png","Feijão tropeiro","Arroz, feijão, farofa, tomate, carne seca,  alho, cheiro verde e calabresa, bacon.","R$21,99");
insert into prato values ('65662348978806',10009,1,49,"imagens/brasileirinho/comida_tipica_brasileira/fitness.png","Fitness","Batata doce, frango, cenoura, ovo, alface e cheiro verde e sal.","R$24,99");
insert into prato values ('65662348978806',10010,1,49,"imagens/brasileirinho/comida_tipica_brasileira/galinhada.png","Galinhada","Arroz, frango, milho, tomate, cenoura, açafrão, cebola, alho e cheiro verde.","R$19,99");
insert into prato values ('65662348978806',10011,1,49,"imagens/brasileirinho/comida_tipica_brasileira/gaucho.png","Gaúcho","Arroz, picanha, palmito, tomate, catupiry e alho, e alho frito.","R$22,99");
insert into prato values ('65662348978806',10012,1,49,"imagens/brasileirinho/comida_tipica_brasileira/integral.png","Integral","Arroz integral, frango, brocolis, cenoura, ervilha e alho.","R$20,99");
insert into prato values ('65662348978806',10013,1,49,"imagens/brasileirinho/comida_tipica_brasileira/oriental.png","Oriental","Arroz, frango empanado, cenoura, omelete, pimentão, brocolis, ervilha, shoyo, alho e cheiro verde.","R$20,99");
insert into prato values ('65662348978806',10014,1,49,"imagens/brasileirinho/comida_tipica_brasileira/parmegiana_carne.png","Parmegiana de carne","Arroz, carne bovina empanada, molho de tomate e muçarela. Acompanha batata palha.","R$23,99");
insert into prato values ('65662348978806',10015,1,49,"imagens/brasileirinho/comida_tipica_brasileira/parmegiana_frango.png","Parmegiana de Frango","Arroz, frango empanado, molho de tomate e muçarela. Acompanha batata palha.","R$22,99");
insert into prato values ('65662348978806',10016,1,49,"imagens/brasileirinho/comida_tipica_brasileira/parmegiana_peixe.jpg","Parmegiana de Peixe","Arroz, Peixe Empanado, Molho de Tomate, Muçarela.","R$23,99");
insert into prato values ('65662348978806',10017,1,49,"imagens/brasileirinho/comida_tipica_brasileira/penne_a_primavera.png","Penne à Primavera","Massa tipo pene, molho branco,presunto, ervilha e queijo mussarela.","R$20,99");
insert into prato values ('65662348978806',10018,1,49,"imagens/brasileirinho/comida_tipica_brasileira/salada_brasileirinho.png","Salada Brasileirinho","Alface, frango, ervilha, ovo, cenoura, tomate e sal.","R$21,99");
insert into prato values ('65662348978806',10019,1,49,"imagens/brasileirinho/comida_tipica_brasileira/talharim_a_bolonhesa.png","Talharim a Bolonhesa","Massa tipo talharim, carne moida, calabresa, molho de tomate e cheiro verde. acompanha queijo ralado.","R$18,99");
insert into prato values ('65662348978806',10020,1,49,"imagens/brasileirinho/comida_tipica_brasileira/talharim_ao_molho_branco.webp","Talharim ao Molho Branco","Massa tipo talharim, molho branco, brócolis, milho verde. acompanha queijo ralado.","R$20,99");
insert into prato values ('65662348978806',10021,1,49,"imagens/brasileirinho/comida_tipica_brasileira/yakissoba_padrao.png","Yakissoba Padrão","Macarrão, frango, carne bovina, pimentão, cenoura, brocolis, vagem, acelga e shoyo.","R$24,99");


/*Recompensas*/
insert into recompensas values ('65662348978806',10001,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('65662348978806',10002,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('65662348978806',10003,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('65662348978806',10004,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('65662348978806',10005,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('65662348978806',10006,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('65662348978806',10007,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('65662348978806',10008,"imagens/brasileirinho/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*Horario Mc Donald's*/


insert into horario_funcionamento values (1,"11:00","02:00",'21912193404921',1);
insert into horario_funcionamento values (2,"11:00","02:00",'21912193404921',1);
insert into horario_funcionamento values (3,"11:00","02:00",'21912193404921',1);
insert into horario_funcionamento values (4,"11:00","02:00",'21912193404921',1);
insert into horario_funcionamento values (5,"11:00","02:00",'21912193404921',1);
insert into horario_funcionamento values (6,"00:00","23:59",'21912193404921',1);
insert into horario_funcionamento values (7,"00:00","23:59",'21912193404921',1);




/*Tipo Prato Mc Donald's*/
insert into tipo_prato values (50,"Lançamentos McOfertas",'21912193404921');
insert into tipo_prato values (51,"McOfertas Premium Típica Brasileira",'21912193404921');
insert into tipo_prato values (52,"McOfertas Classicas",'21912193404921');
insert into tipo_prato values (53,"Sanduíches de Carne Bovina",'21912193404921');
insert into tipo_prato values (54,"Sanduíches de Frango",'21912193404921');
insert into tipo_prato values (55,"Acompanhamentos",'21912193404921');
insert into tipo_prato values (56,"Mclanche feliz",'21912193404921');
insert into tipo_prato values (57,"Sobremesas",'21912193404921');
insert into tipo_prato values (58,"Bebidas",'21912193404921');


/*Mc Donald's Lançamentos McOfertas*/
insert into prato values ('21912193404921',11001,1,50,"imagens/mcdonald/mc_ofertas/big_four.webp","McOferta Big Four","Feito com pão de Big Mac, pepperoni, cebola crispy, 4 carnes de regulares e uma saborosa maionese defumada.","R$35,90");
insert into prato values ('21912193404921',11002,1,50,"imagens/mcdonald/mc_ofertas/big_beef_&_chicken.webp","McOferta Big Beef & Chicken","Carnes e frango juntos ? Sim! Além disso, vai queijo cheddar, maionese, cebola caramelizada, feito com pão de big.","R$35,90");
insert into prato values ('21912193404921',11003,1,50,"imagens/mcdonald/mc_ofertas/big_malt.webp","McOferta Big Malt","Feito com pão de Big Mac integral, bacon, cebola crispy, duas carnes 4:1 e uma surpreendente mostarda de cerveja.","R$35,90");
insert into prato values ('21912193404921',11004,1,50,"imagens/mcdonald/mc_ofertas/duplo_picanha.webp","McOferta Duplo Picanha","Dois deliciosos hambúrgueres de picanha, cebola crispy, tomate, mix de folhas e molho de picanha, acompanhamento e bebida.","R$42,90");
insert into prato values ('21912193404921',11005,1,50,"imagens/mcdonald/mc_ofertas/big_bourbon.webp","McOferta Big Bourbon","Feito com pão de Big Mac, bacon, cebola crispy, cheddar melt, duas carnes 4:1 e um delicioso molho barbecue sabor wishky.","R$35,90");
insert into prato values ('21912193404921',11006,1,50,"imagens/mcdonald/mc_ofertas/big_fire.webp","McOferta Big Fire","Feito com pão de Big Mac integral, bacon, duas carnes 4:1, queijo emmental e um molho pimenta biquinho.","R$35,90");


/*Mc Donald's McOfertas Premium*/
insert into prato values ('21912193404921',11007,1,51,"imagens/mcdonald/mc_ofertas/clubhouse.webp","McOferta ClubHouse","Dois hambúrgueres suculentos de carne 100% bovina, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche, com acompanhamento e bebida.","R$35,90");
insert into prato values ('21912193404921',11008,1,51,"imagens/mcdonald/mc_ofertas/clubhouse_chicken.webp","McOferta ClubHouse Chicken","Filé de frango empanado, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche, com acompanhamento e bebida.","R$35,90");
insert into prato values ('21912193404921',11009,1,51,"imagens/mcdonald/mc_ofertas/duplo_quarterao.webp","McOferta Duplo quarterao","Duplamente inigualável dois hambúrgueres, mostarda, ketchup, cebola e, claro, o delicioso queijo cheddar num pão com gergelim, acompanhamento e bebida.","R$34,90");
insert into prato values ('21912193404921',11010,1,51,"imagens/mcdonald/mc_ofertas/big_tasty_chicken_bacon.webp","McOferta Big Tasty Chicken Bacon","Frango empanado, bacon, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty, com acompanhamento e bebida.","R$35,90");
insert into prato values ('21912193404921',11011,1,51,"imagens/mcdonald/mc_ofertas/big_tasty.webp","McOferta Big Tasty","O maior hambúrguer de carne 100% bovina do mcdonald’s, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty, acompanhamento e bebida.","R$33,90");
insert into prato values ('21912193404921',11012,1,51,"imagens/mcdonald/mc_ofertas/chicken_supreme_crispy.webp","McOferta Chicken Supreme Crispy","Carne de frango empanado, molho delicioso, cebola crispy, tomate, alface fresquinha e queijo emental e pão integral com gergelim, acompanhamento e bebida.","R$29,90");

/*Mc Donald's McOfertas Classicas*/
insert into prato values ('21912193404921',11013,1,52,"imagens/mcdonald/mc_ofertas_classicas/big_mac.webp","McOferta Big Mac","Dois hambúrgueres, alface, queijo e molho especial, cebola e picles num pão com gergelim, acompanhamento e bebida.","R$28,90");
insert into prato values ('21912193404921',11014,1,52,"imagens/mcdonald/mc_ofertas_classicas/quarteirao_com_queijo.webp","McOferta Quarterão com Queijo","Um hambúrguer feito com pura carne bovina, envolvida por duas fatias de queijo temperado com ketchup, mostarda, cebola e picles, acompanhamento e bebida.","R$28,90");
insert into prato values ('21912193404921',11015,1,52,"imagens/mcdonald/mc_ofertas_classicas/cheddar_mcmelt.webp","McOferta Cheddar Mcmelt","Delicioso hambúrguer de carne bovina, queijo tipo cheddar derretido, cebola ao molho shoyu no pão escuro com gergelim,acompanhamento e bebida.","R$28,90");
insert into prato values ('21912193404921',11016,1,52,"imagens/mcdonald/mc_ofertas_classicas/mcnifico_bacon.webp","McOferta Mcnífico Bacon","Três saborosas fatias de bacon, cebola, hambúrguer de 120 gramas de carne bovina, queijo derretido, tomate e um trio de delícias: maionese, ketchup e mostarda, acompanhamento e bebida.","R$30,90");
insert into prato values ('21912193404921',11017,1,52,"imagens/mcdonald/mc_ofertas_classicas/mcchicken.webp","McOferta Mcchicken","Frango empanado e dourado com molho suave e cremoso, acompanhado de alface crocante num pão com gergelim, acompanhamento e bebida.","R$26,90");
insert into prato values ('21912193404921',11018,1,52,"imagens/mcdonald/mc_ofertas_classicas/chicken_mcnuggets.webp","McOferta Chicken McNuggets 10 unidades ","Os frangos empanados mais irresistíveis do mcdonald’s, são quatro opções de molhos (agridoce,barbecue,creamy rach ou caipira), acompanhamento e bebida.","R$26,90");


/*Mc Donald's Sanduíches de carne Bovina*/
insert into prato values ('21912193404921',11019,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_four.webp","Big Four","Feito com pão de Big Mac, pepperoni, cebola crispy, 4 carnes de regulares e uma saborosa maionese defumada.","R$27,90");
insert into prato values ('21912193404921',11020,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_beef_&_chicken.webp","Big Beef & chicken"," Carne e frango juntos? sim! Alem disso, vai queijo cheddar, maionese, cebola caramelizada, feito com pão de big.","R$27,90");
insert into prato values ('21912193404921',11021,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_malt.webp","Big Malt","Feito com pão de Big Mac integral, bacon, cebola crispy, duas carnes 4:1 e uma surpreendente mostarda de cerveja.","R$27,90");
insert into prato values ('21912193404921',11022,1,53,"imagens/mcdonald/sanduiches_carne_bovina/duplo_picanha.webp","Duplo Picanha","Dois deliciosos hambúrgueres de picanha, cebola crispy, tomate, mix de folhas e molho de picanha.","R$33,90");
insert into prato values ('21912193404921',11023,1,53,"imagens/mcdonald/sanduiches_carne_bovina/bacon_smokehouse.webp","Bacon smokehouse","Chegou a novidade do momento. pão de brioche, molho mostarda e mel, cebola empanada, 3 fatias de bacon, 2 deliciosos hambúrgueres, cebola caramelizada e um delicioso molho de bacon.","R$27,90");
insert into prato values ('21912193404921',11024,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_bourbon.webp","Big Bourbon","Feito com pão de Big Mac, bacon, cebola crispy, cheddar melt, duas carnes 4:1 e um delicioso molho barbecue sabor wishky.","R$27,90");
insert into prato values ('21912193404921',11025,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_fire.webp","Big Fire","Feito com pão de Big Mac integral, bacon, duas carnes 4:1, queijo emmental e um molho pimenta biquinho.","R$27,90");
insert into prato values ('21912193404921',11026,1,53,"imagens/mcdonald/sanduiches_carne_bovina/clubhouse.webp","ClubHouse","Dois hambúrgueres suculentos de carne 100% bovina, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche.","R$27,90");
insert into prato values ('21912193404921',11027,1,53,"imagens/mcdonald/sanduiches_carne_bovina/duplo_quarterao.webp","Duplo quarterao","Duplamente inigualável dois hambúrgueres, mostarda, ketchup, cebola e, claro, o delicioso queijo cheddar num pão com gergelim.","R$25,90");
insert into prato values ('21912193404921',11028,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_tasty.webp","Big Tasty","O maior hambúrguer de carne 100% bovina do mcdonald’s, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty.","R$24,90");
insert into prato values ('21912193404921',11029,1,53,"imagens/mcdonald/sanduiches_carne_bovina/big_mac.webp","Big Mac","Dois hambúrgueres, alface, queijo e molho especial, cebola e picles num pão com gergelim.","R$18,90");
insert into prato values ('21912193404921',11030,1,53,"imagens/mcdonald/sanduiches_carne_bovina/quarterao_com_queijo.webp","Quarterão com Queijo","Um hambúrguer feito com pura carne bovina, envolvida por duas fatias de queijo temperado com ketchup, mostarda, cebola e picles.","R$18,90");
insert into prato values ('21912193404921',11031,1,53,"imagens/mcdonald/sanduiches_carne_bovina/cheddar_mcmelt.webp","Cheddar Mcmelt","Delicioso hambúrguer de carne bovina, queijo tipo cheddar derretido, cebola ao molho shoyu no pão escuro com gergelim.","R$18,90");
insert into prato values ('21912193404921',11032,1,53,"imagens/mcdonald/sanduiches_carne_bovina/mcnifico_bacon.webp","Mcnífico Bacon","Três saborosas fatias de bacon, cebola, hambúrguer de 120 gramas de carne bovina, queijo derretido, tomate e um trio de delícias: maionese, ketchup e mostarda.","R$21,90");
insert into prato values ('21912193404921',11033,1,53,"imagens/mcdonald/sanduiches_carne_bovina/cheeseburger.webp","Cheeseburguer","Pão quentinho, hambúrguer de carne 100% bovina, queijo, cebola, picles com ketchup e mostarda.","R$7,50");
insert into prato values ('21912193404921',11034,1,53,"imagens/mcdonald/sanduiches_carne_bovina/hamburger.webp","Hambúrger","Delicioso hambúrguer de carne bovina, cebola e picles com ketchup e mostarda no pão tostado e quentinho.","R$6,50");


/*Mc Donald's Sanduíches de Frango*/
insert into prato values ('21912193404921',11035,1,54,"imagens/mcdonald/sanduiches_frango/big_tasty_chicken_bacon.webp","Big Tasty Chicken Bacon","Frango empanado, bacon, 3 deliciosas fatias de queijo, tomate, alface crocante, cebola e o saboroso molho tasty.","R$27,50");
insert into prato values ('21912193404921',11036,1,54,"imagens/mcdonald/sanduiches_frango/clubhouse_chicken.webp","ClubHouse Chicken","Filé de frango empanado, queijo derretido, cebola caramelizada, tomate e alface fresquinhos, bacon rústico e o molho especial mais famoso do mundo num pão tipo brioche.","R$27,50");
insert into prato values ('21912193404921',11037,1,54,"imagens/mcdonald/sanduiches_frango/chicken_supreme_grill.webp","Chicken Supreme Grill ","Frango empanado e dourado com molho suave e cremoso, acompanhado de alface crocante num pão com gergelim.","R$19,90");
insert into prato values ('21912193404921',11038,1,54,"imagens/mcdonald/sanduiches_frango/chicken_supreme_crispy.webp","Chicken Supreme Crispy","Carne de frango empanado, molho delicioso, cebola crispy, tomate, alface fresquinha e queijo emental e pão integral com gergelim.","R$19,90");
insert into prato values ('21912193404921',11039,1,54,"imagens/mcdonald/sanduiches_frango/mcchicken.webp","Mcchicken","Frango empanado e dourado com molho suave e cremoso, acompanhado de alface crocante num pão com gergelim.","R$16,90");

/*Mc Donald's Acompanhamentos*/
insert into prato values ('21912193404921',11040,1,55,"imagens/mcdonald/acompanhamentos/mcfritas_grande.webp","Mcfritas Grande","Deliciosas batatas selecionadas, fritas, crocantes por fora, macias por dentro, douradas, irresistíveis, saborosas, famosas, e todos os outros adjetivos positivos que você quiser dar.","R$9,50");
insert into prato values ('21912193404921',11041,1,55,"imagens/mcdonald/acompanhamentos/mcfritas_media.png","Mcfritas Média","Deliciosas batatas selecionadas, fritas, crocantes por fora, macias por dentro, douradas, irresistíveis, saborosas, famosas, e todos os outros adjetivos positivos que você quiser dar.","R$8,50");
insert into prato values ('21912193404921',11042,1,55,"imagens/mcdonald/acompanhamentos/chicken_mcnuggets_peito_de_frango_10_unidades.webp","Chicken McNuggets peito de frango 10 unidades","Os frangos empanados mais irresistíveis do McDonald’s.","R$15,90");
insert into prato values ('21912193404921',11043,1,55,"imagens/mcdonald/acompanhamentos/chicken_mcnuggets_peito_de_frango_4_unidades.webp","Chicken McNuggets peito de frango 4 unidades","Os frangos empanados mais irresistíveis do McDonald’s.","R$9,50");
insert into prato values ('21912193404921',11044,1,55,"imagens/mcdonald/acompanhamentos/side_salad.webp","Side Salad","Levíssima salada com três tipos de folhas crocantes e tomate-caprese.","R$9,00");


/*Mc Donald's Mclanche feliz*/
insert into prato values ('21912193404921',11045,1,56,"imagens/mcdonald/mclanche_feliz/mclanche_feliz_cheeseburguer.webp","Mclanche Feliz Cheeseburguer","Você pode montar o seu McLanche Feliz cheeseburger com tomatinho ou McFritas como acompanhamento, uma refrescante bebida pequena e danoninho morango ou purê de maça.","R$17,40");
insert into prato values ('21912193404921',11046,1,56,"imagens/mcdonald/mclanche_feliz/mclanche_feliz_hamburguer.webp","McLanche Feliz Hambúrguer","Você pode montar o seu McLanche Feliz hambúrguer com tomatinho ou McFritas como acompanhamento, uma refrescante bebida pequena e danoninho morango ou purê de maça.","R$21,60");
insert into prato values ('21912193404921',11047,1,56,"imagens/mcdonald/mclanche_feliz/mclanche_feliz_chicken_mcnuggets.webp","McLanche Feliz Chicken McNuggets","Você pode montar o seu McLanche Feliz chicken McNuggets com tomatinho ou McFritas como acompanhamento, uma refrescante bebida pequena e danoninho morango ou purê de maça.","R$21,60");


/*Mc Donald's Sobremesas*/
insert into prato values ('21912193404921',11048,1,57,"imagens/mcdonald/sobremesas/mcflurry_kopenhagen_avela.webp","McFlurry Kopenhagen Avelã","Massa gelada, calda de chocolate, chocolate da Kopenhagen sabor avelã.","R$12,00");
insert into prato values ('21912193404921',11049,1,57,"imagens/mcdonald/sobremesas/mcflurry_ovomaltine_rocks.webp","McFlurry Ovomaltine Rocks","Massa gelada, calda de chocolate, Ovomaltine em pó e pedaços crocantes de Ovomaltine drageado.","R$12,00");
insert into prato values ('21912193404921',11050,1,57,"imagens/mcdonald/sobremesas/top_sundae_chocolate.webp","Top Sundae Chocolate","Uma delícia gelada de baunilha com cobertura de chocolate e uma deliciosa farofa de paçoca.","R$12,00");
insert into prato values ('21912193404921',11051,1,57,"imagens/mcdonald/sobremesas/top_sundae_caramelo.webp","Top Sundae Caramelo","Uma delícia gelada de baunilha com cobertura de caramelo e uma deliciosa farofa de paçoca.","R$12,00");
insert into prato values ('21912193404921',11052,1,57,"imagens/mcdonald/sobremesas/top_sundae_morango.webp","Top Sundae Morango","Uma delícia gelada de baunilha com cobertura de morango e uma deliciosa farofa de paçoca.","R$12,00");
insert into prato values ('21912193404921',11053,1,57,"imagens/mcdonald/sobremesas/sundae_chocolate.webp","Sundae Chocolate","Uma cremosa massa gelada de baunilha coberta com uma divina calda de chocolate.","R$6,90");
insert into prato values ('21912193404921',11054,1,57,"imagens/mcdonald/sobremesas/sundae_caramelo.webp","Sundae Caramelo","Uma cremosa massa gelada de baunilha coberta com uma divina calda de caramelo.","R$6,90");
insert into prato values ('21912193404921',11055,1,57,"imagens/mcdonald/sobremesas/sundae_morango.webp","Sundae Morango","Uma cremosa massa gelada de baunilha coberta com uma divina calda de morango.","R$6,90");
insert into prato values ('21912193404921',11056,1,57,"imagens/mcdonald/sobremesas/torta_banana.webp","Torta De Banana","Deliciosa torta de massa quentinha e crocante com recheio de banana.","R$5,50");
insert into prato values ('21912193404921',11057,1,57,"imagens/mcdonald/sobremesas/torta_maca.webp","Torta De Maçã","Deliciosa torta de massa quentinha e crocante com recheio de maçã.","R$5,50");
insert into prato values ('21912193404921',11058,1,57,"imagens/mcdonald/sobremesas/pure_maca.webp","Purê De Maçã","Delicioso Purê de Maçã 100% fruta.","R$6,50");
insert into prato values ('21912193404921',11059,1,57,"imagens/mcdonald/sobremesas/danoninho.webp","Danoninho","Agora o McLanche Feliz vem com danoninho, a deliciosa sobremesa de morango.","R$4,50");


/*Mc Donald's bebidas*/
insert into prato values ('21912193404921',11060,1,58,"imagens/mcdonald/bebidas/coca_cola_lata.webp","Coca-cola Lata","Refrigerante de Cola","R$7,90");
insert into prato values ('21912193404921',11061,1,58,"imagens/mcdonald/bebidas/fanta_guarana_lata.webp","Fanta Guaraná Lata","Refrigerante Sabor Guaraná","R$7,90");
insert into prato values ('21912193404921',11062,1,58,"imagens/mcdonald/bebidas/fanta_guarana_zero_lata.webp","Fanta Guaraná Zero Lata","Refrigerante Sabor Guaraná Zero açucar","R$7,90");
insert into prato values ('21912193404921',11063,1,58,"imagens/mcdonald/bebidas/fanta_laranja_lata.webp","Fanta Laranja Lata","Refrigerante sabor laranja","R$7,90");
insert into prato values ('21912193404921',11064,1,58,"imagens/mcdonald/bebidas/del_valle_maracuja_lata.webp","Del Valle Maracujá Lata","Néctar de fruta sabor Maracujá.","R$7,90");
insert into prato values ('21912193404921',11065,1,58,"imagens/mcdonald/bebidas/del_valle_uva_lata.webp","Del Valle Uva Lata","Néctar de fruta sabor Uva","R$7,90");


/*Recompensas Mc Donald's*/
insert into recompensas values ('21912193404921',11001,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('21912193404921',11002,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('21912193404921',11003,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('21912193404921',11004,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('21912193404921',11005,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('21912193404921',11006,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('21912193404921',11007,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('21912193404921',11008,"imagens/mcdonald/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);


/*Horario Salua*/


insert into horario_funcionamento values (1,"10:00","22:00",'12136745334526',1);
insert into horario_funcionamento values (2,"10:00","22:00",'12136745334526',1);
insert into horario_funcionamento values (3,"10:00","22:00",'12136745334526',1);
insert into horario_funcionamento values (4,"10:00","22:00",'12136745334526',1);
insert into horario_funcionamento values (5,"10:00","22:00",'12136745334526',1);
insert into horario_funcionamento values (6,"10:00","22:00",'12136745334526',1);
insert into horario_funcionamento values (7,"10:00","22:00",'12136745334526',1);



/*Tipo Prato Salua*/
insert into tipo_prato values (59,"Espetos e Grelhados ",'12136745334526');
insert into tipo_prato values (60,"Pratos Especiais",'12136745334526');
insert into tipo_prato values (61,"Beirutes",'12136745334526');
insert into tipo_prato values (62,"Esfihas Abertas",'12136745334526');
insert into tipo_prato values (63,"Esfihas Fechadas",'12136745334526');
insert into tipo_prato values (64,"Doces & Doce Sirio",'12136745334526');
insert into tipo_prato values (65,"Salgados",'12136745334526');
insert into tipo_prato values (66,"Porções",'12136745334526');
insert into tipo_prato values (67,"Especialidades Árabes e Michui",'12136745334526');
insert into tipo_prato values (68,"Saladas Árabes",'12136745334526');
insert into tipo_prato values (69," Pasta Árabes",'12136745334526');
insert into tipo_prato values (70," Pasta Árabes",'12136745334526');



/*Salua Esfihas Espetos e grelhados*/
insert into prato values ('12136745334526',12001,1,59,"imagens/salua/espetos_grelhados/baby_beef.webp","Baby Beef","Suculento bife de miolo de Alcatra com 03 acompanhamentos.","R$26,00");
insert into prato values ('12136745334526',12002,1,59,"imagens/salua/espetos_grelhados/file_frango.webp","Filé de Frango","Filé de peito de frango grelhado com 03 acompanhamentos.","R$23,00");
insert into prato values ('12136745334526',12003,1,59,"imagens/salua/espetos_grelhados/calabresa.webp","Calabresa","Calabresa grelhada c/ 03 acompanhamentos.","R$20,00");
insert into prato values ('12136745334526',12004,1,59,"imagens/salua/espetos_grelhados/espeto_mignon_suino.webp","Espeto Mignon Suino","Espeto de filet mignon suino com 03 acompanhamentos.","R$20,00");
insert into prato values ('12136745334526',12005,1,59,"imagens/salua/espetos_grelhados/espeto_misto.webp","Espeto Misto","Espeto de carne, frango e calabresa grelhados com 03 acompanhamentos.","R$26,00");
insert into prato values ('12136745334526',12006,1,59,"imagens/salua/espetos_grelhados/espeto_mignon.webp","Espeto de Mignon","Espeto de filet mignon grelhado com 03 acompanhamentos.","R$33,00");


/*Salua Esfihas Pratos Especiais*/
insert into prato values ('12136745334526',12007,1,60,"imagens/salua/pratos_especiais/lasanha_sirio.webp","Lasanha De Pão Sírio","Deliciosa lasanha de pão sirio recheada com presunto, queijo, carne e bacon. coberta com molho de tomate e gratinada ao forno. Acompanha batata frita.","R$23,00");
insert into prato values ('12136745334526',12008,1,60,"imagens/salua/pratos_especiais/panqueca_frango.webp","Panqueca De Frango C/ Requeijão","Deliciosa panqueca de pão sirio recheada com frango e requeijão. Coberta com molho de tomate e gratinada ao forno. Acompanha batata frita.","R$23,00");
insert into prato values ('12136745334526',12009,1,60,"imagens/salua/pratos_especiais/panqueca_carne.webp","Panqueca De Carne","Deliciosa panqueca de pão sirio recheada com carne, azeitona e ovos cozidos. Coberta com molho de tomate e gratinada ao forno. Acompanha batata frita.","R$23,00");
insert into prato values ('12136745334526',12010,1,60,"imagens/salua/pratos_especiais/escondidinho_frango.webp","Escondidinho De Frango","Delicioso escondidinho de batata recheado com frango e requeijão. Gratinado ao forno. Acompanha arroz branco.","R$23,00");

/*Salua Beirutes*/
insert into prato values ('12136745334526',12011,1,61,"imagens/salua/beirutes/beirute_calabresa.webp","Beirute De Calabresa","Calabresa fatiada, queijo, alface, tomate, molho especial, e batatas fritas.","R$30,00");
insert into prato values ('12136745334526',12012,1,61,"imagens/salua/beirutes/beirute_galinha.webp","Beirute De Galinha Cremosa","Frango desfiado refogado com molho de tomate e requeijão cremos, ovo cozido, alface e batata frita.","R$26,00");
insert into prato values ('12136745334526',12013,1,61,"imagens/salua/beirutes/beirute_churrasco.webp","Beirute De Churrasco","Contra filé grelhado, queijo, alface, molho vinagrete e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12014,1,61,"imagens/salua/beirutes/beirute_file_frango.webp","Beirute De Filé De Frango","Filet de frango queijo alface tomate molho especial e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12015,1,61,"imagens/salua/beirutes/beirute_filet_mignon.webp","Beirute De Filet Mignon","Filet mignon queijo alface tomate molho especial e batatas fritas.","R$43,00");
insert into prato values ('12136745334526',12016,1,61,"imagens/salua/beirutes/beirute_frango_milho.webp","Beirute De Frango Com Milho E Requeijão","Frango cozido e desfiado com milho requeijão cremoso alface tomate e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12017,1,61,"imagens/salua/beirutes/beirute_frango_bacon.webp","Beirute De Frango & Bacon","Frango desfiado, queijo, bacon frito, alface, maionese e batatas fritas.","R$35,00");
insert into prato values ('12136745334526',12018,1,61,"imagens/salua/beirutes/beirute_presunto_queijo.webp","Beirute De Presunto E Queijo","Presunto queijo alface tomate molho especial e batatas fritas.","R$31,00");
insert into prato values ('12136745334526',12019,1,61,"imagens/salua/beirutes/beirute_roastbeef.webp","Beirute De Roastbeef","Carne assada fatiada presunto queijo alface tomate molho especial e batatas fritas.","R$40,00");
insert into prato values ('12136745334526',12020,1,61,"imagens/salua/beirutes/beirute_salua.webp","Beirute De Roastbeef Saluá","Carne assada fatiada mussarela de búfala tomate seco rúcula molho especial e batatas fritas.","R$42,00");
insert into prato values ('12136745334526',12021,1,61,"imagens/salua/beirutes/beirute_ceasar.webp","Beirute Ceasar","Tirinhas de Frango grelhado, mussarela de búfala, alface, tomate seco e molho especial.","R$25,00");
insert into prato values ('12136745334526',12022,1,61,"imagens/salua/beirutes/beirute_ligth.webp","Beirute Ligth","Frango desfiado cenoura ralada maionese alface e tomate.","R$28,00");
insert into prato values ('12136745334526',12023,1,61,"imagens/salua/beirutes/beirute_vegetariano.webp","Beirute Vegetariano","Mussarela de búfala, berinjela assada e tomate seco ao forno.","R$33,00");

/*Salua Esfihas Abertas*/
insert into prato values ('12136745334526',12024,1,62,"imagens/salua/esfihas_salgadas/alho.webp","Esfiha De Alho","Queijo tipo mussarela derretido com flocos de alho crocante por cima.","R$12,00");
insert into prato values ('12136745334526',12025,1,62,"imagens/salua/esfihas_salgadas/bacon.webp","Esfiha De Bacon","Queijo tipo mussarela derretido com cubinhos de bacon frito por cima.","R$12,00");
insert into prato values ('12136745334526',12026,1,62,"imagens/salua/esfihas_salgadas/beringela.webp","Esfiha De Beringela com mussarela de búfala","Berinjela em cubinhos assada com pimentão e cebola, coberta com mussarela de búfala derretida.","R$14,00");
insert into prato values ('12136745334526',12027,1,62,"imagens/salua/esfihas_salgadas/brasileira.webp","Esfiha Brasileira","Carne seca desfiada e refogada com cebola e salsa, coberta com mussarela e azeitonas pretas.","R$15,00");
insert into prato values ('12136745334526',12028,1,62,"imagens/salua/esfihas_salgadas/brocolis.webp","Esfiha De Brócolis","Brócolis ninja cozido coberto com flocos de alho crocante e mussarela derretida.","R$13,00");
insert into prato values ('12136745334526',12029,1,62,"imagens/salua/esfihas_salgadas/calabresa.webp","Esfiha De Calabresa","Esfiha aberta de calabresa moída.","R$10,00");
insert into prato values ('12136745334526',12030,1,62,"imagens/salua/esfihas_salgadas/calabresa_cheddar.webp","Esfiha De Calabresa Com Cheddar","Esfiha aberta de calabresa moída coberta com cheddar cremoso.","R$14,00");
insert into prato values ('12136745334526',12031,1,62,"imagens/salua/esfihas_salgadas/calabresa_queijo.webp","Esfiha De Calabresa Com Queijo","Esfiha de calabresa moída coberta com mussarela derretida.","R$13,00");
insert into prato values ('12136745334526',12032,1,62,"imagens/salua/esfihas_salgadas/calabresa_catupiry.webp","Esfiha De Calabresa Com Requeijão","Esfiha de calabresa moída coberta com requeijão cremoso.","R$13,00");
insert into prato values ('12136745334526',12033,1,62,"imagens/salua/esfihas_salgadas/carne.webp","Esfiha De Carne","Tradicional esfiha aberta de carne moída temperada com tomate cebola e condimentos sírios.","R$10,00");
insert into prato values ('12136745334526',12034,1,62,"imagens/salua/esfihas_salgadas/carne_cheddar.webp","Esfiha De Carne Com Cheddar","Esfiha aberta de carne com cheddar cremoso.","R$14,00");
insert into prato values ('12136745334526',12035,1,62,"imagens/salua/esfihas_salgadas/carne_seca.webp","Esfiha De Carne Seca Com Requeijão","Esfiha de carne seca desfiada e refogada com cebola e salsa coberta com requeijão cremoso.","R$15,00");
insert into prato values ('12136745334526',12036,1,62,"imagens/salua/esfihas_salgadas/dois_queijos.webp","Esfiha De Dois Queijos","Queijo tipo mussarela derretido coberta com requeijão cremoso.","R$13,00");
insert into prato values ('12136745334526',12037,1,62,"imagens/salua/esfihas_salgadas/frango_catupiry.webp","Esfiha De Frango Com Requeijão","Peito de frango cozido e desfiado refogado com cebola e salsa coberto com requeijão cremoso.","R$13,00");
insert into prato values ('12136745334526',12038,1,62,"imagens/salua/esfihas_salgadas/frango_milho.webp","Esfiha De Frango Com Milho E Requeijão","Peito de frango cozido e desfiado refogado com cebola e salsa e coberto com requeijão cremoso e milho.","R$14,00");
insert into prato values ('12136745334526',12039,1,62,"imagens/salua/esfihas_salgadas/marguerita.webp","Esfiha De Marguerita","Mussarela derretida, manjericão fresco, tomate cereja e parmesão gratinado.","R$13,00");
insert into prato values ('12136745334526',12040,1,62,"imagens/salua/esfihas_salgadas/jardineira.webp","Esfiha De Jardineira","Brócolis cozido, palmito em rodelas, cobertos com mussarela, tomate cereja e parmesão gratinado.","R$15,00");
insert into prato values ('12136745334526',12041,1,62,"imagens/salua/esfihas_salgadas/pepperoni.webp","Esfiha De Peperoni","Fatias de peperoni com cebola e azeitona cobertas com mussarela derretida.","R$15,00");
insert into prato values ('12136745334526',12042,1,62,"imagens/salua/esfihas_salgadas/palmito.webp","Esfiha De Palmito","Fatias de palmito de pupunha cobertos com mussarella derretida e orégano.","R$15,00");
insert into prato values ('12136745334526',12043,1,62,"imagens/salua/esfihas_salgadas/pizza.webp","Esfiha De Pizza","Presunto moído coberto com mussarela derretida tomate e orégano.","R$12,00");
insert into prato values ('12136745334526',12044,1,62,"imagens/salua/esfihas_salgadas/queijo.webp","Esfiha De Queijo","Queijo tipo mussarela derretido.","R$11,00");
insert into prato values ('12136745334526',12045,1,62,"imagens/salua/esfihas_salgadas/portuguesa.webp","Esfiha Portuguesa","Calabresa e presunto moídos mussarela cebola ervilha e ovos cozidos.","R$14,00");
insert into prato values ('12136745334526',12046,1,62,"imagens/salua/esfihas_salgadas/quatro_queijo.webp","Esfiha De Quatro Queijos","Queijo tipo mussarela com fatias de provolone coberto com requeijão cremoso e parmesão gratinado.","R$15,00");
insert into prato values ('12136745334526',12047,1,62,"imagens/salua/esfihas_salgadas/salua.webp","Esfiha Saluá","Mussarela de búfala derretida com tomate seco.","R$14,00");
insert into prato values ('12136745334526',12048,1,62,"imagens/salua/esfihas_salgadas/queijo_branco","Esfiha De Queijo Branco","Queijo branco fresco com uma pitada de orégano.","R$11,00");


/*Salua Esfihas Fechadas*/
insert into prato values ('12136745334526',12049,1,63,"imagens/salua/esfihas_fechadas/calabresa.webp","Esfiha Fechada De Calabresa Com Requeijão","Calabresa moída com requeijão cremoso.","R$12,00");            
insert into prato values ('12136745334526',12050,1,63,"imagens/salua/esfihas_fechadas/carne.webp","Esfiha Fechada De Carne","Carne moída assada com tomate e cebola picadinha.","R$12,00");
insert into prato values ('12136745334526',12051,1,63,"imagens/salua/esfihas_fechadas/frango.webp","Esfiha Fechada De Frango Com Requeijão","Peito de frango cozido e desfiado com requeijão cremoso.","R$12,00");
insert into prato values ('12136745334526',12052,1,63,"imagens/salua/esfihas_fechadas/pizza.webp","Esfiha Fechada De Pizza","Presunto moído mussarela derretida tomate e orégano","R$12,00");

/*Salua Esfihas Doces & Doce Sirio*/
insert into prato values ('12136745334526',12053,1,64,"imagens/salua/esfihas_doces_sirio/chocolate.webp","Esfiha De Chocolate","Chocolate derretido coberto com granulado e cobertura de chocolate.","R$13,00");
insert into prato values ('12136745334526',12054,1,64,"imagens/salua/esfihas_doces_sirio/chocolate_mm.jpeg","Esfiha De M&Ms","Chocolate derretido e coberto com confeitos de chocolate m&m's e cobertura de chocolate.","R$17,00"); 
insert into prato values ('12136745334526',12055,1,64,"imagens/salua/esfihas_doces_sirio/sonho.webp","Esfiha De Sonho De Valsa","Chocolate derretido e coberto com pedacinhos de bombom sonho de valsa e cobertura de chocolate.","R$16,00"); 
insert into prato values ('12136745334526',12056,1,64,"imagens/salua/esfihas_doces_sirio/doce_de_leite.webp","Esfiha De Doce De Leite Com Mini Churros - 6 Unidades","6 unidades de mini churros de doce de leite, acompanhados de uma esfiha de doce de leite, e salpicados com açúcar e canela.","R$17,00"); 
insert into prato values ('12136745334526',12057,1,64,"imagens/salua/esfihas_doces_sirio/doce.webp","Doce Sírio","Burma, faissali, folhados de castanha, bolinho de semolina e ninhos de nozes, pistache e geleia de damasco.","R$8,00"); 
           
/*Salua Salgados*/
insert into prato values ('12136745334526',12058,1,65,"imagens/salua/salgados/kibe.webp","Kibe Carne","Salgado feito de carne moída","R$10,00");
insert into prato values ('12136745334526',12059,1,65,"imagens/salua/salgados/kibe.webp","Kibe De Carne Com Requeijão","Salgado feito de carne moída e requeijão","R$10,00"); 

/*Salua Porções*/
insert into prato values ('12136745334526',12060,1,66,"imagens/salua/porcoes/esfiha.webp","Mini Esfiha - 12 Unidades","Carne, queijo ou calabresa.","R$30,00"); 
insert into prato values ('12136745334526',12061,1,66,"imagens/salua/porcoes/mini_kibe.webp","Mini Kibe - 12 unidades","Acompanham coalhada seca.","R$30,00"); 
insert into prato values ('12136745334526',12062,1,66,"imagens/salua/porcoes/frita.webp","Batata Frita - 250g","Batata frita crocante. Individual.","R$9,00"); 

/*Salua Especialidades árabes e michui*/
insert into prato values ('12136745334526',12063,1,67,"imagens/salua/especialidades/kafta.jpg","Kafta No Espeto","2 espetinhos de carne moída grelhados e temperados com condimentos sírios.","R$42,00"); 
insert into prato values ('12136745334526',12064,1,67,"imagens/salua/especialidades/kibe_cru.webp","Kibe Cru","Kibe de carne moída crua temperada com trigo azeite e condimentos sírios.","R$42,00"); 
insert into prato values ('12136745334526',12065,1,67,"imagens/salua/especialidades/mignon.webp","Espeto Michui De Filet Mignon","Michui filet mignom.","R$43,00"); 
insert into prato values ('12136745334526',12066,1,67,"imagens/salua/especialidades/misto.webp","Espeto Michui Misto","Cubinhos de carne, peito de frango e calabresa intercalados com cebola e pimentão grelhados.","R$40,00"); 

/*Salua Saladas arabes*/
insert into prato values ('12136745334526',12067,1,68,"imagens/salua/saladas/ceasar.webp","Salada Saluá Ceasar","Alface, americana, mussarela de búfala moída, tomate seco, torradinhas de pão sírio e molho especial Acompanha pão sírio.","R$24,00"); 
insert into prato values ('12136745334526',12068,1,68,"imagens/salua/saladas/tabule.webp","Tabule","Pepino, tomate, cebola, alface, hortelã, salsa e trigo. Acompanha pão sírio.","R$18,00"); 


/*Salua pasta arabes*/
insert into prato values ('12136745334526',12069,1,69,"imagens/salua/pasta/babaganuj.webp","Babaganuj","Pasta de berinjela temperada com azeite limão, alho, tahine e condimentos árabes. Acompanha pão sírio.","R$23,00"); 
insert into prato values ('12136745334526',12070,1,69,"","Coalhada Seca","Coalhada de leite sem soro temperada com azeite limão, alho, tahine e condimentos árabes. Acompanha pão sírio.","R$27,00"); 
insert into prato values ('12136745334526',12071,1,69,"imagens/salua/pasta/homus.webp","Homus","Pasta de grão de bico temperada com azeite, limão, tahine e condimentos árabes. Acompanha pão sírio.","R$23,00"); 

/*Salua Bebidas*/
insert into prato values ('12136745334526',12072,1,70,"","Água Mineral","Água mineral 500ml s/gás.","R$6,00"); 
insert into prato values ('12136745334526',12073,1,70,"","Aquarius Fresh Limão","Refrigerante de limão 500ml.","R$8,00");
insert into prato values ('12136745334526',12074,1,70,"","Cerveja Heineken","Cerveja lata heineken 350ml.","R$10,00");
insert into prato values ('12136745334526',12075,1,70,"","Del Valle","Suco Del Valle 290ml saobres:manga, maracujá, pêssego, uva e uva light.","R$23,00");
insert into prato values ('12136745334526',12076,1,70,"","Água tÔnica","Água tonificada lata 350ml.","R$8,00");
insert into prato values ('12136745334526',12077,1,70,"","Schweppes Citrus","Refrigerante citrus 350ml.","R$8,00");
insert into prato values ('12136745334526',12078,1,70,"","Refrigerante Lata 350 ml","Refrigerante lata:Coca-cola e Fanta Guaraná.","R$7,00");
insert into prato values ('12136745334526',12079,1,70,"","Chá Nestea","Chá Nestea 340ml sabor:limão.","R$8,00");



/*Recompensas Salua*/
insert into recompensas values ('12136745334526',12001,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('12136745334526',12002,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('12136745334526',12003,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('12136745334526',12004,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('12136745334526',12005,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('12136745334526',12006,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('12136745334526',12007,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('12136745334526',12008,"imagens/Salua/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*Horario Nagazaki*/ /*abre duas vezes*/


insert into horario_funcionamento values (1,"10:00","22:00",'69545560300155',1);
insert into horario_funcionamento values (2,"10:00","22:00",'69545560300155',1);
insert into horario_funcionamento values (3,"10:00","22:00",'69545560300155',1);
insert into horario_funcionamento values (4,"10:00","22:00",'69545560300155',1);
insert into horario_funcionamento values (5,"10:00","22:00",'69545560300155',1);
insert into horario_funcionamento values (6,"10:00","22:00",'69545560300155',1);
insert into horario_funcionamento values (7,"10:00","22:00",'69545560300155',1);



/*Tipo Prato Nagasaki Ya*/
insert into tipo_prato values (71,"Entradas",'69545560300155');



/*Nagasaki Ya entradas*/
insert into prato values ('69545560300155',13001,1,71,"imagens/nagasaki_ya/entradas/missoshiru.webp","Missoshiru","Sopa de pasta de soja com tofu e cebolinha","R$8,00");
insert into prato values ('69545560300155',13002,1,71,"imagens/nagasaki_ya/entradas/hot_especial_1.webp","Hot especial 1 (10 unidades )","Hossomaki de patê de salmão empanado coberto com creamcheese e cubo de salmão cru e tarê.","R$25,00");
insert into prato values ('69545560300155',13003,1,71,"imagens/nagasaki_ya/entradas/hot_especial_2.webp","Hot especial 2 ( 10 unidades)","Hossomaki de patê de salmão empanado, coberto com creamcheese , couve crispy e tarê.","R$22,00");
insert into prato values ('69545560300155',13004,1,71,"imagens/nagasaki_ya/entradas/sumono_simples_com_gergelim.webp","Sunomono simples com gergelim","Pepino fatiado agridoce em conserva copo 360 ml","R$15,00");
insert into prato values ('69545560300155',13005,1,71,"imagens/nagasaki_ya/entradas/batata_file_mussarela.webp","Robata de file com mussarela","1 espetinho com 4 pedaços, com tare.","R$12,00");
insert into prato values ('69545560300155',13006,1,71,"imagens/nagasaki_ya/entradas/mini_harumaki_de_queijo.webp","Mini harumaki de queijo","3 unidades","R$10,00");
insert into prato values ('69545560300155',13007,1,71,"imagens/nagasaki_ya/entradas/gyoza_lombo_legume.webp","Gyoza de lombo e legumes","6 unidades","R$30,00");
insert into prato values ('69545560300155',13008,1,71,"imagens/nagasaki_ya/entradas/gyoza_vegetariano.webp","Gyoza vegetariano","6 unidades","R$25,00");
insert into prato values ('69545560300155',13009,1,71,"imagens/nagasaki_ya/entradas/shimeji_no_azeite.webp","Shimeji no azeite","Shimeji no azeite com shoyu copo 360 ml","R$26,00");


/*Recompensas Nagasaki Ya*/
insert into recompensas values ('69545560300155',13001,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 5% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",100);
insert into recompensas values ('69545560300155',13002,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$10,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",10);
insert into recompensas values ('69545560300155',13003,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: Filé A Parmegiana Com Penne","Utilize esse cupom para garantir desconto na sua proxima refeição",389);
insert into recompensas values ('69545560300155',13004,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('69545560300155',13005,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('69545560300155',13006,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: 20% de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2000);
insert into recompensas values ('69545560300155',13007,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$100,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",1000);
insert into recompensas values ('69545560300155',13008,"imagens/nagasaki_ya/promocoes_ponto/temaki_salmao_com_shimeji.webp","Cupom: R$250,00 de Desconto","Utilize esse cupom para garantir desconto na sua proxima refeição",2500);



/*Horario Kanashiro*/


insert into horario_funcionamento values (1,"10:00","22:00",'98445038000191',1);/*Fechado aos domingos*/
insert into horario_funcionamento values (2,"19:00","23:30",'98445038000191',1);
insert into horario_funcionamento values (3,"19:00","23:30",'98445038000191',1);
insert into horario_funcionamento values (4,"19:00","23:30",'98445038000191',1);
insert into horario_funcionamento values (5,"19:00","23:30",'98445038000191',1);
insert into horario_funcionamento values (6,"19:00","23:30",'98445038000191',1);
insert into horario_funcionamento values (7,"19:00","23:30",'98445038000191',1);


/*Tipo Prato kanashiro*/
insert into tipo_prato values (72,"Entradas",'98445038000191');


/*kanashiro entradas*/
insert into prato values ('98445038000191',14001,1,72,"imagens/kanashiro/entradas/tofu_temperado.webp","Tofu Temperado","Tofu, óleo de gergelim, katsuobushi, gengibre ralado, cebolete e tagarashi.","R$15,00");
insert into prato values ('98445038000191',14002,1,72,"imagens/kanashiro/entradas/sumono_rabanete.webp","Sunomono de rabanete","Fatias fininhas de rabanete temoerado.","R$15,00");
insert into prato values ('98445038000191',14003,1,72,"imagens/kanashiro/entradas/raiz_lotus.jpeg","Raiz de lótus","Crocante e sequinho","R$15,00");
insert into prato values ('98445038000191',14004,1,72,"imagens/kanashiro/entradas/edamane.webp","Edamane","Soja verde com flor de sal","R$18,00");
insert into prato values ('98445038000191',14005,1,72,"imagens/kanashiro/entradas/guioza.webp","Guioza","3 unidades","R$25,00");
insert into prato values ('98445038000191',14006,1,72,"imagens/kanashiro/entradas/polvo_empanado.webp","Polvo empanado","crocante por fora e macio por dentro","R$25,00");
insert into prato values ('98445038000191',14007,1,72,"imagens/kanashiro/entradas/shimeji.webp","Shimeji","Shimeji temperado","R$30,00");
insert into prato values ('98445038000191',14008,1,72,"imagens/kanashiro/entradas/kimpira_gobo.webp","Kimpira gobô","Raiz de bardana temperado","R$15,00");





/*Horario Santa Arena*/ 
insert into horario_funcionamento values (1,"10:00","22:00",'70348766554387',1);
insert into horario_funcionamento values (2,"19:00","23:30",'70348766554387',1);
insert into horario_funcionamento values (3,"19:00","23:30",'70348766554387',1);
insert into horario_funcionamento values (4,"19:00","23:30",'70348766554387',1);
insert into horario_funcionamento values (5,"19:00","23:30",'70348766554387',1);
insert into horario_funcionamento values (6,"19:00","23:30",'70348766554387',1);
insert into horario_funcionamento values (7,"19:00","23:30",'70348766554387',1);


/*Tipo Prato Santa Arena*/
insert into tipo_prato values (73,"Entradas",'70348766554387');




/*Santa Arena entradas*/
insert into prato values ('70348766554387',15001,1,73,"imagens/okey-dokey/starters/nacho_supremo.webp","Nacho Supremo","Nachos com cobertura de chilli com carne, machacas (carne desfiada) ou frango desfiado, cheddar cremoso, azeitona preta, guacamole, sour cream e pico de gallo","R$43,90");
insert into prato values ('70348766554387',15002,1,73,"imagens/okey-dokey/starters/tex_mex_nacho.webp","Tex-mex nacho","Nachos com cobertura de chilli com carne e cheddar cremoso.","R$39,90");
insert into prato values ('70348766554387',15003,1,73,"imagens/okey-dokey/starters/nacho_libre.webp","Nacho Libre","Nachos crocantes com acompanhamento separado de molhos guacamole, sour cream e pico de gallo","R$36,90");
insert into prato values ('70348766554387',15004,1,73,"imagens/okey-dokey/starters/chicken_fingers.webp","Chicken fingers - isca de frango estilo americano","Riquíssimo sassami de frango a milanesa. acompanham ranch dressing dip e barbecue sauce","R$39,90");
insert into prato values ('70348766554387',15005,1,73,"imagens/okey-dokey/starters/bufalo_wings.webp","Bufalo wings - alitas picosas","Deliciosas asas de frango fritas banhadas em molho picante okey-dokey. acompanha ranch dressing dip","R$39,90");



/*Horario Cantina di lucca*/ /*abre duas vezes*/


insert into horario_funcionamento values (1,"10:00","22:00",'26549325558956',1);
insert into horario_funcionamento values (2,"19:00","23:30",'26549325558956',1);
insert into horario_funcionamento values (3,"19:00","23:30",'26549325558956',1);
insert into horario_funcionamento values (4,"19:00","23:30",'26549325558956',1);
insert into horario_funcionamento values (5,"19:00","23:30",'26549325558956',1);
insert into horario_funcionamento values (6,"19:00","23:30",'26549325558956',1);
insert into horario_funcionamento values (7,"19:00","23:30",'26549325558956',1);



/*Tipo Prato Cantina di lucca*/
insert into tipo_prato values (74,"Entradas",'26549325558956');



/*cantina di lucca entradas*/
insert into prato values ('26549325558956',16001,1,74,"imagens/cantina_di_lucca/pratos/brusquetta.webp","Brusquetta","Torrada coberta com queijo, tomates e salsa","R$27,00");
insert into prato values ('26549325558956',16002,1,74,"imagens/cantina_di_lucca/pratos/talharim.webp","Talharim com Calabresa","Talharim com molho sugo e calabresa picada","R$82,00");
insert into prato values ('26549325558956',16003,1,74,"imagens/cantina_di_lucca/pratos/supremo_frango_com_creme_de_mihlo.webp","Supremo de frango com creme de milho","Filet de peito de frango, grelhado ou milanesa, com creme de milho e arroz","R$77,00");
insert into prato values ('26549325558956',16004,1,74,"imagens/cantina_di_lucca/pratos/perna_de_cabrito.jpg","Perna de cabrito","Pernil de cabrito assado com ervas, acompanha batatas coradas, brócolis ao alho e óleo e arroz branco","R$181,00");
insert into prato values ('26549325558956',16005,1,74,"imagens/cantina_di_lucca/pratos/payard_com_talharim.webp","Payard com talharim aos 4 formagi","Filet mignon tipo escalope ao molho roti com parmesão ralado grosso acompanha talharim com molho 4 formagi (4 queijos)","R$165,00");



/*Horario spoleto*/


insert into horario_funcionamento values (1,"10:00","23:30",'23248325558205',1);
insert into horario_funcionamento values (2,"10:00","23:30",'23248325558205',1);
insert into horario_funcionamento values (3,"10:00","23:30",'23248325558205',1);
insert into horario_funcionamento values (4,"10:00","23:30",'23248325558205',1);
insert into horario_funcionamento values (5,"10:00","23:30",'23248325558205',1);
insert into horario_funcionamento values (6,"10:00","23:30",'23248325558205',1);
insert into horario_funcionamento values (7,"10:00","23:30",'23248325558205',1);

/*Tipo Prato Spoleto*/
insert into tipo_prato values (75,"Entradas",'23248325558205');



/*spoleto entradas*/
insert into prato values ('23248325558205',17001,1,75,"imagens/spoleto/massas/ravioli_frango.webp","Ravioli de frango","200g Ravioli recheado de frango + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17002,1,75,"imagens/spoleto/massas/ravioli_queijo_presunto.webp","Ravioli Queico e Presunto","200g ravioli recheado de queijo e presunto + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17003,1,75,"imagens/spoleto/massas/ravioli_carne.webp","Ravioli de Carne","200g Ravioli recheado de carne + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17004,1,75,"imagens/spoleto/massas/ravioli_ricota.webp","Ravioli de Ricota","200g Ravioli recheado de ricota + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");
insert into prato values ('23248325558205',17005,1,75,"imagens/spoleto/massas/ravioli_gorgonzola.webp","Raviole de Gorgonzola","200g Ravioli recheado de gorgonzola + 2 conchas de molho a escolher + 8 ingredientes a escolher","R$29,90");

/*Horario Cozinha do Roma*/


insert into horario_funcionamento values (1,"10:30","15:30",'50996645258098',1); /*fechado no domingo*/
insert into horario_funcionamento values (2,"10:30","15:30",'50996645258098',1);
insert into horario_funcionamento values (3,"10:30","15:30",'50996645258098',1);
insert into horario_funcionamento values (4,"10:30","15:30",'50996645258098',1);
insert into horario_funcionamento values (5,"10:30","15:30",'50996645258098',1);
insert into horario_funcionamento values (6,"10:30","15:30",'50996645258098',1);
insert into horario_funcionamento values (7,"10:30","15:30",'50996645258098',1);


/*Tipo Prato Cozinha do Roma*/
insert into tipo_prato values (76,"Entradas",'50996645258098');



/*Cozinha do Roma entradas*/
insert into prato values ('50996645258098',18001,1,76,"imagens/cozinha_do_roma/marmita/bife_cavala.webp","Bife a Cavala","Arroz,feijão,fritas,ovo e salada","R$16,00");
insert into prato values ('50996645258098',18002,1,76,"imagens/cozinha_do_roma/marmita/parmegiana_carne.webp","A Parmegiana de Carne","Acompanhamentos: arroz ,batata frita ou souté , farofa e salada","R$20,00");
insert into prato values ('50996645258098',18003,1,76,"imagens/cozinha_do_roma/marmita/parmegiana_frango.webp","A Parmegiana de Frango","Acompanhamentos : arroz batata frita ou batata souté farofa e salada","R$18,00");
insert into prato values ('50996645258098',18004,1,76,"imagens/cozinha_do_roma/marmita/salada_fitnes.webp","Salada fitnes top 10 (10 itens)","Composta por 10 itens :alface, cenoura, tomate,ovo de codorna, agrião, cebola ,beterraba , azeitona, brócolis, milho ,batata doce e pepino.mais 1 proteína a sua escolha (frango ou bife grelhado no azeite )","R$20,00");
insert into prato values ('50996645258098',18005,1,76,"imagens/cozinha_do_roma/marmita/omelete_gourmet.webp","Omelete Gourmet","Arroz-feijão-fritas-salada _ opcional:(recheado com mussarela ,Catupiry ou cheddar)","R$16,00");

/*Horario Seven kings*/


insert into horario_funcionamento values (1,"13:00","21:00",'32789896969632',1);
insert into horario_funcionamento values (2,"10:30","15:30",'32789896969632',1); /*fechado na segunda*/
insert into horario_funcionamento values (3,"12:00","22:00",'32789896969632',1);
insert into horario_funcionamento values (4,"12:00","22:00",'32789896969632',1);
insert into horario_funcionamento values (5,"12:00","22:00",'32789896969632',1);
insert into horario_funcionamento values (6,"12:00","00:00",'32789896969632',1);
insert into horario_funcionamento values (7,"13:00","00:00",'32789896969632',1);



/*Tipo Prato Seven Kings*/
insert into tipo_prato values (77,"Os Reis",'32789896969632');
insert into tipo_prato values (78,"Os Pebleus",'32789896969632');
insert into tipo_prato values (79,"Refeição Real",'32789896969632');
insert into tipo_prato values (80,"Escudeiros",'32789896969632');
insert into tipo_prato values (81,"Escudeiros Veggie",'32789896969632');
insert into tipo_prato values (82,"Bebidas",'32789896969632');
insert into tipo_prato values (83,"Sobremesas",'32789896969632');



/*Seven Kings Os reis*/
insert into prato values ('32789896969632',19001,1,77,"imagens/seven_kings/reis/olaf.webp","Rei Olaf Vermundsson","Pão, hambúrguer de 180g, creme de provolone, bacon e pimenta jalapeño.","R$35,07");
insert into prato values ('32789896969632',19002,1,77,"imagens/seven_kings/reis/ragnar.webp","Rei Ragnar Lothbrok","Pão, hambúrguer de 180g, cream cheese, geleia de pimenta e bacon.","R$35,07");
insert into prato values ('32789896969632',19003,1,77,"imagens/seven_kings/reis/bruce.webp","Rei Robert De Bruce","Pão, hambúrguer de 180g, queijo cheddar e cebola caramelizada no molho bbq com whisky.","R$35,07");
insert into prato values ('32789896969632',19004,1,77,"imagens/seven_kings/reis/arthur.webp","Rei Arthur Pendragon","Pão, hambúrguer de 180g, creme de gorgonzola, farofa de bacon e rúcula.","R$35,07");
insert into prato values ('32789896969632',19005,1,77,"imagens/seven_kings/reis/jimmu.webp","Rei Jimmu","Pão, hambúrguer de 180g, queijo cheddar, cebola e shimeji caramelizada no shoyo.","R$35,07");
insert into prato values ('32789896969632',19006,1,77,"imagens/seven_kings/reis/ludwig.webp","Rei Ludwig Da Baviera","Pão, dois smashed burger, cheddar, bacon, maionese de bacon, pimentas jalapêno e barbecue.","R$40,07");



/*Seven Kings Os Pebleus*/
insert into prato values ('32789896969632',19007,1,78,"imagens/seven_kings/pebleus/cheese.webp","Cheese Burger 90gr","Pão, hambúrguer de 90g, maionese artesanal e queijo prato (ou cheddar).","R$18,07");
insert into prato values ('32789896969632',19008,1,78,"imagens/seven_kings/pebleus/hamburguer.webp","Hambúrguer","Pão, hambúrguer de 180g e maionese artesanal.","R$20,07");
insert into prato values ('32789896969632',19009,1,78,"imagens/seven_kings/pebleus/cheese.webp","Cheese Burger","Pão, hambúrguer de 180g, maionese artesanal e queijo prato (ou cheddar).","R$23,07");
insert into prato values ('32789896969632',19010,1,78,"imagens/seven_kings/pebleus/bacon.webp","Cheese Bacon","Pão, carne de 180g, queijo prato (ou cheddar), maionese artesanal e bacon.","R$27,07");
insert into prato values ('32789896969632',19011,1,78,"imagens/seven_kings/pebleus/salada.webp","Cheese Salada","Pão, carne de 180g, queijo prato (ou cheddar), maionese artesanal, alface lisa, tomate e cebola roxa.","R$27,07");

/*Seven Kings Refeição Real*/
insert into prato values ('32789896969632',19012,1,79,"imagens/seven_kings/refeicao/real.webp","Combo Real","Monte um combo com seu rei favorito com um mega desconto!","R$47,07");
insert into prato values ('32789896969632',19013,1,79,"imagens/seven_kings/refeicao/combo.webp","Combo cheese bacon","Cheese bacon + batata chips + refrigerante","R$37,07");

/*Seven Kings Escudeiros*/
insert into prato values ('32789896969632',19014,1,80,"","Porção De Candy Bacon","4 Fatias de bacon caramelizado.","R$16,07");
insert into prato values ('32789896969632',19015,1,80,"imagens/seven_kings/escudeiro/onion.webp","Onion Rings","Porção individual de anéis de cebola empanados feitos na casa.","R$20,07");
insert into prato values ('32789896969632',19016,1,80,"","Porção de Batata Chips","Batata Chips feitas na casa","R$15,07");
insert into prato values ('32789896969632',19017,1,80,"imagens/seven_kings/escudeiro/bitter.webp","Bitterballen","Porção de 6 unidades de bolinhos de carne empanados e fritos, acompanhados de geleia de pimenta da casa.","R$22,07");

/*Seven Kings Escudeiros veggie*/
insert into prato values ('32789896969632',19018,1,81,"","Bolinho De Shimeji","Bolinho veggie com massa de coxinha e recheado de shimeji salteado.","R$22,07");
insert into prato values ('32789896969632',19019,1,81,"","Falafel","Bolinho de grão de bico ao estilo arabe.","R$22,07");

/*Seven Kings Bebidas*/
insert into prato values ('32789896969632',19020,1,82,"","Água 500ml","S/gás ou C/gás","R$6,07");
insert into prato values ('32789896969632',19021,1,82,"","Refrigerante lata 350ml","Sabores:Fanta uva,Schweppes citrus,Sprite,Fanta Guaraná,Coca cola zero e Coca cola","R$7,07");
insert into prato values ('32789896969632',19022,1,82,"","Sol","350ml","R$9,07");
insert into prato values ('32789896969632',19023,1,82,"","Heineken","343ml","R$9,07");

/*Seven Kings Sobremesa*/
insert into prato values ('32789896969632',19024,1,83,"imagens/seven_kings/sobremesa/cooki.webp","Cookiempada","Empada com massa de cookie recheada.","R$13,07");
insert into prato values ('32789896969632',19025,1,83,"","Pavê de Brownie","Pavê de brownie com mousse de diversos sabores","R$12,07");





/*Horario Iphome*/


/*fechado no Domingo*/
insert into horario_funcionamento values (2,"11:00","20:00",'98663233654044',1); 
insert into horario_funcionamento values (3,"11:00","20:00",'98663233654044',1);
insert into horario_funcionamento values (4,"11:00","20:00",'98663233654044',1);
insert into horario_funcionamento values (5,"11:00","20:00",'98663233654044',1);
insert into horario_funcionamento values (6,"11:00","20:00",'98663233654044',1);
insert into horario_funcionamento values (7,"11:00","19:00",'98663233654044',1);



/*Tipo Prato Iphome*/
insert into tipo_prato values (84,"Salgados",'98663233654044');
insert into tipo_prato values (85,"Minichurros",'98663233654044');



/*Iphome salgados*/
insert into prato values ('98663233654044',20001,1,84,"imagens/iphome/mini_salgados/cone_p_12_unidades.webp","Cone p (12 unid.)","Escolha até 3 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$4,50");
insert into prato values ('98663233654044',20002,1,84,"imagens/iphome/mini_salgados/cone_m_20_unidades.webp","Cone m (20 unid.)","Escolha até 4 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$7,00");
insert into prato values ('98663233654044',20003,1,84,"imagens/iphome/mini_salgados/50tinha.png","50tinha","Escolha até 5 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$13,00");
insert into prato values ('98663233654044',20004,1,84,"imagens/iphome/mini_salgados/cento_na_caixa.png","Cento na caixa","Escolha até 5 sabores: Costelinha c/ barbecue, Coxinha de frango, Coxinha de frango c/requeijao, Bolinho de queijo, Calabresa com queijo, Kibe, Bolinho de carne, Mexicano de carne, Apimentado, Bacon c/ cheddar, Maravilha, Brocolis c/ queijo","R$26,00");


/*Iphome minichurros*/
insert into prato values ('98663233654044',20005,1,85,"imagens/iphome/mini_churros/cone_p_12_unidades.png","Cone p (12 unid.)","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$4,50");
insert into prato values ('98663233654044',20006,1,85,"imagens/iphome/mini_churros/cone_m_20_unidades.webp","Cone m (20 unid.)","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$7,00");
insert into prato values ('98663233654044',20007,1,85,"imagens/iphome/mini_churros/50tinha.png","50tinha","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$13,00");
insert into prato values ('98663233654044',20008,1,85,"imagens/iphome/mini_churros/cento_na_caixa.png","Cento na caixa","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$26,00");


/*Horario O Custelão*/


insert into horario_funcionamento values (1,"11:30","19:00",'60334456098530',1);
insert into horario_funcionamento values (2,"11:30","00:00",'60334456098530',1); 
insert into horario_funcionamento values (3,"11:30","00:00",'60334456098530',1);
insert into horario_funcionamento values (4,"11:30","00:00",'60334456098530',1);
insert into horario_funcionamento values (5,"11:30","00:00",'60334456098530',1);
insert into horario_funcionamento values (6,"11:30","00:00",'60334456098530',1);
insert into horario_funcionamento values (7,"11:30","00:00",'60334456098530',1);



/*Tipo Prato Churrascaria O Custelão*/
insert into tipo_prato values (86,"Espetos",'60334456098530');
insert into tipo_prato values (87,"Bebidas",'60334456098530');


/*Churrascaria O Custelão Espetos*/
insert into prato values ('60334456098530',21005,1,86,"imagens/o_costelao/mini_churros/cone_p_12_unidades.webp","Espeto de Picanha","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$4,50");
insert into prato values ('60334456098530',21006,1,86,"imagens/o_costelao/mini_churros/cone_m_20_unidades.webp","Espeto de Linguiça","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$7,00");
insert into prato values ('60334456098530',21007,1,86,"imagens/o_costelao/mini_churros/50tinha.webp","Espeto de Azinha de Frango","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$13,00");
insert into prato values ('60334456098530',21008,1,86,"imagens/o_costelao/mini_churros/cento_na_caixa.webp","Espeto de Coração","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$26,00");


/*Churrascaria O Custelão Bebidas*/
insert into prato values ('60334456098530',21009,1,87,"imagens/o_costelao/mini_churros/cone_p_12_unidades.webp","Coca Cola","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$4,50");
insert into prato values ('60334456098530',21010,1,87,"imagens/o_costelao/mini_churros/cone_m_20_unidades.webp"," Fanta","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$7,00");
insert into prato values ('60334456098530',21011,1,87,"imagens/o_costelao/mini_churros/50tinha.webp","Pepsi","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$13,00");
insert into prato values ('60334456098530',21012,1,87,"imagens/o_costelao/mini_churros/cento_na_caixa.webp","Guarana Antartica","Escolha até 3 sabores:Doce de leite, Chocolate ou Banana com canela","R$26,00");


/*Horario cafe 87*/


/*fechado no Domingo*/
insert into horario_funcionamento values (2,"08:00","20:00",'56324591446635',1); 
insert into horario_funcionamento values (3,"08:00","20:00",'56324591446635',1);
insert into horario_funcionamento values (4,"08:00","20:00",'56324591446635',1);
insert into horario_funcionamento values (5,"08:00","20:00",'56324591446635',1);
insert into horario_funcionamento values (6,"08:00","20:00",'56324591446635',1);
insert into horario_funcionamento values (7,"08:00","20:00",'56324591446635',1);

/*Tipo Prato cafe 87*/
insert into tipo_prato values (88,"Cafés & Capuccino",'56324591446635');
insert into tipo_prato values (89,"Lanches",'56324591446635');

/*cafe 87 cafes e capuccino*/
insert into prato values ('56324591446635',22001,1,88,"imagens/cafe_87/cafes_e_cappucinos/cafe_coador.webp","Café de Coador","60 ml de café passado em coador de pano","R$2,50");
insert into prato values ('56324591446635',22002,1,88,"imagens/cafe_87/cafes_e_cappucinos/cafe_expresso.webp","Café Expresso","75ml","R$3,00");
insert into prato values ('56324591446635',22003,1,88,"imagens/cafe_87/cafes_e_cappucinos/capuccino_cremoso.webp","Capuccino Cremoso","120ml de cappuccino já adoçado.","R$7,00");


/*cafe 87 lanches*/
insert into prato values ('56324591446635',22004,1,89,"imagens/cafe_87/lanches/x_salada.webp","X Salada","Pão de hambúrguer, hambúrguer, alface, tomate, queijo e presunto","R$10,00");
insert into prato values ('56324591446635',22005,1,89,"imagens/cafe_87/lanches/completao.webp","Completão","Pão de hambúrguer, alface, tomate, hambúrguer, queijo mussarela, presunto, bacon e ovo .","R$13,00");
insert into prato values ('56324591446635',22006,1,89,"imagens/cafe_87/lanches/omelete.webp","Omelete","3 ovos com recheio a escolher: Bacon, Peito de peru, Queijo branco, Presunto, Mussarela","R$12,00");



/*Horario Taco Bell*/


insert into horario_funcionamento values (1,"15:00","21:00",'35546123998702',1);
insert into horario_funcionamento values (2,"10:00","22:00",'35546123998702',1); 
insert into horario_funcionamento values (3,"10:00","22:00",'35546123998702',1);
insert into horario_funcionamento values (4,"10:00","22:00",'35546123998702',1);
insert into horario_funcionamento values (5,"10:00","22:00",'35546123998702',1);
insert into horario_funcionamento values (6,"10:00","22:00",'35546123998702',1);
insert into horario_funcionamento values (7,"10:00","22:00",'35546123998702',1);


/*Tipo Prato Taco Bell*/
insert into tipo_prato values (90,"Burritos",'35546123998702');
insert into tipo_prato values (91,"Tacos",'35546123998702');

/*Taco Bell Burritos*/
insert into prato values ('35546123998702',23001,1,90,"imagens/taco_bell/burritos/cheesy_burrito.webp","Cheesy burrito","Tortilla, arroz, molho nacho cheese, proteína","R$7,90");
insert into prato values ('35546123998702',23002,1,90,"imagens/taco_bell/burritos/burrito_supreme.webp","Burrito Supreme","Tortilla, feijão, cebola, queijo prato, sour cream, alface, tomate, proteína","R$17,50");
insert into prato values ('35546123998702',23003,1,90,"imagens/taco_bell/burritos/power_burrito.webp","Power Burrito","Tortilla, arroz, queijo prato, molho california ranch, guacamole, sour cream, pico de gallo, alface, proteína","R$18,50");


/*Taco Bell Tacos*/
insert into prato values ('35546123998702',23004,1,91,"imagens/taco_bell/tacos/soft_taco.jpg","Soft Taco","Tortilla, queijo prato, alface, proteína","R$6,90");
insert into prato values ('35546123998702',23005,1,91,"imagens/taco_bell/tacos/cheesy_double_decker.webp","Cheesy double decker","Tortillas, feijão, queijo prato, molho nacho cheese, alface, proteína","R$7,90");
insert into prato values ('35546123998702',23006,1,91,"imagens/taco_bell/tacos/soft_taco_supreme.webp","Soft taco supreme","Tortilla, queijo prato, sour cream, alface, tomate, proteína","R$9,50");


/*Horario Taquitos Beer*/


insert into horario_funcionamento values (1,"18:00","23:00",'20365987889633',1);
 /*fechado na Segunda*/
insert into horario_funcionamento values (3,"18:00","23:00",'20365987889633',1);
insert into horario_funcionamento values (4,"18:00","23:00",'20365987889633',1);
insert into horario_funcionamento values (5,"18:00","23:00",'20365987889633',1);
insert into horario_funcionamento values (6,"18:00","00:00",'20365987889633',1);
insert into horario_funcionamento values (7,"18:00","00:00",'20365987889633',1);


/*Tipo Prato Taquitos Beer*/
insert into tipo_prato values (92,"Petiscos",'20365987889633');

/*Taquitos Beer */
insert into prato values ('20365987889633',24001,1,92,"imagens/taquitos_beer/petiscos/nacho_libre.jpeg","Nacho libre","Chips de tortilha de milho. acompanha 4 molhos a escolha. serve 2 pessoas.","R$35,00");
insert into prato values ('20365987889633',24002,1,92,"imagens/taquitos_beer/petiscos/nacho_tex_mex.jpeg","Nacho tex mex","Chips de tortilha de milho com cobertura de chilli com carne e cheddar (enviados separadamente). acompanha 4 molhos a escolha. serve 2 pessoas.","R$44,000");
insert into prato values ('20365987889633',24003,1,92,"imagens/taquitos_beer/petiscos/taquitos.webp","Taquitos","4 unidades de tortilha de trigo grelhada e recheada com queijo muçarela. + 2 molhos. serve 1 a 2 pessoas.","R$37,00");



/*Horario dboa_mexico*/


/*fechado no Domingo*/
insert into horario_funcionamento values (2,"11:30","01:00",'12503069878892',1); 
insert into horario_funcionamento values (3,"11:30","01:00",'12503069878892',1);
insert into horario_funcionamento values (4,"11:30","01:00",'12503069878892',1);
insert into horario_funcionamento values (5,"11:30","01:00",'12503069878892',1);
insert into horario_funcionamento values (6,"11:30","01:00",'12503069878892',1);
insert into horario_funcionamento values (7,"11:30","01:00",'12503069878892',1);

/*Tipo Prato Taquitos Beer*/
insert into tipo_prato values (93,"Burritos",'12503069878892');


/*dboa_mexico*/
insert into prato values ('12503069878892',25001,1,93,"imagens/dboa_mexico/logo_dboa_mexico.webp","Burritos de Carne com Cheddar","Burrito carne desfiada com cheddar","R$39,50");
insert into prato values ('12503069878892',25002,1,93,"imagens/dboa_mexico/logo_dboa_mexico.webp","Burrito don julio","Salmão com cream cheese","R$42,50");
insert into prato values ('12503069878892',25003,1,93,"imagens/dboa_mexico/logo_dboa_mexico.webp","Burritos Chilli","Com mussarela e pasta de feijão","R$36,50");


/*Horario guadalupe*/


insert into horario_funcionamento values (1,"19:00","23:30",'60322256698770',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'60322256698770',1);
insert into horario_funcionamento values (4,"19:00","23:30",'60322256698770',1);
insert into horario_funcionamento values (5,"19:00","23:30",'60322256698770',1);
insert into horario_funcionamento values (6,"19:00","01:00",'60322256698770',1);
insert into horario_funcionamento values (7,"19:00","01:00",'60322256698770',1);



/*Tipo Prato Taquitos Beer*/
insert into tipo_prato values (94,"Burritos",'60322256698770');


/*guadalupe*/
insert into prato values ('60322256698770',26001,1,94,"imagens/guadalupe/logo_guadalupe.webp","Burritos de Carne com Cheddar","Burrito carne desfiada com cheddar","R$39,50");
insert into prato values ('60322256698770',26002,1,94,"imagens/guadalupe/logo_guadalupe.webp","Burrito don julio","Salmão com cream cheese","R$42,50");
insert into prato values ('60322256698770',26003,1,94,"imagens/guadalupe/logo_guadalupe.webp","Burritos Chilli","Com mussarela e pasta de feijão","R$36,50");


/*Horario Arriba Maria*/


insert into horario_funcionamento values (1,"19:00","23:30",'60322256698770',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'60322256698770',1);
insert into horario_funcionamento values (4,"19:00","23:30",'60322256698770',1);
insert into horario_funcionamento values (5,"19:00","23:30",'60322256698770',1);
insert into horario_funcionamento values (6,"19:00","01:00",'60322256698770',1);
insert into horario_funcionamento values (7,"19:00","01:00",'60322256698770',1);



/*Tipo Prato Taquitos Beer*/
insert into tipo_prato values (95,"Burritos",'23366909788850');

/*Arriba Maria*/
insert into prato values ('23366909788850',27001,1,95,"imagens/arriba_maria/logo_arriba_maria.webp","Burritos de Carne com Cheddar","Burrito carne desfiada com cheddar","R$39,50");
insert into prato values ('23366909788850',27002,1,95,"imagens/arriba_maria/logo_arriba_maria.webp","Burrito don julio","Salmão com cream cheese","R$42,50");
insert into prato values ('23366909788850',27003,1,95,"imagens/arriba_maria/logo_arriba_maria.webp","Burritos Chilli","Com mussarela e pasta de feijão","R$36,50");







/*Horario Família Santos Churrascaria*/


insert into horario_funcionamento values (1,"19:00","23:30",'12255889999633',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'12255889999633',1);
insert into horario_funcionamento values (4,"19:00","23:30",'12255889999633',1);
insert into horario_funcionamento values (5,"19:00","23:30",'12255889999633',1);
insert into horario_funcionamento values (6,"19:00","01:00",'12255889999633',1);
insert into horario_funcionamento values (7,"19:00","01:00",'12255889999633',1);



/*Tipo Prato TFamília Santos Churrascaria*/
insert into tipo_prato values (96,"Espetos Churrasco",'12255889999633');



/*Família Santos Churrascaria*/
insert into prato values ('12255889999633',28001,1,96,"imagens/familia_santos/espetos_churrasco/espetao_familia.webp","Espetão à familia santos especial","Filé mignon, lombo, linguiça, frango (na brasa), arroz carreteiro, fritas, farofa, molho de cebola e molho a vinagrete","R$218,50");
insert into prato values ('12255889999633',28002,1,96,"imagens/familia_santos/espetos_churrasco/espetao_file_mignon.webp","Espetão de filé mignon completo","Filé mignon, arroz com brócolis, fritas, farofa, molho de cebola e molho a vinagrete","R$167,44");
insert into prato values ('12255889999633',28003,1,96,"imagens/familia_santos/espetos_churrasco/espetao_picanha_argentina.webp","Espetão de picanha argentina","Picanha argentina, arroz com brócolis, fritas, farofa, molho de cebola e molho a vinagrete","R$167,44");
insert into prato values ('12255889999633',28004,1,96,"imagens/familia_santos/espetos_churrasco/espetao_baby_beef.webp","Espetão de baby bife","Baby bife, arroz branco, fritas, farofa, molho de cebola e molho a vinagrete","R$116,84");
insert into prato values ('12255889999633',28005,1,96,"imagens/familia_santos/espetos_churrasco/espetao_linguica.webp","Espetão de linguiça","Linguiça, arroz branco, fritas, farofa, molho de cebola e molho a vinagrete","R$64,40");
insert into prato values ('12255889999633',28006,1,96,"imagens/familia_santos/espetos_churrasco/espetao_lombo.webp","Espetão de lombo","Lombo, arroz branco, fritas, farofa, molho de cebola e molho a vinagrete","R$92,00");




/*Horario himalai fit*/


insert into horario_funcionamento values (1,"19:00","23:30",'39560145672313',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'39560145672313',1);
insert into horario_funcionamento values (4,"19:00","23:30",'39560145672313',1);
insert into horario_funcionamento values (5,"19:00","23:30",'39560145672313',1);
insert into horario_funcionamento values (6,"19:00","01:00",'39560145672313',1);
insert into horario_funcionamento values (7,"19:00","01:00",'39560145672313',1);


/*Tipo Prato himalai fit*/
insert into tipo_prato values (97,"Espetos Churrasco",'39560145672313');


/*himalai fit*/
insert into prato values ('39560145672313',29001,1,97,"imagens/himalaia_fit/quinoto.jpg","Quinoto de frango caprese","Risoto de quinoa com frango,vinho branco, tomatinho, manjericão e queijo grana padano sem lactose","R$22,90");
insert into prato values ('39560145672313',29002,1,97,"imagens/himalaia_fit/mignon.jpg","Tiras de mignon acebolado","Tiras de mignon acebolado, acompanhado de legumes salteados e arroz integral com cúrcuma.","R$23,90");
insert into prato values ('39560145672313',29003,1,97,"imagens/himalaia_fit/frango_espinafre.webp","Frango ao toque oriental com cogumelos e arroz integral com espinafre","Frango ao toque oriental com brócolis e cenoura, acompanhado de arroz integral com espinafre","R$22,90");
insert into prato values ('39560145672313',29004,1,97,"imagens/himalaia_fit/frango_espinafre.webp","Bobó de frango + quinoa ao brócolis","Nossa marmitinha mais pedida de todos os tempos, agora acompanhada de quinoa orgânica ao brócolis.","R$22,90");
insert into prato values ('39560145672313',29005,1,97,"imagens/himalaia_fit/strogonoff.webp","Strogonoff de frango com base de leite de castanhas + quinoa c cenoura","Strogonoff de frango como você nunca viu! base de leite artesanal de castanha de caju acompanhado de quinoa com cenoura.","R$22,90");
insert into prato values ('39560145672313',29006,1,97,"imagens/himalaia_fit/frango_espinafre.webp","Carne moída + purê de inhame ao alho com couve refogada e bacon","Purê de inhame (super rico em vitaminas e minerais) ao alho acompanhado de carne moída e couve manteiga refogada com bacon ;)","R$22,90");
insert into prato values ('39560145672313',29007,1,97,"imagens/himalaia_fit/frango_espinafre.webp","Curry de frango e couve flor + quinoa","Curry de couve flor com frango, acomnpanhado de quinoa com cenouras. refeição low carb ;)","R$19,90");




/*Horario Patroni Pizzaria*/


insert into horario_funcionamento values (1,"19:00","23:30",'21556478987412',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'21556478987412',1);
insert into horario_funcionamento values (4,"19:00","23:30",'21556478987412',1);
insert into horario_funcionamento values (5,"19:00","23:30",'21556478987412',1);
insert into horario_funcionamento values (6,"19:00","01:00",'21556478987412',1);
insert into horario_funcionamento values (7,"19:00","01:00",'21556478987412',1);


/*Tipo Prato Patroni Pizzaria*/
insert into tipo_prato values (98,"Parmegianas",'21556478987412');



/*Patroni Pizzaria*/
insert into prato values ('21556478987412',30001,1,98,"imagens/patroni_santos/parmegianas/parmegiana_catupiry_carne.webp","Parmegiana Catupiry carne","Parmegiana de carne, com molho de tomate artesanal feito na cucina da mamma coberto com Catupiry.","R$29,90");
insert into prato values ('21556478987412',30002,1,98,"imagens/patroni_santos/parmegianas/parmegiana_catupiry_frango.webp","Parmegiana Catupiry frango","Parmegiana de frango, com molho de tomate artesanal feito na cucina da mamma coberto com Catupiry.","R$29,90");
insert into prato values ('21556478987412',30003,1,98,"imagens/patroni_santos/parmegianas/parmegiana_tradicional_carne.webp","Parmegiana tradicional carne","Parmegiana de carne, com molho de tomate artesanal feito na cucina da mamma finalizado com mussarela patroni.","R$29,90");
insert into prato values ('21556478987412',30004,1,98,"imagens/patroni_santos/parmegianas/parmegiana_tradicional_frango.webp","Parmegiana tradicional frango","Parmegiana de frango, com molho de tomate artesanal feito na cucina da mamma finalizado com mussarela patroni.","R$29,90");





/*Horario Pizza Hut*/


insert into horario_funcionamento values (1,"19:00","23:30",'36554770089987',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'36554770089987',1);
insert into horario_funcionamento values (4,"19:00","23:30",'36554770089987',1);
insert into horario_funcionamento values (5,"19:00","23:30",'36554770089987',1);
insert into horario_funcionamento values (6,"19:00","01:00",'36554770089987',1);
insert into horario_funcionamento values (7,"19:00","01:00",'36554770089987',1);


/*Tipo Prato Pizza Hut*/
insert into tipo_prato values (99,"Parmegianas",'36554770089987');


/*Pizza Hut*/
insert into prato values ('36554770089987',31001,1,99,"","Parmegiana Catupiry carne","Parmegiana de carne, com molho de tomate artesanal feito na cucina da mamma coberto com Catupiry.","R$29,90");
insert into prato values ('36554770089987',31002,1,99,"","Parmegiana Catupiry frango","Parmegiana de frango, com molho de tomate artesanal feito na cucina da mamma coberto com Catupiry.","R$29,90");
insert into prato values ('36554770089987',31003,1,99,"","Parmegiana tradicional carne","Parmegiana de carne, com molho de tomate artesanal feito na cucina da mamma finalizado com mussarela patroni.","R$29,90");
insert into prato values ('36554770089987',31004,1,99,"","Parmegiana tradicional frango","Parmegiana de frango, com molho de tomate artesanal feito na cucina da mamma finalizado com mussarela patroni.","R$29,90");




/*Horario Casa Nova Pizzaria*/


insert into horario_funcionamento values (1,"19:00","23:30",'50633214477787',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'50633214477787',1);
insert into horario_funcionamento values (4,"19:00","23:30",'50633214477787',1);
insert into horario_funcionamento values (5,"19:00","23:30",'50633214477787',1);
insert into horario_funcionamento values (6,"19:00","01:00",'50633214477787',1);
insert into horario_funcionamento values (7,"19:00","01:00",'50633214477787',1);


/*Tipo Prato Casa Nova Pizzaria*/
insert into tipo_prato values (100,"Pratos Teste",'50633214477787');



/*Casa Nova Pizzaria*/
insert into prato values ('50633214477787',32001,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32002,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32003,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32004,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32005,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32006,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32007,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50633214477787',32008,1,100,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Florença Forneria*/


insert into horario_funcionamento values (1,"19:00","23:30",'64808098785322',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'64808098785322',1);
insert into horario_funcionamento values (4,"19:00","23:30",'64808098785322',1);
insert into horario_funcionamento values (5,"19:00","23:30",'64808098785322',1);
insert into horario_funcionamento values (6,"19:00","01:00",'64808098785322',1);
insert into horario_funcionamento values (7,"19:00","01:00",'64808098785322',1);


/*Tipo Prato Florença Forneria*/
insert into tipo_prato values (101,"Pratos Teste 01",'64808098785322');



/*Florença Forneria*/
insert into prato values ('64808098785322',33001,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33002,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33003,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33004,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33005,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33006,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33007,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64808098785322',33008,1,101,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Pizzaria Vila dy Napolli*/


insert into horario_funcionamento values (1,"19:00","23:30",'40566932201478',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'40566932201478',1);
insert into horario_funcionamento values (4,"19:00","23:30",'40566932201478',1);
insert into horario_funcionamento values (5,"19:00","23:30",'40566932201478',1);
insert into horario_funcionamento values (6,"19:00","01:00",'40566932201478',1);
insert into horario_funcionamento values (7,"19:00","01:00",'40566932201478',1);


/*Tipo Prato Pizzaria Vila dy Napolli*/
insert into tipo_prato values (102,"Pratos Teste 02",'40566932201478');



/*Pizzaria Vila dy Napolli*/
insert into prato values ('40566932201478',34001,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34002,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34003,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34004,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34005,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34006,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34007,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40566932201478',34008,1,102,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Don Corrêa Pizzaria*/


insert into horario_funcionamento values (1,"19:00","23:30",'32255569874125',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'32255569874125',1);
insert into horario_funcionamento values (4,"19:00","23:30",'32255569874125',1);
insert into horario_funcionamento values (5,"19:00","23:30",'32255569874125',1);
insert into horario_funcionamento values (6,"19:00","01:00",'32255569874125',1);
insert into horario_funcionamento values (7,"19:00","01:00",'32255569874125',1);


/*Tipo Prato Don Corrêa Pizzaria*/
insert into tipo_prato values (103,"Pratos Teste 03",'32255569874125');



/*Don Corrêa Pizzaria*/
insert into prato values ('32255569874125',35001,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35002,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35003,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35004,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35005,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35006,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35007,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32255569874125',35008,1,103,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Pizza Madre*/


insert into horario_funcionamento values (1,"19:00","23:30",'36699878521002',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'36699878521002',1);
insert into horario_funcionamento values (4,"19:00","23:30",'36699878521002',1);
insert into horario_funcionamento values (5,"19:00","23:30",'36699878521002',1);
insert into horario_funcionamento values (6,"19:00","01:00",'36699878521002',1);
insert into horario_funcionamento values (7,"19:00","01:00",'36699878521002',1);


/*Tipo Prato Pizza Madre*/
insert into tipo_prato values (104,"Pratos Teste 04",'36699878521002');



/*Pizza Madre*/
insert into prato values ('36699878521002',36001,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36002,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36003,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36004,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36005,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36006,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36007,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('36699878521002',36008,1,104,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Nonna Carmello Pizzaria*/


insert into horario_funcionamento values (1,"19:00","23:30",'20336558940102',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'20336558940102',1);
insert into horario_funcionamento values (4,"19:00","23:30",'20336558940102',1);
insert into horario_funcionamento values (5,"19:00","23:30",'20336558940102',1);
insert into horario_funcionamento values (6,"19:00","01:00",'20336558940102',1);
insert into horario_funcionamento values (7,"19:00","01:00",'20336558940102',1);


/*Tipo Prato Nonna Carmello Pizzaria*/
insert into tipo_prato values (105,"Pratos Teste 05",'20336558940102');



/*Nonna Carmello Pizzaria*/
insert into prato values ('20336558940102',37001,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37002,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37003,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37004,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37005,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37006,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37007,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20336558940102',37008,1,105,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Baviera*/


insert into horario_funcionamento values (1,"19:00","23:30",'50644100236502',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'50644100236502',1);
insert into horario_funcionamento values (4,"19:00","23:30",'50644100236502',1);
insert into horario_funcionamento values (5,"19:00","23:30",'50644100236502',1);
insert into horario_funcionamento values (6,"19:00","01:00",'50644100236502',1);
insert into horario_funcionamento values (7,"19:00","01:00",'50644100236502',1);


/*Tipo Prato Baviera*/
insert into tipo_prato values (106,"Pratos Teste 06",'50644100236502');




/*Baviera*/
insert into prato values ('50644100236502',38001,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38002,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38003,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38004,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38005,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38006,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38007,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50644100236502',38008,1,106,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Tomato Forneria*/


insert into horario_funcionamento values (1,"19:00","23:30",'40005698632573',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'40005698632573',1);
insert into horario_funcionamento values (4,"19:00","23:30",'40005698632573',1);
insert into horario_funcionamento values (5,"19:00","23:30",'40005698632573',1);
insert into horario_funcionamento values (6,"19:00","01:00",'40005698632573',1);
insert into horario_funcionamento values (7,"19:00","01:00",'40005698632573',1);


/*Tipo Prato Tomato Forneria*/
insert into tipo_prato values (107,"Pratos Teste 07",'40005698632573');




/*Tomato Forneria*/
insert into prato values ('40005698632573',39001,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39002,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39003,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39004,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39005,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39006,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39007,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40005698632573',39008,1,107,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Rizzo*/


insert into horario_funcionamento values (1,"19:00","23:30",'50069878203657',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'50069878203657',1);
insert into horario_funcionamento values (4,"19:00","23:30",'50069878203657',1);
insert into horario_funcionamento values (5,"19:00","23:30",'50069878203657',1);
insert into horario_funcionamento values (6,"19:00","01:00",'50069878203657',1);
insert into horario_funcionamento values (7,"19:00","01:00",'50069878203657',1);


/*Tipo Prato Rizzo*/
insert into tipo_prato values (108,"Pratos Teste 08",'50069878203657');




/*Rizzo*/
insert into prato values ('50069878203657',40001,1,108,"imagens/rizzo_italian/telefono.webp","Risoto al teléfono","Arroz arbóreo, queijo parmesão,tomate italiano, mussarela, azeitona e manjericão. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40002,1,108,"imagens/rizzo_italian/filetto.webp","Risoto filetto","Arroz arbóreo, queijo parmesão,tomate italiano, manjericão, rúcula e isca de mignon. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40003,1,108,"imagens/rizzo_italian/frango_legumes.webp","Risoto de frango com legumes","Arroz arbóreo, queijo parmesão,frango desfiado, cenoura, vagem e brócolis picado. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40004,1,108,"imagens/rizzo_italian/palmito.webp","Risoto de palmito","Arroz arbóreo, queijo parmesão, palmito picado tomate seco e especiarias. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40005,1,108,"imagens/rizzo_italian/salmao.webp","Risoto de salmão","Arroz arbóreo, queijo parmesão, salmão desfiado, cenoura, vagem e brócolis picado. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40006,1,108,"imagens/rizzo_italian/funghi.webp","Risoto funghi","Arroz arbóreo, queijo parmesão,funghi chileno e especiarias. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40007,1,108,"imagens/rizzo_italian/michelangelo.webp","Risoto michelangelo","Arroz arbóreo, queijo parmesão,tomate seco, rúcula e funghi. Serve 1 pessoa","R$29,90");
insert into prato values ('50069878203657',40008,1,108,"imagens/rizzo_italian/milanes.webp","Risoto milanês","Arroz arbóreo, queijo parmesão, açafrão e vinho branco. Serve 1 pessoa","R$29,90");



/*Horario Massas Veneza*/


insert into horario_funcionamento values (1,"19:00","23:30",'90878999650024',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'90878999650024',1);
insert into horario_funcionamento values (4,"19:00","23:30",'90878999650024',1);
insert into horario_funcionamento values (5,"19:00","23:30",'90878999650024',1);
insert into horario_funcionamento values (6,"19:00","01:00",'90878999650024',1);
insert into horario_funcionamento values (7,"19:00","01:00",'90878999650024',1);


/*Tipo Prato Massas Veneza*/
insert into tipo_prato values (109,"Pratos Teste 09",'90878999650024');




/*Massas Veneza*/
insert into prato values ('90878999650024',41001,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41002,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41003,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41004,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41005,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41006,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41007,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90878999650024',41008,1,109,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Liliana Pasta & Pizza*/


insert into horario_funcionamento values (1,"19:00","23:30",'20588789000001',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'20588789000001',1);
insert into horario_funcionamento values (4,"19:00","23:30",'20588789000001',1);
insert into horario_funcionamento values (5,"19:00","23:30",'20588789000001',1);
insert into horario_funcionamento values (6,"19:00","01:00",'20588789000001',1);
insert into horario_funcionamento values (7,"19:00","01:00",'20588789000001',1);


/*Tipo Prato Liliana Pasta & Pizza*/
insert into tipo_prato values (110,"Pratos Teste 10",'20588789000001');




/*Liliana Pasta & Pizza*/
insert into prato values ('20588789000001',42001,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42002,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42003,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42004,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42005,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42006,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42007,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20588789000001',42008,1,110,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Beduino*/


insert into horario_funcionamento values (1,"19:00","23:30",'10056900877453',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'10056900877453',1);
insert into horario_funcionamento values (4,"19:00","23:30",'10056900877453',1);
insert into horario_funcionamento values (5,"19:00","23:30",'10056900877453',1);
insert into horario_funcionamento values (6,"19:00","01:00",'10056900877453',1);
insert into horario_funcionamento values (7,"19:00","01:00",'10056900877453',1);


/*Tipo Prato Beduino*/
insert into tipo_prato values (111,"Pratos Teste 11",'10056900877453');



/*Beduino*/
insert into prato values ('10056900877453',43001,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43002,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43003,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43004,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43005,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43006,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43007,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10056900877453',43008,1,111,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Salaam_Shawarma*/


insert into horario_funcionamento values (1,"19:00","23:30",'15047362149878',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'15047362149878',1);
insert into horario_funcionamento values (4,"19:00","23:30",'15047362149878',1);
insert into horario_funcionamento values (5,"19:00","23:30",'15047362149878',1);
insert into horario_funcionamento values (6,"19:00","01:00",'15047362149878',1);
insert into horario_funcionamento values (7,"19:00","01:00",'15047362149878',1);


/*Tipo Prato Salaam_Shawarma*/
insert into tipo_prato values (112,"Lanches",'15047362149878');


/*Salaam_Shawarma*/
insert into prato values ('15047362149878',44001,1,112,"imagens/salaam/frango.jpg","Shawarma de Frango (pão folha)","Pão folha, frango, molho de alho, alface, tomate e batata frita.","R$17,00");
insert into prato values ('15047362149878',44002,1,112,"imagens/salaam/falafael,webp","Falafel (vegetariano e vegano)","Sanduíche: Pão folha, bolinho de grão de bico, alface, tomate, cebola, thaine (molho de gergelim) e homus (pasta de grão de bico).","R$17,00");
insert into prato values ('15047362149878',44003,1,112,"imagens/salaam_shawarma/logo_salaam_shawarma.webp","Sanduiche de Kafta","Pão folha, kafta, homus ou mutabal, tomate, salsa e celoba","R$24,00");
insert into prato values ('15047362149878',44004,1,112,"imagens/salaam/shawara.webp","Shawarma Arabe de Frango","Sanduiche Shawarma de Frango Crocante cortado em Pedacos, com Molho de Alho, Tomate, Batata Frita, acompanhado de Salada de Alface e Tahine","R$23,00");
insert into prato values ('15047362149878',44005,1,112,"imagens/salaam_shawarma/logo_salaam_shawarma.webp","Beirute de Frango da Salaam","2 Paes Sirios (original), Frango da Shawarma, Molho de Alho, Tomate, Pimentao, Cebola, Alface, Mussarela acompanhado de Batata Frita","R$25,00");
insert into prato values ('15047362149878',44006,1,112,"imagens/salaam_shawarma/logo_salaam_shawarma.webp","Beirute Vegetariano do Salaam","2 Paes Sirios (original), )Bolinhos de Falafel, Molho de Alho, Tomate, Pimentao, Cebola Grelhados na Chapa, Mussarela, Alface e Temperos da Salaam acompanhado de Batata Frita.","R$25,00");
insert into prato values ('15047362149878',44007,1,112,"imagens/salaam/shawara_frango.webp","Shawarma de Frango (pão sírio)","Pão Sírio, Frango, Molho de Alho, Alface e Tomate","R$12,00");
insert into prato values ('15047362149878',44008,1,112,"imagens/salaam/shawara_carne.webp","Shawarma Arabe de Carne (pão folha)","Sanduiche Crocante no Pão Folha, Carne, Tomate, Salsa, Cebola e Molho de Iorgute + Tahine (especial)","R$24,00");
insert into prato values ('15047362149878',44009,1,112,"imagens/salaam_shawarma/logo_salaam_shawarma.webp","Falafel","4 bolinhos de Gao-de-bico, molho de falafel (vegetariano) ou tahine (vegano)","R$12,00");


/*Horario Burgolandia*/


insert into horario_funcionamento values (1,"19:00","23:30",'78350125697410',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'78350125697410',1);
insert into horario_funcionamento values (4,"19:00","23:30",'78350125697410',1);
insert into horario_funcionamento values (5,"19:00","23:30",'78350125697410',1);
insert into horario_funcionamento values (6,"19:00","01:00",'78350125697410',1);
insert into horario_funcionamento values (7,"19:00","01:00",'78350125697410',1);


/*Tipo Prato Burgolandia*/
insert into tipo_prato values (113,"Lanches",'78350125697410');



/*Burgolandia*/
insert into prato values ('78350125697410',45001,1,113,"imagens/burgolandia/cheese_burguer.webp","Cheeseburger","Pão, hambúrguer artesanal 150g e queijo.","R$15,00");
insert into prato values ('78350125697410',45002,1,113,"imagens/burgolandia/cheese_salada.webp","Cheese salada","Pão, hambúrguer artesanal 150g, queijo, alface e tomate.","R$16,00");
insert into prato values ('78350125697410',45003,1,113,"imagens/burgolandia/bacon_salad.webp","Bacon salad","Pão, hambúrguer artesanal 150g, bacon, queijo, alface e tomate.","R$18,00");
insert into prato values ('78350125697410',45004,1,113,"imagens/burgolandia/bbq.webp","Bbq salad","Pão, hambúrguer artesanal 150g ao molho barbecue, queijo, alface e tomate.","R$18,00");
insert into prato values ('78350125697410',45005,1,113,"imagens/burgolandia/garlic.webp","Garlic","Pão, molho especial de ervas e alho, hambúrguer 150g, fatia de queijo, alho frito, alface e tomate","R$19,00");
insert into prato values ('78350125697410',45006,1,113,"imagens/burgolandia/special_salad.webp","Special salad","Pão, maionese de alho, cebola empanada, hambúrguer 150g, quiejo, alface americana e tomate.","R$20,00");
insert into prato values ('78350125697410',45007,1,113,"imagens/burgolandia/cheddar_bacon.webp","Cheddar bacon","Pão, maionese, hambúrguer artesanal 150g, cheddar autêntico e bacon.","R$18,00");
insert into prato values ('78350125697410',45008,1,113,"imagens/burgolandia/cheddar_cebola.webp","Cheddar com cebola caramelizada","Pão, maionese, hambúrguer artesanal 150g, autêntico cheddar e cebola caramelizada.","R$18,00");
insert into prato values ('78350125697410',45009,1,113,"imagens/burgolandia/double_burguer.webp","Double burger","Pão, 2 hambúrgueres artesanais de 150g cada, queijo, alface, tomate e bacon","R$26,00");




/*Horario Salt_Hamburgueria*/


insert into horario_funcionamento values (1,"19:00","23:30",'30021480097563',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'30021480097563',1);
insert into horario_funcionamento values (4,"19:00","23:30",'30021480097563',1);
insert into horario_funcionamento values (5,"19:00","23:30",'30021480097563',1);
insert into horario_funcionamento values (6,"19:00","01:00",'30021480097563',1);
insert into horario_funcionamento values (7,"19:00","01:00",'30021480097563',1);


/*Tipo Prato Salt_Hamburgueria*/
insert into tipo_prato values (114,"Lanches",'30021480097563');




/*Salt_Hamburgueria*/
insert into prato values ('30021480097563',46001,1,114,"imagens/salt/burguer.webp","BURGUER","PÃO ESPECIAL , MAIONESE , HAMBURGER DE 90G E QUEIJO","R$9,99");
insert into prato values ('30021480097563',46002,1,114,"imagens/salt/duplo_bacon.webp","DUPLO BACON BARBECUE","PÃO ESPECIAIS , 2 HAMBURGUERS DE 90G , CHEDDAR , BACON , MOLHO BARBECUE E ALFACE AMERICANA","R$17,99");
insert into prato values ('30021480097563',46003,1,114,"imagens/salt/triplo.webp","TRIPLO","PÃO ESPECIAL , MAIONESE , 3 HAMBURGUERS DE 90G , CHEDDAR , QUEIJO , ALFACE AMERICANO E MOLHO ESPECIAL","R$18,90");
insert into prato values ('30021480097563',46004,1,114,"imagens/salt/chicken.webp","CHICKEN","PÃO ESPECIAL , HAMBURGUER 100% DE FRANGO EMPANADO , CREAM CHESSE , QUEIJO ,ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$16,49");
insert into prato values ('30021480097563',46005,1,114,"imagens/salt/calabresa.webp","CALABRESA","PÃO ESPECIAL , MAIONESE , HAMBURGUER DE 90G , CHEDDAR , CALABRESA , QUEIJO ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$14,99");
insert into prato values ('30021480097563',46006,1,114,"imagens/salt/bacon_egg.webp","BACON EGG","PÃO ESPECIAL , MAIONESE , HAMBURGUER DE 90 G CHEDDAR , BACON ,OVO, QUEIJO , ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$16,49");
insert into prato values ('30021480097563',46007,1,114,"imagens/salt/egg.webp","EGG","PÃO ESPECIAL , MAIONESE , HAMBÚRGUER DE 90G , OVO , QUEIJO , ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$12,99");
insert into prato values ('30021480097563',46008,1,114,"imagens/salt/mega.webp","MEGA","PÃO ESPECIAL , MAIONESE , 2 HAMBURGUERS DE 90G , BACON , CALABRESA , OVO , QUEIJO , CHEDDAR , ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$21,90");
insert into prato values ('30021480097563',46009,1,114,"imagens/salt/cala_bacon.webp","CALABACON","PÃO ESPECIAL , MAIONESE , HAMBURGUER DE 90 G CHEDDAR ,CALABRESA, BACON , QUEIJO , ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$16,90");
insert into prato values ('30021480097563',46010,1,114,"imagens/salt/bacon.jpg","BACON","PÃO ESPECIAL , MAIONESE , HAMBURGUER DE 90 G CHEDDAR , BACON , QUEIJO , ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$14,99");
insert into prato values ('30021480097563',46011,1,114,"imagens/salt/duplo.webp","DUPLO","PÃO ESPECIAL , MAIONESE , 2 HAMBURGUER DE 90 G , CHEDDAR , QUEIJO , ALFACE AMERICANA , E MOLHO ESPECIAL","R$14,99");
insert into prato values ('30021480097563',46012,1,114,"imagens/salt/cala_egg.webp","CALA EGG","PÃO ESPECIAL , MAIONESE , HAMBURGUER DE 90G , CHEDDAR , CALABRESA , OVO , QUEIJO , ALFACE AMERICANO , TOMATE E MOLHO ESPECIAL","R$16,49");




/*Horario Buddy's*/


insert into horario_funcionamento values (1,"19:00","23:30",'36000457986321',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'36000457986321',1);
insert into horario_funcionamento values (4,"19:00","23:30",'36000457986321',1);
insert into horario_funcionamento values (5,"19:00","23:30",'36000457986321',1);
insert into horario_funcionamento values (6,"19:00","01:00",'36000457986321',1);
insert into horario_funcionamento values (7,"19:00","01:00",'36000457986321',1);


/*Tipo Prato Buddy's*/
insert into tipo_prato values (115,"Lanches",'36000457986321');




/*Buddy's*/
insert into prato values ('36000457986321',47001,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Classic burguer","Pão brioche hambúrguer, alface, tomate e queijo prato 340g.","R$19,00");
insert into prato values ('36000457986321',47002,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Buddy picanha burguer","Pão brioche hambúrguer de picanha bovina, cebola caramelizada, molho inglês, queijo, saladinha com molho tártaro 410g.","R$29,50");
insert into prato values ('36000457986321',47003,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Buddy burguer","Pão brioche hambúrguer bovino, fatia de queijo coalho, fatia de longuiça, bacon, cebola caramelizada e molho tártaro apimentado 310g.","R$24,00");
insert into prato values ('36000457986321',47004,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Buddy's sanduiches","Pão brioche hambúrguer de carne fraldinha moída com tempero da casa, cebola assada, saladinha, molho tártaro e queijo derretido 370g.","R$19,50");
insert into prato values ('36000457986321',47005,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Prime chiken burguer","Pão brioche hambúrguer de frango com toque de curry, abobrinha laminada, alface, tomate e uma camada de nosso coleslaw 380g.","R$20,50");
insert into prato values ('36000457986321',47006,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Grand veggier burguer","Pão australiano, hambúrguer vegetariano, muçarela de búfala, tomate, rúcula, maionese de mel e mostarda 420g.","R$23,50");
insert into prato values ('36000457986321',47007,1,115,"imagens/Buddys_bar_hamburgueria/logo_Buddys_bar_hamburgueria.webp","Paulistinha","Pão francês, sanduiche de filé mignon grelhado, queijo prato e vinagre 290g.","R$24,50");




/*Horario Seiko Temakeria*/


insert into horario_funcionamento values (1,"19:00","23:30",'50088779863014',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'50088779863014',1);
insert into horario_funcionamento values (4,"19:00","23:30",'50088779863014',1);
insert into horario_funcionamento values (5,"19:00","23:30",'50088779863014',1);
insert into horario_funcionamento values (6,"19:00","01:00",'50088779863014',1);
insert into horario_funcionamento values (7,"19:00","01:00",'50088779863014',1);


/*Tipo Prato Seiko Temakeria*/
insert into tipo_prato values (116,"Pratos Teste 12",'50088779863014');




/*Seiko Temakeria*/
insert into prato values ('50088779863014',48001,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48002,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48003,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48004,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48005,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48006,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48007,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50088779863014',48008,1,116,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Hoshi Temaki & Poke*/


insert into horario_funcionamento values (1,"19:00","23:30",'20068796324578',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'20068796324578',1);
insert into horario_funcionamento values (4,"19:00","23:30",'20068796324578',1);
insert into horario_funcionamento values (5,"19:00","23:30",'20068796324578',1);
insert into horario_funcionamento values (6,"19:00","01:00",'20068796324578',1);
insert into horario_funcionamento values (7,"19:00","01:00",'20068796324578',1);


/*Tipo Prato Hoshi Temaki & Poke*/
insert into tipo_prato values (117,"Pratos Teste 13",'20068796324578');




/*Hoshi Temaki & Poke*/
insert into prato values ('20068796324578',49001,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49002,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49003,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49004,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49005,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49006,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49007,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20068796324578',49008,1,117,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Kampay*/


insert into horario_funcionamento values (1,"19:00","23:30",'40320069872344',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'40320069872344',1);
insert into horario_funcionamento values (4,"19:00","23:30",'40320069872344',1);
insert into horario_funcionamento values (5,"19:00","23:30",'40320069872344',1);
insert into horario_funcionamento values (6,"19:00","01:00",'40320069872344',1);
insert into horario_funcionamento values (7,"19:00","01:00",'40320069872344',1);


/*Tipo Prato Kampay*/
insert into tipo_prato values (118,"Pratos Teste 14",'40320069872344');



/*Kampay*/
insert into prato values ('40320069872344',50001,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50002,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50003,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50004,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50005,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50006,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50007,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40320069872344',50008,1,118,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Seu Miyagi Sushi*/


insert into horario_funcionamento values (1,"19:00","23:30",'60098753214598',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'60098753214598',1);
insert into horario_funcionamento values (4,"19:00","23:30",'60098753214598',1);
insert into horario_funcionamento values (5,"19:00","23:30",'60098753214598',1);
insert into horario_funcionamento values (6,"19:00","01:00",'60098753214598',1);
insert into horario_funcionamento values (7,"19:00","01:00",'60098753214598',1);


/*Tipo Prato Seu Miyagi Sushi*/
insert into tipo_prato values (119,"Pratos Teste 15",'60098753214598');




/*Seu Miyagi Sushi*/
insert into prato values ('60098753214598',51001,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51002,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51003,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51004,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51005,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51006,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51007,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60098753214598',51008,1,119,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Pastel Trevo Bertioga Gonzaga*/


insert into horario_funcionamento values (1,"19:00","23:30",'40036598752014',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'40036598752014',1);
insert into horario_funcionamento values (4,"19:00","23:30",'40036598752014',1);
insert into horario_funcionamento values (5,"19:00","23:30",'40036598752014',1);
insert into horario_funcionamento values (6,"19:00","01:00",'40036598752014',1);
insert into horario_funcionamento values (7,"19:00","01:00",'40036598752014',1);


/*Tipo Prato Pastel Trevo Bertioga Gonzaga*/
insert into tipo_prato values (120,"Pratos Teste 16",'40036598752014');


/*Pastel Trevo Bertioga Gonzaga*/
insert into prato values ('40036598752014',52001,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52002,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52003,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52004,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52005,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52006,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52007,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40036598752014',52008,1,120,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Vivenda do Camarão*/


insert into horario_funcionamento values (1,"19:00","23:30",'98000054621357',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'98000054621357',1);
insert into horario_funcionamento values (4,"19:00","23:30",'98000054621357',1);
insert into horario_funcionamento values (5,"19:00","23:30",'98000054621357',1);
insert into horario_funcionamento values (6,"19:00","01:00",'98000054621357',1);
insert into horario_funcionamento values (7,"19:00","01:00",'98000054621357',1);


/*Tipo Prato Vivenda do Camarão*/
insert into tipo_prato values (121,"Pratos Teste 17",'98000054621357');




/*Vivenda do Camarão*/
insert into prato values ('98000054621357',53001,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53002,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53003,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53004,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53005,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53006,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53007,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98000054621357',53008,1,121,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Peixe na Brasa*/


insert into horario_funcionamento values (1,"19:00","23:30",'70063254789602',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'70063254789602',1);
insert into horario_funcionamento values (4,"19:00","23:30",'70063254789602',1);
insert into horario_funcionamento values (5,"19:00","23:30",'70063254789602',1);
insert into horario_funcionamento values (6,"19:00","01:00",'70063254789602',1);
insert into horario_funcionamento values (7,"19:00","01:00",'70063254789602',1);


/*Tipo Prato Peixe na Brasa*/
insert into tipo_prato values (122,"Pratos Teste 18",'70063254789602');


/*Peixe na Brasa*/
insert into prato values ('70063254789602',54001,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54002,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54003,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54004,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54005,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54006,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54007,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('70063254789602',54008,1,122,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Master Veggie*/


insert into horario_funcionamento values (1,"19:00","23:30",'64500008796321',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'64500008796321',1);
insert into horario_funcionamento values (4,"19:00","23:30",'64500008796321',1);
insert into horario_funcionamento values (5,"19:00","23:30",'64500008796321',1);
insert into horario_funcionamento values (6,"19:00","01:00",'64500008796321',1);
insert into horario_funcionamento values (7,"19:00","01:00",'64500008796321',1);


/*Tipo Prato Master Veggie*/
insert into tipo_prato values (123,"Pratos Teste 19",'64500008796321');



/*Master Veggie*/
insert into prato values ('64500008796321',55001,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55002,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55003,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55004,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55005,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55006,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55007,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('64500008796321',55008,1,123,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Desfrutti*/


insert into horario_funcionamento values (1,"19:00","23:30",'12340000078654',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'12340000078654',1);
insert into horario_funcionamento values (4,"19:00","23:30",'12340000078654',1);
insert into horario_funcionamento values (5,"19:00","23:30",'12340000078654',1);
insert into horario_funcionamento values (6,"19:00","01:00",'12340000078654',1);
insert into horario_funcionamento values (7,"19:00","01:00",'12340000078654',1);


/*Tipo Prato Desfrutti*/
insert into tipo_prato values (124,"Pratos Teste 20",'12340000078654');



/*Desfrutti*/
insert into prato values ('12340000078654',56001,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56002,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56003,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56004,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56005,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56006,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56007,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12340000078654',56008,1,124,"","Prato Teste","Descrição Prato Teste","R$29,90");


/*Horario Yê*/

insert into horario_funcionamento values (1,"19:00","23:30",'40788865200002',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'40788865200002',1);
insert into horario_funcionamento values (4,"19:00","23:30",'40788865200002',1);
insert into horario_funcionamento values (5,"19:00","23:30",'40788865200002',1);
insert into horario_funcionamento values (6,"19:00","01:00",'40788865200002',1);
insert into horario_funcionamento values (7,"19:00","01:00",'40788865200002',1);


/*Tipo Prato Yê*/
insert into tipo_prato values (125,"Pratos Teste 21",'40788865200002');



/*Yê*/
insert into prato values ('40788865200002',57001,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57002,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57003,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57004,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57005,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57006,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57007,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('40788865200002',57008,1,125,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Light Food Way*/

insert into horario_funcionamento values (1,"19:00","23:30",'23601478954223',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'23601478954223',1);
insert into horario_funcionamento values (4,"19:00","23:30",'23601478954223',1);
insert into horario_funcionamento values (5,"19:00","23:30",'23601478954223',1);
insert into horario_funcionamento values (6,"19:00","01:00",'23601478954223',1);
insert into horario_funcionamento values (7,"19:00","01:00",'23601478954223',1);


/*Tipo Prato Light Food Way*/
insert into tipo_prato values (126,"Pratos Teste 22",'23601478954223');

/*Light Food Way*/
insert into prato values ('23601478954223',58001,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58002,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58003,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58004,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58005,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58006,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58007,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23601478954223',58008,1,126,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Soutu Saudável*/

insert into horario_funcionamento values (1,"19:00","23:30",'13022200007567',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"19:00","23:30",'13022200007567',1);
insert into horario_funcionamento values (4,"19:00","23:30",'13022200007567',1);
insert into horario_funcionamento values (5,"19:00","23:30",'13022200007567',1);
insert into horario_funcionamento values (6,"19:00","01:00",'13022200007567',1);
insert into horario_funcionamento values (7,"19:00","01:00",'13022200007567',1);


/*Soutu Saudável*/
insert into tipo_prato values (127,"Pratos Teste 23",'13022200007567');


/*Soutu Saudável*/
insert into prato values ('13022200007567',59001,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59002,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59003,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59004,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59005,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59006,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59007,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13022200007567',59008,1,127,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Maria Açai*/

insert into horario_funcionamento values (1,"14:00","23:30",'20006578880005',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"14:00","23:30",'20006578880005',1);
insert into horario_funcionamento values (4,"14:00","23:30",'20006578880005',1);
insert into horario_funcionamento values (5,"14:00","23:30",'20006578880005',1);
insert into horario_funcionamento values (6,"14:00","01:00",'20006578880005',1);
insert into horario_funcionamento values (7,"14:00","01:00",'20006578880005',1);


/*Maria Açai*/
insert into tipo_prato values (128,"Pratos Teste 24",'20006578880005');


/*Maria Açai*/
insert into prato values ('20006578880005',60001,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60002,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60003,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60004,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60005,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60006,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60007,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20006578880005',60008,1,128,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Super Açai*/

insert into horario_funcionamento values (1,"12:00","23:30",'15478899660004',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"14:00","23:30",'15478899660004',1);
insert into horario_funcionamento values (4,"14:00","23:30",'15478899660004',1);
insert into horario_funcionamento values (5,"14:00","23:30",'15478899660004',1);
insert into horario_funcionamento values (6,"14:00","01:00",'15478899660004',1);
insert into horario_funcionamento values (7,"12:00","01:00",'15478899660004',1);


/*Super Açai*/
insert into tipo_prato values (129,"Pratos Teste 25",'15478899660004');

/*Super Açai*/
insert into prato values ('15478899660004',61001,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61002,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61003,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61004,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61005,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61006,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61007,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15478899660004',61008,1,129,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Zabari*/

insert into horario_funcionamento values (1,"11:00","23:30",'13567895412566',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"12:00","23:30",'13567895412566',1);
insert into horario_funcionamento values (4,"12:00","23:30",'13567895412566',1);
insert into horario_funcionamento values (5,"12:00","23:30",'13567895412566',1);
insert into horario_funcionamento values (6,"12:00","01:00",'13567895412566',1);
insert into horario_funcionamento values (7,"11:00","01:00",'13567895412566',1);


/*Zabari*/
insert into tipo_prato values (130,"Pratos Teste 26",'13567895412566');

/*Zabari*/
insert into prato values ('13567895412566',62001,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62002,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62003,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62004,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62005,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62006,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62007,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('13567895412566',62008,1,130,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Creperia da Praia*/

insert into horario_funcionamento values (1,"10:00","23:30",'23650004789564',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'23650004789564',1);
insert into horario_funcionamento values (4,"13:00","23:30",'23650004789564',1);
insert into horario_funcionamento values (5,"13:00","23:30",'23650004789564',1);
insert into horario_funcionamento values (6,"13:00","01:00",'23650004789564',1);
insert into horario_funcionamento values (7,"10:00","01:00",'23650004789564',1);


/*Creperia da Praia*/
insert into tipo_prato values (131,"Pratos Teste 27",'23650004789564');

/*Creperia da Praia*/
insert into prato values ('23650004789564',63001,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63002,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63003,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63004,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63005,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63006,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63007,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23650004789564',63008,1,131,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Pastel da Erika*/

insert into horario_funcionamento values (1,"10:00","23:30",'75320000478967',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'75320000478967',1);
insert into horario_funcionamento values (4,"13:00","23:30",'75320000478967',1);
insert into horario_funcionamento values (5,"13:00","23:30",'75320000478967',1);
insert into horario_funcionamento values (6,"13:00","01:00",'75320000478967',1);
insert into horario_funcionamento values (7,"10:00","01:00",'75320000478967',1);


/*Pastel da Erika*/
insert into tipo_prato values (132,"Pratos Teste 28",'75320000478967');



/*Pastel da Erika*/
insert into prato values ('75320000478967',64001,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64002,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64003,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64004,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64005,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64006,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64007,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75320000478967',64008,1,132,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Yoi Nami*/

insert into horario_funcionamento values (1,"10:00","23:30",'85200000365789',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'85200000365789',1);
insert into horario_funcionamento values (4,"13:00","23:30",'85200000365789',1);
insert into horario_funcionamento values (5,"13:00","23:30",'85200000365789',1);
insert into horario_funcionamento values (6,"13:00","01:00",'85200000365789',1);
insert into horario_funcionamento values (7,"10:00","01:00",'85200000365789',1);


/*Yoi Nami*/
insert into tipo_prato values (133,"Pratos Teste 29",'85200000365789');


/*Yoi Nami*/
insert into prato values ('85200000365789',65001,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65002,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65003,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65004,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65005,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65006,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65007,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('85200000365789',65008,1,133,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Amor aos Pedaços*/

insert into horario_funcionamento values (2,"10:00","16:30",'90006478954231',1);
insert into horario_funcionamento values (2,"20:00","23:59",'90006478954231',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'90006478954231',1);
insert into horario_funcionamento values (4,"13:00","23:30",'90006478954231',1);
insert into horario_funcionamento values (5,"13:00","23:30",'90006478954231',1);
insert into horario_funcionamento values (6,"13:00","01:00",'90006478954231',1);
insert into horario_funcionamento values (7,"10:00","01:00",'90006478954231',1);


/*Amor aos Pedaços*/
insert into tipo_prato values (134,"Pratos Teste 30",'90006478954231');



/*Amor aos Pedaços*/
insert into prato values ('90006478954231',66001,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66002,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66003,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66004,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66005,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66006,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66007,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('90006478954231',66008,1,134,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Vem la da Roça*/

insert into horario_funcionamento values (1,"10:00","23:30",'60987000065478',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'60987000065478',1);
insert into horario_funcionamento values (4,"13:00","23:30",'60987000065478',1);
insert into horario_funcionamento values (5,"13:00","23:30",'60987000065478',1);
insert into horario_funcionamento values (6,"13:00","01:00",'60987000065478',1);
insert into horario_funcionamento values (7,"10:00","01:00",'60987000065478',1);


/*Vem la da Roça*/
insert into tipo_prato values (135,"Pratos Teste 31",'60987000065478');

/*Vem la da Roça*/
insert into prato values ('60987000065478',67001,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67002,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67003,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67004,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67005,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67006,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67007,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('60987000065478',67008,1,135,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Capitão Grill*/

insert into horario_funcionamento values (1,"10:00","23:30",'75620003214578',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'75620003214578',1);
insert into horario_funcionamento values (4,"13:00","23:30",'75620003214578',1);
insert into horario_funcionamento values (5,"13:00","23:30",'75620003214578',1);
insert into horario_funcionamento values (6,"13:00","01:00",'75620003214578',1);
insert into horario_funcionamento values (7,"10:00","01:00",'75620003214578',1);


/*Capitão Grill*/
insert into tipo_prato values (136,"Pratos Teste 32",'75620003214578');

/*Capitão Grill*/
insert into prato values ('75620003214578',68001,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68002,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68003,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68004,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68005,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68006,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68007,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75620003214578',68008,1,136,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Bolo da Madre*/

insert into horario_funcionamento values (1,"10:00","23:30",'56478921305478',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'56478921305478',1);
insert into horario_funcionamento values (4,"13:00","23:30",'56478921305478',1);
insert into horario_funcionamento values (5,"13:00","23:30",'56478921305478',1);
insert into horario_funcionamento values (6,"13:00","01:00",'56478921305478',1);
insert into horario_funcionamento values (7,"10:00","01:00",'56478921305478',1);


/*Bolo da Madre*/
insert into tipo_prato values (137,"Pratos Teste 33",'56478921305478');


/*Bolo da Madre*/
insert into prato values ('56478921305478',69001,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69002,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69003,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69004,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69005,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69006,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69007,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56478921305478',69008,1,137,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Grife dos Brigadeiros*/

insert into horario_funcionamento values (1,"10:00","23:30",'55021230014785',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'55021230014785',1);
insert into horario_funcionamento values (4,"13:00","23:30",'55021230014785',1);
insert into horario_funcionamento values (5,"13:00","23:30",'55021230014785',1);
insert into horario_funcionamento values (6,"13:00","01:00",'55021230014785',1);
insert into horario_funcionamento values (7,"10:00","01:00",'55021230014785',1);


/*Grife dos Brigadeiros*/
insert into tipo_prato values (138,"Pratos Teste 34",'55021230014785');




/*Grife dos Brigadeiros*/
insert into prato values ('55021230014785',70001,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70002,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70003,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70004,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70005,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70006,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70007,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('55021230014785',70008,1,138,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Conrado Brigaderia*/

insert into horario_funcionamento values (1,"10:00","23:30",'32500097896541',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'32500097896541',1);
insert into horario_funcionamento values (4,"13:00","23:30",'32500097896541',1);
insert into horario_funcionamento values (5,"13:00","23:30",'32500097896541',1);
insert into horario_funcionamento values (6,"13:00","01:00",'32500097896541',1);
insert into horario_funcionamento values (7,"10:00","01:00",'32500097896541',1);


/*Conrado Brigaderia*/
insert into tipo_prato values (139,"Pratos Teste 35",'32500097896541');




/*Conrado Brigaderia*/
insert into prato values ('32500097896541',71001,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71002,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71003,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71004,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71005,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71006,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71007,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('32500097896541',71008,1,139,"","Prato Teste","Descrição Prato Teste","R$29,90");


/*Horario Lig-Lig*/

insert into horario_funcionamento values (1,"10:00","23:30",'12035789451523',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'12035789451523',1);
insert into horario_funcionamento values (4,"13:00","23:30",'12035789451523',1);
insert into horario_funcionamento values (5,"13:00","23:30",'12035789451523',1);
insert into horario_funcionamento values (6,"13:00","01:00",'12035789451523',1);
insert into horario_funcionamento values (7,"10:00","01:00",'12035789451523',1);


/*Lig-Lig*/
insert into tipo_prato values (140,"Pratos Teste 36",'12035789451523');




/*Lig-Lig*/
insert into prato values ('12035789451523',72001,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72002,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72003,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72004,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72005,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72006,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72007,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('12035789451523',72008,1,140,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario China Gourmet*/

insert into horario_funcionamento values (1,"10:00","23:30",'23600087544423',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'23600087544423',1);
insert into horario_funcionamento values (4,"13:00","23:30",'23600087544423',1);
insert into horario_funcionamento values (5,"13:00","23:30",'23600087544423',1);
insert into horario_funcionamento values (6,"13:00","01:00",'23600087544423',1);
insert into horario_funcionamento values (7,"10:00","01:00",'23600087544423',1);


/*China Gourmet*/
insert into tipo_prato values (141,"Pratos Teste 37",'23600087544423');




/*China Gourmet*/
insert into prato values ('23600087544423',73001,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73002,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73003,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73004,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73005,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73006,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73007,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23600087544423',73008,1,141,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Mel Sucos e Lanches*/

insert into horario_funcionamento values (1,"10:00","23:30",'50400098745632',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'50400098745632',1);
insert into horario_funcionamento values (4,"13:00","23:30",'50400098745632',1);
insert into horario_funcionamento values (5,"13:00","23:30",'50400098745632',1);
insert into horario_funcionamento values (6,"13:00","01:00",'50400098745632',1);
insert into horario_funcionamento values (7,"10:00","01:00",'50400098745632',1);


/*Mel Sucos e Lanches*/
insert into tipo_prato values (142,"Pratos Teste 38",'50400098745632');




/*Mel Sucos e Lanches */
insert into prato values ('50400098745632',74001,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74002,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74003,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74004,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74005,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74006,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74007,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('50400098745632',74008,1,142,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Sabor da Praça*/

insert into horario_funcionamento values (1,"10:00","23:30",'34500087954121',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'34500087954121',1);
insert into horario_funcionamento values (4,"13:00","23:30",'34500087954121',1);
insert into horario_funcionamento values (5,"13:00","23:30",'34500087954121',1);
insert into horario_funcionamento values (6,"13:00","01:00",'34500087954121',1);
insert into horario_funcionamento values (7,"10:00","01:00",'34500087954121',1);


/*Sabor da Praça*/
insert into tipo_prato values (143,"Pratos Teste 39",'34500087954121');




/*Sabor da Praça*/
insert into prato values ('34500087954121',75001,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75002,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75003,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75004,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75005,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75006,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75007,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('34500087954121',75008,1,143,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Delicias & Cia*/

insert into horario_funcionamento values (1,"10:00","23:30",'62145789656423',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'62145789656423',1);
insert into horario_funcionamento values (4,"13:00","23:30",'62145789656423',1);
insert into horario_funcionamento values (5,"13:00","23:30",'62145789656423',1);
insert into horario_funcionamento values (6,"13:00","01:00",'62145789656423',1);
insert into horario_funcionamento values (7,"10:00","01:00",'62145789656423',1);


/*Delicias & Cia*/
insert into tipo_prato values (144,"Pratos Teste 40",'62145789656423');




/*Delicias & Cia*/
insert into prato values ('62145789656423',76001,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76002,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76003,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76004,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76005,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76006,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76007,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('62145789656423',76008,1,144,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Shake Burger*/

insert into horario_funcionamento values (1,"10:00","23:30",'78945695123578',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'78945695123578',1);
insert into horario_funcionamento values (4,"13:00","23:30",'78945695123578',1);
insert into horario_funcionamento values (5,"13:00","23:30",'78945695123578',1);
insert into horario_funcionamento values (6,"13:00","01:00",'78945695123578',1);
insert into horario_funcionamento values (7,"10:00","01:00",'78945695123578',1);


/*Shake Burger*/
insert into tipo_prato values (145,"Pratos Teste 41",'78945695123578');




/*Shake Burger*/
insert into prato values ('78945695123578',77001,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77002,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77003,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77004,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77005,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77006,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77007,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945695123578',77008,1,145,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Burgui Food*/

insert into horario_funcionamento values (1,"10:00","23:30",'82395784561856',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'82395784561856',1);
insert into horario_funcionamento values (4,"13:00","23:30",'82395784561856',1);
insert into horario_funcionamento values (5,"13:00","23:30",'82395784561856',1);
insert into horario_funcionamento values (6,"13:00","01:00",'82395784561856',1);
insert into horario_funcionamento values (7,"10:00","01:00",'82395784561856',1);


/*Burgui Food*/
insert into tipo_prato values (146,"Pratos Teste 42",'82395784561856');




/*Burgui Food*/
insert into prato values ('82395784561856',78001,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78002,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78003,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78004,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78005,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78006,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78007,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('82395784561856',78008,1,146,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Bacio Di Latte*/

insert into horario_funcionamento values (1,"10:00","23:30",'89632574188956',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'89632574188956',1);
insert into horario_funcionamento values (4,"13:00","23:30",'89632574188956',1);
insert into horario_funcionamento values (5,"13:00","23:30",'89632574188956',1);
insert into horario_funcionamento values (6,"13:00","01:00",'89632574188956',1);
insert into horario_funcionamento values (7,"10:00","01:00",'89632574188956',1);


/*Bacio Di Latte*/
insert into tipo_prato values (147,"Pratos Teste 43",'89632574188956');




/*Bacio Di Latte*/
insert into prato values ('89632574188956',79001,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79002,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79003,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79004,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79005,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79006,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79007,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('89632574188956',79008,1,147,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Bamba Açai*/

insert into horario_funcionamento values (1,"10:00","23:30",'78945789641231',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'78945789641231',1);
insert into horario_funcionamento values (4,"13:00","23:30",'78945789641231',1);
insert into horario_funcionamento values (5,"13:00","23:30",'78945789641231',1);
insert into horario_funcionamento values (6,"13:00","01:00",'78945789641231',1);
insert into horario_funcionamento values (7,"10:00","01:00",'78945789641231',1);


/*Bamba Açai*/
insert into tipo_prato values (148,"Pratos Teste 44",'78945789641231');




/*Bamba Açai*/
insert into prato values ('78945789641231',80001,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80002,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80003,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80004,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80005,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80006,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80007,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('78945789641231',80008,1,148,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Aloha Poke Beer*/

insert into horario_funcionamento values (1,"10:00","23:30",'71945879641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'71945879641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'71945879641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'71945879641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'71945879641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'71945879641237',1);


/*Aloha Poke Beer*/
insert into tipo_prato values (149,"Pratos Teste 45",'71945879641237');




/*Aloha Poke Beer*/
insert into prato values ('71945879641237',81001,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81002,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81003,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81004,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81005,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81006,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81007,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71945879641237',81008,1,149,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Domino's Pizza*/

insert into horario_funcionamento values (1,"10:00","23:30",'47945789648537',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'47945789648537',1);
insert into horario_funcionamento values (4,"13:00","23:30",'47945789648537',1);
insert into horario_funcionamento values (5,"13:00","23:30",'47945789648537',1);
insert into horario_funcionamento values (6,"13:00","01:00",'47945789648537',1);
insert into horario_funcionamento values (7,"10:00","01:00",'47945789648537',1);


/*Domino's Pizza*/
insert into tipo_prato values (150,"Pratos Teste 46",'47945789648537');




/*Domino's Pizza*/
insert into prato values ('47945789648537',82001,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82002,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82003,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82004,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82005,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82006,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82007,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('47945789648537',82008,1,150,"","Prato Teste","Descrição Prato Teste","R$29,90");





/*Horario Sabores do Mar*/

insert into horario_funcionamento values (1,"10:00","23:30",'20145789625237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'20145789625237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'20145789625237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'20145789625237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'20145789625237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'20145789625237',1);


/*Sabores do Mar*/
insert into tipo_prato values (151,"Pratos Teste 47",'20145789625237');




/*Sabores do Mar*/
insert into prato values ('20145789625237',83001,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83002,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83003,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83004,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83005,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83006,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83007,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('20145789625237',83008,1,151,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Burger Company*/

insert into horario_funcionamento values (1,"10:00","23:30",'38945784741237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'38945784741237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'38945784741237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'38945784741237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'38945784741237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'38945784741237',1);


/*Burger Company*/
insert into tipo_prato values (152,"Pratos Teste 48",'38945784741237');




/*Burger Company*/
insert into prato values ('38945784741237',84001,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84002,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84003,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84004,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84005,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84006,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84007,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('38945784741237',84008,1,152,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Mordidela*/

insert into horario_funcionamento values (1,"10:00","23:30",'75845786641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'75845786641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'75845786641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'75845786641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'75845786641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'75845786641237',1);


/*Mordidela*/
insert into tipo_prato values (153,"Pratos Teste 49",'75845786641237');



/*Mordidela*/
insert into prato values ('75845786641237',85001,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85002,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85003,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85004,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85005,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85006,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85007,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('75845786641237',85008,1,153,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Precious Burguer*/

insert into horario_funcionamento values (1,"10:00","23:30",'96445781441237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'96445781441237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'96445781441237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'96445781441237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'96445781441237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'96445781441237',1);


/*Precious Burguer*/
insert into tipo_prato values (154,"Pratos Teste 50",'96445781441237');



/*Precious Burguer*/
insert into prato values ('96445781441237',86001,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86002,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86003,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86004,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86005,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86006,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86007,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('96445781441237',86008,1,154,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Esfiharia Santista 2*/

insert into horario_funcionamento values (1,"10:00","23:30",'65445788941237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'65445788941237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'65445788941237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'65445788941237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'65445788941237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'65445788941237',1);


/*Esfiharia Santista 2*/
insert into tipo_prato values (155,"Pratos Teste 51",'65445788941237');



/*Esfiharia Santista 2*/
insert into prato values ('65445788941237',87001,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87002,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87003,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87004,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87005,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87006,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87007,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('65445788941237',87008,1,155,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Yakisoba do Pezão*/

insert into horario_funcionamento values (1,"10:00","23:30",'35845710641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'35845710641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'35845710641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'35845710641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'35845710641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'35845710641237',1);


/*Yakisoba do Pezão*/
insert into tipo_prato values (156,"Pratos Teste 52",'35845710641237');



/*Yakisoba do Pezão*/
insert into prato values ('35845710641237',88001,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88002,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88003,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88004,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88005,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88006,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88007,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('35845710641237',88008,1,156,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Vitshop*/

insert into horario_funcionamento values (1,"10:00","23:30",'71045736641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'71045736641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'71045736641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'71045736641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'71045736641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'71045736641237',1);


/*Vitshop*/
insert into tipo_prato values (157,"Pratos Teste 53",'71045736641237');


/*Vitshop*/
insert into prato values ('71045736641237',89001,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89002,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89003,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89004,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89005,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89006,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89007,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('71045736641237',89008,1,157,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Empório da Granola*/

insert into horario_funcionamento values (1,"10:00","23:30",'98685789641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'98685789641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'98685789641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'98685789641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'98685789641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'98685789641237',1);


/*Empório da Granola*/
insert into tipo_prato values (158,"Pratos Teste 54",'98685789641237');



/*Empório da Granola*/
insert into prato values ('98685789641237',90001,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90002,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90003,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90004,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90005,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90006,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90007,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98685789641237',90008,1,158,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Capim Limao*/

insert into horario_funcionamento values (1,"10:00","23:30",'45789110641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'45789110641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'45789110641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'45789110641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'45789110641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'45789110641237',1);


/*Capim Limao*/
insert into tipo_prato values (159,"Pratos Teste 55",'45789110641237');



/*Capim Limao*/
insert into prato values ('45789110641237',91001,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91002,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91003,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91004,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91005,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91006,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91007,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45789110641237',91008,1,159,"","Prato Teste","Descrição Prato Teste","R$29,90");


/*Horario Restaurante Rota Nordestina*/

insert into horario_funcionamento values (1,"10:00","23:30",'84725789641237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'84725789641237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'84725789641237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'84725789641237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'84725789641237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'84725789641237',1);


/*Restaurante Rota Nordestina*/
insert into tipo_prato values (160,"Pratos Teste 56",'84725789641237');



/*Restaurante Rota Nordestina*/
insert into prato values ('84725789641237',92001,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92002,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92003,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92004,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92005,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92006,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92007,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('84725789641237',92008,1,160,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Giraffas*/

insert into horario_funcionamento values (1,"10:00","23:30",'99945789641251',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'99945789641251',1);
insert into horario_funcionamento values (4,"13:00","23:30",'99945789641251',1);
insert into horario_funcionamento values (5,"13:00","23:30",'99945789641251',1);
insert into horario_funcionamento values (6,"13:00","01:00",'99945789641251',1);
insert into horario_funcionamento values (7,"10:00","01:00",'99945789641251',1);


/*Giraffas*/
insert into tipo_prato values (161,"Pratos Teste 57",'99945789641251');



/*Giraffas*/
insert into prato values ('99945789641251',93001,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93002,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93003,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93004,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93005,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93006,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93007,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('99945789641251',93008,1,161,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Pedra Baiana*/

insert into horario_funcionamento values (1,"10:00","23:30",'10235789641542',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'10235789641542',1);
insert into horario_funcionamento values (4,"13:00","23:30",'10235789641542',1);
insert into horario_funcionamento values (5,"13:00","23:30",'10235789641542',1);
insert into horario_funcionamento values (6,"13:00","01:00",'10235789641542',1);
insert into horario_funcionamento values (7,"10:00","01:00",'10235789641542',1);


/*Pedra Baiana*/
insert into tipo_prato values (162,"Pratos Teste 58",'10235789641542');



/*Pedra Baiana*/
insert into prato values ('10235789641542',94001,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94002,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94003,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94004,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94005,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94006,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94007,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('10235789641542',94008,1,162,"","Prato Teste","Descrição Prato Teste","R$29,90");




/*Horario Yakissoba Brasil*/

insert into horario_funcionamento values (1,"10:00","23:30",'98655789641987',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'98655789641987',1);
insert into horario_funcionamento values (4,"13:00","23:30",'98655789641987',1);
insert into horario_funcionamento values (5,"13:00","23:30",'98655789641987',1);
insert into horario_funcionamento values (6,"13:00","01:00",'98655789641987',1);
insert into horario_funcionamento values (7,"10:00","01:00",'98655789641987',1);


/*Yakissoba Brasil*/
insert into tipo_prato values (163,"Pratos Teste 59",'98655789641987');



/*Yakissoba Brasil*/
insert into prato values ('98655789641987',95001,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95002,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95003,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95004,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95005,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95006,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95007,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('98655789641987',95008,1,163,"","Prato Teste","Descrição Prato Teste","R$29,90");

select * from  prato where cd_cnpj_restaurante = 98655789641987;

/*Horario Stella's Gourmet*/

insert into horario_funcionamento values (1,"10:00","23:30",'56545789641285',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'56545789641285',1);
insert into horario_funcionamento values (4,"13:00","23:30",'56545789641285',1);
insert into horario_funcionamento values (5,"13:00","23:30",'56545789641285',1);
insert into horario_funcionamento values (6,"13:00","01:00",'56545789641285',1);
insert into horario_funcionamento values (7,"10:00","01:00",'56545789641285',1);


/*Stella's Gourmet*/
insert into tipo_prato values (164,"Pratos Teste 60",'56545789641285');



/*Stella's Gourmet*/
insert into prato values ('56545789641285',96001,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96002,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96003,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96004,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96005,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96006,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96007,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('56545789641285',96008,1,164,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Baixada Fit*/

insert into horario_funcionamento values (1,"10:00","23:30",'15984578964123',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'15984578964123',1);
insert into horario_funcionamento values (4,"13:00","23:30",'15984578964123',1);
insert into horario_funcionamento values (5,"13:00","23:30",'15984578964123',1);
insert into horario_funcionamento values (6,"13:00","01:00",'15984578964123',1);
insert into horario_funcionamento values (7,"10:00","01:00",'15984578964123',1);


/*Baixada Fit*/
insert into tipo_prato values (165,"Pratos Teste 61",'15984578964123');



/*Baixada Fit*/
insert into prato values ('15984578964123',97001,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97002,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97003,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97004,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97005,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97006,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97007,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('15984578964123',97008,1,165,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Monkey St.*/

insert into horario_funcionamento values (1,"10:00","23:30",'58545789647485',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'58545789647485',1);
insert into horario_funcionamento values (4,"13:00","23:30",'58545789647485',1);
insert into horario_funcionamento values (5,"13:00","23:30",'58545789647485',1);
insert into horario_funcionamento values (6,"13:00","01:00",'58545789647485',1);
insert into horario_funcionamento values (7,"10:00","01:00",'58545789647485',1);


/*Monkey St.*/
insert into tipo_prato values (166,"Pratos Teste 62",'58545789647485');



/*Monkey St.*/
insert into prato values ('58545789647485',98001,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98002,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98003,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98004,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98005,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98006,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98007,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('58545789647485',98008,1,166,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Artesanal X Burger*/

insert into horario_funcionamento values (1,"10:00","23:30",'23245789625237',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'23245789625237',1);
insert into horario_funcionamento values (4,"13:00","23:30",'23245789625237',1);
insert into horario_funcionamento values (5,"13:00","23:30",'23245789625237',1);
insert into horario_funcionamento values (6,"13:00","01:00",'23245789625237',1);
insert into horario_funcionamento values (7,"10:00","01:00",'23245789625237',1);


/*Artesanal X Burger*/
insert into tipo_prato values (167,"Pratos Teste 63",'23245789625237');


/*Artesanal X Burger*/
insert into prato values ('23245789625237',99001,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99002,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99003,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99004,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99005,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99006,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99007,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('23245789625237',99008,1,167,"","Prato Teste","Descrição Prato Teste","R$29,90");



/*Horario Seu Burger*/

insert into horario_funcionamento values (1,"10:00","23:30",'45855789641275',1);
/*fechado na Segunda*/
insert into horario_funcionamento values (3,"13:00","23:30",'45855789641275',1);
insert into horario_funcionamento values (4,"13:00","23:30",'45855789641275',1);
insert into horario_funcionamento values (5,"13:00","23:30",'45855789641275',1);
insert into horario_funcionamento values (6,"13:00","01:00",'45855789641275',1);
insert into horario_funcionamento values (7,"10:00","01:00",'45855789641275',1);


/*Seu Burger*/
insert into tipo_prato values (168,"Pratos Teste 64",'45855789641275');



/*Seu Burger*/
insert into prato values ('45855789641275',100001,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100002,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100003,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100004,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100005,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100006,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100007,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");
insert into prato values ('45855789641275',100008,1,168,"","Prato Teste","Descrição Prato Teste","R$29,90");