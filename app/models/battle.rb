class Battle
  require 'open4'
  include Mongoid::Document
  include Mongoid::MagicCounterCache
  Mongoid.raise_not_found_error = false 

  field :time,  type: DateTime
  field :result, type: String
  field :defender_id, type: String
  field :attacker_id, type: String
  field :winner_id, type: String
  field :score, type: Integer

  has_and_belongs_to_many :meches
  has_and_belongs_to_many :users, class_name: 'User', inverse_of: :battles
  # counter_cache :users

  belongs_to :match

  has_and_belongs_to_many :starers, class_name: 'User', inverse_of: :stareds
  # counter_cache :starers

  def rand_battle
    # logfile = File.open("test_log.txt","a")
    rand_num = rand()
    # File.open("test_log.txt","a")do |file|  
    #    file.puts rand_num
    # end 
    # logger.error(rand_num)
    # logfile.puts rand_num
    if rand_num > 0.5
      battle_result = self.battle(self.defender,self.attacker)
      # logfile.puts "defender,attacker"
    else
      battle_result = self.battle(self.attacker,self.defender)
      # logfile.puts "attacker,defender"
    end

    if !battle_result
      return false
    end
    # logfile.puts self.winner_id
    # logfile.puts self.attacker_id
    if self.winner_id == self.attacker_id
      # logfile.puts "protect"
      self.defender.update_attributes(:protect_begin_time => Time.now.to_i,
                                      :protect_time => 300)
    end
    # logfile.puts "---"
    # logfile.close
    return true
  end

  def battle(first_mech,second_mech)
    #run battle in sandbox
    pid, stdin, stdout, stderr = Open4.popen4("battle/battle.sh #{first_mech.code_dir}libmyAI.so #{second_mech.code_dir}libmyAI.so #{self._id}")
    ignored, status = Process::waitpid2 pid
    # logger.error(stderr.read)
    #get battle result

    pid, stdin, stdout, stderr = Open4.popen4("battle/result.sh #{first_mech.code_dir}libmyAI.so #{second_mech.code_dir}libmyAI.so #{self._id}")
    ignored, status = Process::waitpid2 pid


    if FileTest::exists?("battle/result/#{self._id}.xml")
      x = File.read("battle/result/#{self._id}.xml")
    else
      return false
    end

    # x = File.read("battle/result/#{self._id}.xml")
    winnerID = Hash.from_xml(x)['battleStatistics']['winnerID']

    sa = 0.0
    sb = 0.0

    if winnerID == "0"
      sb = 1.0
      self.winner_id = first_mech._id #self.defender_id
      first_mech.update_attributes(:score => first_mech.score + 3,
                                    :win_times => first_mech.win_times + 1)
      first_mech.user.update_attributes(:win_times => first_mech.user.win_times + 1,
                                      :battle_count => first_mech.user.battle_count + 1)

      second_mech.update_attributes(:score => second_mech.score - 1,
                                      :fail_times => second_mech.fail_times + 1)

      second_mech.user.update_attributes(:fail_times => second_mech.user.fail_times + 1,
                                      :battle_count => second_mech.user.battle_count + 1)
    elsif winnerID == "1"
      sa = 1.0
      self.winner_id = second_mech._id
      second_mech.update_attributes(:score => second_mech.score + 3,
                                      :win_times => second_mech.win_times + 1)
      second_mech.user.update_attributes(:win_times => second_mech.user.win_times + 1,
                                      :battle_count => second_mech.user.battle_count + 1)

      first_mech.update_attributes(:score => first_mech.score - 1,
                                      :fail_times => first_mech.fail_times + 1)
      
      first_mech.user.update_attributes(:fail_times => first_mech.user.fail_times + 1,
                                        :battle_count => first_mech.user.battle_count + 1)
    elsif winnerID == "-1"
      sa = sb = 0.5
      self.winner_id = nil
      second_mech.update_attribute("draw_times", second_mech.draw_times + 1)
      second_mech.user.update_attributes(:draw_times => second_mech.user.draw_times + 1,
                                         :battle_count => second_mech.user.battle_count + 1)

      first_mech.update_attribute("draw_times", first_mech.draw_times + 1)
      first_mech.user.update_attributes(:draw_times => first_mech.user.draw_times + 1,
                                        :battle_count => first_mech.user.battle_count + 1)

    end

    ra = second_mech.user.score
    rb = first_mech.user.score
    ea = 1.0 / (1.0 + 10 **( (rb-ra)/400.0 ) )
    eb = 1.0 / (1.0 + 10 **( (ra-rb)/400.0 ) )
    k = 32 + 16 * (0.9 ** (first_mech.user.battle_count + second_mech.user.battle_count ))
    ra = ra + k * (sa - ea)
    rb = rb + k * (sb - eb)
    if ra < 0
      ra = 0
    end
    if rb < 0
      rb = 0
    end

    self.score = (k * (sa - ea)).abs

    second_mech.user.update_attribute("score", ra)
    first_mech.user.update_attribute("score", rb)

    # logger.error(stderr.read)
  end

  def defender
    Mech.find(self.defender_id)
  end

  def attacker
    Mech.find(self.attacker_id)
  end

  def winner
    Mech.find(self.winner_id)
  end
end
