require_relative './TraitImpl'

class MiClase
  include TraitImpl

  def metodo1
    "mundo"
  end

  def initialize(*traits)
    self.instance = self
    uses traits
  end
end