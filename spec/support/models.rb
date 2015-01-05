class Chicken < Attributor::Model
  attributes(:identity => :email) do
    attribute :name, Attributor::String, example: /[:first_name:]/
    attribute :age, Attributor::Integer, :default => 1, :min => 0, :max => 120, :description => "The age of the chicken"
    attribute :email, Attributor::String, :example => /[:email:]/, :regexp => /@/, :description => "The email address of the chicken"
    attribute :angry, Attributor::Boolean, :example => "true", :description => "Angry bird?"
    attribute :weight, Attributor::Float, :example => /\d{1,2}\.\d/, :description => "The weight of the chicken"
  end
end


class Duck < Attributor::Model
  attributes do
    attribute :age, Attributor::Integer, :required_if => {"name" => "Daffy" }
    attribute :name, Attributor::String
    attribute :email, Attributor::String, :required_if => "name"
    attribute :angry, Attributor::Boolean, :default => true, :example => /true|false/, :description => "Angry bird?"
    attribute :weight, Attributor::Float, :example => /\d{1,2}\.\d/, :description => "The weight of the duck"
  end
end


class Turkey < Attributor::Model
  attributes do
    attribute :age, Integer, :default => 1, :min => 0, :max => 120, :description => "The age of the turkey"
    attribute :name, String , :description => "name of the turkey", :example => /[:name:]/ #, :default => "Providencia Zboncak"
    attribute :email, String, :example => /[:email:]/, :regexp => /@/, :description => "The email address of the turkey"
    attribute :weight, Attributor::Float, :example => /\d{1,2}\.\d/, :max => 86.7, :description => "The weight of the turkey"
  end
end



class Turducken < Attributor::Model
  attributes do
    attribute :name, String, :default => "Turkey McDucken", :description => "Turducken name", :example => /[:name:]/
    attribute :chicken, Chicken
    attribute :duck, Duck
    attribute :turkey, Turkey, :description => "The turkey"
  end
end


# http://en.wikipedia.org/wiki/Cormorant
class Cormorant < Attributor::Model
  attributes do
    # This will be a collection of arbitrary Ruby Objects
    attribute :fish, Attributor::Collection, :description => "All kinds of fish for feeding the babies"

    # This will be a collection of Cormorants (note, this relationship is circular)
    attribute :neighbors, Attributor::Collection.of(Cormorant), :description => "Neighbor cormorants"

    # This will be a collection of instances of an anonymous Struct class, each having two well-defined attributes

    attribute :babies, Attributor::Collection.of(Attributor::Struct), :description => "All the babies", :member_options => {:identity => 'name'} do
      attribute :name, Attributor::String, :example => /[:name]/, :description => "The name of the baby cormorant"
      attribute :months, Attributor::Integer, :default => 0, :min => 0, :description => "The age in months of the baby cormorant"
      attribute :weight, Attributor::Float, :example => /\d{1,2}\.\d{3}/, :description => "The weight in kg of the baby cormorant"
    end

  end
end


class Person < Attributor::Model
  attributes do
    attribute :name, String, example: /[:first_name:]/
    attribute :title, String, values: %w{Mr Mrs Ms Dr}
    attribute :okay, Attributor::Boolean, values: [true]
    attribute :address, Address, example: proc { |person, context| Address.example(context, person: person) }
  end
end


class Address < Attributor::Model
  attributes do
    attribute :name, String, example: /\w+/
    attribute :state, String, values: %w{OR CA}
    attribute :person, Person, example: proc { |address, context| Person.example(context, address: address) }
  end
end


class ModelWithHash < Attributor::Model
  attributes do 
    attribute :name, String
    #attribute :hash, Attributor::Hash
  end
end

