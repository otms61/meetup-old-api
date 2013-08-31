var selectedColor = "green"
var unselectedColor = "red"
var cellWidth = App.width;
var cellHeight = App.height;
var startTouchX = 0;
var startTouchY = 0;
var isSelectingCells = true;
var coords = [];

function touchStart( e ) {  
  var elemId = e.currentTarget.id;
  var box = document.getElementById(elemId); 
  coords = [];
  if (box.style.background == selectedColor)
  {
    isSelectingCells = false;
  } 
  else
  {
    isSelectingCells = true;
  }
  //console.log("Start Touch - screenX:"+ e.targetTouches[0].pageX + ", screenY:"+e.targetTouches[0].pageY);
  startTouchX = e.targetTouches[0].pageX;
  startTouchY = e.targetTouches[0].pageY;

  e.preventDefault();  
  return false;  
}  

function touchMove( e ) {  
  var elemId = e.currentTarget.id;
  var box = document.getElementById(elemId);
  var cur_col = parseInt(box.getAttribute("data_col"));
  var cur_row = parseInt(box.getAttribute("data_row"));
  var cellCols = Math.floor((e.targetTouches[0].pageX - startTouchX + cellWidth/2)/cellWidth);
  var cellRows = Math.floor((e.targetTouches[0].pageY - startTouchY+ cellHeight/2)/cellHeight);
  //console.log("Move Touch - screenX:"+ e.targetTouches[0].pageX + ", screenY:"+e.targetTouches[0].pageY);
  //console.log("Move Touch - cellCols:"+ cellCols +", cellRows:"+cellRows);

  var colSign = 1;
  var rowSign = 1;
  if (cellCols < 0)
  {
    colSign = -1;
  }
  if (cellRows < 0)
  {
    rowSign = -1;
  }

  // Change the UI
  for (var x=0; x<=Math.abs(cellCols); x++)
  { 
    for (var y=0; y<=Math.abs(cellRows); y++)
    {
      row = cur_row+rowSign*y;
      col = cur_col+colSign*x;
      var selectedBox = document.getElementById("cell:"+row+","+col);
      if (selectedBox !== null)
      {
        var saveVar = "("+row+","+col+")";
        if ($.inArray(saveVar, coords) === -1)
        {
          coords.push(saveVar);  
        }
        
        if (isSelectingCells)
        {
          selectedBox.style.background = selectedColor;
        }
        else
        {
          selectedBox.style.background = unselectedColor;
        }
      }
    }
  }
}

function touchEnd( e ) {  
  var resultData = {token:"adfa123413adfasdf",
                coordinates: coords,
                isSelecting: isSelectingCells};

  // Do ajax post
  $.post('ajax/test.html', resultData, function(data) {
    console.log("Success log:");
    console.log(data);
  }, "json");

  e.preventDefault();  
  return false;
}

