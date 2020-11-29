// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
var map = new Map;

function updateNumberOfOrders3(){
  var array = session;
  alert(session);


  array.map(function(currentValue, index){
    var id = "nrUnits" + currentValue;

    if(map.has(id)){
      var temp = map.get(id) + 1;
      map.set(id, temp);
      // map[id] = map[id] + 1;
    } else{
      map.set(id,1);
      // map[id] = 1;
    }
  });
}

function load(){
  if(typeof(Storage) !== "undefined"){
    var finalPrice = 0;

    for (var i = 1; i <= map.size; i++) {
      var id = "nrUnits" + i;
      var id_ppu = "ppu" + i;
      var id_totalPrice = "totalPrice" + i;


      var totalPrice = document.getElementById(id_ppu).innerHTML * map.get(id);
      finalPrice += totalPrice;

      localStorage.setItem(id, map.get(id));
      localStorage.setItem(id_totalPrice, totalPrice);

      document.getElementById(id).innerHTML = localStorage.getItem(id);
      document.getElementById(id_totalPrice).innerHTML = localStorage.getItem(id_totalPrice) + "£";

      if(i == map.size){
        localStorage.setItem("finalPrice", finalPrice);
        document.getElementById("finalPrice").innerHTML = "Final price is: " + localStorage.getItem("finalPrice") + "£";
      }

    }
  } else {
    alert("Sorry, your browser does not support Web Storage...");
  }
}
// function updateNumberOfOrders2(){
//   var ses = session.sort(); //getting session
//   var rObj = {}; // initializing
//   var uniqueSes = [];
//
//   ses.map(function(currentValue, index){
//     if(rObj.hasOwnProperty(currentValue)){
//       rObj[currentValue] = rObj[currentValue] + 1;
//     } else {
//       rObj[currentValue] = 1;
//     }
//   });
//   alert("aa" + rObj);
//   for(var keys in rObj){
//     var units = "nrUnits" + rObj[keys];
//     var totalprice = "totalPrice" + rObj[keys];
//     alert(units + " " + totalPrice);
//   }
//
// }
function updateNumberOfOrders(){
  var ses = session.sort(); //getting session
  var rObj = {} // initializing
  var uniqueSes = [];

  // Create an array of non duplicates
  $.each(ses,function(i,el){
    if($.inArray(el,uniqueSes) === -1) uniqueSes.push(el);
  })

  // Update number of orders
  for (var i = 0; i < session.length; i++) {
    var id = "nrUnits" + ses[i];
    var temp = +document.getElementById(id).innerHTML
    temp +=1;
    $("#"+id).text(temp);
  }
};

//
// window.onload = function WindowLoad(){
//   var QS = ParseQueryString();
//   var reloaded = QS["reloaded"];
//   if (reloaded === "1") {
//     updateNumberOfOrders();
//   }
// };

window.onbeforeunload = function(){
  load();
}

$(document).ready(function(){
  $('[data-js-hide-link]').click(function(event){
    alert("The pizza has been added to you basket!");
    event.preventDefault();
  });

  updateNumberOfOrders3();
  load();
});
