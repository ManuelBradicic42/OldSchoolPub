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
var map;
var max = 0;
var uniqueSes = [];

function setTotalPrice(){
  document.getElementById("order_totalPrice").text = +localStorage.getItem("finalPrice");
}

// Creating a map of orders and unique array
function updateNumberOfOrders3(){
  map = new Map;
  var array = session;
  // alert(session);


  array.map(function(currentValue, index){
    var id = "nrUnits" + currentValue;
    if(currentValue > max){
      max = currentValue;
    }
    if(map.has(id)){
      var temp = map.get(id) + 1;
      map.set(id, temp);
      // map[id] = map[id] + 1;
    } else{
      map.set(id,1);
      // map[id] = 1;
    }
    // session.set("map", map);
  });

  // Create an array of non duplicates
  $.each(array,function(i,el){
    if($.inArray(el,uniqueSes) === -1) uniqueSes.push(el);
  })
  // alert(uniqueSes);
}

function load(){
  if(typeof(Storage) !== "undefined"){
    var finalPrice = 0;
    alert(max);
    for (var i = 0; i < uniqueSes.length; i++) {
      var id = "nrUnits" + uniqueSes[i];
      var id_ppu = "ppu" + uniqueSes[i];
      var id_totalPrice = "totalPrice" + uniqueSes[i];


      var totalPrice = document.getElementById(id_ppu).innerHTML * map.get(id);
      finalPrice += totalPrice;

      localStorage.setItem(id, map.get(id));
      localStorage.setItem(id_totalPrice, totalPrice);

      document.getElementById(id).innerHTML = localStorage.getItem(id);
      document.getElementById(id_totalPrice).innerHTML = localStorage.getItem(id_totalPrice) + "£";

      if(i+1 == uniqueSes.length){
        finalPrice = finalPrice.toFixed(2);
        localStorage.setItem("finalPrice", finalPrice);
        document.getElementById("finalPrice").innerHTML = "Final price is: " + localStorage.getItem("finalPrice") + "£";
      }

    }
  } else {
    alert("Sorry, your browser does not support Web Storage...");
  }
}


function updateNumberOfOrders(){
  var ses = session.sort(); //getting session
  var rObj = {} // initializing


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

// window.onbeforeunload = function(){
//   load();
// }

$(document).on("turbolinks:load",function(){
  // console.log('event triggered!')
  updateNumberOfOrders3();
  load();
  setTotalPrice();
});

$(document).ready(function(){
  $('[data-js-hide-link]').click(function(event){
    alert("The pizza has been added to you basket!");
    event.preventDefault();
  });

  $('#confirmId').click(function() {
     $(this).hide()
  })

});
