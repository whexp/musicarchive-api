require 'json'
require 'grape'

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
end
