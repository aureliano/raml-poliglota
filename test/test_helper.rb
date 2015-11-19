require File.expand_path '../assert_helper.rb', __FILE__
require File.expand_path '../class_meta_helper.rb', __FILE__
require File.expand_path '../../lib/configuration/app_logger.rb', __FILE__

include RamlPoliglota::Configuration

AppLogger.set_default_level 'debug'