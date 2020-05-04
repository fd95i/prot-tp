require_relative 'simple_trait'

class CompositeTrait < SimpleTrait
  def initialize(methods)
    methods.each do |method|
      define_singleton_method(method.name,&method)
    end
  end
end