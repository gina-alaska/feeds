require 'net/http'
require 'uri'

class CensusCounty
  include Mongoid::Document
  
  field :type,        type: String
  field :properties,  type: Hash
  field :geometry,    type: Hash
  
  def state
    properties['STATEFP10']
  end
  
  def county 
    properties['COUNTYFP10']
  end
end
