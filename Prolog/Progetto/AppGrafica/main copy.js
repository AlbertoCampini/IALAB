let type=0;
        let startPositionRow=0;
        let startPositionCol=0;
        let checkpoints=[];
        let solution=[];
        let outputMappa=[];
        function setType(typeNew){
            type=typeNew;
            console.log(type);
        }
        function setCellType(Row,Col){
            if(type===0){
                if(outputMappa.find((element) => {return element.id === Row+'-'+Col ? element : null}) === null){
                    outputMappa.push({id:Row+'-'+Col, row: Row, col:Col, type: 0 , value:'occupata(pos('+Row+','+Col+')).\n'})
                }
                //document.getElementById('output-mappa').value = document.getElementById('output-mappa').value+"occupata(pos("+Row+","+Col+")).\n";
                document.getElementById(Row+"-"+Col).style.backgroundColor = "gray";
            }
            if(type===1){
                if(document.getElementById('output-mappa').value.includes("iniziale")){
                    let previusElem = outputMappa.find((element) => {return element.type ===1 ? element : null})
                   document.getElementById(previusElem.id).style.backgroundColor = "";
                   document.getElementById(previusElem.id).classList="buttonClass";
                   outputMappa = outputMappa.filter((element) => {return element.type !== 1 ? element : null});
                   
                }
                outputMappa.push({id:Row+'-'+Col, row: Row, col:Col, type:1 , value:'iniziale(pos('+Row+','+Col+')).\n'})
                startPositionCol=Col;
                startPositionRow=Row;
                //document.getElementById('output-mappa').value = document.getElementById('output-mappa').value+"iniziale(pos("+Row+","+Col+")).\n";
                document.getElementById(Row+"-"+Col).style.backgroundColor = "green";
            }
            if(type===2){
                checkpoints.push("pos("+Row+","+Col+")");
                let checkpointsStr="checkpoints([";
                for(let i=0;i<checkpoints.length;i++)
                    checkpointsStr+=checkpoints[i]+",";
                checkpointsStr= checkpointsStr.substring(0,checkpointsStr.length-1);
                checkpointsStr+="]).";
                document.getElementById('checkPoints').value = checkpointsStr;
                document.getElementById(Row+"-"+Col).style.backgroundColor = "blue";
            }
            document.getElementById(Row+"-"+Col).classList="buttonClassNoHover";
            document.getElementById('output-mappa').value = 'num_col('+width+'). \nnum_righe('+height+').\nfinale([]).\n';
            outputMappa.forEach((element) => {document.getElementById('output-mappa').value = document.getElementById('output-mappa').value + element.value})
        }

        window.onload = function() {
        let width = 30;
        let height = 15;

        if(width==null || height==null){    //TODO se ci va aggiungere i controlli
                alert("Errore nei dati input, riprovare");
                return;
        }
        document.getElementById('output-mappa').value = 'num_col('+width+'). \nnum_righe('+height+').\nfinale([]).\n';
        let buttonMap="";
        buttonWidth=(document.getElementById("map").offsetWidth-50)/width;

        for(let i=1;i<=height;i++){
            for(let j=1;j<=width;j++){
                buttonMap+="<button class=\"buttonClass\" id=\""+i+"-"+j+"\" style=\"width:"+buttonWidth+"px;height:"+buttonWidth+"px;\" onclick=\"setCellType("+i+","+j+")\"></button>";
            }
            buttonMap+="<br>";
        }
        document.getElementById('mapButtons').innerHTML = buttonMap;
    };

    function solve(){
        Solution=document.getElementById('solution').value;
        Solution=Solution.substring(1,Solution.length-1);
        Moves=Solution.split(",");
        let prevRow=-1;
        let prevCol=-1;
        let posRow=startPositionRow;
        let posCol=startPositionCol;
        for(let i=0;i<Moves.length;i++){
            Moves[i]=Moves[i].toLowerCase();
            console.log(Moves[i]);
            prevCol=posCol;
            prevRow=posRow;
            if(Moves[i].includes("nord")){
                console.log("NORD");
                posRow-=1;
            }
            if(Moves[i].includes("sud")){
                console.log("SUD");
                posRow+=1;
            }
            if(Moves[i].includes("est") && !Moves[i].includes("ovest")){
                console.log("EST");
                posCol+=1;
            }
            if(Moves[i].includes("ovest")){
                console.log("OVEST");
                posCol-=1;
            }
            solution.push({prevC:prevCol,prevR:prevRow,C:posCol,R:posRow});
        }
        solveStep(0);
    }

    function delay(time) {
        return new Promise(resolve => setTimeout(resolve, time));
    }
    function solveStep(index){
        if(index>=solution.length){
            return;
        }else{
            console.log(solution[index].R+"-"+solution[index].C);
            document.getElementById(solution[index].prevR+"-"+solution[index].prevC).style.backgroundColor = "orange";
            document.getElementById(solution[index].R+"-"+solution[index].C).style.backgroundColor = "red";
        }
        delay(500).then(() => solveStep(index+1));
  }