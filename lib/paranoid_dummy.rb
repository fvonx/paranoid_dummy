require 'active_record'

require 'paranoid_dummy/version'
require 'paranoid_dummy/dummy'
require 'paranoid_dummy/paranoid_dummy'

ActiveRecord::Base.send :include, ParanoidDummy
