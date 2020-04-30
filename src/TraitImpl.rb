require_relative './trait_abstraction'

module TraitImpl
  attr_accessor :instance

  def uses(traits)
    traits.each do |trait|
      availableMethods = getAvailableMethods(trait)
      availableMethods.each do |method|
        makeDefinition(method, trait)
      end
    end
  end

  private
  def getAvailableMethods(trait)
    trait.instance_methods(false)
  end

  private
  def makeDefinition(method, trait)
    if (!instance.respond_to? method)
      instance.define_singleton_method(method,&trait.new.method(method))
    end
  end
end