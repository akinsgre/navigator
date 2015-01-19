function popUpWindow(id, title, containerId) {
    var divObj = $('#' + id);
    divObj.dialog({'title':title});
    divObj.dialog({
		      // Hack to make the 'X' appear in JQuery Titlebar close 
		      // http://stackoverflow.com/questions/17367736/jquery-ui-dialog-missing-close-icon
		      open: function() {
			  $(this).closest(".ui-dialog")
			      .find(".ui-dialog-titlebar-close")
			      .removeClass("ui-dialog-titlebar-close")
			      .html("<span class='ui-button-icon-primary ui-icon ui-icon-closethick'></span>");
		      }});
    divObj.dialog('open');
    divObj.scrollTop("0") ; 
}


$( function(){
       
       var loggedIn = false ; 
       var appId = $('#appid').text();

       window.fbAsyncInit = function() {
	   FB.init({
		       appId  : appId,
		       status : true, // check login status
		       level : 'debug',
		       cookie : true, // enable cookies to allow the server to access the session
		       xfbml  : true,  // parse XFBML
		       version    : 'v2.2'
		   });
	   var accessToken = "" ; 

	   if ($("#fbgroup").length > 0) {
	       console.log("FBGroup exists" + $('#fbgroup').attr("id"));
	       var groupId = $('#fbGroupIds').text();
	       var groupArr = groupId.split(",");
	       console.log("Group id arre " + groupArr);
	       FB.login(function(response){ 
			    console.log(JSON.stringify(response.authResponse.accessToken));
			    $.post("/facebook/refresh", {"accessToken":response.authResponse.accessToken })
				.done(function(response) {
					  console.log("Saved new access Token" + response.accessToken);  
				      }) ; 
			    // FB.ui({ to:groupArr,
			    // 	   method: 'share', 
			    // 	   href:'http://www.notifymyclub.com'
			    // 	  });
			}, {scope: 'user_groups,publish_actions'} ); 
	       
	   }
	   
       };
       (function(d) {
            var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
            js = d.createElement('script'); js.id = id; js.async = true;
	    //js.src = "//connect.facebook.net/en_US/all/debug.js";
	    js.src = "//connect.facebook.net/en_US/sdk.js";
            d.getElementsByTagName('head')[0].appendChild(js);
        }(document));

       $("#invite_btn").click(function(e) {
				  e.preventDefault();
				  $('#invite_form').modal('show') ;
			      });
       $('#new_invite').submit(function(e){
				e.preventDefault();
				$.ajax({
					   url: "invites/create",
					   type: "POST",
					   data:$("#new_invite").serialize()
				       }).done(function() {
						   $('#alerts').html("<div id=\"flash_notice\"><p>Thank you for requesting an invite.  An email will be sent to confirm your request.</p></div>");
						   $('#invite_form').modal('hide') ;

					       });
				   return false ; 
			    });
       

       
       $( "#popups" ).scrollTop(0);
       $("#popups").dialog({autoOpen:false, 
			    width:"80%", 
			    height:500, 
			    draggable: false,
			    modal:true});
       
       
       $("body").on("click",".openwindow", function(e) {
       			e.preventDefault();
			var link = $(this).attr("href");
			var title = $(this).attr("title");
			$.get(link, function(response) {
				  $( "#popups" ).html(response);
				  popUpWindow('popups', title, 'showterms') ;
			      }) ;

       			
       		    });
       
       
       // instantiate the bloodhound suggestion engine
       var groups = new Bloodhound(
	   {
	       datumTokenizer: function (d) {  return Bloodhound.tokenizers.obj.whitespace('value');  },
	       queryTokenizer: Bloodhound.tokenizers.whitespace,
	       remote: {
		   url: '/groups.json?search=%QUERY',
		   filter: function (groups) {
		       return $.map(groups.results, function (group) {
		   			return {
		   			    value: group.name,
		   			    id: group.id
		   			};
		   		    });
		   }
	       }
	   });
       
       var initPromise = groups.initialize();
       initPromise.done(function() {}).fail(function() { console.log('Fail');});
       
       $('[id^="groupsearch"]').typeahead({}, 
       					  {
       					      source: groups.ttAdapter()
       					  });
       $('[id^="groupsearch"]').bind('typeahead:selected', function(obj, datum, name) {   
					 var query = "";
					 if ($(this).attr('id').split("_")[1] == "user" ) {
					     query = "?user=true" ;
					 } 
       					 window.location = "/groups/"+datum.id + "/contacts/new" + query ;
       				     });
   });
