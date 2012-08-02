class RealtimeTile
  include Mongoid::Document

  field :type,        type: String
  field :properties,  type: Hash
  field :geometry,    type: Hash
  index :type
  index 'properties.id'

  def as_json(*args)
    data = super

    data['properties'].delete('wkt')

    data
  end
end
