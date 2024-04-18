require "bundler"
Bundler.require

module LivingCostCalc
  class App < Sinatra::Base

    # global settings
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, "public"

      register Sinatra::ActiveRecordExtension
    end

    # development settings
    configure :development do
      register Sinatra::Reloader
    end

    # database settings
    set :database_file, "config/database.yml"

    # require all models
    Dir.glob("./lib/*.rb") do |model|
      require model
    end

    # root route
    get "/" do
      erb :start
    end

    # start here (where the user enters their info)
    get "/start" do
      erb :start
    end

<<<<<<< HEAD
    def save_request(doc)
      File.open("response.json", "w") do |file|
        file.write(JSON.dump(doc))
      end
    end

    def read_request
      file = File.read("response.json")
      response = JSON.parse(file)
    end

=======
>>>>>>> 37539f8 (release)
    # results
    get "/results" do
      city = params[:city]
      country = params[:country]

      # if country or city names have spaces, process accordingly
      esc_city = ERB::Util.url_encode(city) # e.g. "St Louis" becomes 'St%20Louis'
      esc_country = ERB::Util.url_encode(country) # e.g. "United States" becomes 'United%20States'

      # Определение URL и параметров запроса
      url = "https://cost-of-living-and-prices.p.rapidapi.com/prices"
      params = { city_name: esc_city, country_name: esc_country }

      # Создание соединения с помощью Faraday
      connection = Faraday.new(url: url) do |conn|
        conn.response :logger                  # Логирование запросов для отладки
        conn.adapter Faraday.default_adapter   # Использование стандартного адаптера (Net::HTTP)
      end

      # Выполнение GET-запроса с параметрами и заголовками
      response = connection.get do |req|
        req.params = params
        req.headers["X-RapidAPI-Key"] = "e1b5e72bf2mshc3929941f4f4a15p1f54bdjsn2312a4cbb70c"
        req.headers["X-RapidAPI-Host"] = "cost-of-living-and-prices.p.rapidapi.com"
      end

      @code = response.status
      @results = JSON.parse (response.body)

      erb :results
    end

    # partials

    helpers do
      # define the navbar partial
      def partial(navbar)
        erb(navbar, layout: false)
      end
    end
  end
end
