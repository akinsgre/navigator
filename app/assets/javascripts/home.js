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
}

function statusChangeCallback(response) {
    //#update my current access_token
    if (response.status === 'connected') {
	console.log("#### Status change Callback " + response.authResponse.accessToken);
	 $.post("/facebook/refresh", {"accessToken":response.authResponse.accessToken }).done(function(response) {
	 										     console.log("Saved new access Token" + response.accessToken);
	 										 }) ; 
	$("#fbgroupedit").html("Click here to add a Facebook group").show();
	$("#fbgrouplogin").hide();
	return true;
    } else {
	console.log("Not logged into Facebook");	
	$("#fbgroupedit").hide();
	$("#fbgrouplogin").show().html("Login to Facebook to be able to choose a Facebook group to post to.");
	return false;
    }
}
$( function(){
       
       var loggedIn = false ; 
       var appId = $('#appid').text();
       console.log("App ID is " + appId);
       window.fbAsyncInit = function() {
	   FB.init({
		       appId  : appId,
		       status : true, // check login status
		       cookie : true, // enable cookies to allow the server to access the session
		       xfbml  : true,  // parse XFBML
		       version    : 'v2.2'
		   });

	   FB.getLoginStatus(function(response) {

				 statusChangeCallback(response);
			     });

       };
       (function(d) {
            var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
            js = d.createElement('script'); js.id = id; js.async = true;
	    // js.src = "//connect.facebook.net/en_US/all/debug.js";
	    js.src = "//connect.facebook.net/en_US/sdk.js";
            d.getElementsByTagName('head')[0].appendChild(js);
        }(document));

       
       $( "#popups" ).scrollTop(0);
       $("#popups").dialog({autoOpen:false, 
			    width:"80%", 
			    height:500, 
			    draggable: false,
			    modal:true});
       
       
       $("body").on("click",".openwindow", function(e) {
			console.log("Clicked link " );
       			e.preventDefault();
			var link = $(this).attr("href");
			var title = $(this).attr("title");
			$.get(link, function(response) {
				  console.log(response);
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
		       console.log('### test ' + JSON.stringify(groups) );
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
