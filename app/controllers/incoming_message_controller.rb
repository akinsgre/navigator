class IncomingMessageController < ApplicationController
def index

#  response.content_type = text/xml
  respond_to do |format|
    format.html
    format.xml 
  end

end
end
