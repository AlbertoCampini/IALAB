let filteredData = []
let inputHouses

let grid = new gridjs.Grid({ 
    columns: ["identifier",
    "metriQuadri",
    "numeroVani",
    "numeroPiano",
    "numeroServizi",
    "citta",
    "quartiere",
    "ascensore",
    "boxAuto",
    "spaziEsterni",
    "prezzo",
    "tipologia",
    "classeEnergetica",
    "ristrutturata",
"servizi"],
    data: house,
    search: {
        enabled: true
      },
      sort: true
  }).render(document.getElementById('wrapper'));
  document.getElementById("clear").addEventListener('click', ()=>{
    document.getElementById("wrapper-output").innerHTML = "";
    grid.updateConfig({
        search: true,
        data: house
      }).forceRender();
  })

  document.getElementById("submit-input").addEventListener('click', ()=>{
    filteredData = []
    inputHouses = null
   inputHouses = document.getElementById("input").value.split(",")
   house.forEach((elem) => { if(inputHouses.includes(elem.identifier+"")) filteredData.push(elem)})
   grid.updateConfig({
    search: true,
    data: filteredData
  }).forceRender();
  })