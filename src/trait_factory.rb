require_relative 'simple_trait'

class TraitFactory < SimpleTrait
  private
  def self.define(&b)
    instance = self.new
    instance.instance_eval &b
    instance
  end

  private
  def nombre(nombre)
    Object.const_set(nombre,self)
  end

  private
  def metodo(nombre,&bloque)
    self.define_singleton_method(nombre,bloque)
  end
end