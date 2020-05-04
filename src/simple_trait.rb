class SimpleTrait
  def <<(op)
    a = CompositeTrait.new subMethod(op[1])
    a.define_singleton_method(op[0],&self.method(op[1]))
    a
  end

  def +(otroTrait)
    CompositeTrait.new combineMethodsWith otroTrait
  end

  def -(unMetodo)
    CompositeTrait.new subMethod unMetodo
  end

  private
  def combineMethodsWith(otroTrait)
    list = []
    list + self.methods(false).map { |method| self.method(method) } + otroTrait.methods(false).map {|method| otroTrait.method(method)}
  end

  def subMethod(unMetodo)
    self.methods(false).select { |metodo| !metodo.eql? unMetodo }.map {|method| self.method(method)}
  end
end

class Class
  def uses(*traits)
    traits.each do |trait|
      availableMethods = getAvailableMethods(trait)
      availableMethods.each do |method|
        makeDefinition(method, trait)
      end
    end
    self.new
  end

  private
  def getAvailableMethods(trait)
    trait.singleton_methods(false)
  end

  def makeDefinition(method, trait)
    if (!self.respond_to? method)
      self.define_method(method,&trait.method(method))
    end
  end
end

class Symbol
  def >>(otroSimbolo)
    [otroSimbolo,self]
  end
end