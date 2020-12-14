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
//= require jquery.validate
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require_tree .

var map;
var max = 0;
var uniqueSes = [];

// Function which sets the final price in the order form
function setTotalPrice(){
  if(document.getElementById("order_totalPrice") != null){
    document.getElementById("order_totalPrice").value = +localStorage.getItem("finalPrice");
    document.getElementById("order_totalPrice").readOnly = true;
  }
}

// Creating a map of orders and unique array
function updateNumberOfOrders3(){
  map = new Map;

  try{
    var array = session;
    array.map(function(currentValue, index){
      var id = "nrUnits" + currentValue;
      if(currentValue > max){
        max = currentValue;
      }
      if(map.has(id)){
        var temp = map.get(id) + 1;
        map.set(id, temp);
      } else{
        map.set(id,1);
      }
    });

    // Create an array of non duplicates
    $.each(array,function(i,el){
      if($.inArray(el,uniqueSes) === -1) uniqueSes.push(el);
    });
  }catch{

  }
}

// Loading the prices and number of units per product from localStorage
function load(){
  if(typeof(Storage) !== "undefined"){
    var finalPrice = 0;
    for (var i = 0; i < uniqueSes.length; i++) {
      var id = "nrUnits" + uniqueSes[i];
      var id_ppu = "ppu" + uniqueSes[i];
      var id_totalPrice = "totalPrice" + uniqueSes[i];

      try{
        var totalPrice = document.getElementById(id_ppu).innerHTML * map.get(id);

      }catch(err){
      }
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
  }
  else {
    alert("Sorry, your browser does not support Web Storage...");
  }
}


  $(document).on("turbolinks:load",function(){
    // console.log('event triggered!')
    updateNumberOfOrders3();
    load();
  });

function ValidateOrderForm(){
  alert("Alo1");

  $('#myOrderForm').validate({
    rules: {
      'order[customerName]': {
        required: true,
        minlength: 2,
      },
      'order[customerNumber]': {
        required: true,
        minlength: 8,
        digits: true,
      },
      'order[address]': {
        required: true,
        minlength: 5,
      },
    },
    messages: {
      'order[customerName]': {
        required: "We need your name to contact you",
      },
      'order[customerNumber]': {
        digits: "They are not digits",
        required: "We need your number to contact you",
      },
      'order[address]': {
        required: "We need your address to make delivery",
      },
    },
  });
}
function ValidateContactForm(){
  alert("Alo2");

  $('#contactUsForm').validate({
    rules:{
      'name': {
        required: true,
      }
    },
    messages:{
      'name': {
        required: 'That is required',
      },
    }
  });
}
$(document).ready(function(){
  setTotalPrice();

  if(document.getElementById('contactUsForm')){
    ValidateContactForm();
  }
  if(document.getElementById('newOrderForm')){
    ValidateOrderForm();
  }

  $('[data-js-add-pizza]').click(function(event){
    alert("The pizza has been added to you basket!");
    event.preventDefault();
  });

  $('#confirmId').click(function() {
     $(this).hide();
     alert("hide");
  });

});
