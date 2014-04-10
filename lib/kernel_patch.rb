require 'youyouaidi/uuid'

module Kernel
  UUID = Youyouaidi::UUID

  def UUID(uuid_param = nil)
    Youyouaidi::UUID.parse uuid_param
  end
end
