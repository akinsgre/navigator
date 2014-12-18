$( function(){
       var groupId = window.location.href.split('/')[window.location.href.split('/').length-1];
       var url = '/';
       $("#sendpost").click(function(e) {
				url = $(this).attr('href');
				e.preventDefault();
				var loggedIn = false;
				dfd = new $.Deferred();
				FB.login(function(response) {
					     if (response.status == "connected" ) {
						 console.log("Saved new access Token" + response.authResponse.accessToken);
						 $.post("/facebook/refresh", 
							{"accessToken":response.authResponse.accessToken }
						       ).done(function(response) {
								  console.log("Response " + JSON.stringify(response));
							      }) ; 
					     }
					     dfd.resolve();
					   }, {scope:'publish_actions'} );
				dfd.done( function() {
				    window.location = url;
				});

				
			      }) ; 
       
       $("#fbgrouplogin").click(function(e) {
				    event.preventDefault();
				    var loggedIn = false;
				    FB.getLoginStatus(function(response) {
							  loggedIn = statusChangeCallback(response);
						      });
				    if (loggedIn == false) {
					FB.login(function(response) {
						     if (response.authResponse) {
							 $.getJSON('/auth/facebook/callback', 
								   { signed_request : response.authResponse.signedRequest },
								   function( data ) {
								       $('#fbgrouplogin').hide();
								       $('#fbgroupedit').html("Click here to add a Facebook group").show();
								   });
							 

						     }
						 }, {scope:'email,user_groups'} );
				    }

				});
       $('#fbgroupedit').editable({
				      type: 'checklist',    
				      source: '/facebook/groups',
				      url: groupId+'/facebook/post',     
				      pk: 1,    
				      title: 'Select groups',
				      placement: 'right',
				      display: function(value, sourceData) {

					  var checked, html = '';
					  
					  checked = $.grep(sourceData, function(o){
							       return $.grep(value, function(v){ 
										 return v == o.value; 
									     }).length;
							   });

					  $.each(checked, function(i, v) { 
						     html+= '<tr><td></td><td>'+$.fn.editableutils.escape(v.text)+'</td><td></td><td>Facebook Group</td></tr>';
						 });

					  $('#contacts').append(html);
				      }
				  });

       $("#new_group").formToWizard() ;
       
       $("#entryLabel").text("Please enter a valid " + $("#contact_type :selected").text());
       $("#contact_type").change( function () {
				      selectedType = $('#contact_type :selected').val() ;
				      $.ajax( "/contact_type/" + selectedType + ".json" )
					  .done(
					      function(data) {
						  $("#entryLabel").text("Please enter a " + data);
					      })
					  .fail(function(jqXHR, textStatus) { console.log("Something messed up"+textStatus); } ) ; 
				  }) ; 

       $("#new_group").validate( 
	   {
	       rules: {
		   'group[name]': {
		       required:true,
		       maxlength:20
		   },
		   'group[sponsor_email]': {
		       email:true
		   }
	       },
	       messages: {
		   'group[name]': {
		       required:"You must name your group",
		       maxlength:"The name must be less than 20 characters."
		   },
		   'group[sponsor_email]': {
		       email: "The sponsor's email must be in the format of name@domain.com."
		   }
	       },
	       onfocusout: function(element) { $(element).valid(); }
	   });  

   }) ; 
