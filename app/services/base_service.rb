# just a little base class that other services can inherit from
# with the benefit that all services are similar.
# Calling a service looks like: MyService.call(opt1: "foo", opt2: "bar")
# Services should return truthy or falsey.

class BaseService
  Response = Struct.new(:successful?, :error, :data)

  def self.call(*args)
    new(*args).call
  end

  def initialize(*args)
    # if your class has ivars that need to be set from the args
    # then you should override this in your class.  ie
    # def initialize(:opt1, :opt2)
    #   @opt1 = opt1
    #   @opt2 = opt2
    # end
  end

  def call
    raise "Please provide your own call method."
  end
end