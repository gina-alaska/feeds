class RealtimeTile
  include Mongoid::Document

  field :type,        type: String
  field :properties,  type: Hash
  field :geometry,    type: Hash
  index :type => 1
  index 'properties.id' => 1

  def as_json(*args)
    data = super

    data['properties'].delete('wkt')

    data
  end
end
