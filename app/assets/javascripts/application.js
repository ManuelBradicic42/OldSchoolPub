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
    // If there is an element order_totalPrice, then set up the value from the localStorage
    document.getElementById("order_totalPrice").value = +localStorage.getItem("finalPrice");
    document.getElementById("order_totalPrice").readOnly = true;
  }
}

// Creating a map of orders and uniquer array
//  map - contains no. of units
//  uniqueSes - an array containing only single id of a products
function updateNumberOfOrders3(){
  map = new Map;

  try{
    // getting the session from javascript tag in the delivery view
    var array = session;

    // creating a map of products, key: id in the html view, value: number of units in the cart
    // currentValue is the actual ID
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

// Loading the prices and number of units per product from  the localStorage
function load(){
  // it the web browser supports localStorage
  if(typeof(Storage) !== "undefined"){
    var finalPrice = 0;
    // creating html ids for each of the product
    for (var i = 0; i < uniqueSes.length; i++) {
      var id = "nrUnits" + uniqueSes[i];          // number of units id
      var id_ppu = "ppu" + uniqueSes[i];          // price per unit id
      var id_totalPrice = "totalPrice" + uniqueSes[i];    //totalprice per unit id

      // if there is an element with the id above, then:
      try{
        //set the total price for a specific pizza
        var totalPrice = document.getElementById(id_ppu).innerHTML * map.get(id);

      }catch(err){
      }
      // final price is a sum of all total prices
      finalPrice += totalPrice;

      // storing number of units of a procust (id) and total price for that product(id_totalPrice) in localStorage
      localStorage.setItem(id, map.get(id));
      localStorage.setItem(id_totalPrice, totalPrice);

      // getting the no. of units and total price for each product from the localstorage and setting them up in the view.
      document.getElementById(id).innerHTML = localStorage.getItem(id);
      document.getElementById(id_totalPrice).innerHTML = localStorage.getItem(id_totalPrice) + "£";

      // if we reach the last element, then we have to set up the final price
      if(i+1 == uniqueSes.length){
        finalPrice = finalPrice.toFixed(2);
        localStorage.setItem("finalPrice", finalPrice);
        document.getElementById("finalPrice").innerHTML = "Final price is: " + localStorage.getItem("finalPrice") + "£";
      }
    }
  }
  // if the browser doesn't support localStorage
  else {
    alert("Sorry, your browser does not support Web Storage...");
  }
}

// loading prices and localstorage
  $(document).on("turbolinks:load",function(){
    // console.log('event triggered!')
    updateNumberOfOrders3();
    load();
  });

// validation for order form
function ValidateOrderForm(){
  $('#myOrderForm').validate({
    debug: true,
    //rules for the form., it has to contain customerName,customerNumber, address
    rules: {
      'order[customerName]': {
        required: true,
        minlength: 2,   // the length must be at least 2
      },
      'order[customerNumber]': {
        required: true,
        minlength: 8,   // the length must be at least 8
        digits: true,   // it must contain digits only
      },
      'order[address]': {
        required: true,
        minlength: 5,
      },
    },
    // meesages if one of the rules get triggered
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


$(document).ready(function(){
  // seting the total price in delivery view
  setTotalPrice();

  // validation for order form, after 'Checkout' button
  if(document.getElementById('newOrderForm')){
    ValidateOrderForm();
  }

  // if an product was added to the cart
  $('[data-js-add-pizza]').click(function(event){
    alert("The pizza has been added to you basket!");
    event.preventDefault();
  });

  $('#confirmId').click(function() {
     $(this).hide();
  });

});
