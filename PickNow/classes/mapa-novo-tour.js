var map;

var mapStyle = [
    {
        "featureType": "all",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "32"
            },
            {
                "lightness": "-3"
            },
            {
                "visibility": "on"
            },
            {
                "weight": "1.18"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "-70"
            },
            {
                "lightness": "14"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "saturation": "100"
            },
            {
                "lightness": "-14"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            },
            {
                "lightness": "12"
            }
        ]
    }
    
]

function carregaMapa()
{

    var mapId = document.getElementById('mapa'); /*--- 'mapa' ---*/
    /*alert('Elemento html verificado no Id do Mapa Ok.')*/

    var mapOpcoes = {
        center: new google.maps.LatLng(48.8586542,2.2971404),
        /* Controles do Mapa */
        mapTypeControl: false,
        mapTypeControlOptions:
        {
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
            mapTypeIds: [google.maps.MapTypeId.ROADMAP,
                         google.maps.MapTypeId.SATELITE,
                         google.maps.MapTypeId.HYBRID],
            position: google.maps.ControlPosition.TOP_RIGHT
        },

        mapTypeId: google.maps.MapTypeId.ROADMAP,
        /* Zoom + Gesto de Manipulação*/

        gestureHandling: 'greedy',
        zoom: 12,
        minZoom: 10,
        maxZoom: 20,
        zoomControl: true,
        zoomControlOptions:
        {
            position: google.maps.ControlPosition.RIGHT_TOP
        },
        streetViewControl: false,

        styles: mapStyle
    }
  
    // Por mapa com sua Config. completa na tela.
    map = new google.maps.Map( mapId,mapOpcoes );
   
}

var locais = [
 { 'x': '48.8547', 'y': '2.3372', 'titulo': 'Ilê de la Cité', 'LINK': '#', 'RUA': 'Centro de Paris','foto':'img/ile-da-cite.jpg'},
 { 'x': '48.851207', 'y': '2.357611', 'titulo': 'Ilê Saint-Louis', 'LINK': '#', 'RUA': 'Île Saint-Louis, 75004 Paris, França','foto':'img/ile-saint-louis.jpg'},
 { 'x': '48.851350', 'y': '2.343320', 'titulo': 'Quartier Latin de Paris', 'LINK': '#', 'RUA': 'Quartier Latin, Paris, França','foto':'img/quartier-latin-paris.jpg'},
 { 'x': '48.884370', 'y': '2.343330', 'titulo': 'Montmartre', 'LINK': '#', 'RUA': 'Montmartre, 75018 Paris, França','foto':'img/montmartre.jpg'},
 { 'x': '48.8910034', 'y': '2.1733269', 'titulo': 'La Defense','LINK': '#', 'RUA': 'La Defense, França','foto':'img/la-defense.jpg'},
 { 'x': '48.869789', 'y': '2.3056251', 'titulo': 'Champs Élyées','LINK': '#', 'RUA': 'Av. des Champs-Élysées, 75008 Paris, França','foto':'img/Champs-elysees.jpg'},
 { 'x': '48.8656331', 'y': '2.3212357', 'titulo': 'Praça le la Concorde','LINK': '#', 'RUA': 'Av. des Champs-Élysées, 75008 Paris, França','foto':'img/praca-le-la-concorde.jpg'},
 { 'x': '48.867435', 'y': '2.329437', 'titulo': 'Praça Vendôme','LINK': '#', 'RUA': 'Place Vendôme, 75001 Paris, França','foto':'img/praca-vendome.jpg'}
];


function criarJanelaInfo(marcador)
{
    var conteudo = '<div class="conteudojanela">';
        conteudo += '<img class="img-lugar fl" src=\"'+ marcador.imagem + '\">';
        conteudo += '<div class="titulo-div fl"><h1 class="tituloMarcador">' + marcador.title + '</h1></div>';
        conteudo += '<p class="paragrafoMarcador">' + marcador.endereco + '</p>';
        conteudo += '<a class="marcadorLink fl" href=\"' + marcador.link + '\" target="_blank">Mais informação</a>';
        conteudo += '<button class="botaoAdicionar-Retirar fl">Adicionar</button>';
        conteudo += '<button class="botaoAdicionar-Retirar fl">Retirar</button>';
        conteudo += '<div class="cl"></div>';

    var JanelaInfo = new google.maps.InfoWindow({
        content: conteudo
    });

    google.maps.event.addListener(marcador, 'click', function(event){
        JanelaInfo.open(map, marcador);
    })
}


var marcadores01 =[];

function carregarMarcadores()
{
    for (var i = 0; i < locais.length; i++) 
    {
        var marcador01 = new google.maps.Marker({
        position: new google.maps.LatLng( locais[i].x, locais[i].y),
        imagem: locais[i].foto,
        title: locais[i].titulo,
        endereco: locais[i].RUA,
        link: locais[i].LINK,
        icon: {
                url: 'marcadores/Marcador-Praças.png',
                size: new google.maps.Size(34,50),
                origin: new google.maps.Point(0,0),
                anchor: new google.maps.Point(20,50),
                scaledSize: new google.maps.Size(34,50)
              }
        });

        marcador01.setMap(map);
        criarJanelaInfo(marcador01);      

        marcadores01.push(marcador01);
    }
}

/*-------- Lista 02: Pontos Turísticos --------*/


var locais02 = [
 { 'x': '48.858372', 'y': '2.294481', 'titulo': 'Torre Eiffel', 'LINK': 'Torre-Eiffel.html', 'RUA': ' Champ de Mars, 5 Avenue Anatole France, 75007 Paris, França','foto':'img/torre-eiffel-pequena.jpg'},
 { 'x': '48.873774', 'y': '2.295050', 'titulo': 'Arco do Triunfo', 'LINK': '#', 'RUA': 'Aeroporto de Paris-Charles de Gaulle','foto':'img/arco-do-triunfo-pequeno.jpg'},
 { 'x': '48.8462218', 'y': '2.3464138', 'titulo': 'Panteão de Paris', 'LINK': '#', 'RUA': 'Place du Panthéon, 75005 Paris, França','foto':'img/panteon-de-paris.jpg'},
 { 'x': '48.8550869', 'y': '2.3125577', 'titulo': 'Hôtel de Invalides', 'LINK': '#', 'RUA': 'Rond-Point du Bleuet de France, 75007 Paris, França','foto':'img/hotel-invalides.jpg'},
 { 'x': '48.8719697', 'y': '2.3316014', 'titulo': 'Ópera Garnier', 'LINK': '#', 'RUA': 'Place de Opéra, 75009 Paris, França','foto':'img/opera-garnier.jpg'},
 { 'x': '48.8048649', 'y': '2.1203554', 'titulo': 'Palácio de Versalhes', 'LINK': '#', 'RUA': 'Place de Armes, 78000 Versailles, França','foto':'img/palacio-de-versalhes.jpg'},
 { 'x': '48.8338325', 'y': '2.3324222', 'titulo': 'Catacumbas de Paris', 'LINK': '#', 'RUA': '1 Avenue du Colonel Henri Rol-Tanguy, 75014 Paris, França','foto':'img/catacumbas-paris.jpg'}

];

var marcadores02 = [];

function carregarMarcadores02()
{
    for (var i = 0; i < locais02.length; i++) 
    {
        var marcador02 = new google.maps.Marker({
        position: new google.maps.LatLng( locais02[i].x, locais02[i].y),
        imagem: locais02[i].foto,
        title: locais02[i].titulo,
        endereco: locais02[i].RUA,
        link: locais02[i].LINK,
        icon: {
                url: 'marcadores/Marcador-Camera.png',
                size: new google.maps.Size(34,50),
                origin: new google.maps.Point(0,0),
                anchor: new google.maps.Point(20,50),
                scaledSize: new google.maps.Size(34,50)
              }
        });

        marcador02.setMap(map);
        criarJanelaInfo(marcador02);

        marcadores02.push(marcador02);
    }
}


/*-------- Lista 03: Museus --------*/

var locais03 = [
 { 'x': '48.861148', 'y': '2.333696', 'titulo': 'Museu do Louvre', 'LINK': '#', 'RUA': ' Champ de Mars, 5 Avenue Anatole France, 75007 Paris, França','foto':'img/museu-do-louvre-pequeno.jpg'},
 { 'x': '48.8599614', 'y': '2.3265614', 'titulo': 'Museu de Orsay', 'LINK': '#', 'RUA': ' Champ de Mars, 5 Avenue Anatole France, 75007 Paris, França','foto':'img/museu-dorsay.jpg'},
 { 'x': '48.860642', 'y': '2.352245', 'titulo': 'Centro Georges Pompidou', 'LINK': '#', 'RUA': 'Place Georges-Pompidou, 75004 Paris, França','foto':'img/centro-pompidou.jpg'},
 { 'x': '48.8608889', 'y': '2.297894', 'titulo': 'Museu do Quai Brainly', 'LINK': '#', 'RUA': '37 Quai Branly, 75007 Paris, França','foto':'img/museu-do-quai-branly.jpg'},
 { 'x': '48.854747', 'y': '2.315867', 'titulo': 'Museu Rodin', 'LINK': '#', 'RUA': '77 Rue de Varenne, 75007 Paris, França','foto':'img/museu-rodin.jpg'}
];


var marcadores03 = [];

function carregarMarcadores03()
{
    for (var i = 0; i < locais03.length; i++) 
    {
        var marcador03 = new google.maps.Marker({
        position: new google.maps.LatLng( locais03[i].x, locais03[i].y),
        imagem: locais03[i].foto,
        title: locais03[i].titulo,
        endereco: locais03[i].RUA,
        link: locais03[i].LINK,
        icon: {
                url: 'marcadores/Marcador-Museu.png',
                size: new google.maps.Size(34,50),
                origin: new google.maps.Point(0,0),
                anchor: new google.maps.Point(20,50),
                scaledSize: new google.maps.Size(34,50)
              }
        });

        marcador03.setMap(map);
        criarJanelaInfo(marcador03);

        marcadores03.push(marcador03);
    }
}


/*-------- Lista 04: Locais Religiosos --------*/

var locais04 = [
 { 'x': '48.852968', 'y': '2.349902', 'titulo': 'Catedral de Notre Dame', 'LINK': '#', 'RUA': ' 6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris, França','foto':'img/catedral-de-notre-dame-pequena.jpg'},
 { 'x': '48.886726', 'y': '2.343053', 'titulo': 'Basílica de Sacré Coeur', 'LINK': '#', 'RUA': '35 Rue du Chevalier de la Barre, 75018 Paris, França','foto':'img/basilica-sacre-coeur.jpg'},
 { 'x': '48.855420', 'y': '2.344987', 'titulo': 'Sainte Chapelle', 'LINK': '#', 'RUA': ' 8 Boulevard du Palais, 75001 Paris, França','foto':'img/sainte-chapelle.jpg'},
 { 'x': '48.935461', 'y': '2.359835', 'titulo': 'Basílica de Saint-Denis', 'LINK': '#', 'RUA': '1 Rue de la Légion de Honneur, 93200 Saint-Denis, França','foto':'img/basilica-de-saint-denis.jpg'},
 { 'x': '48.870044', 'y': '2.324550', 'titulo': 'Igreja Madeleine', 'LINK': '#', 'RUA': 'Place de la Madeleine, 75008 Paris, França','foto':'img/igreja-madeleine.jpg'},
 { 'x': '48.865101', 'y': '2.293690', 'titulo': 'Museu Guimet', 'LINK': '#', 'RUA': '6 Place de Iéna, 75116 Paris, França','foto':'img/museu-guimet.jpg'},
 { 'x': '48.850483', 'y': '2.344081', 'titulo': 'Museu de Cluny', 'LINK': '#', 'RUA': '28 Rue du Sommerard, 75005 Paris, França','foto':'img/museu-de-cluny.jpg'},
 { 'x': '48.878824', 'y': '2.312791', 'titulo': 'Museu Nissim de Camondo', 'LINK': '#', 'RUA': '63 Rue de Monceau, 75008 Paris, França','foto':'img/museu-nissim-de-camondo.jpg'}

];

var marcadores04 = [];

function carregarMarcadores04()
{
    for (var i = 0; i < locais04.length; i++) 
    {
        var marcador04 = new google.maps.Marker({
        position: new google.maps.LatLng( locais04[i].x, locais04[i].y),
        imagem: locais04[i].foto,
        title: locais04[i].titulo,
        endereco: locais04[i].RUA,
        link: locais04[i].LINK,
        icon: {
                url: 'marcadores/Marcador-Igreja.png',
                size: new google.maps.Size(34,50),
                origin: new google.maps.Point(0,0),
                anchor: new google.maps.Point(20,50),
                scaledSize: new google.maps.Size(34,50)
              }
        });

        marcador04.setMap(map);
        criarJanelaInfo(marcador04);

        marcadores04.push(marcador04);
    }
}


/*-------- Lista 05: Pontos Turísticos --------*/


var locais05 = [
 { 'x': '48.846222', 'y': '2.337160', 'titulo': 'Jardim de Luxemburgo', 'LINK': '#', 'RUA': ' 75006 Paris, França','foto':'img/Jardim-de-Luxemburgo.jpg'},
 { 'x': '48.863492', 'y': '2.327494', 'titulo': 'Jardins das Tulherias', 'LINK': '#', 'RUA': '113 Rue de Rivoli, 75001 Paris, França','foto':'img/Jardim-de-Luxemburgo.jpg'},
 { 'x': '48.843329', 'y': '2.360959', 'titulo': 'Jardim das Plantas de Paris', 'LINK': '#', 'RUA': '57 Rue Cuvier, 75005 Paris, França','foto':'img/jardim-das-plantas.jpg'}
];

var marcadores05 = [];

function carregarMarcadores05()
{
    for (var i = 0; i < locais05.length; i++) 
    {
        var marcador05 = new google.maps.Marker({
        position: new google.maps.LatLng( locais05[i].x, locais05[i].y),
        imagem: locais05[i].foto,
        title: locais05[i].titulo,
        endereco: locais05[i].RUA,
        link: locais05[i].LINK,
        icon: {
                url: 'marcadores/Marcador-Parque.png',
                size: new google.maps.Size(34,50),
                origin: new google.maps.Point(0,0),
                anchor: new google.maps.Point(20,50),
                scaledSize: new google.maps.Size(34,50)
              }
        });

        marcador05.setMap(map);
        criarJanelaInfo(marcador05);

        marcadores05.push(marcador05);
    }
}

function OpenCloseAllMark()
{
    document.getElementById('TODOS').onclick = function()
    {
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(map);
        }
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(map);
        }
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(map);
        }
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(map);
        }
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(map);
        }
    };
    document.getElementById('LUGAR').onclick = function()
    {
        /*alert('exibir somente lista 01')
        alert(marcadores01.length);*/ 
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(map);
        }
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
    };
    document.getElementById('LUGAR2').onclick = function()
    {
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(map);
        }
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
    };
    document.getElementById('LUGAR3').onclick = function()
    {
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(map);
        }
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
    };
    document.getElementById('LUGAR4').onclick = function()
    {
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(map);
        }
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
    };
    document.getElementById('LUGAR5').onclick = function()
    {
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(map);
        }
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
    };
}


function AbrirLugarIndividual()
{

    /* Primeira Lista */
    document.getElementById('Lugar1Lista1').onclick = function(){
        for (var i = 1; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
    }
    document.getElementById('Lugar2Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[1].setMap(map);
    }
    document.getElementById('Lugar3Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[2].setMap(map);
    }
    document.getElementById('Lugar4Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[3].setMap(map);
    }
    document.getElementById('Lugar5Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[4].setMap(map);
    }
    document.getElementById('Lugar6Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[5].setMap(map);
    }
    document.getElementById('Lugar7Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[6].setMap(map);
    }
    document.getElementById('Lugar8Lista1').onclick = function(){
        for (var i = 0; i < marcadores01.length; i++) {
            marcadores01[i].setMap(null);
        }
        marcadores01[7].setMap(map);
    }

    /*Segunda Lista */

    document.getElementById('Lugar1Lista2').onclick = function(){
        for (var i = 1; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
    }
    document.getElementById('Lugar2Lista2').onclick = function(){
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        marcadores02[1].setMap(map);
    }
    document.getElementById('Lugar3Lista2').onclick = function(){
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        marcadores02[2].setMap(map);
    }
    document.getElementById('Lugar4Lista2').onclick = function(){
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        marcadores02[3].setMap(map);
    }
    document.getElementById('Lugar5Lista2').onclick = function(){
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        marcadores02[4].setMap(map);
    }
    document.getElementById('Lugar6Lista2').onclick = function(){
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        marcadores02[5].setMap(map);
    }
    document.getElementById('Lugar7Lista2').onclick = function(){
        for (var i = 0; i < marcadores02.length; i++) {
            marcadores02[i].setMap(null);
        }
        marcadores02[6].setMap(map);
    }

    /*Terceira Lista */

    document.getElementById('Lugar1Lista3').onclick = function(){
        for (var i = 1; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
    }
    document.getElementById('Lugar2Lista3').onclick = function(){
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        marcadores03[1].setMap(map);
    }
    document.getElementById('Lugar3Lista3').onclick = function(){
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        marcadores03[2].setMap(map);
    }
    document.getElementById('Lugar4Lista3').onclick = function(){
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        marcadores03[3].setMap(map);
    }
    document.getElementById('Lugar5Lista3').onclick = function(){
        for (var i = 0; i < marcadores03.length; i++) {
            marcadores03[i].setMap(null);
        }
        marcadores03[4].setMap(map);
    }

    /* Quarta Lista */

    document.getElementById('Lugar1Lista4').onclick = function(){
        for (var i = 1; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
    }
    document.getElementById('Lugar2Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[1].setMap(map);
    }
    document.getElementById('Lugar3Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[2].setMap(map);
    }
    document.getElementById('Lugar4Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[3].setMap(map);
    }
    document.getElementById('Lugar5Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[4].setMap(map);
    }
    document.getElementById('Lugar6Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[5].setMap(map);
    }
    document.getElementById('Lugar7Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[6].setMap(map);
    }
    document.getElementById('Lugar8Lista4').onclick = function(){
        for (var i = 0; i < marcadores04.length; i++) {
            marcadores04[i].setMap(null);
        }
        marcadores04[7].setMap(map);
    }

    /* Quinta Lista */

    document.getElementById('Lugar1Lista5').onclick = function(){
        for (var i = 1; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
    }
    document.getElementById('Lugar2Lista5').onclick = function(){
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
        marcadores05[1].setMap(map);
    }
    document.getElementById('Lugar3Lista5').onclick = function(){
        for (var i = 0; i < marcadores05.length; i++) {
            marcadores05[i].setMap(null);
        }
        marcadores05[2].setMap(map);
    }
}


/*READY*/
$(function ()
{
    carregaMapa();
    carregarMarcadores();
    carregarMarcadores02();
    carregarMarcadores03();
    carregarMarcadores04();
    carregarMarcadores05();
    OpenCloseAllMark();
    AbrirLugarIndividual();
});
