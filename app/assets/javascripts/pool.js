$(document).ready(function(){
  
    $("#private_pool_enabled").hide();
 
    $("input:radio[name='pool[public]']").change(function(){  

        if(this.value == 'false' && this.checked){
          $("#private_pool_enabled").show();
        }else{
          $("#private_pool_enabled").hide();
        }
    });
});