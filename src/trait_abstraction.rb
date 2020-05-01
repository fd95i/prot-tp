require_relative './trait_factory'

class TraitAbstraction < TraitFactory
  def self.demostrar
    "Soy un trait! Puedo probarlo"
  end

  def self.+(otroTrait)
    traitInstance = self.new
    otroTrait.instance_methods(false).each do |metodo|
      raise 'Lanzo una excepcion' unless !traitInstance.respond_to? metodo
      traitInstance.define_singleton_method(metodo,otroTrait.new.method(metodo).to_proc)
    end
    traitInstance
  end

  def self.-(*metodos)
    metodos.each do |unMetodo|
      if (self.new.respond_to? unMetodo)
        undef_method(unMetodo)
      end
    end
    self
  end

  def self.<<(metodo,otro)
    alias_method otro,metodo
  end
end