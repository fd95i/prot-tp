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
    if (trait.is_a? Class)
      trait.instance_methods(false)
    else
      trait.singleton_methods(false) + trait.class.instance_methods(false)
    end
  end

  private
  def makeDefinition(method, trait)
    if (!instance.respond_to? method)
      if (trait.is_a? Class)
        instance.define_singleton_method(method,&trait.new.method(method))
      else
        instance.define_singleton_method(method,&trait.method(method))
      end
    end
  end
end