class TraitFactory
  private
  def self.define(&b)
    clase = Class.new(TraitAbstraction)
    clase.class_eval &b
    clase.new
  end

  private
  def self.nombre(nombre)
    Object.const_set(nombre,self)
  end

  private
  def self.metodo(nombre,&bloque)
    self.define_method(nombre,bloque)
  end
end