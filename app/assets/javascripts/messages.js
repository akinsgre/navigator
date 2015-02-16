$( function(){
       $("#new_message").submit(function(event) {
				    var messages =  {"messages":{} } ; 

				    $("[id^=message_text_]").each(function(index) {

								      $('#new_message').append(
									  $('<input />').attr('type', 'hidden')
									      .attr('name', "messages["+index+"]")
									      .attr('value', $(this).text())
								      );
								  });
				    return true ; 
				}) ;
   }) ; 