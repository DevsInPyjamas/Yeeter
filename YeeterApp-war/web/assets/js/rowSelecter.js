/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function($) {
    $(".card").click(function() {
        window.document.location = $(this).data("href");
    });
});

/* Esto es una chapuza pero paso de romperme la cabeza con el estilo */

$(document).ready(function($) {
    $(".clickable-row").click(function() {
        window.document.location = $(this).data("href");
    });
});