class Mech
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  require 'zip'
  require 'open4'
  
  mount_uploader :code, CodeUploader
  
  field :create_at, type: DateTime
  field :name, type: String
  field :author, type: String
  field :manifesto, type: String
  field :weapon, type: String
  field :engine, type: String
  field :state, type: String

  field :protect_begin_time, type: Integer
  field :protect_time, type: Integer

  field :score, type: Integer, default: -> { 0 }
  field :win_times,type: Integer, default: -> { 0 }
  field :fail_times,type: Integer, default: -> { 0 }
  field :draw_times,type: Integer, default: -> { 0 }

  validates :code, presence: true
  belongs_to :user

  has_and_belongs_to_many :battles

  validates :manifesto, length: { maximum: 60 }

  def engine_info
    Carrier.find_by(:iden => self.engine)
  end

  def weapon_info
    Weapon.find_by(:iden => self.weapon) 
  end

  def backup_code
    # system "mv #{self.code_dir} #{self.dir}/code-#{Time.now.to_i}"
    # pid, stdin, stdout, stderr = Open4.popen4("mv #{self.code_dir} #{self.dir}/code-#{Time.now.to_i}")
    # ignored, status = Process::waitpid2 pid
    # logger.error(stderr.read)
  end

  def mech_info_json
    pid, stdin, stdout, stderr = Open4.popen4("compile/get_info.sh -p #{self.code_dir}")
    # mech_info = `compile/RobotAppearanceReader #{self.code_dir}libmyAI.so stdout`
    return stdout
  end

  def get_mech_info

    if FileTest::exist?("#{self.code_dir}libmyAI.so")
      self.update_attribute("state","SUCCESS")
      # mech_info = `compile/RobotAppearanceReader #{self.code_dir}libmyAI.so stdout`
      pid, stdin, stdout, stderr = Open4.popen4("compile/get_info.sh -p #{self.code_dir}")
      json_info = JSON::parse(stdout)
      self.update_attributes(:name => json_info['name'], 
                            :author => json_info['author'],
                            :weapon => json_info['weapon'],
                            :engine => json_info['engine'])
    else
      self.update_attribute("state","FAILED")
    end

  end

  def code_dir
    File.dirname(self.code.path) + '/code/'
  end

  def dir
    "public/uploads/#{self.class.to_s.underscore}/code/#{self.id}"
  end

  def compile
    self.unzip_file(self.code.path,"public/uploads/#{self.class.to_s.underscore}/code/#{self.id}/code")
    pid, stdin, stdout, stderr = Open4.popen4("compile/compile_user_ai.sh -p #{self.code_dir}")
    ignored, status = Process::waitpid2 pid

    compile_error = stderr.read

    File.open("public/uploads/#{self.class.to_s.underscore}/code/#{self.id}/code/status.txt", "w+") do |f|
      f.write(status.exitstatus)
    end

    if compile_error
      compile_error = compile_error.gsub('home/rails-deploy/Mechempire/public/uploads/mech/code/',' ')
    end

    return status.exitstatus, compile_error
  end

  def unzip_file (file, destination)
    Zip::File.open(file) { |zip_file|
      zip_file.each { |f|
        next if f.name =~ /__MACOSX/ or f.name =~ /\.DS_Store/ or !f.file?
        f_path = File.join(destination, File.basename(f.name))
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)
      }
    }
  end
end