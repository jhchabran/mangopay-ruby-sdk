module Leetchi
  class Ressource

  protected

    def self.post_request route, data
      request('POST', route, data)
    end

    def self.get_request route, options=nil
      request('GET', route, nil, options)
    end

    def self.put_request route, data
      request('PUT', route, data)
    end

    def self.delete_request route
      request('DELETE', route)
    end

  private

    def self.request method, route, data=nil, options=nil
      path = path_for(route, options)
      uri = uri_for(path)
      method = method.upcase
      data = data.to_json unless data.nil?
      headers = header_for(method, path, data)
      res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        case method
        when 'POST'   then request = Net::HTTP::Post.new(uri.request_uri, headers)
        when 'GET'    then request = Net::HTTP::Get.new(uri.request_uri, headers)
        when 'PUT'    then request = Net::HTTP::Put.new(uri.request_uri, headers)
        when 'DELETE' then request = Net::HTTP::Delete.new(uri.request_uri, headers)
        else
          return {}
        end
        request.body = data unless data.nil?
        http.request request
      end
      begin
        JSON.parse(res.body)
      rescue JSON::ParserError => e
        {'ErrorCode' => -1}
      end
    end

    def self.key
      OpenSSL::PKey::RSA.new(File.read(ENV['LEETCHI_KEY_PATH']), ENV['LEETCHI_PASSPHRASE'])
    end

    def self.path_for route, options
      File.join('', 'v1', 'partner', ENV['LEETCHI_PARTNER_ID'], route.to_s) + "?ts=#{Time.now.to_i.to_s}" + (options.nil? ? '' : ('&' + options))
    end

    def self.uri_for path
      URI(File.join(API_BASE_URL, path))
    end

    def self.sign data
      Base64.encode64(key.sign('sha1', data)).to_s.chomp.gsub(/\n/, '')
    end

    def self.signature_for method, path, data
      sign("#{method}|#{path}|" + (data.nil? ? '' : "#{data}|"))
    end

    def self.header_for method, path, data
      {'X-Leetchi-Signature' => signature_for(method, path, data), 'Content-Type' => 'application/json'}
    end

  end
end

