class Url < ApplicationRecord
    belongs_to :user
    
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true

    def self.urls_with_front_url(arr_urls)
        urls = []
        arr_urls.each do |url|
            urls.push({
                id: url.id,
                short_url: url.short_url,
                long_url: url.long_url,
                status: url.status,
                created_at: url.created_at.strftime("%d/%m/%Y %H:%M")
            })
        end
        return urls
    end

    def self.random(len=6, character_set = [])
        character_set = ["A".."Z", "a".."z", "0".."9", '_', '-'] if character_set.empty?
        chars = character_set.map{|x| x.is_a?(Range) ? x.to_a : x }.flatten
        Array.new(len){ chars.sample }.join
    end

    def self.new(options = {})
        super({
            long_url: options[:long_url],
            short_url: self.random,
            status: true
        })
    end

    def short_url
        APP_CONFIG['front_url'] + super
    end
end
