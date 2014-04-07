require 'youyouaidi'

module Kernel
  def UUID(uuid_param)
    Youyouaidi::UUID.parse uuid_param
  end
end
