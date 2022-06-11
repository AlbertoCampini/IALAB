
const quartiere = [
  {
    "nomeCitta":"torino", 
    "nomeQuartiere":"centro", 
    "servizi":[
        "scuola",
        "metro",
        "parco"
    ]
},
{
  "nomeCitta":"torino", 
  "nomeQuartiere":"periferia", 
  "servizi":[
      "scuola",
      "parco"
  ]
},
{
  "nomeCitta":"torino", 
  "nomeQuartiere":"campagna", 
  "servizi":[
      "parco"
  ]
},
{
  "nomeCitta":"asti", 
  "nomeQuartiere":"periferia", 
  "servizi":[
    "parco"
  ]
},
{
  "nomeCitta":"asti", 
  "nomeQuartiere":"campagna", 
  "servizi":[
    "scuola"
   
  ]
},
{
  "nomeCitta":"alessandria", 
  "nomeQuartiere":"centro", 
  "servizi":[
      "scuola",
      "metro",
      "parco"
  ]
},
{
"nomeCitta":"alessandria", 
"nomeQuartiere":"periferia", 
"servizi":[
    "scuola",
    "parco"
]
},
{
"nomeCitta":"alessandria", 
"nomeQuartiere":"campagna", 
"servizi":[
    "scuola"
]
},
{
"nomeCitta":"novara", 
"nomeQuartiere":"periferia", 
"servizi":[
  "scuola"
]
},
{
"nomeCitta":"novara", 
"nomeQuartiere":"campagna", 
"servizi":[
  "scuola",
  "parco"
 
]
},
]


let house = [
      {
        "identifier": 1,
        "metriQuadri": 100,
        "numeroVani": 4,
        "numeroPiano": 1,
        "numeroServizi": 2,
        "citta": "torino",
        "quartiere": "centro",
        "ascensore": "si",
        "boxAuto": "no",
        "spaziEsterni": [
          "balcone",
          "terrazzo"
        ],
        "prezzo": 350,
        "tipologia": "appartamento",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      },
      {
        "identifier": 2,
        "metriQuadri": 80,
        "numeroVani": 2,
        "numeroPiano": 3,
        "numeroServizi": 1,
        "citta": "asti",
        "quartiere": "periferia",
        "ascensore": "no",
        "boxAuto": "si",
        "spaziEsterni": [
          "giardino"
        ],
        "prezzo": 250,
        "tipologia": "villetta",
        "classeEnergetica": "c",
        "ristrutturata": "no",
        "servizi":""
      },
      {
        "identifier": 3,
        "metriQuadri": 180,
        "numeroVani": 4,
        "numeroPiano": 3,
        "numeroServizi": 2,
        "citta": "asti",
        "quartiere": "campagna",
        "ascensore": "no",
        "boxAuto": "si",
        "spaziEsterni": [
          "giardino"
        ],
        "prezzo": 300,
        "tipologia": "villetta",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      },
      {
        "identifier": 4,
        "metriQuadri": 50,
        "numeroVani": 1,
        "numeroPiano": 5,
        "numeroServizi": 1,
        "citta": "torino",
        "quartiere": "centro",
        "ascensore": "si",
        "boxAuto": "no",
        "spaziEsterni": [
          "balcone"
        ],
        "prezzo": 80,
        "tipologia": "appartamento",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      },
      {
        "identifier": 5,
        "metriQuadri": 160,
        "numeroVani": 5,
        "numeroPiano": 3,
        "numeroServizi": 2,
        "citta": "torino",
        "quartiere": "campagna",
        "ascensore": "si",
        "boxAuto": "si",
        "spaziEsterni": [
          "terrazzo"
        ],
        "prezzo": 200,
        "tipologia": "appartamento",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      },
      {
        "identifier": 6,
        "metriQuadri": 80,
        "numeroVani": 2,
        "numeroPiano": 5,
        "numeroServizi": 2,
        "citta": "alessandria",
        "quartiere": "periferia",
        "ascensore": "si",
        "boxAuto": "si",
        "spaziEsterni": [
          "giardino"
        ],
        "prezzo": 200,
        "tipologia": "villetta",
        "classeEnergetica": "b",
        "ristrutturata": "no",
        "servizi":""
      },
      {
        "identifier": 7,
        "metriQuadri": 70,
        "numeroVani": 3,
        "numeroPiano": 3,
        "numeroServizi": 2,
        "citta": "alessandria ",
        "quartiere": "campagna",
        "ascensore": "si",
        "boxAuto": "si",
        "spaziEsterni": [
          "terrazzo"
        ],
        "prezzo": 150,
        "tipologia": "appartamento",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      },
      {
        "identifier": 8,
        "metriQuadri": 70,
        "numeroVani": 3,
        "numeroPiano": 4,
        "numeroServizi": 1,
        "citta": "torino",
        "quartiere": "campagna",
        "ascensore": "si",
        "boxAuto": "si",
        "spaziEsterni": [
          "terrazzo"
        ],
        "prezzo": 200,
        "tipologia": "appartamento",
        "classeEnergetica": "a",
        "ristrutturata": "no",
        "servizi":""
      },
      {
        "identifier": 9,
        "metriQuadri": 100,
        "numeroVani": 4,
        "numeroPiano": 4,
        "numeroServizi": 1,
        "citta": "novara",
        "quartiere": "periferia",
        "ascensore": "no",
        "boxAuto": "si",
        "spaziEsterni": [
          "balcone"
        ],
        "prezzo": 100,
        "tipologia": "appartamento",
        "classeEnergetica": "b",
        "ristrutturata": "no",
        "servizi":""
      },
      {
        "identifier": 10,
        "metriQuadri": 250,
        "numeroVani": 6,
        "numeroPiano": 1,
        "numeroServizi": 3,
        "citta": "asti",
        "quartiere": "campagna",
        "ascensore": "no",
        "boxAuto": "si",
        "spaziEsterni": [
          "giardino"
        ],
        "prezzo": 350,
        "tipologia": "villetta",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      },
      {
        "identifier": 11,
        "metriQuadri": 100,
        "numeroVani": 4,
        "numeroPiano": 3,
        "numeroServizi": 2,
        "citta": "torino",
        "quartiere": "centro",
        "ascensore": "si",
        "boxAuto": "no",
        "spaziEsterni": [
          "balcone",
          "terrazzo"
        ],
        "prezzo": 450,
        "tipologia": "appartamento",
        "classeEnergetica": "a",
        "ristrutturata": "si",
        "servizi":""
      }
    ]

    getServizi()

    function getServizi(){
      house.forEach(elementHouse => {
      quartiere.forEach((element)=>{
        if(element.nomeQuartiere === elementHouse.quartiere && element.nomeCitta === elementHouse.citta){
          elementHouse.servizi = element.servizi.join(" ")
        }
      })
    });
    }


