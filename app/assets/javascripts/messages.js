$( function(){
       $("#new_message").submit(function(event) {
				    var messages =  {"messages":{} } ; 

				    $("[id^=message_text_]").each(function(index) {
								      messages.messages.concat( $( this ).text() );
								      console.log("Messages are " + JSON.stringify(messages.messages));
								  });
				    var data = $("#new_message").serializeArray();
				    data =  data.concat({"message":"one"});
				    console.log("   Submitting " + JSON.stringify(data));
				    event.preventDefault();
				}) ;
   }) ; 