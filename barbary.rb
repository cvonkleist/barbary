module Barbary
end

class String
  def /(text)
    File.join(self, text)
  end
end
