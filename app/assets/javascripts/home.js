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
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
	console.log ("The person is logged into Facebook, but not your app.");
    } else {
      console.log(" The person is not logged into Facebook, so we're not sure if they are logged into this app or not.");
    }
  }
$( function(){
       // This is called with the results from from FB.getLoginStatus().
       

       window.fbAsyncInit = function() {
	   FB.init({
		       appId  : '862680253782909',
		       status : true, // check login status
		       cookie : true, // enable cookies to allow the server to access the session
		       xfbml  : true  // parse XFBML
		   });

	   FB.getLoginStatus(function(response) {
				 statusChangeCallback(response);
			     });

       };
       (function(d) {
            var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
            js = d.createElement('script'); js.id = id; js.async = true;
	    //js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=862680253782909&version=v2.1";
            js.src = "//connect.facebook.net/en_US/all/debug.js";
            d.getElementsByTagName('head')[0].appendChild(js);
        }(document));

       // Here we run a very simple test of the Graph API after login is
       // successful.  See statusChangeCallback() for when this call is made.
       function testAPI() {
	   console.log('Welcome!  Fetching your information.... ');
	   FB.api('/me', function(response) {
		      console.log('Successful login for: ' + response.name);
		      console.log('Thanks for logging in, ' + response.name + '!');
		  });
       }
       
       
       $( "#popups" ).scrollTop(0);
       $("#popups").dialog({autoOpen:false, 
			    width:"80%", 
			    height:500, 
			    draggable: false,
			    modal:true});

       $(".openwindow").each(function() {
				 $(this).click( function(e) {
						    var link = $(this).attr("href");
						    $( "#popups" ).load(link);
						    var title = $(this).attr("title");
       						    e.preventDefault();
       						    popUpWindow('popups', title, 'showterms') ;
       						});
			     }) ; 
       
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
