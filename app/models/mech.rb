class Mech
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  require 'zip'
  
  mount_uploader :code, CodeUploader
  
  field :create_at, type: DateTime # mech create time
  # field :carrier_id, type: String
  # field :weapon_id, type: String
  # validates :carrier_id, presence: true
  # validates :weapon_id, presence: true
  # validates :code, presence: true
  # field :code_dir, type: String
  belongs_to :user
  # belongs_to :weapon
  # belongs_to :carrier

  # has_one :code

  def code_dir
    self.code.path.split('.')[0]+'/'
  end

  def compile
    self.unzip_file(self.code.path,"public/uploads/#{self.class.to_s.underscore}/code/#{self.id}")
  end

  def unzip_file (file, destination)
    Zip::File.open(file) { |zip_file|
      zip_file.each { |f|
        f_path=File.join(destination, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)
      }
    }
  end
end