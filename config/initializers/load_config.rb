# -*- encoding : utf-8 -*-
APP_CONFIG = HashWithIndifferentAccess.new YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
SOCIAL_KEYS = HashWithIndifferentAccess.new YAML.load_file("#{Rails.root}/config/social_keys.yml")[Rails.env]
SOCIAL_KEYS.each do |k, v|
  ENV[k.upcase] ||= v
end
