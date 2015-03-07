
class SikulixClient

  Image = Struct.new(:path, :similarity) do

    def to_json(*args)
      %Q[{"path":"#{path}","similarity":"#{similarity}"}]
    end
  end
end
