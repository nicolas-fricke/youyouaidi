require 'youyouaidi/uuid'

module Kernel
  UUID = Youyouaidi::UUID

  private
  def UUID(uuid_param = nil)
    Youyouaidi::UUID.parse uuid_param
  end
end
