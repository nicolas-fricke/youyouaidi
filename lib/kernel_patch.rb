require 'youyouaidi'

module Kernel
  def UUID(uuid_param = nil)
    Youyouaidi::UUID.parse uuid_param
  end
end
