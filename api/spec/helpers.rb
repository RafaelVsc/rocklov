module Helpers
  def get_fixture(item)
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  def get_thumbnail(filename)
    return File.open(File.join(Dir.pwd, "spec/fixtures/images", filename), "rb")
  end

  module_function :get_fixture
  module_function :get_thumbnail
end
