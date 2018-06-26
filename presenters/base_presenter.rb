module Presenters
  class BasePresenter
    def print(data)
      data.each do |cell|
        puts "#{cell[0]} #{cell[1]}"
      end
    end
  end
end