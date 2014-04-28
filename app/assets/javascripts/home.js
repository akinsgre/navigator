$(function(){

      $("#emailForm").validate({
				   rules: {
				       email: {
					   required: true,
					   email: true
				       }
				   },
				   messages: {
				       email: "Please enter a valid email address"
				   }
			       }) ; 



      $( "#emailForm").submit(function() { 
				  inviteEmail = $("#email").val();
				  $.post('email/create', { email : inviteEmail } );
				  $("#emailDialog").dialog("close");
			      });

      
      $( "#sendEmail" ).click( function() {
				   $( "#emailDialog").dialog({title:"Enter Email" });

				   $( "#emailDialog").dialog({ buttons : {"Ok" : function() { 
									      $("#emailForm").submit();
									  }}});

				   $( "#emailDialog").dialog("open") ; 
			       }) ; 
  });