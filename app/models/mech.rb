class Mech
  include Mongoid::Document
  Mongoid.raise_not_found_error = false

  require 'zip'
  
  mount_uploader :code, CodeUploader
  
  field :create_at, type: DateTime
  field :name, type: String
  field :author, type: String
  field :weapon, type: String
  field :engine, type: String
  
  validates :code, presence: true
  belongs_to :user

  has_and_belongs_to_many :battles

  def battle_with(opponent)
    battle = Battle.new
    battle.time = Time.now
    battle.meches << self
    battle.meches << opponent
    # battle.users << self.user
    # battle.users << opponent.user
    battle.save
    self.battles << battle
    # self.user.battles << battle
    # opponent.user.battles << battle
    opponent.battles << battle
    # exec "../MechBattleConsoleForLinuxServer/MechBattleConsoleForLinuxServer ../MechBattleConsoleForLinuxServer/BattleModeConfig.conf 2 ../MechBattleConsoleForLinuxServer/libmyAI2.so ../MechBattleConsoleForLinuxServer/libmyAI1.so"
  end

  def get_mech_info
    exec "compile/RobotAppearanceReader #{self.code_dir}libmyAI.so stdout"
    # json_info = JSON::parse(File::read("#{self.code_dir}appearance.json"))
    # self.update_attributes(:name => json_info['name'], 
    #                       :author => json_info['author'],
    #                       :weapon => json_info['weapon'],
    #                       :engine => json_info['engine'])
  end

  def code_dir
    self.code.path.split('.')[0]+'/'
  end

  def compile
    self.unzip_file(self.code.path,"public/uploads/#{self.class.to_s.underscore}/code/#{self.id}")
    system "compile/compile_user_ai.sh -p #{self.code_dir}"
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