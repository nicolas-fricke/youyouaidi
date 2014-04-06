require 'youyouaidi'

module Kernel
  def UUID(uuid_param)
    Youyouaidi::UUID.new uuid_param
  end
end
