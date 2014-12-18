require 'awesome_print'
class FacebookController < ApplicationController
  respond_to :html, :json
  
  def callback

    auth = request.env['omniauth.auth']
    
    Rails.logger.debug "##### Scopes : #{auth.inspect}"
    if current_user
      current_user.fb_token = auth['credentials']['token'] 
      Rails.logger.debug "###### Access Token is #{current_user.fb_token}"
      if current_user.save
        Rails.logger.debug "##### Facebook auth token saved for #{current_user.email}"
        render :json => {'status' => 'success'}
      else
        render :json => {'status' => 'failure'}
      end
    end
  end

  def refresh
     Rails.logger.debug "####### Refreshing accessToken with #{params['accessToken']}"
     Rails.logger.debug "####### Current User token #{current_user.fb_token}"
     if params['accessToken'] != current_user.fb_token
       Rails.logger.debug "##### Saving new token"
       current_user.fb_token = params['accessToken']
       current_user.save
     end
     hashMap = { "accessToken" =>  current_user.fb_token  }
    render :json => hashMap
  end
  def post
    Rails.logger.debug "##### facebook#post params #{params}"
    fbGroupId = params["value"]
    redirect_to new_user_session_path and return if current_user.nil?
    @access_token = current_user.fb_token

    Rails.logger.debug "##### Access Token = #{@access_token}"
    graph = Koala::Facebook::API.new(@access_token)
    uri = "/#{fbGroupId[0]}" if fbGroupId.size == 1
    Rails.logger.debug "##### Get this URI #{uri} for #{fbGroupId[0]}" 
    @fbgroup = graph.get_object(uri)
    Rails.logger.debug "##### FB Group information = #{@fbgroup["name"]}"
    group = Group.find(params[:group_id])
    fbg = FbGroup.new({name: @fbgroup["name"], entry: fbGroupId[0]})
    group.contacts << fbg
    unless group.save
      raise 'Error saving the group'
    end
    render :nothing => true
  end
  def groups
    redirect_to new_user_session_path and return if current_user.nil?
    @access_token = current_user.fb_token

    Rails.logger.debug "##### Access Token = #{@access_token}"
    graph = Koala::Facebook::API.new(@access_token)
    @fbgroups = graph.get_connection("/me", "groups")
    @fbgroups.reject! { |fb| fb['administrator'].nil? }
    @fbgroups

  end

end
