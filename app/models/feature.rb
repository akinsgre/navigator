class Feature
  def self.active?(*args)
    Rails.logger.debug "##### Feature Flag #{feature_flags_enabled?}"
    Rails.logger.debug "##### Rollout active #{$rollout.inspect}"
    (!feature_flags_enabled?) || $rollout.active?(*args) 
  rescue => e
    Rails.logger.debug "######## Error #{e.message}"
    true
  end

  def self.feature_flags_enabled?
    #Rails.env.production? || Rails.env.staging?
    true
  end
end
