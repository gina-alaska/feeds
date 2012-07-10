class CensusCounty
  include Mongoid::Document
  
  field :type,        type: String
  field :properties,  type: Hash
  field :geometry,    type: Hash
end
