class CensusApi
  DEFAULT_FIELDS = {'NAME' => 'Name', 'P0010001' => 'Total Population'}
  
  def self.where(params)
    self.new.where(params)
  end
  
  def self.select(params)
    self.new.select(params)
  end
  
  def where(p)
    @params ||= {}
    @params.merge!(p)
    
    self
  end
  
  def all
    fetch
  end
  
  def first
    fetch.first
  end
  
  def select(fields)
    @fields = fields
  end
  
  def fields
    @fields || DEFAULT_FIELDS
  end
  
  def state
    @params[:state] || '*'
  end
  
  def county
    @params[:county] || '*'
  end

  def fetch_url
    "#{api_url}?get=#{fields.keys.join(',')}&for=county:#{county}&in=state:#{state}&key=#{api_key}"
  end
  
  protected
  
  def config
    @@config ||= YAML.load_file(Rails.root.join('config/census.yml'))
  end
  
  def api_url
    config['url']
  end
  
  def api_key
    config['key']
  end
  
  def fetch
    response = Net::HTTP.get(URI.parse(fetch_url))
    data = JSON.parse(response)

    # Turn the array of arrays into an array of hashes
    dummy = data.shift
    data.collect { |v| Hash[*fields.values.zip(v).flatten] }
  end
end