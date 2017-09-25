#!/usr/bin/env ruby

require "webrick"


class MyNormalClass
  def self.status
    res = %x{cat database/status.txt}
    return res
  end

  def self.count_car
    res = %x{cat database/count_car.txt}
    return res
  end

  def self.price_taxi
    res = %x{cat database/price_taxi.txt}
    return res
  end

  def self.get_taxi(name, count, num, location, ip)
    File.open("database/get_taxi.txt", "w") do |file|
      file.puts("نام و نام خانوادگی : #{name.to_s.force_encoding("UTF-8")}\nتعداد تاکسی سفارش شده : #{count.to_s.force_encoding("UTF-8")}\nشماره تماس : #{num.to_s.force_encoding("UTF-8")}\nادرس : #{location.to_s.force_encoding("UTF-8")}\n\n")
      file.puts("========================\n\nIP : #{ip.to_s.force_encoding("UTF-8")}")
    end
  end

  def self.message(name, num, msg)
    File.open("database/message.txt", "w") do |file|
      file.puts("Name : #{name}\nNumber : #{num}\nMessage : #{msg}")
    end
  end

  def self.show_taxi
    res = %x{cat database/get_taxi.txt}
    return res
  end

  def self.show_message
    res = %x{cat database/message.txt}
    return res
  end


  def self.setting_status(status)
    File.open("database/status.txt", "w") do |file|
      file.puts(status)
    end
  end

  def self.setting_price(price)
    File.open("database/price_taxi.txt", "w") do |file|
      file.puts(price)
    end
  end

  def self.setting_count(count)
    File.open("database/count_car.txt", "w") do |file|
      file.puts(count)
    end
  end

  def self.backup_taxi(name, count, num, location, ip)
    File.open("database/backup_get_taxi.txt", "a+") do |file|
      file.puts("نام و نام خانوادگی : #{name.to_s.force_encoding("UTF-8")}\nتعداد تاکسی سفارش شده : #{count.to_s.force_encoding("UTF-8")}\nشماره تماس : #{num.to_s.force_encoding("UTF-8")}\nادرس : #{location.to_s.force_encoding("UTF-8")}\n\n")
      file.puts("\n\nIP : #{ip.to_s.force_encoding("UTF-8")}\n\n=====================\n\n")
    end
  end

  def self.get_version()
    ver = %x{cat database/version.txt}
    return ver
  end

end

class MyServlet < WEBrick::HTTPServlet::AbstractServlet

  def do_GET (request, response)
    #get status
    if request.query[""]
      response.status = 200
      response.content_type = "text/plain"
      result = nil

      case request.path
        when "/status"
          result = MyNormalClass.status

        when "/price_taxi"
          result = MyNormalClass.price_taxi

        when "/count"
          result = MyNormalClass.count_car

        when "/get_taxi"
          result = MyNormalClass.show_taxi

        when "/get_message"
          result = MyNormalClass.show_message

        when "/get_version"
          result = MyNormalClass.get_version

        else
          result = "No such method (1)"
      end

      response.body = result.to_s
    else
      response.status = 200
      response.body = "You did not provide the correct parameters(1)"
    end

  end


  def do_POST(request, response)
    if request.query["name"] && request.query["count"] && request.query["num"] && request.query["location"]
      response.status = 200
      response.content_type = "text/plain"

      name = request.query["name"]
      count = request.query["count"]
      num = request.query["num"]
      location = request.query["location"]

      #get ip
      ip = request.remote_ip

      result = nil

      case request.path
        when "/get_taxi"
          puts "Name : #{name}\nCount : #{count}\nNumber : #{num}\nLocation : #{location}\n IP : #{ip}"
          # result = "Name : #{name}\nCount : #{count}\nNumber : #{num}\nLocation : #{location}"
          result = "0"
          MyNormalClass.get_taxi(name, count, num, location, ip)
          #set backup
          MyNormalClass.backup_taxi(name, count, num, location, ip)


        else
          result = "No such method (4)"

      end

      response.body = result.to_s
    else
      response.body = "You did not provide the correct parameters(4)"
    end

    if request.query["name"] && request.query["num"] && request.query["msg"]
      response.status = 200
      response.content_type = "text/plain"

      name = request.query["name"]
      num = request.query["num"]
      msg = request.query["msg"]

      result = nil

      case request.path
        when "/message"
          # result = "Name : #{name}\nNumber : #{num}\nMessage: #{msg}"
          MyNormalClass.message(name, num, msg)
          result = "0"

      else
        result = "No such method (5)"
      end

      response.body = result.to_s
    else
      response.body = "You did not provide the correct parameters(5)"
    end

    #> Method Post
    #setting up status
    if request.query["sStatus"]
      response.status = 200
      response.content_type = "text/plain"

      sStatus = request.query["sStatus"]

      result = nil

      case request.path
        when "/setting_status"
          MyNormalClass.setting_status(sStatus)
          result = "0"

        else
          result = "No such method (6)"
      end

      response.body = result.to_s
    else
      response.body = "You did not provide the correct parameters(6)"
    end

    #Setting up price
    if request.query["sPrice"]
      response.status = 200
      response.content_type = "text/plain"

      sPrice = request.query["sPrice"]

      result = nil

      case request.path
        when "/setting_price"
          MyNormalClass.setting_price(sPrice)
          result = "0"

        else
          result = "No such method (7)"
      end

      response.body = result.to_s
    else
      response.body = "You did not provide the correct parameters(7)"
    end


    #setting up count
    if request.query["sCount"]
      response.status = 200
      response.content_type = "text/plain"

      sCount = request.query["sCount"]

      result = nil

      case request.path
        when "/setting_count"
          MyNormalClass.setting_count(sCount)
          result = "0"

        else
          result = "No such method (8)"
      end

      response.body = result.to_s
    else
      response.body = "You did not provide the correct parameters(8)"
    end


  end
end

server = WEBrick::HTTPServer.new(:Port => 1234)

server.mount "/", MyServlet

trap("INT") {
  server.shutdown
}

server.start