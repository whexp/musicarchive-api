require 'json'
require 'grape'
require 'rest-client'


$musicarchive = RestClient::Resource.new('https://freemusicarchive.org')

class HelloAPI < Grape::API
    version 'v1', using: :accept_version_header

    format :json
    default_format :json

    parser :json, lambda { |object, env|
        data = JSON.parse object
        out = {value: data}
        if data.is_a? Hash
            out.merge!(data)
        end
        out
    }

    get do
        redirect '/help', permanent: true
    end

    desc "Display API help"
    get :help do
        help = []

        HelloAPI.routes.each do |route|
            help << {
                path: route.route_path.gsub('(.:format)',''),
                params: route.route_params,
                version: route.route_version,
                desc: route.route_description,
                method: route.route_method
            }
        end
        help
    end

    namespace :hello do
        route_param :name do
            desc %q<Respond Hello <name> where <name> is the name parameter>
            get do
                "Hello #{params[:name]}"
            end
        end
    end
    namespace :top_downloads do
        desc %q<Respond Hello <name> where <name> is the name parameter>
        get do
            response = $musicarchive['recent.json'].get
            data = JSON::parse(response.body)
            tracks = data['aTracks'].sort{|x,y| y['track_downloads'].to_i <=> x['track_downloads'].to_i}
            tracks.each do |track|
                {
                    track_id: track["track_id"],
                    artist: track["track_artist_name"],
                    title: track["track_title"],
                    date_created: track["track_date_created"],
                    downnloads: track["track_downloads"], 
                }
            end
        end
    end



end
