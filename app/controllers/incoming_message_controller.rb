class IncomingMessageController < ApplicationController
def index
  logger.info "Did this work"
#  response.content_type = text/xml
  respond_to do |format|
    format.html
    format.xml 
  end

end
end
