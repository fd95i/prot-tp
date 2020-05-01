require_relative '../src/mi_clase'
require_relative '../src/trait_factory'
require 'rspec'

describe 'traits' do
  TraitFactory.define do
    nombre :MiTraitSafe
    metodo :metodo2 do |un_numero|
      un_numero * 0 + 42
    end
  end

  TraitFactory.define do
    nombre :MiTrait
    metodo :metodo1 do #TODO resolver test de la excepción con la resolución del conflicto
      "Hola"
    end
    metodo :metodo2 do |un_numero|
      un_numero * 0 + 42
    end
  end

  TraitFactory.define do
    nombre :MiOtroTrait
    metodo :metodo1 do
      "kawuabonga"
    end
    metodo :metodo3 do
      "zaraza"
    end
  end

  let(:ejemplo1) do
    MiClase.new MiTrait
  end

  let(:ejemplo2) do
    MiClase.new MiTraitSafe + MiOtroTrait
  end

  let(:ejemplo3) do
    MiClase.new MiTrait + (MiOtroTrait - :metodo1)
  end

  let(:ejemplo4) do
    MiClase.new MiTrait .<<(:metodo2,:saludo)
  end

  it 'deberia no tener metodos' do
    expect(MiClase.new.singleton_methods(false)).to eq([])
  end

  it 'deberia tener los metodos de los traits inventados' do
    expect(ejemplo1.metodo1).to eq("mundo")
  end

  it 'debería tener métodos de los traits sumados' do
    expect(ejemplo2.metodo2(84)).to eq(42)
    expect(ejemplo2.metodo3).to eq("zaraza")
  end

  it 'deberia sumar' do
    expect do
      MiTrait + MiOtroTrait
    end.to raise_error RuntimeError, "Lanzo una excepcion"
  end

  it 'deberia restar' do
    expect( ejemplo3.respond_to? :metodo3).to eq(true)
  end

  it 'deberia hacer alias' do
    expect(ejemplo4.respond_to? :saludo).to eq(true)
  end
end